# Define ssh to config in instance

resource "openstack_compute_keypair_v2" "user_key" {
  name       = "user-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDBbVAYTW8J3OUiS32ZPi7aGyRkd51pesaemkJCXSpML2i20LZpZudmTYaNhQzzEpB1lu9Y33Cfko8uHJhIT7ZdFysJpx3ycDvu+9ICYNbyv5enX8CN8wvAlA1w3hd9Xcv7g8tyD5I3Qrt+TxfHfyGV9XFkEQaNmk/KOh2nha2avMgNMUZXD+Sjf6j0m91NbziVPWCzSnFKwEmW8qWt+MCQRMJ18KNKmacFgCjE0lHtpsBlCc8fnRrW0JaK7CQJnQ5buWzjEOHLUUdIa/TysAf9tjtlCNrnLDP1WJRBh+8aGw6+wqjKncVoi5ZuLTC5aiak2VbTG6/ROifM27tKDsFL Generated-by-Nova"
}

