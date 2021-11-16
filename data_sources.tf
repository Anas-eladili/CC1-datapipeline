# Data sources : defines aws parameters usable in the TF files

# Current region name
data "aws_region" "current" {}

# Current AWS user ID
data "aws_caller_identity" "current" {}
