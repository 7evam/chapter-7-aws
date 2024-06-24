#
# Creates a container registry on AWS so that you can publish your Docker images.
#
resource "aws_ecr_repository" "flixtube" {
  name = "flixtube"
  tags = {
    Stage = "Test"
  }
}

output "repository_url" {
  value = aws_ecr_repository.flixtube.repository_url
}
