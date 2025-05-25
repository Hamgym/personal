from dotenv import load_dotenv
load_dotenv()


from models.rdb import CRUD
import csv


def post_prod(category, brand, name):
  category_id = CRUD.create_category(category)
  brand_id = CRUD.create_brand(brand)
  new_product = CRUD.create_product(category_id, brand_id, name)
  if new_product:
    print("成功")
  else:
    print("失敗")


with open("./data/cookie.csv", mode="r", newline="", encoding="utf-8") as file:
  reader = csv.reader(file)
  for row in reader:
    post_prod(*row)