from mysql.connector.pooling import MySQLConnectionPool
from passlib.context import CryptContext
from dotenv import load_dotenv
import os
load_dotenv()
dbconfig = {
  "user": os.getenv("DB_USER"),
  "password": os.getenv("DB_PASSWORD"),
  "host": os.getenv("DB_HOST"),
  "database": "mygo",
  "pool_name": "mypool"
}
cnxpool = MySQLConnectionPool(pool_size=5, **dbconfig)
pwd_context = CryptContext(schemes=["bcrypt"])


def get_list_data(rows):
  data = []
  # 只需要，項目編號、商品名稱、備註說明、已買狀態
  for row in rows:
    tmp = list(row)
    tmp.pop(1)
    tmp.pop(1)
    data.append(tmp)
  return data
def get_rating(rows):
  """
  [1, 2, 3, 4, 5, avg, percent, review]
  """
  if not rows:
    return [0,0,0,0,0,0,0,0]
  result = [0,0,0,0,0]
  for row in rows:
    if row[0]==1:
      result[0] += 1
      continue
    if row[0]==2:
      result[1] += 1
      continue
    if row[0]==3:
      result[2] += 1
      continue
    if row[0]==4:
      result[3] += 1
      continue
    if row[0]==5:
      result[4] += 1
      continue
  total = 0
  count = 0 # review count
  for i in range(5):
    total += result[i]*(i+1)
    count += result[i]
  avg_rating = total/count
  percent = avg_rating/5*100
  # avg_rating = f"{avg_rating:.2}" # 讓前端決定小數位數
  for i in range(5):
    result[i] = result[i]/count*100
  max_value = max(result)
  for i in range(5):
    result[i] = result[i]/max_value*100
  result.append(avg_rating)
  result.append(percent)
  result.append(count)
  return result


