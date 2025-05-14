from fastapi import FastAPI, Request, Form
from fastapi.responses import FileResponse
from fastapi.staticfiles import StaticFiles
app = FastAPI()
app.mount("/static", StaticFiles(directory="static"), name="static")


@app.get("/")
async def index():
  return FileResponse("./static/index.html")


@app.post("/add-item")
async def add_item(description=Form()):
  return description