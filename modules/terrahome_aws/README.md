## Terrahome AWS

```tf
module "home_halo_2" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.halo_2_public_path
  content_version = var.content_version
}

```
The public directory expects the following:
- index.html
- error.html
- assets

All top level files and assets will be copied, but not any sub directories.
