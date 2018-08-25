module "observability" {
    source = "../"
    profile = "your_profile_here" ,
    aws_credential_path = "~/.aws/credentials",
    aws_region = "your_aws_region", 
    aws_ami = "ami-5e8bb23b" , # ubuntu 16.04 LTS
    prometheus_count = 1 ,
    alertmanager_count = 1 ,
    grafana_count = 1 ,
    pushgateway_count = 1 ,
    aws_instance_type = "t2.micro" , 
    key_name = "your_key_pair_here" ,
    user = "ubuntu" ,
    private_ssh_key = "ssh_key_path" ,
    cidr_blocks = ["0.0.0.0/0"] ,
    outcidr_blocks = ["0.0.0.0/0"] ,
    vpc_id = "your_vpc_id_here" ,
    has_public_ip = true
}