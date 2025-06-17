from fastapi import *
from fastapi.responses import JSONResponse
from utils.auth import *
from models.rdb import *
from models.data import *
from models.bucket import upload
router = APIRouter()

@router.post("/api/product",
  responses={
    400: {"model": ErrorMessage }
  },
)
async def post_product(
  payload=Depends(jwt_auth),
  category:str=Form(description="商品類別"),
  brand:str=Form(description="商品品牌"),
  name:str=Form(description="商品名稱"),
  photo:UploadFile=Form(description="圖片檔案")
):
  rows = CRUD.read_products(name, category, brand)
  if len(rows)>0:
    return {
      "error": True,
      "message": "該商品已經存在！",
    }
  if photo.size>1*1024*1024:
    return {
      "error": True,
      "message": "檔案太大，請選擇小於 1MB 的檔案。",
    }
  image_url = upload(photo)
  category_id = CRUD.create_category(category)
  brand_id = CRUD.create_brand(brand)
  created = CRUD.create_product(category_id, brand_id, name, image_url)
  return {
    "ok": True,
    "message": "成功建立新商品！",
  }

@router.get("/api/product",
  responses={
    200: {"model": ProductRes }
  },
)
async def get_products(
  payload=Depends(jwt_auth),
  keyword:str=Query("", example="紅茶"),
  category:str=Query("", example="飲料"),
  brand:str=Query("", example="麥香"),
  sort:str=Query("", example="percent", description='可接受：percent、review、id'),
  personal:bool=Query(False, description="個人模式")
):
  user_id = payload["id"]
  products = CRUD.read_products(keyword, category, brand, sort, personal, user_id)
  return {"products": products}

@router.get("/api/product/category",
  responses={
    200: {"model": CategoryRes }
  },
)
async def get_category(
  payload=Depends(jwt_auth),
  keyword:str=Query(""),
  personal:bool=Query(False)
):
  if personal:
    user_id = payload["id"]
  else:
    user_id = 0
  category_list = CRUD.read_category(keyword, user_id)
  return {"categories": category_list}

@router.get("/api/product/brand",
  responses={
    200: {"model": BrandRes }
  },
)
async def get_brand(
  payload=Depends(jwt_auth),
  keyword:str=Query(""),
  category:str=Query(""),
  personal:bool=Query(False)
):
  if personal:
    user_id = payload["id"]
  else:
    user_id = 0
  brands = CRUD.read_brand(keyword, category, user_id)
  return {"brands": brands}

@router.get("/api/product/suggest",
  responses={
    200: {"model": SuggestionsRes }
  },
)
async def get_suggest(q:str=Query(min_length=1, example="無糖")):
  rows = CRUD.read_suggest(q)
  if len(rows)<6:
    more_rows = CRUD.read_suggest(q, need_more=True)
    rows += more_rows
  suggestions = []
  for row in rows:
    suggestions.append(row[0])
  return {"suggestions": suggestions}

@router.get("/api/product/{productID}",
  responses={
    200: {"model": OneProductRes }
  },
)
async def get_product(productID: int):
  product = CRUD.read_product(productID)
  return {"product": product}