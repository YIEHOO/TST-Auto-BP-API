import hvac
import sys

# Authentication


def initializeServer():
    client = hvac.Client(url='http://localhost:8200')
    print(f" Is client authenticated: {client.is_authenticated()}")
    return client


# Reading a secret


def readSecret(accountToRetrieve):
    client = initializeServer()
    readResponse = client.secrets.kv.v2.read_secret_version(
        path=accountToRetrieve)
    password = readResponse['data']['data']['password']
    return password
