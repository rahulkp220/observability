provider "aws" {
  region                  = "${var.aws_region}"
  shared_credentials_file = "${var.aws_credential_path}"
  profile                 = "${var.profile}"
}
