# Import all the models, so that Base has them before being
# imported by Alembic
from app.db.base_class import Base
from app.models.user import User
from app.models.tribe import Tribe
from app.models.match import Match, Like
from app.models.message import Message
