import os

settings = {
    'host': os.environ.get('ACCOUNT_HOST', '<YOUR HOST NAME>'),
    'master_key': os.environ.get('ACCOUNT_KEY', 'YOUR ACCOUNT MASTER KEY'),
    'database_id': os.environ.get('COSMOS_DATABASE', '<YOUR DATABASE ID>'),
    'container_id': os.environ.get('COSMOS_CONTAINER', '<YOUR CONTAINER ID>'),
}