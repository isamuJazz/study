## 設定ファイル

```shell
/etc/ssh
      |
      |--/ssh_config
      |--/sshd_config
```

からなる。  
sshd_configでは次のようなディレクティブがある

|主なディレクティブ|意味|
|---|---|
|PORT|待機ポート番号|
|Protocol|プロトコルバージョン|
|PermitRootLogin|rootログイン|
|PubkeyAuthentication||
|AuthorizedKeysFile||
|PasswordAuthentication||
|AllowUsers||
|X11Forwarding||

設定例 sshd_config

```
Port 22 
Protocol 2 #１にしない
PermitRootLogin true
PubkeyAuthentication yes
AuthorizedKeysfile .ssh/authorized_keys
PasswordAuthentication yes
X11Forwarding no
```
        

## コマンド

### key 生成

```
ssh-keygen -t タイプ
```

タイプは rsa1, rsa, dsa, ecdsa, ed25519  
rsa1はプロトコルバージョン１で古い

### ssh ログインのながれ

- 1 sshコマンドを実行
- 2 パスフレーズが設定されている場合は秘密鍵を複合
- 3 sshコマンドは公開鍵を含むデータに秘密鍵での署名をつけてサーバーに送る
- 4 サーバは送られてきた公開鍵がサーバに登録されているものか調べる。
- 5 登録された公開鍵なら、その公開鍵で署名を検証し、正しければログインを許可する

### ssh-agent

パスフレーズなしでログインできるプログラム  

以下のの設定がいる（ssh-agentをbash の子プロセスとして立ち上げると自動的に設定される. ``` ssh-agent bash ```）

- SSH_AGENT_PID
- SSH_AUTH_SOCK ...  ssh-agentのソケットファイルのパス
- ssh-add にて秘密鍵を登録しておく

## 認証の優先度

ホストベース認証 > 公開鍵認証 > パスワード認証  

ホストベース認証については  

- クライアントの /ect/ssh/ssh_configに HostbasedAuthentication yesが記述されていること、されてなければ、 ~/.ssh/ssh_configに記述
- サーバの ~/.ssh/known_hostsに、クライアントホストの公開鍵を登録する
- サーバの ~/.shostsあるいは~/.rhostsに「クライアントホスト名」あるいは、 「クライアントホスト名　ユーザ名」の書式で許可するクライアントを登録する
