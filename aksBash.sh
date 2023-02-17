#!/bin/bash

###################################################################################################
###################################################################################################
#######################                                                 ###########################
#######################              Création des ressources            ###########################
#######################                                                 ###########################
###################################################################################################
###################################################################################################

az login

#Créer un groupe de ressource

echo "Le nom de votre groupe de ressource"

read groupeName

echo "Localisation de votre groupe de ressource"

read location

az group create --name $groupeName \
                --location $location

# Créer l'AKS cluster 

echo "Le nom de votre AKS"

read aksName

az aks create -g $groupeName -n $aksName --enable-managed-identity --node-count 3 --enable-addons monitoring --generate-ssh-keys

#Se connecter au cluster

az aks install-cli

az aks get-credentials --resource-group $groupeName --name $aksName

kubectl get nodes

kubectl apply -f azure-vote.yaml

kubectl get service azure-vote-front --watch