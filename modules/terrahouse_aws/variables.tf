variable "user_uuid" {
  type    = string
  description = "The UUID of the user"
  
  validation {
    condition     = can(regex("^[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}$", var.user_uuid))
    error_message = "User UUID must be in the format of a UUID (e.g., 123e4567-e89b-12d3-a456-426614174000)"
  }
}
variable "bucket_name" {
  type        = string
  description = "The name of the AWS S3 bucket"
  
  validation {
    condition     = can(regex("^[a-zA-Z0-9.-]{3,255}$", var.bucket_name))
    error_message = "Bucket name must be between 3 and 255 characters long and contain only letters, numbers, hyphens, and periods."
  }
}

variable "index_html_filepath" {
  type        = string
  description = "The local file path to the index.html file"

  validation {
    condition     = fileexists(var.index_html_filepath)
    error_message = "The specified file path does not exist or is invalid."
  }
}

variable "error_html_filepath" {
  type        = string
  description = "The local file path to the error.html file"

  validation {
    condition     = fileexists(var.error_html_filepath)
    error_message = "The specified file path does not exist or is invalid."
  }
}

variable "content_version" {
  type        = number
  description = "The version number for the content"

  validation {
    condition     = var.content_version > 0 && floor(var.content_version) == var.content_version
    error_message = "Content version must be a positive integer starting at 1."
  }
}

variable "assets_path" {
description = "Path to assets folder"
type = string

}