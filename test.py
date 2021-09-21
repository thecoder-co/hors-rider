import requests as re
import json as js

token = 'Bearer 30|61CDC2iCRZawrMGBmlVMIJv3Zmlc5vbyT7WUjNNB'

baseurl = 'https://app.johors.com'
def login():
    url = "https://app.johors.com/api/mobile/login"

    payload={
            'user_type':0,
            'device_name':'android emulator',
            'password':'12345678',
            'email':'abimbsthefirst@gmail.com'
            }
    headers = {}

    response = re.post(url, headers=headers, data=payload)

    print(response.text)
    return response.json

def register():
    url = "https://app.johors.com/api/mobile/client/register"

    payload={
        'surname':'abimbola',
        'first_name':'idunnuoluwa',
        'email':'abimbsthefirst@gmail.com',
        'phone_number':'08116603879',
        'address':'lagos',
        'device_name':'android emulator',
        'password':'12345678',
        'password_confirmation':'12345678'
        }
    headers = {}

    response = re.post(url, headers=headers, data=payload)
    print(response.text)
    return response.json

def chg_num():
    att = '/api/mobile/client/change-client-phone-number'
    payload={
            'phone_number':'07016307908'
            }
    headers = {
        'Content-type':'application/json',
        'Accept':'application/json',
        'Authorization':token
    }

    response = re.post(baseurl+att, headers=headers, data=js.dumps(payload))

    print(response.text)
    return response.json

def update_profile():

    url = "/api/mobile/client/update-client-profile"

    payload={
        'surname':'abimbola',
        'first_name':'idunnuoluwa',
        'gender':'male',
        'address':'lagos',
        'marital_status':'single',
    }
    headers = {
        'Content-type':'application/json',
        'Accept':'application/json',
        'Authorization':token
    }

    response = re.request("POST", baseurl+url, headers=headers, data=js.dumps(payload))

    print(response.text)

def forget_password():
    url = "/api/mobile/forget-password"

    payload={'email':'thecoder.co@gmail.com'}
    headers = {
        'Content-type':'application/json',
        'Accept':'application/json',
    }

    response = re.request("POST", baseurl+url, headers=headers, data=js.dumps(payload))

    print(response.text)

def reset_password():
    url = "/api/mobile/reset-password"

    payload={
        'email':'thecoder.co@gmail.com',
        'password':'1234567890',
        'password_confirmation':'1234567890',
        'reset_token':'RAj90cLQDANx5TVRpUtz'
    }
    headers = {
        'Content-type':'application/json',
        'Accept':'application/json',
    }

    response = re.request("POST", baseurl+url, headers=headers, data=js.dumps(payload))

    print(response.text)

def profile_details():
    url = "https://app.johors.com/api/mobile/profile-details"
    headers = {
        'Content-type':'application/json',
        'Accept':'application/json',
        'Authorization':token
    }

    response = re.request("GET", url, headers=headers)

    print(response.text)


profile_details()