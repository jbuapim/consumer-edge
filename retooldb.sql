create table retool.brand_product(
  brand_product_id int unsigned not null auto_increment,
  brand_id int unsigned not null,
  product_id int not null,
  publish_flag tinyint not null CHECK(publish_flag BETWEEN 0 AND 2),
  channel_publish_flag int not null,
  delivery_publish_flag int not null,
  updated_dt_tm datetime not null,
  updated_user_id int not null,
  PRIMARY KEY (brand_product_id),
  FOREIGN KEY (brand_id) REFERENCES brand(id)
),

create table retool.product(
  id int unsigned not null auto_increment,
  name varchar(255) not null,
  description TEXT not null,
  updated_dt_tm datetime not null,
  updated_user_id int not null,
  PRIMARY KEY (id)
)


create table retool.segment_product(
  id int unsigned not null auto_increment,
  segment_id int unsigned not null,
  symbol_id int unsigned not null,
  product_id int unsigned not null,
  primary_segment_flag int unsigned,
  publish_flag tinyint not null CHECK(publish_flag BETWEEN 0 AND 2),
  channel_publish_flag int unsigned,
  updated_dt_tm datetime not null,
  updated_user_id int not null,

  FOREIGN KEY (segment_id) REFERENCES retool.segment(segment_id),
  FOREIGN KEY (symbol_id) REFERENCES retool.symbol(symbol_id),
  FOREIGN KEY (product_id) REFERENCES retool.product(id),

  PRIMARY KEY (id)
);

create table retool.metric_list(
  metric_type_id int unsigned not null auto_increment,
  metric_type varchar(20),
  metric_desc varchar(255),   

  updated_dt_tm datetime not null,
  updated_user_id int not null,

  PRIMARY KEY (metric_type_id)
);


create table retool.segment_product_metric(
  id int unsigned not null auto_increment,
  metric_type_id int unsigned not null,
  segment_id int unsigned not null,
  product_id int unsigned not null,
  primary_segment_metric_flag int unsigned,
  

  updated_dt_tm datetime not null,
  updated_user_id int not null,

  FOREIGN KEY (segment_id) REFERENCES retool.segment(segment_id),
  FOREIGN KEY (product_id) REFERENCES retool.product(id),
  PRIMARY KEY (id)
 );



  --same as segment_financial
  create table retool.segment_financial_metric(
  id unsigned int not null auto_increment,    
  segment_product_metric_id int unsigned not null auto_increment,
  financial_id int unsigned not null,
  fundamental varchar(255),
  fundamental_shortcoming varchar(255),
  suggested_remedy varchar(255),
  primary_financial_flag int unsigned,


  updated_dt_tm datetime not null,
  updated_user_id int not null,

  PRIMARY KEY (id)
 )

 as

 select
 id, 
 segment_id as segment_product_metric_id,
 financial_id,
 fundamental,
 shortcoming as fundamental_shortcoming ,
 remedy as suggested_remedy,

  updated_dt_tm ,
  updated_user_id 

 from ceidb.segment_financial

--  need to create
-- same as financial-detail  table
create table retool.financial_metric_detail(
  financial_id int unsigned not null,
  symbol_id int unsigned not null,
  reported_metric_summary varchar(255),
  reported_metric_attrib1 varchar(255),
  reported_metric_attrib2 varchar(255),
  reported_metric_attrib3 varchar(255),
  reported_metric_type varchar(255),
  reported_metric_currency varchar(255),
  financial_type varchar(20),
  estimated_type varchar(20),


  updated_dt_tm datetime not null,
  updated_user_id int not null,

  FOREIGN KEY (financial_id) REFERENCES retool.segment_financial_metric(id),
  FOREIGN KEY (symbol_id) REFERENCES retool.symbol(symbol_id),

  PRIMARY KEY (financial_id)
 )
 as 
 select 
 financial_id,
 symbol_id,
 summary as reported_metric_summary, 
 attrib1 as reported_metric_attrib1,
 attrib2 as reported_metric_attrib2,
 attrib3 as reported_metric_attrib3,
 metric_type as reported_metric_type,
 currency as reported_metric_currency,
 financial_type,
 metric_type,
