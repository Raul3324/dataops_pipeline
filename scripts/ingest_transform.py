from pyspark.sql import SparkSession

# Initialize Spark with Delta Lake support
spark = SparkSession.builder \
    .appName("DeltaIngest") \
    .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension") \
    .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog") \
    .getOrCreate()

# Read from HDFS
df = spark.read.csv("hdfs://hadoop-namenode:8020/user/data/input/application_train.csv", header=True, inferSchema=True)

# Drop rows without target
df_clean = df.dropna(subset=["TARGET"])

# Write to Delta Lake 
df_clean.write \
    .format("delta") \
    .mode("overwrite") \
    .save("hdfs://hadoop-namenode:8020/user/data/output/application_train_delta")

spark.stop()

