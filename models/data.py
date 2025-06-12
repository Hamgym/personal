from pydantic import BaseModel, EmailStr, Field
from fastapi import UploadFile # 可能不適合用在資料模型中


class SignUp(BaseModel):
  name: str = Field(min_length=1, examples=["John"])
  email: str = Field(pattern=r"^[^\s@]+@[^\s@]+$", examples=["abc@abc"])
  password: str = Field(min_length=3, examples=["password"])
class OkMessage(BaseModel):
  ok: bool = True
  message: str = "成功訊息"
class ErrorMessage(BaseModel):
  error: bool = True
  message: str = "錯誤訊息"
class CustomValidationError(BaseModel):
  error: bool = True
  message: str = "資料格式不符，請重新輸入"
class SignIn(BaseModel):
  email: str = Field(pattern=r"^[^\s@]+@[^\s@]+$", examples=["abc@abc"])
  password: str = Field(min_length=3, examples=["password"])
class Token(BaseModel):
  token: str = Field(description="這是一個 JWT，建議儲存至 localStorage 備用", examples=["header.payload.signature"])
class Payload(BaseModel):
  id: int = Field(examples=[1])
  name: str = Field(min_length=1, examples=["John"])
  email: str = Field(pattern=r"^[^\s@]+@[^\s@]+$", examples=["abc@abc"])
class User(BaseModel):
  user: Payload


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