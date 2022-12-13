variable "label" {
  description = "Provide a label for this image"
  type        = string
  default     = "CyberWarGame"
}

variable "token" {
  description = "The API token to use"
  type        = string
}

variable "type" {
  description = "The type of image"
  type        = string
}

variable "stackscript_id" {
  description = "stackscript_id to use"
  type        = number
}
