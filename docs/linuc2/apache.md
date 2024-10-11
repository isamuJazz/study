<b>※以下は試験範囲としてRed hat 系として記載する。</b>

## 設定ファイル

redhat系の位置。試験では以下を指しているっぽい。
/ect/httpd/conf/httpd.conf

※最新のは以下？

Debian計では以下らしい

/etc/apache2/apache2.conf

## サービス(デーモン)

httpd

## ディレクティブとコンテキスト

設定ファイルにはディレクティブと、コンテキストがある。

- ディレクティブは設定ファイルの中でデーモンに指示を与えるもの
- コンテキストはディレクトリが使える場所のことを指す

例えば、サーバ設定ファイルのコンテキストで使えるディレクティブ、バーチャルホストの中で使用できるディレクティブ、ディレクトリの中で使えるディレクティブ、.htaccessの中で使えるディレクティブ、などという。

## 重要なディレクティブ

### AllowOverride

.htaccessファイルで許可できるディレクティブの種類を指定する。

.htaccessを使わないのであれば、AccessFileNameでファイルを指定する。

AllowOverrideで使用を許可できるディレクティブタイプは

|ディレクティブタイプ|説明| 仕様を許可するディレクティブ |
|---|---|---|
| AuthConfig|認証に関するディレクティブを許可| AuthGroupFile, AuthName, AuthType, AuthUserFile, Require|
|FileInfo| ドキュメントのタイプやメタデータなどを制御するディレクティブを許可||
|Indexex| ディレクトリインデックスを制御するディレクティブを許可| DirectoryIndex FanchIndexing|
| Limit| ホストのアクセス制御を行うディレクティブを許可| Allow, Deny, Order|
| Options| Optionsディレクティブを許可|Options|

例えば次のような形で利用する

```xml
<Directory /var/www/html/labs>
  AuthType Basic
  AuthName "Lab"
  AuthUserfile /var/www/passwd
  Require valid-user
  Order Allow,Deny
  Allow from 172.16.1.0/24
  Satisfy Any
</Directory>
```

### Module

LoadModuleでモジュールを追加すると使用できるディレクティブが増える。  
mod_authz_coreをロードすると

- RequireAny, RequireAll, RequireNone

など利用できる。  
承認モジュールはほかに

- mod_authz_core コア承認を提供し、承認プロバイダは env, all, methood, expr
- mod_authz_user ユーザ認証を提供し、user, valid-user
- mod_authz_host ホスト認証を提供し、 ip, host, forward-dns, local
- mod_authz_groupfile

これを利用することで以下のように記載できる。

```xml
<Directory /var/www/html/labs>
  AuthType Basic
  AuthName "Lab"
  AuthUserFile /var/www/passwd
  <RequireAll>
    <RequireAny>
      Require valid-user
      Require ip 172.16.100.0/24a
    </RequireAny>
    <RequireNone>
      Require user nguser
    </RequireNone>
</Directory>
```

## SSL回り

### ディレクティブ

- SSLCertificateKeyFile サーバ秘密鍵
- SSLCertificateFile 証明書

### 秘密鍵、公開鍵、証明書リクエスト

- CSR ... Certificate Signin Request.

秘密鍵の生成は 

- rsa ``` openssl genrsa -out myserver.key ```
- dsa 鍵の生成。dsaparam.pem が必要 ``` openssl gendsa -out myserver.key dsaparam.pe ```
- dsaparam.pem の作成。 not -> gendsaparam -> but dsaparam ``` openssl dsaparam -out dsaparam.pem 2048```
- 証明書リクエストと、公開鍵を同時に生成（公開鍵は証明書に含まれる）``` openssl req -new -key 事前に作った秘密鍵 -out CSRファイル名 ```
- 秘密鍵を含めて作成　```openssl req -new -keyout 同時に作る秘密鍵名 -out CSR ファイル名```


## VirtualHost

VirtualHost は１台のサーバで複数のWebサーバーを提供する機能

- ip ベース
- 名前ベース

がある。

ipベースはサーバーに複数のipアドレスの紐づけが必要

```xml
<VirtualHost 172.17.0.101>
  DocumentRoot /var/www/html
  ServerName www.mylinuc.com
</VirtualHost>

<VirtualHost 172.17.0.1>
  DocumentRoot /var/www2/html
  ServerName www.kd-train.com
</VirtualHost>
```

名前ベースは ディレクティブ <b>NameVirtualHost</b>でIPアドレスを指定しておく  

```xml
NameVirtualHost 172.17.0.101
<VirtualHost 172.17.0.101>
  <!-- http://www.mylinuc.com -->
  DocumentRoot /var/www/html
  ServerName www.mylinuc.com
</VirtualHost>
<VirtualHost 172.17.0.101>
  <!-- http://www.kd-train.com -->
  DocumentRoot /var/www2/html
  ServerName www.kd-train.com
</VirtualHost>

```