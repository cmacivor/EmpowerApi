Please follow the below mentioned steps to load the data in staging environment.


1.Run the drop script- 0_DROP_JUSTICESERVICES_DEV.sql, it will drop all the tables and stored procedures from existing database.

2.Run the Create script- 1_CREATE_JUSTICESERVICES_DEV.sql, make sure if JJSCaseMgt database in  (dit-mssql01-sv) has the correct data as like JJScaseMgt(dit-mssql-p).

If not restore the JJSCaseMgt(dit-mssql01-sv) with JJScaseMgt(dit-mssql-p).

3.Run the insert script to load the data from JJScasemgt(dit-mssql01-sv).

4.Run the loading script for personaddress table -3-Load Person Address.sql, it will truncate all the existing data in personaddress table and load the new data.


5. update the ssns with encrypt ssn button in search screen and update the unique ids with update unique id button(these buttons  will be hided in the code just uncomment the code in search.html).

6.compare the servicerelease(active column) with JJS case mgt.[tblSrvRelease] table data.

7. run the updatescript.sql