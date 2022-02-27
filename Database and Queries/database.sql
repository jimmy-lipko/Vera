DROP TABLE if exists web_request CASCADE;
CREATE TABLE web_request (
  id serial PRIMARY KEY,
  customer_id int,
  service_hours VARCHAR (255),
  manufacturer VARCHAR (255),
  name VARCHAR (255),
  message text,
  service_booked boolean,
  service_date DATE,
  submitted_at timestamp DEFAULT now(),
  CONSTRAINT web_request_fk
      FOREIGN KEY(customer_id)
	  REFERENCES customers(id)
);

DROP TABLE if exists customers CASCADE;
CREATE TABLE  customers (
   id serial PRIMARY KEY,
   customer_name VARCHAR (255) NOT NULL,
   address VARCHAR (255) NOT NULL,
   city VARCHAR (255),
   state_code VARCHAR (2) NOT NULL,
   country_code VARCHAR (2) NOT NULL,
   zip_code VARCHAR(10) NOT NULL,
   email VARCHAR(255)
   phone_number VARCHAR (20),
   location_type VARCHAR (20),
   business_type VARCHAR(20),
   customer_since timestamp NOT NULL default NOW()
);

DROP TABLE if exists technicians CASCADE;
CREATE TABLE technicians (
   id serial PRIMARY KEY,
   first_name VARCHAR (255),
   last_name VARCHAR (255),
   address VARCHAR (255),
   city VARCHAR (255),
   state_code VARCHAR (2),
   country_code VARCHAR (2),
   zip_code VARCHAR,
   phone_number VARCHAR (20),
   vera_affiliation boolean,
   technician_since timestamp NOT NULL default NOW()
);

DROP TABLE if exists products;
CREATE TABLE products (
	id serial PRIMARY KEY,
  type varchar(255),
  manufacturer_sku varchar(255),
	name varchar (255) NOT NULL,
	manufacturer varchar(255),
  group_heads varchar(255),
  configuration varchar(10),
  variation varchar(10),
	price decimal,
	cost decimal
);

DROP TABLE if exists reports CASCADE;
CREATE TABLE reports (
    id serial PRIMARY KEY,
    report_type varchar(25),
    technician_id int not null,
    customer_id int not null,
    pre_installation_report_id int,
    pm_schedule varchar(10) ,
    on_site_date date not null,
    amperage_reading int,
    voltage_reading int,
    psi_reading int,
    symptoms text,
    notes text,
    recommendations text,
    filter_replaced boolean,
    next_filter_repair date,
    observed_scale boolean,
    groundhead_temp int,
    duration int not null,
    report_submitted_at timestamp default now(),
    CONSTRAINT tech_fk
        FOREIGN KEY(technician_id)
      REFERENCES technicians(id),
    CONSTRAINT fk_customer_id
        FOREIGN KEY(customer_id)
      REFERENCES customers(id)
    );

DROP TABLE if exists jobs CASCADE;
CREATE TABLE jobs (
	id serial PRIMARY KEY,
  job_type varchar(20),
	report_id int not null,
	product_id int not null,
  product_serial_number varchar(255),
  product_manufacturer_invoice_date DATE,
	qty int,
  machine_downtime_days int,
	start_date date not null,
  end_date date,
	CONSTRAINT fk_report
      FOREIGN KEY(report_id)
	  REFERENCES reports(id),
	CONSTRAINT fk_products
      FOREIGN KEY(product_id)
	  REFERENCES products(id)
);

DROP TABLE if exists water_analysis CASCADE;
CREATE TABLE  water_analysis (
	id serial PRIMARY KEY,
  date_results DATE,
	report_id int not null,
	pre_or_post_filtration varchar(4),
	alkalinity int,
  ammonia int,
  nacl int,
  dpd1 int,
  dpd4 int,
  cu2 int,
  caco3 int,
  no3 int,
  ph int,
  phosphate int,
  submitted_at timestamp default now(),
	CONSTRAINT fk_report
      FOREIGN KEY(report_id)
	  REFERENCES reports(id)
);
