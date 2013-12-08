#!/bin/bash
curpath=$(pwd)

filename=$(git status -s |awk '$1 ~/^[M]/ {print $2}')
filename1=$(git status -s |awk '$1 ~/^[A]/ {print $2}')
echo $filename
echo $filename1

#在当前目录下创建export目录，用于保存修改文件目录树
if [ ! -d "export" ]; then
	#echo "create export dir"
	mkdir export
else
	rm -rf export/*
fi

logfile=$curpath/export/modify$(date +%y%m%d%H%M%S).log
#echo "modify log begin..." >$logfile

for file in $filename
do
	cp --parents $filename $curpath/export/
	echo "The following files is Modified." >>$logfile
	echo $curpath/$file >>$logfile
done

echo "===================================================" >> $logfile

for file1 in $filename1
do
	cp --parents $filename1 $curpath/export/
	echo "The following files is Added." >>$logfile
	echo $curpath/$file1 >>$logfile
done

#update log
if [ "$1" ]; then
	update_log=$curpath/export/Readme$(date +%y%m%d%H%M%S).txt
	#echo "user log exist!"
	echo "$1" >$update_log
#else
	#echo "user log not exist"
fi
