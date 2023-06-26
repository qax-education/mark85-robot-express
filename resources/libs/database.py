from robot.api.deco import keyword
from pymongo import MongoClient
import bcrypt

client = MongoClient('mongodb+srv://qa:xperience@cluster0.ood54mi.mongodb.net/?retryWrites=true&w=majority')

db = client['markdb']

@keyword('Clean user from database')
def clean_user(user_email):
    users = db['users']
    tasks = db['tasks']

    u = users.find_one({'email': user_email})

    if (u):
        tasks.delete_many({'user': u['_id']})
        users.delete_many({'email': user_email})

@keyword('Remove user from database')
def remove_user(email):
    users = db['users']
    users.delete_many({'email': email})
    print('removing user by ' + email)

@keyword('Insert user from database')
def insert_user(user):

    hash_pass = bcrypt.hashpw(user['password'].encode('utf-8'), bcrypt.gensalt(8))

    doc = {
        'name': user['name'],
        'email': user['email'],
        'password': hash_pass
    }

    users = db['users']
    users.insert_one(doc)
    print(user)
