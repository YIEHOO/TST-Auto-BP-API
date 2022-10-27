import json
import jsonschema


def validateJsonSchema(inputJson, referenceSchemaPath):
    try:
        referenceSchema = getReferenceJson(referenceSchemaPath)
        print(referenceSchema)
        jsonschema.validate(instance=inputJson, schema=referenceSchema)
    except jsonschema.SchemaError as schemaErr:
        raise jsonschema.SchemaError(
            f'Your schema on path {referenceSchemaPath} is not really a Json schema! Error: {schemaErr}')
    except jsonschema.ValidationError as validationErr:
        raise jsonschema.ValidationError(
            f'The validation went wrong! Error: {validationErr}')
    except Exception as ex:
        raise Exception(f'Something went terribly wrong! Error: {ex}')


def getReferenceJson(referenceSchemaPath):
    try:
        with open(referenceSchemaPath) as jsonFile:
            data = json.load(jsonFile)
            print(data)
        return data
    except json.decoder.JSONDecodeError as jsonErr:
        raise json.decoder.JSONDecodeError(
            f'I could not make Json out of file "{referenceSchemaPath}"! Error: {jsonErr}')
    except FileNotFoundError as fileErr:
        raise FileNotFoundError(
            f'I was not able to open file in path "{referenceSchemaPath}"! Error {fileErr}')
    except Exception as ex:
        raise Exception(f'Something went terribly wrong! Error: {ex}')
