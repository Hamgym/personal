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
async def get_order(payload=Depends(jwt_auth), keyword:str=Query(None)):
  rows = CRUD.read_products(keyword)
  return {"data": rows}

@router.get("/api/product/category")
async def get_order(payload=Depends(jwt_auth)):
  rows = CRUD.read_category()
  return {"data": rows}