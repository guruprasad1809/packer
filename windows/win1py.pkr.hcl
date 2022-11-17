source "amazon-ebs" "win-py" {
  ami_name      = "packer-windows-py"
  instance_type = "t2.micro"
  region      = "eu-west-1"
  communicator = "winrm"
  source_ami_filter {
    filters = {
      name                = "Windows_Server-2022*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["amazon"]
  }
  user_data_file = "./boot_win.txt"
  winrm_password = "SuperS3cr3t!!!!"
  winrm_username = "Administrator"
}

build {
  sources = ["source.amazon-ebs.win-py"]

  provisioner "powershell" {
    environment_vars = ["DEVOPS_LIFE_IMPROVER=PACKER"]
    inline           = ["Write-Host \"HELLO NEW USER; WELCOME TO $Env:DEVOPS_LIFE_IMPROVER\"", "Write-Host \"You need to use backtick escapes when using\"", "Write-Host \"characters such as DOLLAR`$ directly in a command\"", "Write-Host \"or in your own scripts.\""]
  }
}

