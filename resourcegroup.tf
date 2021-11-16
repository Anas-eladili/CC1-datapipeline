resource "aws_resourcegroups_group" "my_resource_group" {
  name = "my-resource-group"

  resource_query {
    query = <<JSON
{
  "ResourceTypeFilters": [
    "AWS::AllSupported"
  ],
  "TagFilters": [
    {
      "Key": "student",
      "Values": ["${var.student_email}"]
    }
  ]
}
JSON
  }
}
