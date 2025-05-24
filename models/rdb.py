import os, json
from mysql.connector.errors import PoolError
from mysql.connector.pooling import MySQLConnectionPool
from datetime import datetime, timezone, timedelta
from passlib.context import CryptContext
dbconfig = {
  "user": os.getenv("DB_USER"),
  "password": os.getenv("DB_PASSWORD"),
  "host": "localhost",
  "database": "mygo"
}
cnxpool = MySQLConnectionPool(pool_size=5, **dbconfig)
pwd_context = CryptContext(schemes=["bcrypt"])


def get_next_page(page, rows):
  if len(rows) < 12:
    return None
  return page + 1
def generate_serial_number() -> str:
  return datetime.now(timezone(timedelta(hours=8))).strftime("%Y%m%d%H%M%S")
def generate_order_number(payload) -> str:
  with cnxpool.get_connection() as cnx:
    cursor = cnx.cursor()
    order_id = generate_serial_number()
    select = "SELECT * FROM orders WHERE id=%s"
    cursor.execute(select, (order_id,))
    row = cursor.fetchone()
    if row!=None:
      appended = f"-{payload["id"]%1000:03}"
      order_id += appended
    return order_id
def get_rating(rows):
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
  count = 0
  for i in range(5):
    total += result[i]*(i+1)
    count += result[i]
  avg_rating = total/count
  percent = avg_rating/5*100
  avg_rating = f"{avg_rating:.2}"
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
      insert = "INSERT INTO lists(user_id, item, specs) VALUES(%s, %s, %s)"
      cursor.execute(insert, (payload["id"], body.item, body.specs))
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
  def create_product(category, brand, name):
    with cnxpool.get_connection() as cnx:
      try:
        cursor = cnx.cursor()
        insert = "INSERT INTO product(category, brand, name) VALUES(%s, %s, %s)"
        cursor.execute(insert, (category,brand,name))
        cnx.commit()
        return True
      except:
        return False
  def create_review(payload, form, image_url):
    with cnxpool.get_connection() as cnx:
      try:
        cursor = cnx.cursor()
        insert = """
          INSERT INTO review(product_id, user_id, rating, comment, image_url, is_anonymous)
          VALUES(%s, %s, %s, %s, %s, %s);
        """
        if form.is_anonymous=="on":
          form.is_anonymous = True
        else:
          form.is_anonymous = False
        values = [form.product_id, payload["id"], form.rating, form.comment, image_url, form.is_anonymous]
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
  def read_attractions(page, keyword):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      limit = 12
      offset = page * limit
      select_all = "SELECT attraction.id, attraction.name, category, description, address, transport, mrt.name, lat, lng, images FROM attraction LEFT JOIN mrt ON attraction.mrt=mrt.id "
      if keyword==None:
        select = select_all+"LIMIT %s OFFSET %s"
        cursor.execute(select, (limit, offset))
      else:
        name = "%"+keyword+"%"
        select = select_all+"WHERE attraction.name LIKE %s OR mrt.name=%s LIMIT %s OFFSET %s"
        cursor.execute(select, (name, keyword, limit, offset))
      rows = cursor.fetchall()
      return rows
  def read_attraction(attractionId):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select_all = "SELECT attraction.id, attraction.name, category, description, address, transport, mrt.name, lat, lng, images FROM attraction LEFT JOIN mrt ON attraction.mrt=mrt.id "
      select = select_all+"WHERE attraction.id=%s"
      cursor.execute(select, (attractionId,))
      row = cursor.fetchone()
      return row
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
  def read_list(payload):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = "SELECT * FROM lists WHERE user_id=%s"
      cursor.execute(select, (payload["id"],))
      rows = cursor.fetchall()
      return rows
  def read_list_item(payload, item_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = "SELECT * FROM lists WHERE user_id=%s AND id=%s"
      cursor.execute(select, (payload["id"],item_id))
      row = cursor.fetchone()
      return row
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
  def read_products(keyword, category, brand):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = """
        SELECT product.id, category.name, brand.name, product.name
        FROM product JOIN category JOIN brand
        ON product.category=category.id AND product.brand=brand.id
      """
      where = " WHERE TRUE"
      value = []
      if keyword!="":
        where += " AND product.name LIKE %s"
        value.append(f"%{keyword}%")
      if category!="" and category!="類別":
        where += " AND category.name=%s"
        value.append(category)
      if brand!="" and brand!="品牌":
        where += " AND brand.name=%s"
        value.append(brand)
      order = " ORDER BY product.id DESC"
      cursor.execute(select+where+order, value)
      rows = cursor.fetchall()
      return rows
  def read_category(keyword, brand):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = """
        SELECT category.name as category, COUNT(product.id) as count
        FROM product JOIN category JOIN brand
        ON product.category=category.id AND product.brand=brand.id
      """
      where = " WHERE TRUE"
      value = []
      if keyword!="":
        where += " AND product.name LIKE %s"
        value.append(f"%{keyword}%")
      if brand!="" and brand!="品牌" and False: # banned
        where += " AND brand.name=%s"
        value.append(brand)
      group = " GROUP BY category.name"
      order = " ORDER BY count DESC;"
      cursor.execute(select+where+group+order, value)
      rows = cursor.fetchall()
      return rows
  def read_brand(keyword, category):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = """
        SELECT brand.name, COUNT(product.id) as count
        FROM product JOIN category JOIN brand
        ON product.category=category.id AND product.brand=brand.id
      """
      where = " WHERE TRUE"
      value = []
      if keyword!="":
        where += " AND product.name LIKE %s"
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
      cursor.execute(select+where, value)
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
      return result
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
  def delete_list_item(payload, item_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      delete = "DELETE FROM lists WHERE user_id=%s AND id=%s"
      cursor.execute(delete, (payload["id"],item_id))
      cnx.commit()