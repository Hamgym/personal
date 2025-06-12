from dotenv import load_dotenv
from datetime import datetime, timezone, timedelta
from fastapi import Header
import jwt, os
load_dotenv()


class AuthError(Exception):
	pass


def generate_token(row):
  payload = {"id":row[0], "name":row[1], "email":row[2]}
  payload["exp"] = datetime.now(timezone.utc) + timedelta(weeks=1)
  token = jwt.encode(payload, os.getenv("JWT_SECRET"), algorithm="HS256")
  return token


async def jwt_auth(authorization:str=Header(example="Bearer JWT")):
  try:
    [scheme, token] = authorization.split()
    payload = jwt.decode(token, os.getenv("JWT_SECRET"), algorithms=["HS256"])
    payload.pop("exp")
    return payload
  except:
    raise AuthError
