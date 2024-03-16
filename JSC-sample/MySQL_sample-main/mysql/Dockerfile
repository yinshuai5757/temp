FROM mysql:8

COPY ./conf/my.cnf /etc/mysql/conf.d/my.cnf         
# Dockerコンテナは独立して実行されるため、外部のファイルに依存する場合、それらのファイルをコンテナ内にコピーする必要があります。特にMySQLコンテナの場合、カスタム設定や初期化スクリプトが必要な場合があります。
RUN chmod +x /etc/mysql/conf.d/my.cnf
# RUN命令はDockerfile内で実行されるコマンドであり、Dockerイメージのビルド時に実行されます。そのため、RUNで実行されるコマンドはDockerコンテナ内ではなく、イメージのビルドプロセス中に実行されます。

COPY ./docker-entrypoint-initdb.d/init.sql /docker-entrypoint-initdb.d/init.sql
RUN chmod +x /docker-entrypoint-initdb.d/init.sql
