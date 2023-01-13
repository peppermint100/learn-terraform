data "aws_vpc" "selected" {
    id = var.vpc_id
    tags = {
      Name = "intra-service-vpc"
    }
}

data "aws_subnets" "this" {
    filter {
      name = "vpc-id"
      values = [data.aws_vpc.selected.id]
    }

    tags = {
      tier = "public"
    }
}