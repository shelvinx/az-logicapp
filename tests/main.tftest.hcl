
run "validate_logicapp_kind" {
  command = plan

  assert {
    condition     = module.logicapp.kind == "logicapp"
    error_message = "Logic App kind is not set to 'logicapp'"
  }
}
