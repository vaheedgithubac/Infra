project_name = "expense"
vpc_cidr     = "10.100.0.0/16"


/* if you want to create only one public, one private and one database subnet 
public_subnet_cidr   = ["10.100.1.0/24"]
private_subnet_cidr  = ["10.100.11.0/24"]
database_subnet_cidr = ["10.100.31.0/24"]
*/


public_subnet_cidr   = ["10.100.1.0/24", "10.100.2.0/24"]
private_subnet_cidr  = ["10.100.11.0/24", "10.100.12.0/24"]
database_subnet_cidr = ["10.100.31.0/24", "10.100.32.0/24"]
