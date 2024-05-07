#!/bin/bash

source connect-db.sh
connection_db
# psql -h ${host} -U ${user} -p ${port} -d ${database_name} -c "SELECT 1"

# awk -F',' '{print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12}' "$(dirname "$0")/exported_data_MD4.csv" | iconv -f SHIFT-JIS -t UTF-8
# awk -F',' '{print $1, $2, $3, $4, $5, $6, $7, $8, $9, $10, $11, $12, $13}' "$(dirname "$0")/exported_data_MD2.csv" | iconv -f SHIFT-JIS -t UTF-8
# tail -n +2 "$(dirname "$0")/exported_data_MD4.csv" | 
# while read line
# do
#    echo "Record is : $line"
# done < <(iconv -f SHIFT-JIS -t UTF-8 "$(dirname "$0")/exported_data_MD4.csv")

############# DOING #######################
count=1
current_year=2024
store_code='ksm1'
while IFS=',' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13
do
    if [ $count -gt 1 ]; then
        psql -h ${host} -U ${user} -p ${port} -d ${database_name} -c "
        INSERT INTO monthly_holiday 
            (store_code, type, year, january, february, march, april, may, june, july, august, september, october, november, december) 
        VALUES 
            ('$store_code', '$count', '$current_year', '$col2', '$col3', '$col4', '$col5', '$col6', '$col7', '$col8', '$col9', '$col10', '$col11', '$col12', '$col13');
        "
    fi
  ((count++)) 
done < <(tail -n +2 "$(dirname "$0")/exported_data_MD4.csv")
############ DOING #####################


# count=1  # Khởi tạo biến đếm
# while IFS=',' read -r col1 col2 col3 col4 col5 col6 col7 col8 col9 col10 col11 col12 col13
# do
#   if [ $count -gt 1 ]; then  # Bỏ qua dòng header (nếu count > 1)
#     echo "Row $((count - 1)) - Column 1: $col1, Column 2: $col2, Column 3: $col3"
#   fi
#   ((count++))  # Tăng biến đếm sau mỗi lần lặp
# done < <(iconv -f SHIFT-JIS -t UTF-8 "$(dirname "$0")/exported_data_MD4.csv")