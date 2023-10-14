terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
 #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}

  #cloud {
  #  organization = "KO4GAT"
  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  }

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "terrahouse_aws" {
  source = "./modules/terrahouse_aws"
  user_uuid = var.teacherseat_user_uuid
  index_html_filepath = var.index_html_filepath
  error_html_filepath = var.error_html_filepath
  content_version = var.content_version
  assets_path = var.assets_path
}


resource "terratowns_home" "home" {
  name = "Guild Wars 1"
  description = <<DESCRIPTION
Guild Wars 1, released in 2005, was a popular MMORPG known for its engaging storyline,
unique character customization with a dual profession system, 
competitive Player vs. Player (PvP) battles, stunning graphics,
and no monthly subscription fees. It offered cooperative missions and
received expansions over time, adding new content and keeping the game exciting. 
The combination of immersive lore, strategic gameplay, and accessible online play made 
Guild Wars 1 a memorable and enjoyable experience for players.
DESCRIPTION
  domain_name = module.terrahouse_aws.cloudfront_url
  #domain_name = "asd7f7v6.cloudfront.net"
  town = "missingo"
  content_version = 5
}