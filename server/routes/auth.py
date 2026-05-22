import uuid
import bcrypt
from fastapi import HTTPException
from database import get_db
from models.user import User
from pydantic_schemas.user_create import UserCreate
from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from pydantic_schemas.user_login import UserLogin

router = APIRouter()

@router.post("/signup", status_code=201)
def signup_user(user : UserCreate, db: Session = Depends(get_db)):
    # Extraire les données venant d'une requete

    # Vérifier si ces données existent déjà dans la db
    user_db = db.query(User).filter(User.email == user.email).first()
    if user_db:
        raise HTTPException(400, "l'utilisateur de ce cet email existe déjà !")
        
    hashed_pw = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())
    
    user_db = User(id = str(uuid.uuid4()), nom = user.nom, email = user.email, password = hashed_pw)
    # Sinon, ajouter à la base de données
    db.add(user_db)
    db.commit()
    db.refresh(user_db)

    return user_db

@router.post("/login")
def login_user(user : UserLogin, db: Session = Depends(get_db)):

    user_db = db.query(User).filter(User.email == user.email).first()
    
    if not user_db:
        raise HTTPException(400, "L'utilisateur de cet email n'existe pas !") 
    
    is_match = hash_pw = bcrypt.checkpw(user.password.encode(), user_db.password)
    
    if not is_match:
        raise HTTPException(400, "Mot de passe incorrect !")
    
    return user_db

