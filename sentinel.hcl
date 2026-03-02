policy "required-tags" {
  source            = "./required-tags.sentinel"
  enforcement_level = "hard-mandatory"
}

policy "cost-limits" {
  source            = "./cost-limits.sentinel"
  enforcement_level = "advisory"
}