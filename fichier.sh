#!/bin/bash

# Configurations des variables
AMI_ID="ami-ID"  # AMI
INSTANCE_TYPE="t2.micro"
KEY_NAME="your-key-pair-name"
SECURITY_GROUP_ID="sg-xxxxxxxx"  # l'id de sécurité du groupe
KEY_FILE="your-key-pair.pem"     # la clé
REGION="eu-west-3"
ZIP_FILE="fichier.zip" # on essaie de trouver le fichier zip !

# On regarde si AWS CLI est installé
if ! command -v aws &> /dev/null
then
    echo "AWS CLI n'as pas peu etre trouve. Il faut l'installer!"
    exit
fi


if [ ! -f $ZIP_FILE ]; then
    echo "Error: $ZIP_FILE n'a pas ete trouve dans le dossier!"
    exit
fi

# Création de l'instance EC2
echo "Creation d'instance EC2..."
INSTANCE_ID=$(aws ec2 run-instances \
    --image-id $AMI_ID \
    --instance-type $INSTANCE_TYPE \
    --key-name $KEY_NAME \
    --security-group-ids $SECURITY_GROUP_ID \
    --region $REGION \
    --query 'Instances[0].InstanceId' \
    --output text)

echo "Instance ID: $INSTANCE_ID"

# On attends l'instance
echo "On attends que l'instance commence..."
aws ec2 wait instance-running --instance-ids $INSTANCE_ID --region $REGION

# On prends l'adresse IP publique
PUBLIC_IP=$(aws ec2 describe-instances \
    --instance-ids $INSTANCE_ID \
    --region $REGION \
    --query 'Reservations[0].Instances[0].PublicIpAddress' \
    --output text)

echo "Public IP: $PUBLIC_IP"

# on attends que ssh se connect
echo "Waiting for SSH connection..."
while ! nc -z $PUBLIC_IP 22; do
    sleep 2
done

# Connection à l'instance et installation de docker
echo "Maintenant on se connecte a l'instance et on installe docker..."
scp -i $KEY_FILE $ZIP_FILE ubuntu@$PUBLIC_IP:/home/ubuntu << 'EOF'
    # Mis a jour des package
    sudo apt update
    sudo apt upgrade
    
    # Installation de docker
    sudo snap install docker
    
    # Verification de l'installation
    sudo docker version
    
    # Optional: on test un conteneur
    # sudo docker run hello-world
    
    echo "Docker installation complete!"
EOF

echo "Script completed. You can now connect using:"
#echo "scp -i $KEY_FILE ubuntu@$PUBLIC_IP:/home/ubuntu"
#echo "sudo docker compose u"