## 概要

Linux間の共有サーバー  

## 構成

### demon

ver3 までは、

- mountd, nfsd, portmap が必要。 mountd, nfsdを動かす前に portmapを動かすのが必要。
- - mountd クライアントのマウントリクエストを受け付ける v4 では廃止
- - nfsd ファイルアクセスリクエストを受け付ける
- - portmap プログラムのサーバーのポートの管理をする。 V4 ではrpcbind

ver4 では

- rpcbind. npc.nfsd, npc.idmapd
- - rpcbind ... NFSサービスを含むPRCサービスのポートとサービスのマッピングを管理する
- - rpc.nfsd ... NSFのコア機能。クライアントからのファイル操作リクエストを処理
- - rpc.idmapd ユーザー名やグループ名のマッピングを行い、アクセス権限を適切に管理する

port は 2049

### 設定ファイル

/etc/exports にて共有許可を行う。反映は ``` exportfs -r ``` か ``` systemctl reload nfs-server ```

書式

- ディレクトリ ホスト名(...オプション)

例

```
/usr/share nfsclient(rw,sync)

```

ホスト名の解決は　/etc/nsswitch.conf の設定において通常以下のため

```
hosts: files dns
```

/etc/hostsが優先される。なければ /etc/resolve.conf に書いてあるdnsサーバーが使用されて解決される  

主なオプションは

- ro, rw read-only(default) read,write
- root_squash rootで入れない。anonymousになる
- no_root_squash rootでアクセスできる。
- sync 書き込み後に応答(default)
- async 書き込み前に応答
- all_squash すべて anonymous

## 疑似ルート

/etc/exports 

例

```
/var/nfs *(ro,fsid=0)
/var/nfs/home  *(rw,sync,nohide)
/var/nfs/opt *(ro,sync,nohide)

```