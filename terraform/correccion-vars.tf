#Variable to define the Region where the infrastructure has been created in Azure
#variable "location" {
#  type = string
#  description = "Region where the infrastructure has been created in Azure"
#  default = "West Europe"
#}

variable "storage_account" {
  type = string
  description = "Nombre para la storage account"
  default = "testunirainaragarzo"
}

variable "public_key_path" {
  type = string
  description = "Ruta para la clave pública de acceso a las instancias"
  default = "~/.ssh/id_rsa.pub" #path to public password
}

variable "ssh_user" {
  type = string
  description = "Usuario para hacer ssh"
  default = "ainara" #user name
}