from pydantic import BaseModel, EmailStr, Field
from fastapi import UploadFile # 可能不適合用在資料模型中


class SignIn(BaseModel):
  # email: EmailStr # 標準驗證
  email: str = Field(pattern=r"^[^\s@]+@[^\s@]+$")
  password: str = Field(min_length=3)
class SignUp(SignIn):
  name: str = Field(min_length=1)
class ShopList(BaseModel):
  item: str
  specs: str
class ReviewCreate(BaseModel):
  product_id: int
  rating: int = Field(ge=1, le=5)
  comment: str
  photo: UploadFile
  is_anonymous: str = "off"


def get_list_data(rows):
  data = []
  for row in rows:
    tmp = list(row)
    tmp.pop(1)
    data.append(tmp)
  return data