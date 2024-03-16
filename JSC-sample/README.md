## 環境構築

### コンテナ上での動作確認
mysql & myllm container を起動
```bash
cd JSC-sample
docker compose up -d
```

### ターミナル WSL上でのDB中身接続
WSL上でのmysql-serverインストール
```bash
sudo apt update
sudo apt install mysql-server
```
ターミナルから以下を実行(pass は "password")("localhost" は使えない)
```bash
mysql -h 127.0.0.1 -P 13306 -u user -p
```
DB中身確認
```bash
use ai;
select * from document_texts;
```