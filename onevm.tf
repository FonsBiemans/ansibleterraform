provider "aws" {
  region     = "eu-west-1"
}


resource "aws_instance" "jenkins_master" {
    # Use an Ubuntu image in eu-west-1
    ami = "ami-f95ef58a"

    instance_type = "t2.micro"

    tags {
        Name = "jenkins-master2"
    }

    # We're assuming the subnet and security group have been defined earlier on

    #subnet_id = "subnet-0d1d1d55"
    security_group_ids = "sg-db25fea0"
    associate_public_ip_address = true

    # We're assuming there's a key with this name already
    key_name = "9310670-fons"

    # This is where we configure the instance with ansible-playbook
    provisioner "local-exec" {
        command = "sleep 120; ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -u ubuntu --private-key ./9310670-aws.pem -i '${aws_instance.jenkins_master.public_ip},' master.yml"
    }
}
