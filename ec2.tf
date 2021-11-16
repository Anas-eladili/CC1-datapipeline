resource "aws_instance" "ec2_vm" {
  ami                  = "ami-01cc34ab2709337aa"
  instance_type        = "t2.micro"
  key_name             = "new-key-pair"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

  # Script to run when the instance is started
  user_data = <<EOF
  #!/bin/bash 
  sudo yum install git -y 
  sudo yum install pip -y 
  sudo pip install --no-input -q pytz 
  sudo pip install --no-input -q numpy 
  sudo pip install --no-input -q faker 
  sudo pip install --no-input -q tzlocal 
  sudo yum install aws-kinesis-agent -y
  mkdir /tmp/logs 
  sudo chown ec2-user /tmp/logs
  EOF

  tags = {
    student = "${var.student_email}"
  }

  vpc_security_group_ids = ["${aws_security_group.default.id}"]
}

# Default ec2 user is "ec2-user"


