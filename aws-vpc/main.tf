# provider "aws" {
#   region    = var.region
# }
provider "aws" {
  alias = "prod"
  region = var.region
  profile = var.profile_prod
}

provider "aws" {
  alias = "jenkins"
  region = var.region
  profile = var.profile_root
}