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