terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 3.50.0"
    }
  }

  # S3 Backend Configuration for Statefile
  backend "s3" {
    bucket         = "kalaisamplebuckettesting" 
    key            = "./terraform/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true  
    
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr         = "10.0.0.0/16"
  public_subnets   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24", "10.0.4.0/24"]
  private_subnets  = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24", "10.0.14.0/24"]
  azs              = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d"]
}

module "alb" {
  source             = "./modules/alb"
  vpc_id             = module.vpc.vpc_id
  public_subnet_ids  = module.vpc.public_subnet_ids
}

module "ec2" {
  source             = "./modules/ec2"
  ami_id             = "ami-084568db4383264d4"
  instance_type      = "t2.micro"
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  user_data          = file("docker.sh")
  target_group_arns  = [module.alb.target_group_arn]
}
