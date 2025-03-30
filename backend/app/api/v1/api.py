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
    streams,
    swipes,
    chat
)

api_router = APIRouter()

# Auth and Users
api_router.include_router(auth.router, prefix="/auth", tags=["auth"])
api_router.include_router(users.router, prefix="/users", tags=["users"])

# Core features
api_router.include_router(swipes.router, prefix="/swipe", tags=["swipes"])
api_router.include_router(chat.router, prefix="/chat", tags=["chat"])
api_router.include_router(matches.router, prefix="/matches", tags=["matches"])
api_router.include_router(messages.router, prefix="/messages", tags=["messages"])
api_router.include_router(tribes.router, prefix="/tribes", tags=["tribes"])
api_router.include_router(streams.router, prefix="/streams", tags=["streams"])

# Social features
api_router.include_router(stories.router, prefix="/stories", tags=["stories"])
api_router.include_router(gifts.router, prefix="/gifts", tags=["gifts"])
api_router.include_router(events.router, prefix="/events", tags=["events"])

# Premium features
api_router.include_router(premium.router, prefix="/premium", tags=["premium"])

# Engagement features
api_router.include_router(icebreaker.router, prefix="/icebreaker", tags=["icebreaker"])

# Moderation
api_router.include_router(moderation.router, prefix="/moderation", tags=["moderation"])
