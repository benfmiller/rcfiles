#!/usr/bin/env python3

"""python script to text number with args passed in"""

import argparse
import json
import pathlib
import sys

from twilio.rest import Client

file_dir = pathlib.Path(__file__).parent.resolve()

parser = argparse.ArgumentParser()
parser.add_argument("wordstosend", nargs="*")
parser.add_argument("-p", action="store_true", help="prints message")
parser.add_argument(
    "-f",
    "--file",
    type=str,
    help="file for auth keys and info",
    required=False,
    default=file_dir / "noclude_twilio.json",
)
args = parser.parse_args()

SENTENCE = " ".join(args.wordstosend)
if args.p:
    print(SENTENCE)

with open(args.file) as f:
    keys = json.load(f)

if len(SENTENCE) == 0:
    sys.exit("No words to send")

# Find your Account SID and Auth Token at twilio.com/console
# and set the environment variables. See http://twil.io/secure
# account_sid = os.environ["TWILIO_ACCOUNT_SID"]
# auth_token = os.environ["TWILIO_AUTH_TOKEN"]

account_sid = keys["account_sid"]
auth_token = keys["account_auth"]
client = Client(account_sid, auth_token)

message = client.messages.create(
    body=SENTENCE,
    from_=keys["phone_from"],
    to=keys["phone_to"],
)

print(message.sid)
