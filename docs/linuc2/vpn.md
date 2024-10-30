## 概要

SSL/TLSを利用し、ネットワーク層あるいはデータリンク層の通信を暗号化してトンネリングする。  
次のネットワーク間の通信

- サーバとクライアント
- サーバのサブネットのホストと、クライアントのサブネットのホスト
- クライアントとクライアント
- クライアントのサブネットと のホストと、クライアントのサブネットのホスト

サーバーのポート番号のデフォルトは<b>1194</b>

クライアント側でポート番号を動的に割り当てるには、<b>client.conf</b>に [nobind] にする。

## 設定ファイル

```
/etc/openvpn/server.conf
```

ここに含まれるのは

- CAの証明書ファイル名
- CAによるサーバーの証明書ファイル名
- サーバーの秘密鍵ファイル名
- サーバーのポート
- 仮想ネットワークのアドレス

### ルーティングVPNの設定例

```
dev tun
server 10.8.0.0 255.255.255.0 仮想ネットワークのアドレスを指定。ここから振られる

```

### ブリッジVPNの設定例


```

dev tap
server-bride 192.xxx.xx.xxx 255.255.255.0 192.xxx.xxx.xxx 255.255.255.0
```

### サーバー、クライアントの設定例

server.conf

```
dev tun
ca ca.crt
cert server.crt
key server.key
dh dh1024.pem
server 10.8.0.0 255.255.255.0
port 1194
status openvpn-status.log

```

client.conf  
※cert key はサーバーで作られる

```
dev tun
remote lx01 1194
ca ca.crt
cert client1.crt
key client1.key

```