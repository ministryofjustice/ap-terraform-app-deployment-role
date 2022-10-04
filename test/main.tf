module "example" {
  source = "./.."

  repo                        = "example2"
  organisation                = "example organisation"
  openid_connect_provider_arn = "examplearn"
  permissions_boundary        = "arn:aws:iam::01234567901:policy/boundary-policy"

}