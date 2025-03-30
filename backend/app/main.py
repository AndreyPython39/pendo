from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.core.config import settings
from app.api.v1.api import api_router
from app.core.monitoring import setup_monitoring

app = FastAPI(
    title=settings.APP_NAME,
    openapi_url=f"{settings.API_V1_STR}/openapi.json",
    docs_url="/docs",
    redoc_url="/redoc",
)

# Set up CORS middleware
origins = [
    "http://localhost",
    "http://localhost:3000",  # React frontend
    "http://localhost:8080",  # Vue frontend
    "http://localhost:4200",  # Angular frontend
    "http://localhost:19006",  # React Native web
    "http://10.0.2.2:8000",   # Android emulator
    "capacitor://localhost",   # iOS app
    "ionic://localhost"        # Ionic app
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Set up monitoring
setup_monitoring(app)

# Include API router
app.include_router(api_router, prefix=settings.API_V1_STR)

# Health check endpoint
@app.get("/health")
async def health_check():
    return {"status": "healthy"}