updated_dt_tm ,
updated_user_id
from ceidb.financial_detail
 
 create table retool.macro_financial_metric(
  macro_id int unsigned not null auto_increment,
  macro_financial_id int unsigned not null,
  fundamental varchar(255),
  fundamental_shortcoming varchar(255),
  suggested_remedy varchar(255),
  
  updated_dt_tm datetime not null,
  updated_user_id int not null,

  PRIMARY KEY (macro_id)
 ), 

  create table retool.macro_financial_metric_detail(
      id int unsigned not null auto_increment,
      macro_financial_id int unsigned not null,
      macro_financial_name varchar(255),
      metric_summary Text,
      metric_type varchar(50),
      metric_currency varchar(50),
      metric_country varchar(255),
      
      dev_publish_flag int unsigned not null,
      prod_publish_flag int unsigned not null,
      
      updated_dt_tm datetime not null,
      updated_user_id int not null,
      
      PRIMARY KEY (id),
     FOREIGN KEY (macro_financial_id) REFERENCES macro_financial_metric(macro_id)
 ), 


--  need to create



create table retool.brand_cleansed_name(
  brand_cleansed_id int,
  brand_id int,
  cleansed_name varchar(250),
  publish_flag TinyInt,
  updated_dt_tm datetime,
  updated_user_id TinyInt,
  PRIMARY KEY(brand_cleansed_id)
) as
select
  brand_cleansed_id,
  brand_id,
  cleansed_name,
  publish_flag,
  updated_dt_tm,
  updated_user_id
from
  ceidb.brand_cleansed_name


create table retool.transact_us_ats_mid_pattern(
  pattern_match_id int,
  brand_id int unsigned,
  map_unmap varchar(50),
  match_method varchar(50),
  merchdesc varchar(250),
  mid varchar(512),
  mcc varchar(1000),
  city varchar(250),
  state varchar(11),
  publish_flag tinyint not null CHECK(publish_flag BETWEEN 0 AND 2),
  updated_dt_tm datetime,
  updated_user_id int,
  PRIMARY KEY(pattern_match_id),
  FOREIGN KEY (brand_id) REFERENCES brand(brand_id)
) AS
SELECT
  pattern_match_id,
  brand_id,
  map_unmap,
  match_method,
  merchdesc,
  mid,
  mcc,
  city,
  state,
  prod_publish_flag as publish_flag,
    updated_dt_tm,
  updated_user_id
FROM
  ceidb.mid_pattern


create table retool.mid_subchannel_pattern(
    pattern_channel_id int unsigned not null auto_increment,
    brand_id int unsigned,
    subchannel varchar(255),
    match_method varchar(255),
    merchdesc Text,
    mid varchar(255),
    mcc varchar(255),
    city varchar(255),
    state varchar(255),

    publish_flag tinyint not null CHECK(publish_flag BETWEEN 0 AND 2),

    updated_dt_tm datetime not null,
    updated_user_id int not null,

    PRIMARY KEY(pattern_channel_id),
    FOREIGN KEY(brand_id) REFERENCES retool.brand(brand_id)
)


create table retool.mid_storenum_pattern(
    pattern_storenum_id int unsigned not null auto_increment,
    brand_id int unsigned,

    match_method varchar(100),
    merchdesc varchar(100),
    mid varchar(512),
    mcc varchar(100),
    city varchar(250),
    state varchar(100),

    storenum_extract_field varchar(100),
    storenum_extract_pattern varchar(100),

    publish_flag tinyint not null CHECK(publish_flag BETWEEN 0 AND 2),

    updated_dt_tm datetime not null,
    updated_user_id int not null,

    PRIMARY KEY(pattern_storenum_id),
    FOREIGN KEY(brand_id) REFERENCES retool.brand(brand_id)
)
AS 
SELECT 
pattern_storenum_id ,
brand_id,
match_method,
merchdesc,
mcc,
city,
state,
 storenum_extract_field,
 storenum_extract_pattern,
 prod_publish_flag as publish_flag,
  updated_dt_tm,
    updated_user_id
    
    from ceidb.store_num_pattern






CREATE TABLE retool.mid_match_brand_ats(


mtid  varchar(255),

main_brand_id  int unsigned,

distribution_brand_id  int unsigned,

payment_brand_id  int unsigned,

main_pattern_match_id  int unsigned,

distribution_pattern_match_id  int unsigned,

payment_pattern_match_id  int unsigned



)


CREATE TABLE retool.mid_match_subchannel_ats(


mtid  varchar(255),

main_brand_id  int unsigned,

distribution_brand_id  int unsigned,

payment_brand_id  int unsigned,

subchannel  varchar(255),

storenum  varchar(255),

pattern_channel_id  int unsigned,

pattern_storenum_id  int unsigned




)


CREATE TABLE retool.mid_match_location_weight_ats(

mtid  varchar(255),

main_brand_id  int unsigned,

locationid  varchar(255),

loc_match_type  varchar(255),

loc_match_weight  varchar(255)




)

