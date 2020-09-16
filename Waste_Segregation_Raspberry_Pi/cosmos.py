import azure.cosmos.documents as documents
import azure.cosmos.cosmos_client as cosmos_client
import azure.cosmos.exceptions as exceptions
from azure.cosmos.partition_key import PartitionKey
import datetime

import config



HOST = config.settings['host']
MASTER_KEY = config.settings['master_key']
DATABASE_ID = config.settings['database_id']
CONTAINER_ID = config.settings['container_id']


def create_items(container):
    print('Creating Items')
    print('\n1.1 Create Item\n')

    # Create a SalesOrder object. This object has nested properties and various types including numbers, DateTimes and strings.
    # This can be saved as JSON as is without converting into rows/columns.
    sales_order = get_sales_order("SalesOrder1")
    container.create_item(body=sales_order)

    # As your app evolves, let's say your object has a new schema. You can insert SalesOrderV2 objects without any
    # changes to the database tier.
    sales_order2 = get_sales_order_v2("SalesOrder2")
    container.create_item(body=sales_order2)

def read_item(container, doc_id, userId):
    print('\n1.2 Reading Item by Id\n')

    # We can do an efficient point read lookup on partition key and id
    response = container.read_item(item=doc_id, partition_key=userId)

    print('Item read by Id {0}'.format(doc_id))
    print('Account Number: {0}'.format(response.get('userId')))
    print('Subtotal: {0}'.format(response.get('subtotal')))


def read_items(container):
    print('\n1.3 - Reading all items in a container\n')

    # NOTE: Use MaxItemCount on Options to control how many items come back per trip to the server
    #       Important to handle throttles whenever you are doing operations such as this that might
    #       result in a 429 (throttled request)
    item_list = list(container.read_all_items(max_item_count=10))

    print('Found {0} items'.format(item_list.__len__()))

    for doc in item_list:
        print('Item Id: {0}'.format(doc.get('id')))




def replace_item(container, doc_id, userId):
    print('\n1.5 Replace an Item\n')

    read_item = container.read_item(item=doc_id, partition_key=userId)
    read_item['subtotal'] = read_item['subtotal'] + 1
    response = container.replace_item(item=read_item, body=read_item)
    print('Done updating!!:)')


def upsert_item(container, doc_id, userId,waste,weight):
    print('\n1.6 Upserting an item\n')

    read_item = container.read_item(item=doc_id, partition_key=userId)
    if(waste == 'metal'):
        read_item['metal_Numbers'] = read_item['metal_Numbers'] + 1
        read_item['metal_Weight'] = read_item['metal_Weight'] + weight
    elif(waste == 'plastic'):
        read_item['plastic_Numbers'] = read_item['plastic_Numbers'] + 1
        read_item['plastic_Weight'] = read_item['plastic_Weight'] + weight
    elif(waste == 'paper'):
        read_item['paper_Numbers'] = read_item['paper_Numbers'] + 1
        read_item['paper_Weight'] = read_item['paper_Weight'] + weight

    response = container.upsert_item(body=read_item)



def delete_item(container, doc_id, userId):
    print('\n1.7 Deleting Item by Id\n')

    response = container.delete_item(item=doc_id, partition_key=userId)

    print('Deleted item\'s Id is {0}'.format(doc_id))






def sendDataToCosmosDB(userId,waste,weight):
    client = cosmos_client.CosmosClient(HOST, {'masterKey': MASTER_KEY}, user_agent="CosmosDBDotnetQuickstart", user_agent_overwrite=True)
    try:
        # setup database for this sample
        try:
            #db = client.create_database(id=DATABASE_ID)
            database_name = 'Bin_Users'
            database = client.create_database_if_not_exists(id=database_name)

        except exceptions.CosmosResourceExistsError:
            print('CosmosResourceExistsError')
            pass

        # setup container for this sample
        try:
            container_name = 'users'
            container = database.create_container_if_not_exists(
                id=container_name,
                partition_key=PartitionKey(path="/userId"),
                offer_throughput=400
            )

        except exceptions.CosmosResourceExistsError:
            print('Container with id \'{0}\' was found'.format(CONTAINER_ID))

        print(container)
        upsert_item(container, str(userId), str(userId),waste,weight)


        # cleanup database after sample

    except exceptions.CosmosHttpResponseError as e:
        print('\nrun_sample has caught an error. {0}'.format(e.message))

    finally:
            print("\nrun_sample done")
