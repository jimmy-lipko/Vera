import sys
from flask_sqlalchemy import SQLAlchemy
from flask import Flask, request, json

application = Flask(__name__)
application.config['SQLALCHEMY_DATABASE_URI'] = 'prod.cazcqhfxsztq.us-east-1.rds.amazonaws.com'
db = SQLAlchemy(application)


def __init__(self, arg):
        super(, self).__init__()
        self.arg = arg



@application.route('/veraWebsite',methods=['POST'])
def veraWebsite():
    sys.stdout.flush()
    if request.method == 'POST':
        data =request.json)
        df =

        return '',200
    else:
        abort(400)




@application.route('/')
def hello():
    return 'Listening...'



if __name__ == '__main__':
    application.run(debug=True)
