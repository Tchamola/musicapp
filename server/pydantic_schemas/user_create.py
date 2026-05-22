from pydantic import BaseModel


class UserCreate(BaseModel):
    nom : str
    email : str
    password : str