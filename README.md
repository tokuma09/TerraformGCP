# terraformによるGCEインスタンス作成

terraformのバージョンは0.15.3


- terraform初期化: `terraform init`
- インスタンス起動: `cd terraform && terraform apply -auto-approve`
- sshでアクセス
  - vscode:
    - remote-ssh用 設定: `gcloud compute config-ssh`
    - remote-sshにてログイン
  - gcloud: `gcloud compute ssh terraform-instance`
- インスタンス削除: `terraform destroy -auto-approve`

