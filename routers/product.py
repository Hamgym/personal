from fastapi import *
from fastapi.responses import JSONResponse
from utils.pay import *
from utils.auth import *
from models.rdb import *
from models.data import *
router = APIRouter()

@router.post("/api/product")
async def post_prod(payload=Depends(jwt_auth), form:ProductForm=Form()):
  category_id = CRUD.create_category(form.category)
  brand_id = CRUD.create_brand(form.brand)
  new_product = CRUD.create_product(category_id, brand_id, form.name)
  return {
    "newProduct": new_product,
    "product": form
  }

@router.get("/api/product")
async def get_products(payload=Depends(jwt_auth), keyword:str=Query(""), category:str=Query(""), brand:str=Query("")):
  rows = CRUD.read_products(keyword, category, brand)
  rows = list(rows)
  result = []
  for row in rows:
    tmp = []
    tmp = list(row)
    pid = row[0]
    row = CRUD.read_rating(pid)
    tmp.append(row[-2])
    tmp.append(row[-1])
    result.append(tmp)
  return {"data": result}

@router.get("/api/products/{id}")
async def get_product(id: int):
  row = CRUD.read_product(id)
  return {"data": row}

@router.get("/api/product/category")
async def get_category(payload=Depends(jwt_auth), keyword:str=Query(""), brand:str=Query("")):
  rows = CRUD.read_category(keyword, brand)
  return {"data": rows}

@router.get("/api/product/brand")
async def get_brand(payload=Depends(jwt_auth), keyword:str=Query(""), category:str=Query("")):
  rows = CRUD.read_brand(keyword, category)
  return {"data": rows}