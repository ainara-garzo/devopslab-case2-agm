variable "storage_account" {
  type = string
  description = "Nombre para la storage account"
  default = "storage4ainaragarzo"
}

variable "public_key_path" {
  type = string
  description = "Ruta para la clave pública de acceso a las instancias"
  default = "~/.ssh/id_rsa.pub" #path to public password
}

variable "ssh_user" {
  type = string
  description = "Usuario para hacer ssh"
  default = "adminUsername" #user name
}