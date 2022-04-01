#   LYm1ZhrjmSnm6Tt3H0M2
#   QvJRRhQqJu

# 자신이 개별적으로 전달받은 키를 사용을 해야 합니다.
# clientID = "LYm1ZhrjmSnm6Tt3H0M2"
# clientSecret = "QvJRRhQqJu"

import requests
import json

# -*- coding: utf-8 -*-
import os
import sys
import urllib.request

clientID = "LYm1ZhrjmSnm6Tt3H0M2"
clientSecret = "QvJRRhQqJu"

url = "https://openapi.naver.com/v1/datalab/search"
body = '{"startDate":"2017-01-01","endDate":"2017-04-30","timeUnit":"month","keywordGroups":[{"groupName":"한글","keywords":["한글","korean"]},{"groupName":"영어","keywords":["영어","english"]}],"device":"pc","ages":["1","2"],"gender":"f"}'

request = urllib.request.Request(url)
request.add_header("X-Naver-Client-Id", clientID)
request.add_header("X-Naver-Client-Secret", clientSecret)
request.add_header("Content-Type", "application/json")
response = urllib.request.urlopen(request, data=body.encode("utf-8"))
rescode = response.getcode()
if rescode == 200:
    response_body = response.read()
    print(response_body.decode("utf-8"))
else:
    print("Error Code:" + rescode)

url = "https://openapi.naver.com/v1/datalab/search"
header = {
    "X-Naver-Client-Id": clientID,
    "X-Naver-Client-Secret": clientSecret,
    "Content-Type": "application/json",
}

data = {
    "startDate": "2021-01-01",
    "endDate": "2022-02-28",
    "timeUnit": "week",
    "keywordGroups": [
        {"groupName": "침착맨", "keywords": ["이말년", "침튜브", "침착맨"]},
        {"groupName": "펭수", "keywords": ["10살펭귄", "김명중", "펭클럽"]},
    ],
    "ages": ["3", "4", "5", "6", "7", "8", "9", "10", "11"],
}

jsonData = json.dumps(data)
response = requests.post(url, data=jsonData, headers=header)
print(response.status_code)

response.json()
