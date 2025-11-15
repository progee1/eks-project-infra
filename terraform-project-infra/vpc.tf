resource "aws_subnet" "eks_subnets" {
  count = 3

  vpc_id = aws_vpc.eks_vpc.id
  cidr_block = cidrsubnet(aws_vpc.eks_vpc.cidr_block, 4, count.index)

  availability_zone = element([
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ], count.index)

  tags = {
    Name = "eks-subnet-${count.index}"
  }
}
