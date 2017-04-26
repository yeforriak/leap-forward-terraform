terraform {
  backend "s3" {
    bucket  = "victorf"
    key     = "leap-forward-state"
    region  = "eu-west-1"
    profile = "leap-forward"
  }
}
