from sqlalchemy import*
from models.base import Base


class User(Base):
    __tablename__ = "users"

    id = Column(TEXT, primary_key=True)
    nom = Column(VARCHAR(100))
    email = Column(VARCHAR(100))
    password = Column(LargeBinary)