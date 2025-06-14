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


class Product(BaseModel):
  productID: int = Field(examples=[21])
  category: str = Field(examples=["飲料"])
  brand: str = Field(examples=["麥香"])
  productName: str = Field(examples=["麥香綠茶"])
  imgaeURL: str = Field(examples=["https://qbdhu.cloudfront.net/5dfd"])
  ratingPercent: int = Field(examples=[85])
  reviewCount: int = Field(examples=[4])
  isListed: bool = Field(examples=[False])
class ProductRes(BaseModel):
  products: list[Product]
class Category(BaseModel):
  category: str = Field(examples=["餅乾"])
  productCount: int = Field(examples=[28])
class CategoryRes(BaseModel):
  categories: list[Category]
class Brand(BaseModel):
  brand: str = Field(examples=["麥香"])
  productCount: int = Field(examples=[6])
class BrandRes(BaseModel):
  brands: list[Brand]
class OneProductRes(BaseModel):
  id: int = Field(examples=[85])
  brand: str = Field(examples=["麥香"])
  productName: str = Field(examples=["麥香綠茶"])