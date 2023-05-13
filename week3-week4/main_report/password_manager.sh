#!/bin/bash

#GPG公開キーIDの設定
GPG_KEY_ID="C7D21B3A6AE3EDEDE1D2D1E7D921D339814916E1"

#パスワードファイルのパス
PASS_FILE_PATH="password.txt"
ENCRYPTED_PASS_FILE_PATH="password.txt.gpg"

echo "パスワードマネージャーへようこそ！"
while true; do
  echo "次の選択肢から入力してください(Add Password/Get Password/Exit)"
  read input
  # 入力を小文字に変換
  input=$(echo $input | tr '[:upper:]' '[:lower:]')

  if [ "$input" = "add password" ]; then
    echo -n "サービス名を入力してください:"
    read service_name

    echo -n "ユーザー名を入力してください"
    read user_name

    echo -n "パスワードを入力してください"
    read -s password

  

    # パスワードファイルに追記
    echo "$service_name,$user_name,$password" >> $PASS_FILE_PATH

    # パスワードファイルを暗号化
    gpg -r $GPG_KEY_ID -e $PASS_FILE_PATH

    # 元のパスワードファイルを削除
    rm $PASS_FILE_PATH

    echo "パスワードの追加は成功しました。"

  elif [ "$input" = "get password" ]; then
    # パスワードファイルを復号化して一時ファイルに保存
    gpg -o tmp_password.txt -d $ENCRYPTED_PASS_FILE_PATH

    echo "サービス名を入力してください"
    read service_name
    entry=$(grep $service_name tmp_password.txt)
    if [ -z "$entry" ]; then
      echo "そのサービスは登録されていません。"
    else
      echo "サービス名：$(echo "$entry" | cut -d ',' -f 1)"
      echo "ユーザー名：$(echo "$entry" | cut -d ',' -f 2)"
      echo "パスワード：$(echo "$entry" | cut -d ',' -f 3)"
      # 一時ファイルを削除
      rm tmp_password.txt
    fi

  elif [ "$input" = "exit" ]; then
    break
  else
    echo "入力が間違えています。Add Password/Get Password/Exit から入力してください。"
  fi
done

echo "Thank you!"
