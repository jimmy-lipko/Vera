Database: postgres


DROP TABLE if exists customers;
CREATE TABLE  customers (
   customer_id serial PRIMARY KEY,
   customer_name VARCHAR (255) NOT NULL,
   address VARCHAR (255) NOT NULL,
   city VARCHAR (255),
   state_code VARCHAR (2) NOT NULL,
   country_code VARCHAR (2) NOT NULL,
   zip_code INT NOT NULL,
   phone_number VARCHAR (20),
   customer_since timestamp NOT NULL default NOW()
);

DROP TABLE if exists technicians ;
CREATE TABLE technicians (
   technician_id serial PRIMARY KEY,
   first_name VARCHAR (255),
   last_name VARCHAR (255),
   address VARCHAR (255),
   city VARCHAR (255),
   state_code VARCHAR (2),
   country_code VARCHAR (2),
   zip_code INT,
   phone_number VARCHAR (20),
   vera_affiliation boolean,
   technician_since timestamp NOT NULL default NOW()
);

DROP TABLE if exists products;
CREATE TABLE products (
	product_id serial PRIMARY KEY,
	name varchar (255) NOT NULL,
	sku varchar(255),
  serial_number varchar (255),
	manufacturer varchar(255),
  manufacturer_invoice_number int,
  manufacture_date date,
  manufacture_invoice_date date,
	price decimal,
	cost decimal
);

DROP TABLE if exists reports;
CREATE TABLE reports (
	report_id serial PRIMARY KEY,
	technician_id int not null,
	customer_id int not null,
  reactive boolean not null,
  schedule varchar(10) check (schedule in ('Annual', 'Biannual')),
	repair_date date not null,
	report_submitted_at timestamp default now(),
	amperage_reading int,
	voltage_reading int,
	psi_reading int,
	duration int not null,
	symptoms text,
	notes text,
	recommendations text,
	filter_replaced boolean,
	next_filter_repair date,
	observed_scale boolean,
	groundhead_temp int,
	CONSTRAINT tech_fk
      FOREIGN KEY(technician_id)
	  REFERENCES technicians(technician_id)
	CONSTRAINT fk_customer_id
      FOREIGN KEY(customer_id)
	  REFERENCES customers(customer_id)
);

DROP TABLE if exists repairs;
CREATE TABLE repairs (
	repair_id serial PRIMARY KEY,
	report_id int not null,
	product_id int not null,
	qty int not null,
  machine_downtime_days int,
	repair_date date not null,
  reason text,
	CONSTRAINT fk_report
      FOREIGN KEY(report_id)
	  REFERENCES reports(report_id)
	CONSTRAINT fk_products
      FOREIGN KEY(product_id)
	  REFERENCES products(product_id)
);

DROP TABLE if exists installations;
CREATE TABLE  installations (
	installation_id serial PRIMARY KEY,
	report_id int not null,
	product_id int not null,
	qty int not null,
	installation_date date not null,
  electric_receptacle varchar(255),
  water_supply_fitting varchar(255),
  pm_schedule text,
  filter_schedule text
	CONSTRAINT fk_report
      FOREIGN KEY(report_id)
	  REFERENCES reports(report_id)
	CONSTRAINT fk_products
      FOREIGN KEY(product_id)
	  REFERENCES products(product_id)
);

DROP TABLE if exists installations;
CREATE TABLE  installations (
	installation_id serial PRIMARY KEY,
	report_id int not null,
	product_id int not null,
	qty int not null,
	installation_date date not null,
  electric_receptacle varchar(255),
  water_supply_fitting varchar(255),
  pm_schedule text,
  filter_schedule text
	CONSTRAINT fk_report
      FOREIGN KEY(report_id)
	  REFERENCES reports(report_id)
	CONSTRAINT fk_products
      FOREIGN KEY(product_id)
	  REFERENCES products(product_id)
);

DROP TABLE if exists water_analysis;
CREATE TABLE  water_analysis (
	water_analysis_id serial PRIMARY KEY,
	report_id int not null,
	pre_or_post_filtration varchar(4) check (pre_or_post_filtration in ('pre','post'))
	alkalinity int,
  ammonia int,
  nacl int,
  dpd1 int,
  dpd4 int,
  cu2 int,
  caco3 int,
  no3 int,
  ph int,
  phosphate,
	CONSTRAINT fk_report
      FOREIGN KEY(report_id)
	  REFERENCES reports(report_id)
);
