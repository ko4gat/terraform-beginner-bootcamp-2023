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
  endpoint = "http://localhost:4567/api"
  user_uuid="e328f4ab-b99f-421c-84c9-4ccea042c7d1" 
  token="9b49b3fb-b8e9-483c-b703-97ba88eef8e0"
}

#module "terrahouse_aws" {
#  source = "./modules/terrahouse_aws"
#  user_uuid = var.user_uuid
#  bucket_name = var.bucket_name
#  index_html_filepath = var.index_html_filepath
#  error_html_filepath = var.error_html_filepath
#  content_version = var.content_version
#}

#}

resource "terratowns_home" "home" {
  name = "Guild Wars 1!"
  description = <<DESCRIPTION
Guild Wars 1, released in 2005, was a popular MMORPG known for its engaging storyline,
unique character customization with a dual profession system, 
competitive Player vs. Player (PvP) battles, stunning graphics,
and no monthly subscription fees. It offered cooperative missions and
received expansions over time, adding new content and keeping the game exciting. 
The combination of immersive lore, strategic gameplay, and accessible online play made 
Guild Wars 1 a memorable and enjoyable experience for players.
DESCRIPTION
  #domain_name = module.terrahouse_aws.cloudfront_url
  domain_name = "3fdq3gz.cloudfront.net"
  town = "gamers-grotto"
  content_version = 1
}