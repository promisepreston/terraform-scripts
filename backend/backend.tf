terraform {
  backend "s3" {
    bucket = "promise-remote-backend"
    key = "terraform/tfstate.tfstate"
    region = "us-east-1"
    access_key = "AKIA2Q4N3HXBWXFUVET6"
    secret_key = "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"
  }
}
