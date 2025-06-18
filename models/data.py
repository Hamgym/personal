from pydantic import BaseModel, Field
from pydantic import EmailStr # 日後有需要再套用
from fastapi import UploadFile # 可能不適合用在資料模型中

# User
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

# List
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
  bought: bool = Field(examples=[True])

# Product
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
class SuggestionsRes(BaseModel):
  suggestions: list[str] = Field(examples=[['無糖綠茶', '無糖冷萃茶', '無糖茶', '無糖茶寶特瓶系列', '熟藏紅茶-無糖', '日式無糖綠茶', '凍頂烏龍茶-無糖']])

# Review
class MyStatistics(BaseModel):
  myReviewCount: int = Field(examples=[5])
  myLikeCount: int = Field(examples=[12])
class PostLikeReq(BaseModel):
  reviewID: int = Field(examples=[11])
class Review(BaseModel):
  id: int = Field(examples=[1])
  userName: str = Field(examples=["測試帳號"])
  rating: int = Field(examples=[5])
  createdAt: str = Field(examples=["2025-06-15T18:48:43"])
  likeCount: int = Field(examples=[3])
  comment: str = Field(examples=["已購買，小孩愛吃"])
  imgURL: str = Field(examples=["https://d2j1.cloudfront.net/76a9"])
  isMyPost: bool = Field(examples=[False])
  isMyLike: bool = Field(examples=[True])
class GetReviewRes(BaseModel):
  reviews: list[Review]
class Rating(BaseModel):
  one: float = Field(examples=[0])
  two: float = Field(examples=[0])
  three: float = Field(examples=[0])
  four: float = Field(examples=[50])
  five: float = Field(examples=[100])
  avg: float = Field(examples=[4.3333])
  percent: float = Field(examples=[86.6666])
  count: int = Field(examples=[3])
class GetRating(BaseModel):
  rating: Rating