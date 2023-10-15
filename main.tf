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

  cloud {
    organization = "KO4GAT"
    workspaces {
      name = "terra-house-1"
    }
  }
  }

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_guildwars" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.guild_wars_public_path
  content_version = var.content_version
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
  domain_name = module.home_guild_wars.domain_name
  #domain_name = "asd7f7v6.cloudfront.net"
  town = "missingo"
  content_version = 5
}

module "home_halo_2" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  public_path = var.halo_2_public_path
  content_version = var.content_version
}

resource "terratowns_home" "home" {
  name = "Halo 2"
  description = <<DESCRIPTION
Halo 2 multiplayer brought unprecedented excitement to gamers with its 
fast-paced action, iconic maps, and innovative matchmaking system. 
Players could engage in intense battles with friends and rivals, using a diverse range of 
weapons and vehicles in epic combat scenarios. Its seamless integration of online play on the
original Xbox Live service further elevated the exhilaration, making it a defining experience for
the early days of competitive console gaming.
DESCRIPTION
  domain_name = module.home_halo_2.domain_name
  #domain_name = "asd7f7v6.cloudfront.net"
  town = "missingo"
  content_version = 5
}