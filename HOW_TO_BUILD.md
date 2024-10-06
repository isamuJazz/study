# 公式サイト

https://www.mkdocs.org/


# Repository

ブランチ名documentでpushしたときにデプロイされます。

# 準備
## localで記述する場合 (container使わない)

```
pip install mkdocs 
```
theme の追加

```
pip install mkdocs-material
```
## devcontainerで記述する場合

Dockerfileにツール入れてるので、コマンドパレットで open in container を選んでください。


# 開発(監視モード)

## localで記述する場合

```
mkdocs serve
```

## devContainerで記述する場合
```
mkdocs serve --dev-addr=0.0.0.0:8000
```

then, => localhost:8000

# Deploy 

```
mkdocs gh-deploy --force
```