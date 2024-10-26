## 概要

Windowsとのファイル共有プロトコル SMB/CIFSによるサービス提供サーバ

## 構成

- デーモン smbd, nmbd, winbindd
- - smbd ファイル共有、プリンタ共有のSMBサービスを提供。ポートは445/TCP, 139TCP
- - nmbd NetBIOSのネームサービスを提供。 137/udp, 138/udp
- 設定ファイル
- - /etc/samba/smb.conf

## 設定ファイルの例

```conf

[global]
   workgroup = mylinuc
   security = user
   passdb backend = tpdsam
[homes]
   writable = yes

[public]
    path = /home/samba

```

## 重要なコマンド

| コマンド | 説明|
| --- | --- |
|pdbedit| ユーザーの表示、登録、削除|
|smbpasswd| passwordの変更、ユーザ管理もできる|
|testparm| 構文チェック|
|smbstatus||
|smbclient| ftpに似たコマンド|
|smbcontrol| 制御メッセージを smbd, nmbd, winbinddに送る|
|net| sambaおよびリモートCIFSのサーバ管理|

## アクセスコントロール

chmodに比べきめ細かい認可制御ができる

```
setfacl -m u:isamu:rwx samba
```


```
getfacl ...?
```