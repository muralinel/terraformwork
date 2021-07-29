
provider "aws" {
  region     = "us-east-1"
}


resource "aws_instance" "my_lab" {
  ami           = "ami-042e8287309f5df03"
  instance_type = "t2.micro"

  tags = {
    name = "jenkins"
  }
}

resource "aws_vpc" "my_lab_vpc" {
    cidr_block = "10.0.0.0/16"

    tags = {
      Name = "mural-vpc"
    }
}
resource "aws_subnet" "my_lab_subnet" {
     vpc_id     = aws_vpc.my_lab_vpc.id
     cidr_block = "10.0.1.0/24"

    tags = {
       Name = "mural-subnet"
  }
}    

resource "aws_internet_gateway" "my_lab_gw" {
  vpc_id = aws_vpc.my_lab_vpc.id

  tags = {
    Name = "mural_gw"
  }
}
resource "aws_route_table" "my_lab_route" {
  vpc_id = aws_vpc.my_lab_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_lab_gw.id

  }
}  


resource "aws_route_table_association" "ara" {

   subnet_id = aws_subnet.my_lab_subnet.id
   route_table_id = aws_route_table.my_lab_route.id
}   
/*
resource "aws_route_table_association" "b" {

    gateway_id     = aws_internet_gateway.terraform_gw.id
    route_table_id = aws_route_table.terraform_route.id

}
*/

