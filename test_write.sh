#!/bin/bash

read -p "test_path:" test_path
read -p "report_path:" report_path
read -p "data_path-256B:" path

mkdir ${path}

value_size=256

mkdir ${path}/${value_size}B

mkdir ${report_path}

# WAL state(true or false)
disable_wal="false"
value=256
data_path=${path}


	for dataset in {200,400}
	do	
		echo "创建测试目录${test_path}"
		mkdir ${test_path}
		mkdir ${path}
		mkdir ${path}/${value_size}B
		 ./write.sh ${path} ${dataset} ${value_size}

		sleep 60

		cp -r ${data_path}/${value}B/${dataset}G/* ${test_path}
		echo "复制${data_path}/${value}B/${dataset}G到${test_path}"

		sleep 10
	
		echo "进行测试写${dataset}G-value${value}-Disable_Wal-${disable_wal}"


		./overwrite.sh ${test_path} ${dataset} ${value} ${report_path} ${disable_wal}
		

		sleep 60
		
		./overwrite_1.sh ${test_path} ${dataset} ${value} ${report_path} ${disable_wal}
		sleep 5
		echo "本次测试完成删除test目录"
		rm -rf ${test_path}
		sleep 10
		rm -rf ${path}
		sleep 10

	done
