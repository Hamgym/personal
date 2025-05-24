from fastapi import *
from fastapi.responses import JSONResponse
from utils.pay import *
from utils.auth import *
from models.rdb import *
from models.data import *
from models.bucket import upload
router = APIRouter()

@router.post("/api/review")
async def post_review(payload=Depends(jwt_auth),form:ReviewCreate=Form()):
  image_url = upload(form.photo)
  new_review = CRUD.create_review(payload, form, image_url)
  return new_review

@router.get("/api/review/{product_id}")
async def get_review(product_id: int):
  rows = CRUD.read_review(product_id)
  return {"data": rows}