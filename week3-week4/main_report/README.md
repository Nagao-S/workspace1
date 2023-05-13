新規作成：5/14

パスワードマネージャー
サービス名、ユーザー名、パスワードを保存し、それを暗号化ファイルとして保管するパスワードマネージャー。

【利用方法】

## 1. スクリプトを実行
```
$ ./password_manager.sh
```
## 2. 以下3つの機能から選択(大文字小文字は区別されません)

  ・`add password` - 新しいパスワードを追加します。

  ・`get password` - 既存のパスワードを取得します。
  
  ・`exit` - スクリプトを終了します

### パスワードの追加（Add Password）

`add password`を選択すると、サービス名、ユーザー名、パスワードを順番に入力します。それらの情報は`password.txt.gpg`という名前の暗号化ファイルに保存されます。

### パスワードの取得

`get password`を選択すると、パスワードを取得したいサービス名を入力します。サービス名が正しければ、対応するユーザー名とパスワードが表示されます。

### 実行終了
`exit`を選択すると、スクリプトは終了します。

