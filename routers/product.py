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
  return new_product

@router.get("/api/order/{orderNumber}")
async def get_order(payload=Depends(jwt_auth), orderNumber:str=Path()):
  row = CRUD.read_order(orderNumber, payload)
  if row==None:
    return {"data": None}
  data = get_order_data(row)
  return {"data": data}