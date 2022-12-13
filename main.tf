provider "linode" {
  token = var.token
}

resource "random_shuffle" "region" {
  input        = ["eu-west", "eu-central", "us-east", "us-west", "ap-northeast"]
  result_count = 1
}

resource "linode_sshkey" "linode_ssh_key" {
  label   = "my_ssh_key"
  ssh_key = chomp(file("~/.ssh/jgrinwis-2018-07-09.pub"))
}

# set some password
resource "random_password" "linode_root_password" {
  length  = 16
  special = false
}

# et's lookup information from the stackscript
data "linode_stackscript" "my_stackscript" {
  id = var.stackscript_id
}

# all these secrets should be stored in a vault
# something for our next project, password can be shown via 'terraform output -json'
# but all credentials should move to Hashicorp Vault in a next release.
resource "linode_instance" "my_akddos_instance" {
  image           = data.linode_stackscript.my_stackscript.images[0]
  label           = var.label
  region          = resource.random_shuffle.region.result[0]
  type            = var.type
  authorized_keys = [linode_sshkey.linode_ssh_key.ssh_key]
  root_pass       = resource.random_password.linode_root_password.result
  stackscript_id  = var.stackscript_id
  # we need to correct input vars for this stackscript
  # all possible vars can be checked via GET https://api.linode.com/v4/linode/stackscripts/401697
  # we can use default values, we can always add
  # 
  stackscript_data = {
    "script_name"     = "akddos.tar"
    "script_location" = "https://hdebeij.akamaized.net/ns/"
  }
}
