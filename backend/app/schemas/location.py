from pydantic import BaseModel
from typing import Optional


class Location(BaseModel):
    latitude: float
    longitude: float
    city: Optional[str] = None
    country: Optional[str] = None

    class Config:
        orm_mode = True
