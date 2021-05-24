#!/bin/bash
# 简化上传文件到OSS
# 感谢官方工具(https://github.com/aliyun/ossutil)
# 使用命令格式如下：
# chmod +x osscp.sh
# ./osscp.sh [filename1] [filename2] [filenameN]

# 访问OSS配置（以下四个变量必须替换成可用信息）
endpoint="oss-cn-hangzhou.aliyuncs.com"
accessKeyID="***"
accessKeySecret="***"
bucketAndFold="***/***/"

# 生成或覆盖配置文件
conf="ossutilconf"
echo "[Credentials]
language=CH
endpoint=${endpoint}
accessKeyID=${accessKeyID}
accessKeySecret=${accessKeySecret}" > ${conf}

# 获取系统信息
SYS_UNAME=`uname  -a`
MAC_OS="Darwin"
CENTOS="centos"
UBUNTU_OS="ubuntu"
LINUX_OS="Linux"
OS_BIT=`getconf LONG_BIT`
 
if [[ $SYS_UNAME =~ $MAC_OS ]];then
    _SYS=$MAC_OS
elif [[ $SYS_UNAME =~ $CENTOS ]];then
    _SYS=$LINUX_OS
elif [[ $SYS_UNAME =~ $UBUNTU_OS ]];then
    _SYS=$LINUX_OS
elif [[ $SYS_UNAME =~ $LINUX_OS ]];then
    _SYS=$LINUX_OS
else
    echo "[ERROR]未知系统 SYSTEM:"$SYS_UNAME
    exit
fi
echo $_SYS

# 根据系统类型选择脚本
if [[ $_SYS == $MAC_OS && $OS_BIT == 64 ]]; then
	cmd=ossutilmac64
elif [[ $_SYS == $MAC_OS && $OS_BIT == 32 ]]; then
	cmd=ossutilmac32
elif [[ $_SYS == $LINUX_OS && $OS_BIT == 64 ]]; then
	cmd=ossutil64
elif [[ $_SYS == $LINUX_OS && $OS_BIT == 32 ]]; then
	cmd=ossutil32
else
	echo "[ERROR]未知系统:"$SYS_UNAME",未知BIT:"$OS_BIT
    exit
fi

# 脚本不存在则下载
if [ ! -e "${cmd}" ]; then
	echo "[INFO]下载脚本"${cmd}
	if [[ $cmd="ossutilmac64" || $cmd="ossutilmac32" ]]; then
		curl -o ${cmd} http://gosspublic.alicdn.com/ossutil/1.7.3/${cmd}
	elif [[ $cmd="ossutil64" || $cmd="ossutil32" ]]; then
		wget http://gosspublic.alicdn.com/ossutil/1.7.3/${cmd}
	else
		echo "[ERROR]未知脚本"${cmd}
		exit
	fi
fi

# 设置脚本执行权限
if [ ! -x "${cmd}" ]; then
	chmod 755 ${cmd}
fi

if [ $# -gt 0 ]; then
	echo "[INFO]上传文件，共计：$#"
	for i in "$@"; do
		echo ">>>上传文件[$i]============================"
	    ./${cmd} cp $i oss://${bucketAndFold} -c ${conf}
	done
	echo "[INFO]上传文件执行完毕！"
else
	echo "[ERROR]未指定上传文件"
fi


