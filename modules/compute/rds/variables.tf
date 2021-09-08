#Naming Standard
variable "region" {
  type        = string
  description = "AWS region"
}

variable "unit" {
  type        = string
  description = "business unit code"
}

variable "env" {
  type        = string
  description = "stage environment where the infrastructure will be deployed"
}

variable "code" {
  type        = string
  description = "service domain code to use"
}

variable "feature" {
  type        = string
  description = "the name of AWS services feature"
}

#Parameter Group
variable "parameter_group_family" {
  type        = string
  description = "Aurora parameter group family"
}

#Aurora Cluster
variable "engine_mode" {
  type        = string
  description = "Aurora engine mode"
}

variable "engine" {
  type        = string
  description = "Aurora engine"
}

variable "engine_version" {
  type        = string
  description = "Aurora engine version"
}
variable "master_username" {
  type        = string
  description = "Aurora Master username"
}

variable "port" {
  type        = number
  description = "Aurora port"
}

variable "backup_retention_period" {
  type        = string
  description = "Aurora backup retention period"
}

variable "preferred_backup_window" {
  type        = string
  description = "Aurora preferred backup window"
}

variable "iam_database_authentication_enabled" {
  type        = bool
  description = "Aurora IAM authentication"
}

variable "copy_tags_to_snapshot" {
  type        = bool
  description = "Aurora copy tags to snapshot"
}

variable "storage_encrypted" {
  type        = bool
  description = "Aurora storage encrypted using KMS CMK"
}

variable "backtrack_window" {
  type        = number
  description = "Aurora Backtrack window"
}

variable "allow_major_version_upgrade" {
  type        = bool
  description = "Aurora allow major version upgrade"
}

variable "enabled_cloudwatch_logs_exports" {
  type        = list(string)
  description = "Aurora enable cloudwatch logs exports"
}

variable "deletion_protection" {
  type        = bool
  description = "Auora deletion protection"
}

variable "apply_immediately" {
  type        = bool
  description = "Aurora apply immediately"
}

variable "skip_final_snapshot" {
  type        = bool
  description = "Aurora Skip Final Snapshot"
}
