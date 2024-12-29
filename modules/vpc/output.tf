output "vpc-names" {
  // value = aws_vpc.abc-vpc
  value = join(", ", [aws_vpc.abc-vpc.id, aws_vpc.xyz-vpc.id])
}

// value = join(", ", [aws_vpc.abc-vpc.id, aws_vpc.xyz-vpc.id])
