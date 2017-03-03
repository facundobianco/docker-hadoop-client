## Docker container for Hadoop client

It's a simple client for Hadoop using the [Hadoop Shell](https://hadoop.apache.org/docs/r2.7.1/hadoop-project-dist/hadoop-common/FileSystemShell.html).
Also includes support for Kerberos authentication.

The Hadoop version is 2.7.1 that corresponds to HDP 2.4.2.

### Before to build

Configure the file `core-site.xml`.

For Keberos authentication you can mount the file with the Docker option

```
-v /etc/krb5.conf:/etc/krb5.conf:ro
```

### How to run it

```
mkdir ${HOME}/data
docker run --name hadoop -v ${HOME}/data:/home/hadoop/data \
    --add-host hdfs.example.com:10.0.0.1 \
    -it hadoop
```
