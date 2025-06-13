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


class PostList(BaseModel):
  item: str = Field(examples=["商品名稱"])
  specs: str = Field("", examples=["備註說明"])
  productID: int|None = Field(None)
class GetList(BaseModel):
  id: int = Field(examples=[12])
  name: str = Field(examples=["商品名稱"])
  note: str = Field(examples=["備註說明"])
  checked: int = Field(examples=[0])
class UpdateList(BaseModel):
  itemId: int = Field(examples=[12])
  bought: int = Field(examples=[1])

# def get_list_data(rows):
#   data = []
#   for row in rows:
#     tmp = list(row)
#     tmp.pop(1)
#     tmp.pop(1)
#     data.append(tmp)
#   return data