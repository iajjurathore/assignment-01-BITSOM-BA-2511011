## Storage Systems ##

For Goal 1 (Predict patient readmission risk), I chose **PostgreSQL** as the primary storage. Patient treatment history, diagnoses, and admission records are structured and relational in nature. PostgreSQL supports ACID transactions which ensures data accuracy. A machine learning model reads historical data from PostgreSQL to generate a readmission risk score per patient.

For Goal 2 (Plain English patient history search), I used **MongoDB** to store unstructured doctor notes and reports, combined with a **Vector Database (Pinecone)**. Doctor notes are converted to vector embeddings and stored in Pinecone. When a doctor types a query like "Has this patient had a cardiac event before?", the query is converted to an embedding and a similarity search is run against Pinecone to find the most relevant records.

For Goal 3 (Monthly reports for management), I chose a **Data Warehouse** (such as Amazon Redshift or PostgreSQL with star schema). Transactional data is moved to the warehouse using an ETL pipeline. The warehouse supports OLAP queries which are needed for aggregations like total bed occupancy per month or department-wise costs. A BI tool like Metabase reads from the warehouse to generate reports.

For Goal 4 (Stream and store real-time ICU vitals), I used **Apache Kafka** for real-time data ingestion and **TimescaleDB** for time-series storage. ICU devices send continuous readings which Kafka collects and passes to TimescaleDB. Kafka is ideal here because it handles high-volume streams and TimescaleDB is optimized for time-stamped data like heart rate or blood pressure readings.

## OLTP vs OLAP Boundary ##

The transactional system (OLTP) includes PostgreSQL and MongoDB. These handle real-time operations such as inserting new patient records, updating treatments, and storing doctor notes. The analytical system (OLAP) begins at the Data Warehouse. Raw data from PostgreSQL is extracted, transformed, and loaded into the warehouse on a scheduled basis (for example, every night). The BI tool and management reports only query the warehouse and never touch the OLTP databases directly. This separation ensures that heavy analytical queries do not slow down the day-to-day hospital operations.

## Trade-offs

One significant trade-off in this design is **data duplication**. Patient data exists in both PostgreSQL (operational) and the Data Warehouse (analytical). This means storage costs are higher and the ETL pipeline must be maintained carefully to keep both systems in sync. If a record is updated in PostgreSQL after the last ETL run, the warehouse will have stale data until the next sync.

To mitigate this, the ETL process should run frequently (every few hours for critical data) and use incremental loading instead of full reloads. An event-driven approach using Kafka can also help by capturing changes in PostgreSQL and pushing updates to the warehouse in near real-time, reducing the lag between the two systems.