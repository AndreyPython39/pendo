from fastapi import FastAPI
from app.api import users

app = FastAPI(
    title="Pendo API",
    version="1.0.0"
)

app.include_router(users.router, prefix="/users", tags=["Users"])