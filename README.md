# Azure-Data-Eng-Pipeline


This project objetive is to setup an end-to-end Data Engineering pipeline using Apache Spark, Azure Databricks, Data Build Tool (DBT) and Azure Cloud services. 

The project was develoloped using a Medallion Architecture which involves three layers - bronze for raw data, silver for cleaned and conformed data, and gold for aggregated and business-level data. 

The project used the AdventureWorks LT sample database. 

![image](https://github.com/user-attachments/assets/f2bf9865-05fa-44b7-af5a-6c40c4419b43)

This image illustrates the project development. 

## Tools and Servies Utilized

1. **Cloud Provider -> Azure**: Azure offers a wire array of servies and tools in a cohesive ecosystem and easy to use;
2. **Database -> Azure SQL**: cloud-based version of Microsoft SQL Server.
3. **Azure Data Lake**: central repository for data storage and analytics. It is capable of handling high volumes of data either structured or unstructured.
4. **Azure Key Vault**: provides security and confidentiality in the project as it store and amanage sensitive information used in it such as keys, secrets and certificates.
5. **Azure Databricks**: apache spark-based analytics service with a direct link to Azure services, it is optimized for big data processing and machine learning.
6. **Azure Data Factory**: data integration tool, it is used to orchestrate and automate the movement and transformation of the data. Its pipeline allows to move the data between Azure services;
7. **dbt (Data Build Tool)**: open-source resource for data transformation, used to create and manage the data workflow during transformation stage of the project.

## Project Development Step-by-step

### 1. Set up Azure Services
* Setup "resource groups"
* Set up Storage Account using ADLS Gen2
* Set up Azure Key Vault -> Create your key vault
* Set up SQL Database -> Search for "SQL DAtabases", create a new database and accept the free database offer, and in "Additional Settings" select the "sample" option.
* Check Query Editor -> within SQL Database just created, check the database on the Query Editor.

### 2. Data Factory
* Go to "Managed > Linked Services" and add the SQL Database just created. It will ask for credentials.
* Go to "Managed > Linked Services" and add the DataLakeStorage (Gen2) and select "To file path" and in the second blank space write "bronze". This is where the data will be stored.
* Go to "Editor > Datasets > Create New" and create the dataset "TablesQuery" and "SqlTable" linked with the databased ealier added.
* * Go to "Editor > Datasets > Create New" and create a Parquet file. Add as parameters "FolderName" and "FileName"
* On "SqlTable > Parameters" create two parameters: SchemaName and TableName
* Go to Pipeline and add the "lookup activity" and in its "Settings", select the source dataset: TablesQueryl, unselect First row only, and select "Query" on Use query. Afterweards paste this query:
``` 
SELECT * FROM [database_name].information_schema.tables WHERE TABLE_SCHEMA = 'SalesLT' and TABLE_TYPE = 'BASE TABLE
```
* Go to pipeline and add "ForEach" and in its "Settings" add a dynamic field. It must be ```@activity('Fetch All Tables').output.value```
* Within ForEach, add "Copy Data" and add as source dataset "SqlTable" and it shall inherit its parameters. 
* Go to "Dataset > Parquet File" and in "Connection" on File path, configure "Bronze / @dataset().FolderName / @dataset().FileName" and select a compression type. 
* Within ForEach again, go to "Copy Data" and in "Sink" select the parquet file. Modify the properties of FolderName and Filename respectively with: ```@formatDateTime(utcnow(),'yyyyMMdd')``` and ```@concat(item().table_schema,'.',item().table_name,'.parquet')```

Afterwards save the pipeline and trigger debug, the data will be dumped into the bronze layer.

### 3. Databricks
* Add a Workspace
* Add "#secrets/createScope" at the end of the url, example: https://adb-00000000000.0.azuredatabricks.net/?o=00000000000#secrets/createScope, and fill the Key Vault properties based on your Key Vault settings.
* Afterwards mount every stage of the medallion with this code example:
```
dbutils.fs.mount(
 source='wasbs://bronze@medallionsa.blob.core.windows.net/',
 mount_point = '/mnt/bronze',
 extra_configs = {'fs.azure.account.key.medallionsa.blob.core.windows.net': dbutils.secrets.get('databricksScope','storageAccountKey')}
)
```
and to check each container ```dbutils.fs.ls("/mnt/bronze")```
* After succesfully mounting the containers and checking connection, leave only one cell with this code:
```
fileName = dbutils.widgets.get('fileName')
tableSchema = dbutils.widgets.get('table_schema')
tableName = dbutils.widgets.get('table_name')

#create database if it doesnt exist
spark.sql(f'create database if not exists {tableSchema}')

#if the table is not existting on the database, create it 
spark.sql("""CREATE TABLE IF NOT EXISTS """+tableSchema+"""."""+tableName+"""
            USING PARQUET
            LOCATION '/mnt/bronze/"""+fileName+"""/"""+tableSchema+"""."""+tableName+""".parquet'
          """)
```
* Go to "Profile > User Settings > Developer > Access tokens " and generate a new one. Save this key.
* Go back to Data Factory Pipeline and within ForEach, add Databricks, and create new linked service. Use the token created before.
* Within ForEach > Databricks, select "Settings" and add the parameters: table_schema, table_name, fileName and their values: ```@item().table_schema```,```@item().table_name```,```@formatDateTime(utcNow(),'yyyyMMdd')```

Trigger the pipeline again and now Databricks shall receive the data.

### 3. DBT
Open your IDE of choice and create a repository for github.
* On terminal: ```pip install dbt-databricks databricks-cli```
* ```databricks configure --token``` and add the token create on databricks earlier
* ```databricks secrets list-scopes``` (if you can see the secrets, its ok)
* ```dbt init``` -> set up project using databricks configurations on "compute > Advanced options > jdbc"
* ```dbt debug``` -> verify if theres any error
* create on snapshots the .sqls files listed on this repository, and also on models > staging, create the bronze.yml.
* ```dbt snapshot``` -> run, and check on databricks catalog if snapshots has been added. You can check on storage account / silver layer the same files.
* On "models" create "marts > customer, product, sales" folders and then copy the content from this repository.
* ```dbt run```  -> run, and check on databricks the new added tables on saleslt. The gold folder in storage account has the same.
* ```dbt docs generate``` and ```dbt docs serve``` and the documentation of the entire transformation will be done.

This is all the process to remake this project! 

