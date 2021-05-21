# shell
一些脚本

## OSS命令上传文件（osscp.sh）

> 使用限制:目前仅支持MacOS、CentOS、Ubuntu的64位/32位系统

### 使用方法：

1. 下载脚本

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
