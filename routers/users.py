from fastapi import *
from fastapi.responses import JSONResponse
from models.rdb import *
from models.data import *
from utils.auth import *
router = APIRouter()

@router.post("/api/user", responses={200: {"model": OkMessage}})
async def post_user(user:SignUp):
  try:
    CRUD.create_user(user)
    return {"ok": True, "message":"恭喜您，註冊成功！"}
  except:
    return JSONResponse({"error":True, "message":"註冊失敗，重複的 Email"}, 400)

@router.put("/api/user", responses={200: {"model": Token}})
async def put_user(user:SignIn):
  row = CRUD.read_user(user)
  if row==None:
    return JSONResponse(
      {"error":True, "message":"登入失敗，帳號或密碼錯誤"}, 400
    )
  token = generate_token(row)
  return {"token": token}

@router.get("/api/user", responses={200: {"model": User}})
async def get_user(payload=Depends(jwt_auth)):
  return {"user": payload}