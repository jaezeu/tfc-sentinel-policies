policy "required-tags" {
  source            = "./required-tags.sentinel"
  enforcement_level = "soft-mandatory"
}

policy "dynamodb-pitr-prod" {
  source            = "./dynamodb-pitr-prod.sentinel"
  enforcement_level = "hard-mandatory"
}