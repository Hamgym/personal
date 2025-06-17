from fastapi import *
from fastapi.responses import JSONResponse
from utils.auth import *
from models.rdb import CRUD
from models.data import *
router = APIRouter()

@router.post("/api/list",
  responses = {
    400: {"model": ErrorMessage },
  }
)
async def post_list_item(payload=Depends(jwt_auth), body:PostList=Body()):
  try:
    id = CRUD.create_lists(payload, body)
    return {
      "ok": True,
      "message": "成功建立新項目"
    }
  except:
    return JSONResponse({
      "error": True,
      "message": "建立失敗，輸入不正確或其他原因"
    }, 400)

@router.get("/api/list", responses={200: {"model":GetList}})
async def get_list_items(payload=Depends(jwt_auth)):
  user_id = payload["id"]
  shopping_list = CRUD.read_list(user_id)
  return {"list": shopping_list}

@router.delete("/api/list/{itemID}")
async def delete_list_item(itemID:int, payload=Depends(jwt_auth)):
  CRUD.delete_list_item(payload, itemID)
  return JSONResponse({"ok":True, "message": "刪除成功"})

@router.patch("/api/list")
async def change_list_item_status(payload=Depends(jwt_auth), body:UpdateList=Body()):
  CRUD.update_list_item(body.itemId, body.bought)
  return JSONResponse({"ok": True, "message": "更新成功"})