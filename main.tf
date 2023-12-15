terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-west-1" 
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
}

resource "aws_s3_bucket" "assesmentbucket" {
  bucket = "my-tf-assesmentbucket-bucket"

}

resource "aws_s3_bucket_ownership_controls" "assesmentbucket" {
  bucket = aws_s3_bucket.assesmentbucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_acl" "assesmentbucket" {
  depends_on = [aws_s3_bucket_ownership_controls.assesmentbucket]

  bucket = aws_s3_bucket.assesmentbucket.id
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_example" {
  bucket = aws_s3_bucket.assesmentbucket.id
  versioning_configuration {
    status = "Enabled"
  }
}


#########################################_-----------------------------------

resource "aws_security_group" "my_sg" {
  name        = "allow-ssh"
  description = "Allow SSH inbound traffic from IP"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.IP]
  }
}

resource "aws_instance" "my_instance" {
  ami             = "ami-0cbd40f694b804622" 
  instance_type   = "t2.micro"            
  key_name        = "allowssh"   

  vpc_security_group_ids = [aws_security_group.my_sg.id]

}