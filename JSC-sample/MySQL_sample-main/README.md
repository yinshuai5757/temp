# MySQL Sample
## Features
初期状態でダミーレコードを挿入済みの MySQL コンテナのサンプルです。
ダミーレコードは "init.sql" で定義しています。

ホストマシンから接続する際は次のようにします（password は "password"）。
```bash
mysql -h 127.0.0.1 -P 13306 -u user -p
```

## 環境構築@WSL
### コンテナ上での動作確認
[WSL に MySQL をインストールする](https://makky12.hatenablog.com/entry/2022/10/11/120500)
```bash
sudo apt update
sudo apt install mysql-server
```
container を起動
```bash
cd mysql
docker compose up -d
```
container の中に入る
```bash
docker exec -it mysql bash
```
mysql に接続(pass は "root")
```bash
mysql -p
```
DB 一覧を確認し、DB を指定
```bash
show databases;
use mydb;
```
Table 一覧を確認し、users table を確認("init.sql" で指定したとおりになっていれば成功)
```bash
show tables;
select * from users;
```
### ホストマシンからコンテナ内の DB に接続
ターミナルから以下を実行(pass は "password")("localhost" は使えない)
```bash
mysql -h 127.0.0.1 -P 13306 -u user -p
```
## 環境構築@Windows
### コンテナ上での動作確認
[WindowsにMySQLをインストールする](https://qiita.com/aki_number16/items/bff7aab79fb8c9657b62)

container を起動
```bash
cd mysql
docker compose up -d
```
container の中に入る
```bash
docker exec -it mysql bash
```
mysql に接続(pass は "root")
```bash
mysql -p
```
DB 一覧を確認し、DB を指定
```bash
show databases;
use mydb;
```
Table 一覧を確認し、users table を確認("init.sql" で指定したとおりになっていれば成功)
```bash
show tables;
select * from users;
```
### ホストマシンからコンテナ内の DB に接続
PowerShell から以下を実行(pass は "password")
```bash
mysql -h localhost -P 13306 -u user -p
```
