//
// Identify any values that need to be returned to the calling modules
//

output "vpc_id" {
  value = aws_vpc.theVPC.id
}

output "public_subnet_ids" {
  value = concat(aws_subnet.public-subnets.*.id, list(""))
}

output "private_subnet_ids" {
  value = concat(aws_subnet.private-subnets.*.id, list(""))
}

output "public_subnet_cidr" {
  value = concat(aws_subnet.public-subnets.*.cidr_block, list(""))
}

output "private_subnet_cidr" {
  value = concat(aws_subnet.private-subnets.*.cidr_block, list(""))
}
