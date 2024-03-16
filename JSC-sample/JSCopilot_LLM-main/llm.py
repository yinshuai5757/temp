import mysql.connector
from datetime import datetime
import time
import os
import openai
import asyncio
import async_timeout
from dotenv import load_dotenv

load_dotenv()

openai.api_type = "azure"
openai.api_version = "2023-03-15-preview"
openai.api_base = "https://internalonly4eval.openai.azure.com/" 
openai.api_key = "427673502fda43748a9eaa490d3ae3ff"   
engine = "aaa"    
# -------------------------------------------------------------------------------------------------------------
id = None
status_id = None
ai_type_id = None
sample_case_memo = None
sample_format = None
sample_generated_text = None
user_case_memo = None
user_format = None
user_generated_text = None
result_global = None
ai_generate_start_datetime = None
ai_generate_end_datetime = None

host="db"
port=3306
user="root"
password="root"

database="ai"
table_name = "document_texts"
time_timeout = 5
cycle_time = 1
# -------------------------------------------------------------------------------------------------------------
def query_database_error(err):
    if err.errno == mysql.connector.errorcode.ER_PARSE_ERROR:
        print("MYSQLクエリエラー: クエリの構文解析中にエラーが発生しました。")
    elif err.errno == mysql.connector.errorcode.ER_NO_SUCH_TABLE:
        print("MYSQLクエリエラー: 指定されたテーブルが存在しません。")
    elif err.errno == mysql.connector.errorcode.ER_DUP_ENTRY:
        print("MYSQLクエリエラー: 一意制約に違反する重複エントリが挿入されました。")
    elif err.errno == mysql.connector.errorcode.ER_LOCK_WAIT_TIMEOUT:
        print("MYSQLクエリエラー: ロック待ちタイムアウトが発生しました。")
    elif err.errno == mysql.connector.errorcode.ER_TABLE_EXISTS_ERROR:
        print("MYSQLクエリエラー: テーブルがすでに存在します。")
    elif err.errno == mysql.connector.errorcode.ER_DATA_TOO_LONG:
        print("MYSQLクエリエラー: データが列の長さを超えました。")
    elif err.errno == mysql.connector.errorcode.ER_ACCESS_DENIED_ERROR:
        print("MYSQLクエリエラー: クエリの実行権限がありません。")
    elif err.errno == mysql.connector.errorcode.ER_TABLEACCESS_DENIED_ERROR:
        print("MYSQLクエリエラー: テーブルへのアクセス権がありません。")
    else:
        print("MYSQLクエリエラー:", err)
        print("エラーコード:", err.errno)
# -------------------------------------------------------------------------------------------------------------
def connect_database_error(err):
    if err.errno == mysql.connector.errorcode.ER_ACCESS_DENIED_ERROR:
        print("ユーザーがアクセス権を持っていない。")
    elif err.errno == mysql.connector.errorcode.ER_BAD_DB_ERROR:
        print("MYSQL接続エラー: データベースが存在しません。")
    elif err.errno == mysql.connector.errorcode.ER_DBACCESS_DENIED_ERROR:
        print("MYSQL接続エラー: データベースにアクセスする権限がない")
    elif err.errno == mysql.connector.errorcode.ER_HOST_IS_BLOCKED:
        print("MYSQL接続エラー: 接続を試みたホストが MySQL サーバーによってブロックされている")
    elif err.errno == mysql.connector.errorcode.ER_DBACCESS_DENIED_ERROR:
        print("MYSQL接続エラー: データベースへのアクセスが拒否された。")
    else:
        print("MYSQL接続エラー:", err)
        print("エラーコード:", err.errno)
# -------------------------------------------------------------------------------------------------------------
# データベース接続メソッド
def connect_to_database(host, user, database, password, port):
    while True:
        try:
            # MySQLデータベースに接続
            connection = mysql.connector.connect(
                host=host,
                user=user,
                database=database,
                password=password,
                port=port
            )
            return connection  
        except mysql.connector.Error as err: 
            connect_database_error(err)
            print(f"再試行します...")
            continue
# -------------------------------------------------------------------------------------------------------------
# globalLLMからMYSQLまでpolling関数
def polling_ai_main():
    mysql_result_global = None
    connection = connect_to_database(host, user, database, password, port)
    if connection.is_connected():
        # カーソルを作成
        try:
            cursor = connection.cursor(dictionary=True)
            # 既に実行中のidが存在するかどうかを確認するクエリ
            check_query = (f"SELECT id FROM {table_name} WHERE status_id = 1 AND ai_type_id = 2 LIMIT 1")
            cursor.execute(check_query)
            existing_result = cursor.fetchone()            
            # あれば、何もしなくて、データベース接続を閉じます。
            if existing_result:
                print("処理中のレコード存在する為、データ取得できません。")
                return mysql_result_global

            # なければ、クエリの作成
            query_global = ("SELECT id, status_id, ai_type_id, sample_case_memo, "
                        "sample_format, sample_generated_text, user_case_memo, "
                        f"user_format FROM {table_name} WHERE status_id = 0 AND ai_type_id = 2 "
                        "ORDER BY created_datetime ASC LIMIT 1")                   
            # クエリの実行
            cursor.execute(query_global)
            # 結果の取得
            mysql_result_global = cursor.fetchone()
            # クエリの表示
            if mysql_result_global:
                # status_idを1に更新
                update_query = (f"UPDATE {table_name} SET status_id = 1 "
                                "WHERE id = %s")
                cursor.execute(update_query, (mysql_result_global['id'],))
                connection.commit()
            else:
                print("処理待ちレコードが存在しません。polling_ai_main関数終了。")
        except mysql.connector.Error as err:
            query_database_error(err)
        finally:
            cursor.close()
            connection.close()
    else:
        print("MySQL接続エラーで、polling_ai_main関数終了。")
    return mysql_result_global
