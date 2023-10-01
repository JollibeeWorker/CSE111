.mode csv
.separator "|"

CREATE TABLE lineitem (
    l_orderkey       INTEGER NOT NULL,
    l_partkey        INTEGER NOT NULL,
    l_suppkey        INTEGER NOT NULL,
    l_linenumber     INTEGER NOT NULL,
    l_quantity       DECIMAL(15,2) NOT NULL,
    l_extendedprice  DECIMAL(15,2) NOT NULL,
    l_discount       DECIMAL(15,2) NOT NULL,
    l_tax            DECIMAL(15,2) NOT NULL,
    l_returnflag     CHAR(1) NOT NULL,
    l_linestatus     CHAR(1) NOT NULL,
    l_shipdate       DATE NOT NULL,
    l_commitdate     DATE NOT NULL,
    l_receiptdate    DATE NOT NULL,
    l_shipinstruct   CHAR(25) NOT NULL,
    l_shipmode       CHAR(10) NOT NULL,
    l_comment        VARCHAR(44) NOT NULL
);

CREATE TABLE customer (
    c_id            INTEGER PRIMARY KEY,      
    c_custkey       VARCHAR(20) NOT NULL,     
    c_name          VARCHAR(50) NOT NULL,     
    c_nationkey     INTEGER NOT NULL,         
    c_phone         VARCHAR(15) NOT NULL,     
    c_acctbal       DECIMAL(10,2) NOT NULL,   
    c_mktsegment    VARCHAR(15) NOT NULL,     
    c_comment       TEXT NOT NULL,
    FOREIGN KEY (c_nationkey) REFERENCES nation(n_nationkey)             
);

CREATE TABLE nation (
    n_nationkey  INTEGER PRIMARY KEY,
    n_name       CHAR(25) NOT NULL,
    n_regionkey  INTEGER NOT NULL,
    n_comment    VARCHAR(152) NOT NULL,
    FOREIGN KEY (n_regionkey) REFERENCES region(r_regionkey)
);

CREATE TABLE orders (
    o_orderkey       INTEGER PRIMARY KEY,     
    o_custkey        INTEGER NOT NULL REFERENCES customer(c_id),      
    o_orderstatus    CHAR(1) NOT NULL,        
    o_totalprice     DECIMAL(10,2) NOT NULL,  
    o_orderdate      DATE NOT NULL,           
    o_orderpriority  VARCHAR(15) NOT NULL,    
    o_clerk          VARCHAR(20) NOT NULL,    
    o_shippriority   INTEGER NOT NULL,        
    o_comment        TEXT NOT NULL            
);

CREATE TABLE part (
    p_partkey INTEGER PRIMARY KEY,
    p_name VARCHAR(100),
    p_mfgr VARCHAR(50),
    p_brand VARCHAR(20),
    p_type VARCHAR(50),
    p_size INTEGER,
    p_container VARCHAR(20),
    p_retailprice DECIMAL(10,2),
    p_comment TEXT
);

CREATE TABLE partsupp (
    ps_partkey INTEGER,
    ps_suppkey INTEGER,
    ps_availqty INTEGER,
    ps_supplycost DECIMAL(10,2),
    ps_comment TEXT,
    FOREIGN KEY (ps_partkey) REFERENCES part(p_partkey)
);

CREATE TABLE region (
    r_regionkey INTEGER PRIMARY KEY,
    r_name TEXT,
    r_comment TEXT
);

CREATE TABLE supplier (
    s_suppkey INTEGER PRIMARY KEY,
    s_name TEXT,
    s_address TEXT,
    s_nationkey INTEGER,
    s_phone TEXT,
    s_acctbal REAL,
    s_comment TEXT,
    FOREIGN KEY (s_nationkey) REFERENCES nation(n_nationkey)
);

.import data/customer.tbl customer
.import data/lineitem.tbl lineitem
.import data/nation.tbl nation
.import data/orders.tbl orders
.import data/part.tbl part
.import data/partsupp.tbl partsupp
.import data/region.tbl region
.import data/supplier.tbl supplier