from fastapi import APIRouter

from .endpoints import (
    auth,
    users,
    tribes,
    matches,
    messages,
    moderation,
    icebreaker,
    stories,
    events,
    gifts,
    premium,
    streams
)

api_router = APIRouter()

# Auth routes
api_router.include_router(auth.router, prefix="/auth", tags=["auth"])
api_router.include_router(users.router, prefix="/users", tags=["users"])

# Core features
api_router.include_router(matches.router, prefix="/matches", tags=["matches"])
api_router.include_router(messages.router, prefix="/messages", tags=["messages"])
api_router.include_router(tribes.router, prefix="/tribes", tags=["tribes"])

# Cultural features
api_router.include_router(events.router, prefix="/events", tags=["events"])
api_router.include_router(stories.router, prefix="/stories", tags=["stories"])
api_router.include_router(streams.router, prefix="/streams", tags=["streams"])
api_router.include_router(gifts.router, prefix="/gifts", tags=["gifts"])

# Premium features
api_router.include_router(premium.router, prefix="/premium", tags=["premium"])

# Moderation
api_router.include_router(moderation.router, prefix="/moderation", tags=["moderation"])

# Utils
api_router.include_router(icebreaker.router, prefix="/icebreaker", tags=["icebreaker"])
