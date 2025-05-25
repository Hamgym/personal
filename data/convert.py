import json
import csv

with open("./data/cookie.json", encoding="utf-8") as file:
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
  # goodsName = goodsName.split()[0]
  categoryName = good["categoryName"]
  categoryName = categoryName.split("#")[0]
  row = [categoryName, brandName, goodsName]
  rows.append(row)

with open("./data/cookie.csv", mode="w", newline="", encoding="utf-8") as file:
  writer = csv.writer(file)
  writer.writerows(rows)