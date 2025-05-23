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
  photo = form.photo
  if photo.size==0 or photo.filename=="":
    return "No Photo"
  image_url = upload(photo)
  return image_url
