# create the subnet group for the rds instance
resource "aws_db_subnet_group" "database_subnet_group" {
  name         = var.db_subnet_group_name
  subnet_ids   = var.database_subnet_ids
  description  = "Subnet Group for Database"

  tags = merge(
    var.common_tags,
    {
        Name = "${var.project_name}-${var.env}"
    }
  )
}

# create the rds instance
resource "aws_db_instance" "db_instance" {
  engine                  = var.engine
  engine_version          = var.engine_version
  multi_az                = var.multi_az
  identifier              = var.identifier
  username                = var.username
  password                = var.password
  instance_class          = var.instance_class
  allocated_storage       = var.allocated_storage
  db_subnet_group_name    = aws_db_subnet_group.database_subnet_group.name
  vpc_security_group_ids  = module.mysql_sg.sg_id   #var.vpc_security_group_ids
  availability_zone       = var.availability_zone
  db_name                 = var.db_name
  skip_final_snapshot     = var.skip_final_snapshot
}