# -------------------------------------------------------------------------------------------------------------
# global AIへリクエスト＆global AIからスポンスを取得関数          
def generate_global_ai_response(sample_format, sample_case_memo, sample_generated_text, user_format, user_case_memo):
    sql_global_ai_result = None
    ai_generate_start_datetime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    response = openai.ChatCompletion.create(
        engine=engine,
        messages=[
            {"role": "system", "content": "あなたは、userが与えたFORMATの内容を修正して返すAIです。\n    修正方法は次のとおりです。\n    ①userはあなたに、FORMAT、及びCASE_MEMOを与えます。\n    ②CASE_MEMOは「X経歴=平成２８年に宅建に合格」のように記載されています。これは、「'X経歴'という変数に文字列'平成２８年に宅建に合格'を代入する」という意味です。\n    ③FORMATには「原告には{X経歴}という経歴がある。」のような記載があります。この場合、あなたは変数部分を展開し「原告には平成２８年に宅建に合格という経歴がある。」のように修正して返します。\n    ④FORMATには「[{X経歴}を自然な文章で紹介]」のような記載があります。この場合、'['と']'で囲まれた部分はあなたへの指示です。その指示に従って、例えば「原告は平成２８年に宅地建物取引士の試験に合格している。」のように修正します。\n    ⑤算用数字はすべて全角文字に修正します。\n    ⑥最後に、あなたはFORMATをCASE_MEMOに基づいて処理した結果をuserに返します。"},
            {"role": "user", "content": f"FORMAT: {sample_format}\nCASE_MEMO: {sample_case_memo}"},
            {"role": "assistant", "content": sample_generated_text},
            {"role": "user", "content": f"FORMAT: {user_format}\nCASE_MEMO: {user_case_memo}"},
        ]
    )

    if response["choices"][0]["message"]["content"]:
        sql_global_ai_result = response["choices"][0]["message"]["content"]
        ai_generate_end_datetime = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        return sql_global_ai_result, ai_generate_start_datetime, ai_generate_end_datetime
# -------------------------------------------------------------------------------------------------------------
# global LLMでの生成文をMYSQLへの書き込み関数
def send_result_ai_main(id, user_generated_text, ai_generate_start_datetime, ai_generate_end_datetime): 
    connection = connect_to_database(host, user, database, password, port)
    if connection.is_connected():
        # カーソルを作成
        try:
            cursor = connection.cursor(dictionary=True)
            # レコード更新
            query = f"""
                    UPDATE {table_name} 
                    SET 
                        user_generated_text = %s, 
                        ai_generate_start_datetime = %s, 
                        ai_generate_end_datetime = %s,
                        status_id = 9
                    WHERE 
                        id = %s
                    """
            cursor.execute(query, (user_generated_text, ai_generate_start_datetime, ai_generate_end_datetime, id))
            connection.commit()
        except mysql.connector.Error as err:
            query_database_error(err)
        finally:
            cursor.close()
            connection.close()
            print("データベース書き込み完了\n--------------------------")
    else:
        print("MYSQL接続エラーで、書き込みできません。send_result_ai_main関数終了。")
# -------------------------------------------------------------------------------------------------------------
def my_async_function():
    result_global = polling_ai_main()  # polling_ai_main()の戻り値を取得
    if result_global:
        #print("--------------------------\nデータベース情報収集完了:\nGlobal Query Result:", result_global)
        print("--------------------------\nデータベース情報収集完了")
        id = result_global['id']
        status_id = result_global['status_id']
        ai_type_id = result_global['ai_type_id']
        sample_case_memo = result_global['sample_case_memo']
        sample_format = result_global['sample_format']
        sample_generated_text = result_global['sample_generated_text']
        user_case_memo = result_global['user_case_memo']
        user_format = result_global['user_format']     
        user_generated_text, ai_generate_start_datetime, ai_generate_end_datetime = generate_global_ai_response(sample_format, sample_case_memo, sample_generated_text, user_format, user_case_memo)     
        if user_generated_text and ai_generate_start_datetime and ai_generate_end_datetime:
            #print("\nAIとのやり取り完了:\nAIの回答:", user_generated_text)
            print("AIとのやり取り完了")
            send_result_ai_main(id, user_generated_text, ai_generate_start_datetime, ai_generate_end_datetime)
        else:
            print("generate_global_ai_response関数でAI回答を取得できません。")
    else:
        print("polling_ai_main関数でデータ取得できません。")          
async def main():
    while True:
        try:
            async with async_timeout.timeout(time_timeout):
                my_async_function()
                await asyncio.sleep(cycle_time)
        except asyncio.TimeoutError:
            print(f"タイムアウト発生によって、再試行します。")
            continue
        except Exception as e:
            print(f"エラー発生: {e}")     
if __name__ == "__main__":
    asyncio.run(main()) 