import sys
import psycopg2
from flask import Flask, request, json

application = Flask(__name__)


def __init__(self, arg):
        super(application, self).__init__()
        self.arg = arg

conn = psycopg2.connect(host='prod.cazcqhfxsztq.us-east-1.rds.amazonaws.com',
                        port='5432',
                        user='postgres',
                        password='password',
                        database='postgres')



@application.route('/veraWebsite',methods=['POST'])
def veraWebsite():
    sys.stdout.flush()
    content_type = request.headers.get('Content-Type')
    if (request.method == 'POST') & (content_type == 'application/json'):

        data = request.get_json()

        customer_query = """INSERT INTO customers (
          customer_name,
          address,
          city,
          state_code,
          country_code,
          zip_code,
          phone_number,
          location_type,
          business_type
          )
        VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s) RETURNING id;"""

        cursor1 = conn.cursor()
        cursor1.execute(customer_query,(data["customer_name"], data["address"],data["city"], data["state_code"], data["country_code"],data["zip_code"], data["phone_number"], data["location_type"], data["business_type"]))
        conn.commit()
        customer_id = cursor1.fetchone()[0]
        cursor1.close()

        cursor2 = conn.cursor()


        website_data_query = """INSERT INTO web_request (
          customer_id,
          service_hours,
          manufacturer,
          model,
          message
          )
        VALUES ('""" + str(customer_id) + "','" + data['service_hours'] + "','" + data['manufacturer'] + "','" + data['model'] + "','" + data['message'] + "'" + ')'

        cursor2.execute(website_data_query)
        conn.commit()
        cursor2.close()

        return '', 200
    else:
        abort(400)




@application.route('/')
def hello():
    return 'Listening...'



if __name__ == '__main__':
    application.run(debug=True)
