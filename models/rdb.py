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
      if category!="":
        where += " AND category.name=%s"
        value.append(category)
      if brand!="":
        where += " AND brand.name=%s"
        value.append(brand)
      order = " ORDER BY product.id DESC"
      cursor.execute(select+where+order, value)
      rows = cursor.fetchall()
      return rows
  def read_category():
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      select = """
        SELECT category.name as category, COUNT(product.id) as count
        FROM category JOIN product
        ON category.id=product.category
        GROUP BY category.name
        ORDER BY count DESC;
      """
      cursor.execute(select)
      rows = cursor.fetchall()
      return rows
  def update_list_item(id, bought):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      update = "UPDATE lists SET bought=%s WHERE id=%s"
      cursor.execute(update, (bought,id))
      cnx.commit()
  def delete_list_item(payload, item_id):
    with cnxpool.get_connection() as cnx:
      cursor = cnx.cursor()
      delete = "DELETE FROM lists WHERE user_id=%s AND id=%s"
      cursor.execute(delete, (payload["id"],item_id))
      cnx.commit()