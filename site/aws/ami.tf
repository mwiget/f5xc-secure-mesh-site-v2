check "ami" {
  data "aws_ami_ids" "smsv2_check" {
    owners = ["434481986642"]

    filter {
      name   = "name"
      values = [ var.aws_ami_name ]
    }
  }
  assert {
    condition     = length(data.aws_ami_ids.smsv2_check.ids) > 0
    error_message = "${var.aws_ami_name} not found in region ${var.aws_region}."
  }
}

data "aws_ami_ids" "smsv2" {
  owners = ["434481986642"]

  filter {
    name   = "name"
    values = [ var.aws_ami_name ]
  }
}

output "ami_ids" {
  value = data.aws_ami_ids.smsv2
}
