# delete the customers.dat file already present in HDFS path
hadoop fs -rm /user/arvind/hbase/acadgild/assignments/assignment_18.1/input/customers.dat;

# create a directory in HDFS to store the input file
hadoop fs -mkdir -p /user/arvind/hbase/acadgild/assignments/assignment_18.1/input;

# copy the input file from local file system to HDFS
# the input file was already downloaded and kept at /home/arvind/hbase/acadgild/assignments/assignment_18.1/input/
hadoop fs -put /home/arvind/hbase/acadgild/assignments/assignment_18.1/input/customers.dat /user/arvind/hbase/acadgild/assignments/assignment_18.1/input/customers.dat;

# import to the customer table using ImportTsv utility
# importtsv.separator property specifies comma(,) as the field sperator
# importtsv.columns specifies the mapping of the CSV file fields to the Hbase columns
# customer is the name of the Hbase table to which we have to import the data
# finally we specify the path to the input file in HDFS
hbase org.apache.hadoop.hbase.mapreduce.ImportTsv -Dimporttsv.separator=,  -Dimporttsv.columns="HBASE_ROW_KEY,details:name,details:location,details:age" customer 'hdfs://hadoop-mn-master:19000/user/arvind/hbase/acadgild/assignments/assignment_18.1/input/customers.dat';

# display the contents of the customer table in Hbase
echo "scan 'customer'"| hbase shell -n;
