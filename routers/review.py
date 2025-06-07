from fastapi import *
from fastapi.responses import JSONResponse
from utils.auth import *
from models.rdb import *
from models.data import *
from models.bucket import upload
router = APIRouter()

@router.post("/api/review")
async def post_review(payload=Depends(jwt_auth), product_id:int=Form(), rating:int=Form(ge=1, le=5), comment:str=Form(), is_anonymous:str=Form("off"), photo:UploadFile=Form()):
  user_id = payload["id"]
  if photo.size>1*1024*1024:
    return False
  image_url = upload(photo)
  new_review = CRUD.create_review(user_id, product_id, rating, comment, is_anonymous, image_url)
  return new_review

@router.get("/api/review/{product_id}")
async def get_review(product_id: int):
  rows = CRUD.read_review(product_id)
  return {"data": rows}

@router.post("/api/review/like")
async def post_like(payload=Depends(jwt_auth), body=Body()):
  user_id = payload["id"]
  review_id = body["reviewID"]
  isLiked = CRUD.create_like(user_id, review_id)
  if isLiked:
    CRUD.update_review_like(review_id)
  return isLiked

@router.get("/api/review/mylike/{reviewID}")
async def get_mylike(payload=Depends(jwt_auth), reviewID:int=Path()):
  user_id = payload["id"]
  row = CRUD.read_mylike(reviewID, user_id)
  return row

@router.get("/api/review/mypost/{reviewID}")
async def get_mylike(payload=Depends(jwt_auth), reviewID:int=Path()):
  user_id = payload["id"]
  row = CRUD.read_mypost(reviewID, user_id)
  return row

@router.get("/api/review/rating/{product_id}")
async def get_rating(product_id:int=Path()):
  result = CRUD.read_rating(product_id)
  return result

@router.get("/api/review/posted/{product_id}")
async def get_posted(payload=Depends(jwt_auth), product_id:int=Path()):
  user_id = payload["id"]
  row = CRUD.read_posted(product_id, user_id)
  return row