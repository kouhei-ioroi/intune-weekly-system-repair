# Intune-Weekly-System-Repair

Intuneのアプリケーション配布機能を利用して、毎週日曜日0:00に`sfc /scannow`および`DISM /Online /Cleanup-Image /RestoreHealth`を実行するタスクを登録するスクリプトです。  
アンインストールにも対応しています。  

# 使い方

1. Releasesから最新のintunewinパッケージと`Verify.ps1`をダウンロードします。
2. Microsoft Intune 管理センターにアクセスし、アプリケーションの追加からWin32アプリを選択します。
3. ダウンロードしたintunewinパッケージをアップロードします。
4. インストールコマンドに以下を入力します。
   ```
   powershell.exe -ExecutionPolicy Bypass -File Register-Task.ps1
   ```
5. アンインストールコマンドに以下を入力します。
   ```
   powershell.exe -ExecutionPolicy Bypass -File Unregister-Task.ps1
   ```
6. インストールの処理を`システム`に指定します。
7. リターンコードを以下のように設定します。
   - 成功: 0
   - 失敗: 1
8. 検出規則の形式をカスタム検出スクリプトに設定し、`Verify.ps1`を指定します。
9. アプリケーションを割り当て、配信します。

# リリースプロセス

このリポジトリでは、セマンティックバージョニングに基づく完全自動化されたリリースプロセスを採用しています。

## Conventional Commits の使用
`main` ブランチへのコミットメッセージは、以下の Conventional Commits 形式に従う必要があります。これにより、バージョンアップの種類が自動的に判断されます。

- `feat:`: 新機能の追加（MINOR バージョンアップ、例: `v0.1.0`）
- `fix:`: バグ修正（PATCH バージョンアップ、例: `v0.0.2`）
- `BREAKING CHANGE:` または `feat!:`: 互換性のない変更（MAJOR バージョンアップ、例: `v1.0.0`）
- `chore:`, `docs:`, `style:`, `refactor:`, `test:`: リリースをトリガーしない変更

## 自動化ワークフロー
1. `main` ブランチに上記形式のコミットがプッシュされると、`version.yml` ワークフローが実行されます。
2. `semantic-release` がコミット履歴を分析し、適切なバージョン番号で Git タグを作成し、GitHub Releases にリリースノートを付与してドラフトを作成します。
3. タグの作成をトリガーとして `release.yml` ワークフローが実行され、Windows 環境で `.intunewin` パッケージと `Verify.ps1` がビルドされ、作成済みのリリースに自動的に添付されます。