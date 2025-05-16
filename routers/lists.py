from fastapi import *
from fastapi.responses import JSONResponse
from utils.auth import *
from models.rdb import *
from models.data import *
router = APIRouter()

@router.post("/api/lists")
async def post_lists(payload=Depends(jwt_auth), body:ShopList=Body()):
  try:
    id = CRUD.create_lists(payload, body)
    return {
      "ok": True,
      "message": body,
      "id": id
    }
  except:
    return JSONResponse({
      "error": True,
      "message": "建立失敗，輸入不正確或其他原因"
    }, 400)
@router.get("/api/lists")
async def get_list(payload=Depends(jwt_auth)):
  rows = CRUD.read_list(payload)
  if rows==None:
    return {"data": None}
  data = get_list_data(rows)
  return {"data": data}
@router.get("/api/lists/{itemId}")
async def get_list(itemId:int, payload=Depends(jwt_auth)):
  row = CRUD.read_list_item(payload, itemId)
  if row==None:
    return {"data": None}
  row = list(row)
  row.pop(1)
  return {"data": row}
@router.delete("/api/lists/{itemId}")
async def delete_list(itemId:int, payload=Depends(jwt_auth)):
  CRUD.delete_list_item(payload, itemId)
  return JSONResponse({"ok": True})
@router.patch("/api/lists/{itemId}")
async def patch_list(itemId:int, body=Body(), payload=Depends(jwt_auth)):
  CRUD.update_list_item(itemId, body["bought"])
  return JSONResponse({"ok": True})