class CRUD:
  def create_user(user):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      user.password = pwd_context.hash(user.password)
      insert = "INSERT INTO user(name, email, password) VALUE(%s, %s, %s)"
      cursor.execute(insert, (user.name, user.email, user.password))
      cnx.commit()
  def create_lists(payload, body):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      insert = "INSERT INTO lists(user_id, item, specs, product_id) VALUES(%s, %s, %s, %s)"
      cursor.execute(insert, (payload["id"], body.item, body.specs, body.productID))
      cnx.commit()
      return cursor.lastrowid
  def create_category(category):
    with cnxpool.get_connection() as cnx:
      try:
        cursor = cnx.cursor()
        insert = "INSERT INTO category(name) VALUES(%s)"
        cursor.execute(insert, (category,))
        cnx.commit()
        return cursor.lastrowid
      except:
        select = "SELECT * FROM category WHERE name=%s"
        cursor.execute(select, (category,))
        row = cursor.fetchone()
        return row[0]
  def create_brand(brand):
    with cnxpool.get_connection() as cnx:
      try:
        cursor = cnx.cursor()
        insert = "INSERT INTO brand(name) VALUES(%s)"
        cursor.execute(insert, (brand,))
        cnx.commit()
        return cursor.lastrowid
      except:
        select = "SELECT * FROM brand WHERE name=%s"
        cursor.execute(select, (brand,))
        row = cursor.fetchone()
        return row[0]
  def create_product(category, brand, name, image=""):
    with cnxpool.get_connection() as cnx:
      try:
        cursor = cnx.cursor()
        insert = "INSERT INTO product(category, brand, name, image) VALUES(%s, %s, %s, %s)"
        cursor.execute(insert, (category,brand,name,image))
        cnx.commit()
        return True
      except:
        return False
  def create_review(user_id, product_id, rating, comment, is_anonymous, image_url):
    with cnxpool.get_connection() as cnx:
      try:
        cursor = cnx.cursor()
        insert = """
          INSERT INTO review(product_id, user_id, rating, comment, image_url, is_anonymous)
          VALUES(%s, %s, %s, %s, %s, %s);
        """
        if is_anonymous=="on":
          is_anonymous = True
        else:
          is_anonymous = False
        values = [product_id, user_id, rating, comment, image_url, is_anonymous]
        cursor.execute(insert, values)
        cnx.commit()
        return True
      except:
        return False
  def create_like(user_id, review_id):
    with cnxpool.get_connection() as cnx:
      try:
        cursor = cnx.cursor()
        insert = """
          INSERT INTO review_likes(review_id, user_id)
          VALUES(%s, %s);
        """
        values = [review_id, user_id]
        cursor.execute(insert, values)
        cnx.commit()
        return True
      except:
        return False
  def read_user(user):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = "SELECT * FROM user WHERE email=%s"
      cursor.execute(select, (user.email,))
      row = cursor.fetchone()
      if row==None:
        return None
      verified = pwd_context.verify(user.password, row[3])
      if not verified:
        return None
      return row
  def read_list(user_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = """
        SELECT *
        FROM lists
        WHERE user_id=%s
        ORDER BY id DESC
      """
      cursor.execute(select, [user_id])
      rows = cursor.fetchall()
      # if rows==None:
      #   return
      # data = get_list_data(rows)
      shopping_list = get_list_data(rows)
      return shopping_list
  def read_list_item(payload, item_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = "SELECT * FROM lists WHERE user_id=%s AND id=%s"
      cursor.execute(select, (payload["id"],item_id))
      row = cursor.fetchone()
      return row
  def read_list_product(user_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = """
        SELECT product_id
        FROM lists
        WHERE user_id=%s AND product_id IS NOT NULL;
      """
      cursor.execute(select, (user_id,))
      rows = cursor.fetchall()
      return rows
  def read_product(id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = """
        SELECT product.id, brand.name, product.name
        FROM product JOIN brand
        ON product.brand=brand.id
      """
      where = "WHERE product.id=%s"
      value = [id]
      cursor.execute(select+where, value)
      row = cursor.fetchone()
      return row
  def read_products(keyword, category, brand, sort="id", personal=False, user_id=0):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = f"""
        SELECT product.id, category.name, brand.name, product.name, product.image, product.percent, product.review, lists.user_id
        FROM product
        JOIN category ON product.category=category.id
        JOIN brand ON product.brand=brand.id
        LEFT JOIN (SELECT product_id, user_id FROM lists WHERE user_id={user_id}) AS lists ON product.id=lists.product_id
        LEFT JOIN (SELECT product_id, user_id FROM review WHERE user_id={user_id}) AS review ON product.id=review.product_id
      """
      where = " WHERE TRUE"
      value = []
      if keyword!="":
        where += " AND (product.name LIKE %s OR category.name LIKE %s OR brand.name LIKE %s)"
        value.append(f"%{keyword}%")
        value.append(f"%{keyword}%")
        value.append(f"%{keyword}%")
      if category!="" and category!="類別":
        where += " AND category.name=%s"
        value.append(category)
      if brand!="" and brand!="品牌":
        where += " AND brand.name=%s"
        value.append(brand)
      if personal:
        where += " AND review.user_id=%s"
        value.append(user_id)
      if sort!="percent" and sort!="review":
        sort = "id"
      order = f" ORDER BY product.{sort} DESC"
      cursor.execute(select+where+order, value)
      rows = cursor.fetchall()
      return rows
  def read_category(keyword, user_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      where = " WHERE TRUE"
      value = []
      if user_id:
        select = """
          SELECT category.name, COUNT(product.id) as count
          FROM product
          JOIN category ON product.category=category.id
          JOIN brand ON product.brand=brand.id
          JOIN review ON product.id=review.product_id
        """
        where += " AND review.user_id=%s"
        value.append(user_id)
      else:
        select = """
          SELECT category.name as category, COUNT(product.id) as count
          FROM product
          JOIN category ON product.category=category.id
          JOIN brand ON product.brand=brand.id
        """
      if keyword!="":
        where += " AND (product.name LIKE %s OR category.name LIKE %s OR brand.name LIKE %s)"
        value.append(f"%{keyword}%")
        value.append(f"%{keyword}%")
        value.append(f"%{keyword}%")
      group = " GROUP BY category.name"
      order = " ORDER BY count DESC;"
      cursor.execute(select+where+group+order, value)
      rows = cursor.fetchall()
      return rows
  def read_brand(keyword, category, user_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      where = " WHERE TRUE"
      value = []
      if user_id:
        select = """
          SELECT brand.name, COUNT(product.id) as count
          FROM product
          JOIN category ON product.category=category.id
          JOIN brand ON product.brand=brand.id
          JOIN review ON product.id=review.product_id
        """
        where += " AND review.user_id=%s"
        value.append(user_id)
      else:
        select = """
          SELECT brand.name, COUNT(product.id) as count
          FROM product
          JOIN category ON product.category=category.id
          JOIN brand ON product.brand=brand.id
        """
      if keyword!="":
        where += " AND (product.name LIKE %s OR category.name LIKE %s OR brand.name LIKE %s)"
        value.append(f"%{keyword}%")
        value.append(f"%{keyword}%")
        value.append(f"%{keyword}%")
      if category!="" and category!="類別":
        where += " AND category.name=%s"
        value.append(category)
      group = " GROUP BY brand.name"
      order = " ORDER BY count DESC;"
      cursor.execute(select+where+group+order, value)
      rows = cursor.fetchall()
      return rows
  def read_review(product_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = """
        SELECT review.id, user.name, review.rating, review.created_at, review.likes, review.comment, review.image_url, review.is_anonymous
        FROM review JOIN user
        ON review.user_id=user.id
      """
      where = " WHERE review.product_id=%s"
      value = [product_id]
      order = " ORDER BY review.likes DESC;"
      cursor.execute(select+where+order, value)
      rows = cursor.fetchall()
      # 匿名處理
      result = []
      for row in rows:
        tmp = list(row)
        if tmp[-1]:
          tmp[1] = "匿名"
        tmp.pop()
        result.append(tmp)
      return result
  def read_review_count(user_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = """
        SELECT COUNT(id)
        FROM review
      """
      where = " WHERE user_id=%s"
      value = [user_id]
      cursor.execute(select+where, value)
      row = cursor.fetchone()
      review_count = row[0]
      return review_count
  def read_like_count(user_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = """
        SELECT SUM(likes)
        FROM review
      """
      where = " WHERE user_id=%s"
      value = [user_id]
      cursor.execute(select+where, value)
      row = cursor.fetchone()
      like_count = row[0]
      return like_count
  def read_like(review_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = """
        SELECT COUNT(user_id)
        FROM review_likes
      """
      where = " WHERE review_id=%s"
      group = " GROUP BY review_id"
      value = [review_id]
      cursor.execute(select+where+group, value)
      row = cursor.fetchone()
      return row
  def read_mylike(review_id, user_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = """
        SELECT *
        FROM review_likes
      """
      where = " WHERE review_id=%s AND user_id=%s;"
      value = [review_id, user_id]
      cursor.execute(select+where, value)
      row = cursor.fetchone()
      return row
  def read_mypost(review_id, user_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = """
        SELECT *
        FROM review
      """
      where = " WHERE id=%s AND user_id=%s;"
      value = [review_id, user_id]
      cursor.execute(select+where, value)
      row = cursor.fetchone()
      return row
  def read_rating(product_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = """
        SELECT rating
        FROM review
      """
      where = " WHERE product_id=%s"
      value = [product_id]
      cursor.execute(select+where, value)
      rows = cursor.fetchall()
      result = get_rating(rows)
      CRUD.update_product_percent(product_id, result[-2], result[-1])
      return result
  def read_suggest(keyword, need_more=False):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = """
        SELECT name
        FROM product
      """
      where = " WHERE name LIKE %s;"
      value = [f"{keyword}%"]
      if need_more:
        value = [f"_%{keyword}%"]
      cursor.execute(select+where, value)
      rows = cursor.fetchall()
      return rows
  def read_posted(product_id, user_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = """
        SELECT *
        FROM review
      """
      where = " WHERE product_id=%s"
      value = [product_id]
      where += " AND user_id=%s;"
      value += [user_id]
      cursor.execute(select+where, value)
      row = cursor.fetchone()
      return row
  def update_list_item(id, bought):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      update = "UPDATE lists SET bought=%s WHERE id=%s"
      cursor.execute(update, (bought,id))
      cnx.commit()
  def update_review_like(review_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      update = """
        UPDATE review
        SET likes=%s
        WHERE id=%s
      """
      row = CRUD.read_like(review_id)
      likes = row[0]
      values = [likes, review_id]
      cursor.execute(update, values)
      cnx.commit()
  def update_product_percent(product_id, percent, review):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      update = """
        UPDATE product
        SET percent=%s, review=%s
        WHERE id=%s;
      """
      values = [percent, review, product_id]
      cursor.execute(update, values)
      cnx.commit()
  def delete_list_item(payload, item_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      delete = "DELETE FROM lists WHERE user_id=%s AND id=%s"
      cursor.execute(delete, (payload["id"],item_id))
      cnx.commit()
  def delete_review(review_id, user_id):
    with cnxpool.get_connection() as cnx:
      try:
        cursor = cnx.cursor()
        delete = "DELETE FROM review_likes WHERE review_id=%s;"
        cursor.execute(delete, (review_id,))
        cnx.commit()
        delete = "DELETE FROM review WHERE id=%s AND user_id=%s;"
        cursor.execute(delete, (review_id, user_id))
        cnx.commit()
        return True
      except:
        return False