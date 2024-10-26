※LINUC2の試験範囲の記述、正解を記載している。

世界シェアNO1のWebサーバ,リバースプロキシ。

- HTTPサーバー
- FastCGI　サーバーへのプロキシ
- HTTPサーバへのリバースプロキシ/ロードバランサ
- SMTPおよびPOP3/IMAPへのリバースプロキシ/ロードバランサ

として機能する。

## デーモン

nginx

## 設定ファイル

/etc/nginx/nginx.conf

```
include /etc/nginx/conf.d/*.conf;
```

サーバの設定。上記で記載した内容のファイル    
/etc/nginx/conf.d/default.conf  

```
# The default server
# 
server {
  listen 80 default_server;
  server_name _;

  location / {
    # ブラウザでhttp://localhostにアクセスすると、/usr/share/nginx/html/index.htmlを表示する
    root /usr/share/nginx/html; 
    index index.html index.htm;
  }
}

```