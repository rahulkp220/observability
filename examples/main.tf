module "observability" {
    source = "../"
    profile = "your_profile_here" ,
    aws_credential_path = "~/.aws/credentials",
    aws_region = "your_aws_region", 
    aws_ami = "your_aws_ami_here" ,
    prometheus_count = 1 ,
    alertmanager_count = 1 ,
    grafana_count = 1 ,
    pushgateway_count = 1 ,
    aws_instance_type = "aws_instance_type_here" , 
    key_name = "your_key_pair_here" ,
    user = "ubuntu" ,
    private_ssh_key = "ssh_key_path" ,
    cidr_blocks = ["cider_range_here"] ,
    outcidr_blocks = ["cider_range_here"] ,
    vpc_id = "your_vpc_id_here" ,
    has_public_ip = true
}