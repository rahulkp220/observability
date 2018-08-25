# Observability :rocket:
A terraform based observability boilerplate that can run on AWS.
Creates a complete setup for Prometheus, Grafana, Alertmanager and Pushgateway. 

## Before you run :running:
* Make sure you have `terraform` installed on your system
* Make sure you have AWS credentials somewhere, the default location being `~/.aws/credentials`, and have a profile created like

```
[your_profile]
aws_access_key_id = "your_access_key"
aws_secret_access_key = "your_secret_access_key"

```

## Module Information :information_source:
```
module "observability" {
    source              = "../"
    profile             = "your_profile_here" ,
    aws_credential_path = "~/.aws/credentials",
    aws_region          = "your_aws_region", # example: us-east-2
    aws_ami             = "your_aws_ami_here" , # example: ami-5e8bb23b
    prometheus_count    = 1 ,
    alertmanager_count  = 1 ,
    grafana_count       = 1 ,
    pushgateway_count   = 1 ,
    aws_instance_type   = "aws_instance_type_here" , # example: t2.micro
    key_name            = "your_key_pair_here" , 
    user                = "ubuntu" ,
    private_ssh_key     = "ssh_key_path" ,
    cidr_blocks         = ["cider_range_here"] , # example: "0.0.0.0/0"
    outcidr_blocks      = ["cider_range_here"] , # example: "0.0.0.0/0"
    vpc_id              = "your_vpc_id_here" ,  # example: vpc-3993a751"
    has_public_ip       = true
}
```
* Change to the `example` directory and fill in the all the values.
* Make sure you have a `VPC` created and also a `KeyPair` generated.
* Run the following terraform commands to see the magic,
    * `terraform init`
    * `terraform plan`
    * `terraform apply --auto-approve`
    
## Sample output
```
Outputs:

alertmanager = [
    18.191.34.26
]
grafana = [
    18.188.149.197
]
prometheus = [
    52.14.154.54
]
pushgateway = [
    18.191.173.29
]
```

## Logging in to the target machines 
```
ssh -i your_key.pem ubuntu@public_ip_here
```

## Note:
The scripts used in the project are written by https://github.com/in4it/prometheus-course. :+1:
