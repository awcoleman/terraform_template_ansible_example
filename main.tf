provider "aws" {
  region = "us-east-1"
}

resource "aws_key_pair" "awc_ssh_key" {
  key_name   = "awc_rsa-ansible-20180209"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAhBCs+zXUpTnEBz9m/6u/keqzlqu3rNWk6IKx7TcTKnq7W/0nJDzHqVbQzfGP4rWQBFCVSkJ3k9AQa/U216tBOVF5st6odI69Y2IZKiUosxMAHgSdnVoNudbvkGaPLDt1Ga2NR9EVMZMgwymt8y/eKHfnROfRh8jDjNy3Tyd1ZKTOIzjZfqrgCOy6ES6lcdijOSS36roVC+AzZ/tDSVdwjd+QSM86e08LBJ1sbE4SK0XCLtJi/TsNL7LHfizjYXTAknIxlj7jyjAJAON1wd2nDkTspHhxxkxeSqvw7lg2WAi7Cusf34vPYmRm2qPS1g7FpKhIXcCB+Vk0RMkojezRsQ== rsa-ansible-20180209"
}
