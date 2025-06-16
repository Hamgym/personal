from fastapi import *
from fastapi.responses import JSONResponse
from utils.auth import *
from models.rdb import *
from models.data import *
from models.bucket import upload
router = APIRouter()

@router.post("/api/review",
  responses={
    400: {"model": ErrorMessage }
  },
)
async def post_review(
  payload=Depends(jwt_auth),
  product_id:int=Form(),
  rating:int=Form(ge=1, le=5, description="5星制評論"),
  comment:str=Form(description="文字內容"),
  is_anonymous:str=Form("off", description="是否匿名發布，使用checkbox的on或off"),
  photo:UploadFile=Form(description="圖片檔案大小限制1MB")
):
  user_id = payload["id"]
  if photo.size>1*1024*1024:
    return False
  image_url = upload(photo)
  new_review = CRUD.create_review(user_id, product_id, rating, comment, is_anonymous, image_url)
  if new_review:
    return {"ok": True, "message": "成功發布評論"}
  else:
    return {"error": True, "message": "已經發布過評論了"}

@router.get("/api/review/count",
  responses={
    200: {"model": MyReviewCount }
  },
)
async def get_my_review_count(payload=Depends(jwt_auth)):
  user_id = payload["id"]
  review_count = CRUD.read_review_count(user_id)
  return {"myReviewCount": review_count}

@router.post("/api/review/like",
  responses={
    400: {"model": ErrorMessage }
  },
)
async def post_like(payload=Depends(jwt_auth), body:PostLikeReq=Body()):
  user_id = payload["id"]
  review_id = body.reviewID
  isLiked = CRUD.create_like(user_id, review_id)
  if isLiked:
    # CRUD.update_review_like(review_id)
    return {"ok": True, "message": "按讚成功"}
  else:
    return JSONResponse({"error": True, "message": "已經按過讚了"}, 400)

@router.get("/api/review/{product_id}")
async def get_review(product_id: int):
  rows = CRUD.read_review(product_id)
  return {"data": rows}

@router.get("/api/review/like/count")
async def get_like_count(payload=Depends(jwt_auth)):
  user_id = payload["id"]
  like_count = CRUD.read_like_count(user_id)
  return {"likeCount": like_count}

@router.get("/api/review/mylike/{reviewID}")
async def get_mylike(payload=Depends(jwt_auth), reviewID:int=Path()):
  user_id = payload["id"]
  row = CRUD.read_mylike(reviewID, user_id)
  return row

@router.get("/api/review/mypost/{reviewID}")
async def get_mypost(payload=Depends(jwt_auth), reviewID:int=Path()):
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

@router.delete("/api/review/{product_id}")
async def delete_review(payload=Depends(jwt_auth), product_id:int=Path()):
  user_id = payload["id"]
  row = CRUD.read_posted(product_id, user_id)
  review_id = row[0]
  deleted = CRUD.delete_review(review_id, user_id)
  return deleted