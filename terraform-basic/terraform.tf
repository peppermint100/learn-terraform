terraform {
    backend "s3" {
        bucket = "terraform-a0b1c3"
        key = "dev/terraform.tfstate"
        region = "ap-northeast-2"
        dynamodb_table = "terraform-locking" // dynamodb에 LockID라는 키로 테이블을 생성하면 여러 곳에서 terraform apply하는 경우를 예방할 수 있다.(잠금)
    }
}

provider "aws" {
  region     = "ap-northeast-2"
}