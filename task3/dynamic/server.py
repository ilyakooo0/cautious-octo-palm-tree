#!/usr/bin/python3

import os
from datetime import datetime

user_agent = os.environ["HTTP_USER_AGENT"]
ip = os.environ["REMOTE_ADDR"]

print("")
print(datetime.now(), user_agent, ip)
