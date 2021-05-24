# shell
一些脚本

## OSS命令上传文件（osscp.sh）

👍感谢[官方工具ossutil](https://help.aliyun.com/document_detail/50452.html)[(源码)](https://github.com/aliyun/ossutil)的支持，更多命令推荐使用官方工具。

> 本脚本使用限制:目前仅支持MacOS、CentOS、Ubuntu的64位/32位系统

### 使用方法：

1. 下载脚本
```
wget https://raw.githubusercontent.com/WesleyOne/shell/main/osscp.sh
```

2. 修改配置
```sh
# 访问OSS配置（以下四个变量必须替换成可用信息）
# 填写Bucket所在地域的Endpoint，建议使用内网域名
endpoint="oss-cn-hangzhou.aliyuncs.com"
# 填写账号的AccessKey，尽量限制该账号的权限
accessKeyID="***"
accessKeySecret="***"
# Bucket名称及其内的文件夹名称
bucketAndFold="***/***/"
```

3. 脚本添加执行权限
```sh
chmod +x osscp.sh
```

4. 上传指定文件
```sh
./osscp.sh [filename1] [filename2] [filenameN]
```

### 提醒

- 建议使用OSS的内网endpoint
- 按需为accessKey用户分配最小权限
- `osscp.sh`配置修改完成后，可上传至OSS，便捷后续使用。（设置私有访问，防止配置外泄）

### 最佳实践

#### 下载内网ECS的内存Dump文件

```shell
# 获取内存 Dump 文件的命令：
jmap -dump:format=b,file=生成的文件名 进程号

# 压缩文件
gzip 文件名

# 上传文件
./osscp.sh 文件名.gz

# 登陆OSS控制台或客户端下载文件
```
