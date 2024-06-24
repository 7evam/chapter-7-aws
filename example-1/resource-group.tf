#
# Creates a resource group for FlixTube in your AWS account.
#

resource "aws_resourcegroups_group" "flixtube" {
  name        = "flixtube"
  description = "resource group for flixtube"
  resource_query {
    query = jsonencode({
      ResourceTypeFilters = ["AWS::AllSupported"],
      TagFilters = [{
        "Key" : "Stage",
        "Values" : ["Test"]
      }]
    })
  }
}
