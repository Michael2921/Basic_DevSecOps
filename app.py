from pymongo import MongoClient
from dotenv import load_dotenv
import os

load_dotenv()

# Connecting to the MongoDB server

uri = (
    f"mongodb://{os.getenv('MONGODB_USER')}:"
    f"{os.getenv('MONGODB_PASS')}@{os.getenv('MONGODB_HOST')}:{os.getenv('MONGODB_PORT')}/"

)

print(uri)

client = MongoClient(uri)

# Create database
db = client["test_database"]

# Create a collection
collection = db["users"]

# Add values
user_data = {"name": "Default_User", "age": 25, "skills": ["Python", "MongoDB"]}

result = collection.insert_one(user_data)

