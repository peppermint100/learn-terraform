data "aws_vpc" "selected" {
    id = var.vpc_id
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

