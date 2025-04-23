output "function_names" {
  value = {
    for k, v in google_cloudfunctions2_function.module_function :
    k => v.name
  }
}