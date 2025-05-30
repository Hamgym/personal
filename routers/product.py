from fastapi import *
from fastapi.responses import JSONResponse
from utils.auth import *
from models.rdb import *
from models.data import *
from models.bucket import upload
router = APIRouter()

@router.post("/api/product")
async def post_prod(
  payload=Depends(jwt_auth), category:str=Form(), brand:str=Form(), name:str=Form(), photo:UploadFile=Form()):
  image_url = upload(photo)
  category_id = CRUD.create_category(category)
  brand_id = CRUD.create_brand(brand)
  new_product = CRUD.create_product(category_id, brand_id, name, image_url)
  return {
    "newProduct": new_product,
    "product": "OK"
  }

@router.get("/api/product")
async def get_products(payload=Depends(jwt_auth), keyword:str=Query(""), category:str=Query(""), brand:str=Query(""), sort:str=Query(""), personal:bool=Query(False)):
  if personal:
    user_id = payload["id"]
  else:
    user_id = 0
  rows = CRUD.read_products(keyword, category, brand, sort, user_id)
  return {"data": rows}

@router.get("/api/products/{id}")
async def get_product(id: int):
  row = CRUD.read_product(id)
  return {"data": row}

@router.get("/api/product/category")
async def get_category(payload=Depends(jwt_auth), keyword:str=Query(""), brand:str=Query(""), personal:bool=Query(False)):
  if personal:
    user_id = payload["id"]
  else:
    user_id = 0
  rows = CRUD.read_category(keyword, brand, user_id)
  return {"data": rows}

@router.get("/api/product/brand")
async def get_brand(payload=Depends(jwt_auth), keyword:str=Query(""), category:str=Query(""), personal:bool=Query(False)):
  if personal:
    user_id = payload["id"]
  else:
    user_id = 0
  rows = CRUD.read_brand(keyword, category, user_id)
  return {"data": rows}

@router.get("/api/product/suggest")
async def get_brand(q:str=Query(..., min_length=1)):
  rows = CRUD.read_suggest(q)
  if len(rows)<5:
    more_rows = CRUD.read_suggest(q, need_more=True)
    rows += more_rows
  return rows