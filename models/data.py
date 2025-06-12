from pydantic import BaseModel, EmailStr, Field
from fastapi import UploadFile # 可能不適合用在資料模型中


class SignIn(BaseModel):
  # email: EmailStr # 標準驗證
  email: str = Field(pattern=r"^[^\s@]+@[^\s@]+$", examples=["abc@abc"])
  password: str = Field(min_length=3, examples=["password"])
class SignUp(BaseModel):
  name: str = Field(min_length=1, examples=["John"])
  email: str = Field(pattern=r"^[^\s@]+@[^\s@]+$", examples=["abc@abc"])
  password: str = Field(min_length=3, examples=["password"])
class OK(BaseModel):
  ok: bool = True
  message: str = "成功訊息"
class Error(BaseModel):
  error: bool = True
  message: str = "錯誤訊息"
class CustomValidationError(BaseModel):
  error: bool = True
  message: str = "資料格式不符，請重新輸入"
class ShopList(BaseModel):
  item: str
  specs: str = ""
  productID: int|None = None
# class ReviewCreate(BaseModel):
#   product_id: int
#   rating: int = Field(ge=1, le=5)
#   comment: str
#   photo: UploadFile
#   is_anonymous: str = "off"


def get_list_data(rows):
  data = []
  for row in rows:
    tmp = list(row)
    tmp.pop(1)
    tmp.pop(1)
    data.append(tmp)
  return data