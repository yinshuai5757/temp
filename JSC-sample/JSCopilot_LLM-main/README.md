# JSCopilot_LLM
## FEATURES
JSCopilot の LLM コンテナ（GlobalLLM と LocalLLM の両方を含む）です。  
実行すると python コードが実行され "Hello LLM!" というメッセージが表示されます。  
これを、次のように追加修正することが目標です。  
- ①あらかじめ MySQL_sample リポジトリのコンテナを起動しておくと（起動方法は同リポジトリの README.md を参照）、DB にアクセスできるように追加修正する
- ②DB から取得したデータを、Azure OpenAI Service に送信できるようにする
- ③Azure OpenAI Service から取得したレスポンスを、MySQL_sample の DB に追加するようにする
- ④①から③を、定期的（例えば１分間隔）に繰り返す
## 動作確認環境
- ゲストマシン
  - WSL2(Ubuntu-22.04)
  - NVIDIA cuDNN v8.9.7
  - NVIDIA CUDA ツールキット 12.3
  - NVIDIA ドライバ:536.67
- ホストマシン
  - Windows11
  - NVIDIA cuDNN v8.9.7
  - NVIDIA CUDA ツールキット 12.3
  - NVIDIA ドライバ:536.67
## 利用方法
- コンテナをビルドして実行（現在は、"Hello LLM!" と表示されるだけ）
```
docker compose up
```
