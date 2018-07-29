# observability
A terraform based observability boilerplate that can run on AWS 

## Before you run
* Make sure you have `terraform` installed on your system
* Make sure you have AWS credentials somewhere, the default location being `~/.aws/credentials`, and have a profile created like

```
[your_profile]
aws_access_key_id = "your_access_key"
aws_secret_access_key = "your_secret_access_key"

```
* Make sure you have a `VPC` created and also a `KeyPair` generated which will be used to login into the machine. The command 
would be like 
```
ssh -i your_key.pem ubuntu@public_ip_here
```
