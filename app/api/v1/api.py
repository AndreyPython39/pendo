from fastapi import APIRouter
from app.api.v1.endpoints import (
    users,
    auth,
    tribes,
    matches,
    messages,
    moderation,
    icebreaker
)

api_router = APIRouter()
api_router.include_router(auth.router, tags=["authentication"])
api_router.include_router(users.router, prefix="/users", tags=["users"])
api_router.include_router(tribes.router, prefix="/tribes", tags=["tribes"])
api_router.include_router(matches.router, prefix="/matches", tags=["matches"])
api_router.include_router(messages.router, prefix="/messages", tags=["messages"])
api_router.include_router(moderation.router, prefix="/moderation", tags=["moderation"])
api_router.include_router(icebreaker.router, prefix="/icebreaker", tags=["icebreaker"])
