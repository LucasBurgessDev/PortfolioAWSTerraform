resource "aws_instance" "app_server" {
  ami           = "ami-0d26eb3972b7f8c96"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}