CREATE TABLE retool.mid_match_ats(


mtid  varchar(255),

main_brand_id  int unsigned,

distribution_brand_id  int unsigned,

payment_brand_id  int unsigned,

channel  varchar(255),

locationid  varchar(255),

loc_score FLOAT(2)

)


CREATE TABLE retool.location(
    locationid  int unsigned auto_increment,

source  varchar(255),

source_id  int unsigned,

brand_id  int unsigned,

address  varchar(255),

city  varchar(255),

state  varchar(255),

zip  varchar(255),

country  varchar(255),

lat FLOAT(10),

long  FLOAT(2),

est_open_date  DateTime,

est_close_date  DateTime,

store_num  varchar(255),

PRIMARY KEY(locationid)





)

CREATE TABLE retool.trans(
  txid varchar(255),
  mtid varchar(255),
  membccid varchar(255),
  trans_date datetime,
  trans_amount FLOAT(2),
  filedate datetime,
  cobrid int unsigned
)

CREATE TABLE retool.mid(
  mtid varchar(255),
  mid varchar(255),
  merchdesc varchar(255),
  mcc varchar(255),
  city varchar(255),
  state varchar(255),
  zip varchar(5)
)


CREATE TABLE retool.card(
  membccid varchar(255),
  zip varchar(5),
  cardtype varchar(255),
  cobrid int unsigned,
  cbsa varchar(255),
  areaid varchar(255),
  zip5 varchar(5),
  individualid varchar(255)
)


CREATE TABLE retool.channel_list(
  subchannel varchar(3),
  channel varchar(3)
);


CREATE TABLE retool.industry_list(
  subindustry_id int not null,
  subindustry_name varchar(255),
  industry_name varchar(255),

  updated_dt_tm datetime not null,
  updated_user_id int not null,

);

CREATE TABLE retool.brand_parent_detail(
  brand_parent_id int not null,
  brand_parent_name varchar(255),
  subindustry int not null,
  naics_code varchar(20), 
  brand_url_addr varchar(255),

  updated_dt_tm datetime not null, 
  updated_user_id int not null,

);


CREATE TABLE retool.symbol_news(
  symbol_id int not null,
  segment_id int not null,
  product_id int not null,
  brand_id int not null,
  metric_type int not null,
  period varchar(255),
  news_date datetime,
  issue_desc text,
  impact_desc text,
  severity varchar(255),
  symbol_impact_type varchar(255),
  issue_type varchar(255),
  est_impact_start_dt datetime,
  est_impact_end_dt datetime,
  publish_flag tinyint not null CHECK(publish_flag BETWEEN 0 AND 2),



  updated_dt_tm datetime not null, 
  updated_user_id int not null

);

CREATE TABLE retool.period_review(
  segment_id int not null,
  financial_id int not null,
  product_id int not null,
  segment_product_metric_id int not null,
  publication_date datetime,
  publication_time datetime,
  reporting_date datetime,
  reporting_daypart varchar(255),
  panel varchar(255),
  version datetime,
  reported_metric_summary varchar(255),
  correlation Float(2),
  closed_period varchar(255),
  closed_panel_accel_yoy Float(2),
  closed_panel_implied_yoy Float(2),
  closed_consensus_yoy Float(2),
  partial_period varchar(255),
  partial_period_day int not null,
  partial_panel_accel_yoy Float(2),
  partial_panel_implied_yoy Float(2),
  partial_consensus_yoy Float(2),
  publish_flag tinyint not null CHECK(publish_flag BETWEEN 0 AND 2),
  updated_dt_tm datetime not null, 
  updated_user_id int not null

);


CREATE TABLE retool.financial_sss_detail(
    financial_id  int not null,
    valid_day_count  int not null,
    include_online_flag  int not null,
    full_period_flag  int not null,
    leap_year_exclude_flag  int not null,
    publish_flag  tinyint not null CHECK(publish_flag BETWEEN 0 AND 2),
    updated_dt_tm datetime not null, 
    updated_user_id int not null
);


CREATE TABLE retool.consensus_financial_metric(

consensus_id int not null,

financial_id int not null, is this a foreign key?

external_identifier varchar(255),

consensus_source varchar(255),

consensus_note varchar(255),

metric_unit varchar(255), 

metric_currency varchar(10),

    publish_flag  tinyint not null CHECK(publish_flag BETWEEN 0 AND 2),
    updated_dt_tm datetime not null, 
    updated_user_id int not null

);


CREATE TABLE retool.consensus_period(

consensus_id int not null,

period varchar(255),

 period_type varchar(255),
 metric FLOAT(2),

 source_publish_date datetime,
 updated_dt_tm datetime not null, 
 updated_user_id int not null

)




