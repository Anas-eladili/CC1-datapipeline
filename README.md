# CC1-DataPipeline

Partie 1 : 

Question1: 
il manque le datastream pour faire la reception de flux des données et la destination du pipeline 

Question 2: 
on va créer 
un fichier datastream : kinesisdtastream.tf 
un fichier destination S3bucket : destination_s3_bucket.tf





Question 5 : 

cette partie sert pour initier et installer tous les librairies et framework qui vont service pour faire marcher l' application de logs.

Question 6:
C'est pour envoyer les données vers le kinesis data delivery


Partie 2 : 
1) ingestion est fait par le kinesis data agent qui lui envoie les donneés vers le data stream de kinesis 
2) la partie stockage est assurée par le destination bucket S3 
3) l'exploration est faite avec kinesis analytic.
4) 
