set dotenv-load

name := "server"
server_min_memory := env_var_or_default("MIN_MEM", "1G")
server_max_memory := env_var_or_default("MAX_MEM", "2G")


default:
    just --list


install:
    # Install Depends
    sudo apt install -y openjdk-21-jre-headless

    # Make User
    sudo useradd -Ms /sbin/nologin minecraft

    # Make Directory
    sudo mkdir -p /srv/minecraft

    # Copy Service Files

    # Download Fabric
    sudo curl -o /srv/minecraft/fabric-mc-server-1.24.4.jar https://meta.fabricmc.net/v2/versions/loader/1.21.4/0.16.10/1.0.1/server/jar
    
    # Ensure Everything is Owned By Minecraft
    sudo chown minecraft:minecraft /srv/*

    # Add Minecraft Services
    sudo cp systemd/minecraft@.service /etc/systemd/system/minecraft@.service
    sudo cp systemd/minecraft@.socket /etc/systemd/system/minecraft@.socket

    # Make Systemd Aware of Services
    sudo systemctl daemon-reload


new:
    # Make Directory
    sudo mkdir -p /srv/minecraft/{{name}}

    # Link Fabric
    sudo ln -sf /srv/minecraft/fabric-mc-server-1.24.4.jar /srv/minecraft/{{name}}/minecraft.jar
    sudo ln -sf /srv/minectaft/mods /srv/minecraft/{{name}}/mods

    # Create EULA Agreement
    sudo sh -c "echo 'eula=true' > /srv/minecraft/{{name}}/eula.txt"

    # Override Environment
    sudo sh -c "echo 'MIN_MEM={{server_min_memory}}' >> /srv/minecraft/{{name}}/systemd.conf"
    sudo sh -c "echo 'MAX_MEM={{server_max_memory}}' >> /srv/minecraft/{{name}}/systemd.conf"

    # Ensure Everything is Owned By Minecraft
    sudo chown -R minecraft:minecraft /srv/*

    # Enable and Start
    sudo systemctl enable --now minecraft@{{name}}.service


remove:
    # Disable and Stop
    sudo systemctl disable minecraft@{{name}}.service
    sudo systemctl stop minecraft@{{name}}.service

    # Remove Directory
    sudo rm -rf /srv/minecraft/{{name}}
