from models.rdb import CRUD
import json

FILE_NAME = "snack"

with open(f"./data/{FILE_NAME}.json", encoding="utf-8") as file:
  data = json.load(file)
  rtnData = data["rtnData"]
  searchResult = rtnData["searchResult"]
  rtnSearchData = searchResult["rtnSearchData"]
  goodsInfoList = rtnSearchData["goodsInfoList"]

rows = []
for good in goodsInfoList:
  rating = good["rating"]
  ratingTimes = good["ratingTimes"]
  imgUrl = good["imgUrl"]
  goodsName = good["goodsName"]
  goodsName = goodsName.split("【")
  goodsName = goodsName[1]
  goodsName = goodsName.split("】")
  brandName = goodsName[0]
  goodsName = goodsName[1]
  # goodsName = goodsName.split()[0] # 讓商品名稱更簡短
  categoryName = good["categoryName"]
  categoryName = categoryName.split("#")[0]
  row = [categoryName, brandName, goodsName, imgUrl]
  rows.append(row)

def insert_product(category, brand, name, image):
  category_id = CRUD.create_category(category)
  brand_id = CRUD.create_brand(brand)
  new_product = CRUD.create_product(category_id, brand_id, name, image)
  if new_product:
    print("成功")
  else:
    print("失敗")

for row in rows:
  insert_product(*row)