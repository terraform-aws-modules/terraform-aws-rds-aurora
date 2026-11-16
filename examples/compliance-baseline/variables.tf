variable "kms_key_arn" {
  description = "ARN of an existing customer-managed KMS key to use for storage, Performance Insights, CloudWatch logs, and the activity stream. When empty, the example creates a dedicated CMK with rotation enabled"
  type        = string
  default     = ""
}

variable "master_user_password_rotation_days" {
  description = "Number of days between automatic rotations of the Secrets Manager master user password"
  type        = number
  default     = 90
}

variable "pgaudit_log_classes" {
  description = "Comma-separated pgAudit statement classes to log via the `pgaudit.log` cluster parameter (e.g. `ddl,role,write`)"
  type        = string
  default     = "ddl,role,write"
}

variable "activity_stream_mode" {
  description = "Mode for Database Activity Streams. Valid values: `async`, `sync`"
  type        = string
  default     = "async"

  validation {
    condition     = contains(["async", "sync"], var.activity_stream_mode)
    error_message = "activity_stream_mode must be either \"async\" or \"sync\"."
  }
}
