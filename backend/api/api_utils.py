from flask import jsonify


def create_http_response(data={}, errors=[]):
    '''
    This generates an HTTP response as specified by the API architecture document.
    If errors is empty (default) then this will be a success response. If errors is not empty, this will be an error
    response

    You can append any JSON data to the response by specifcying the `data` parameter, which is a dict


    :return: an HTTP response object which a Flask endpoint can return
    '''

    success_status = 'successful' if errors is [] or None else 'error'
    print(errors)

    response = {
        'success_status': success_status,
        'errors': errors
    }

    response.update(data)

    return jsonify(response), 200,  {'ContentType': 'application/json'}

