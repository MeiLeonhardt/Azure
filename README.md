# Azure
Portal Azure Management

## Connessione con chiave pubblica a VM-Linux porta SSH
#in Ubuntu per avere accesso come root si può utilizzare su- ma è sconsigliato (soprattutto alle prime armi) perché hai poteri illimitati e rischi di rompere tutto >.<
```
#create .ssh 
mkdir C:\Users\Tuonomeutente\.ssh
```
```
#spostare file da download a .ssh
move C:\Users\tuonomeutente\Downloads\nomefilescaricato_key.pem C:\Users\TuoNomeUtente\.ssh
```
```
#eseguo la connessione
ssh -i C:\Users\tuonomeutente\.ssh\nomefilescaricato_key.pem userscelto@IPpubblicoVM
```

## Connessione con password (-p)
```
#serve per richiamare la password di accesso
#Attenzione! è importante inserire la password manualmente, non copia-incolla
ssh -i -p nomeutente@IPpubblico
ssh nomeutente@IPpubblico
```
```
sudo apt update
```
```
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
```
#browser interattivo, browser testuale
![image](https://github.com/user-attachments/assets/832df248-8ed2-4127-9c1d-cac33cd4c31f)
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```
```
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```
```
#Aggiornamento dell'elenco dei pacchetti
sudo apt update
```
```
# utilizzato per installare Docker Community Edition (Docker CE) su un sistema operativo basato su Debian, come Ubuntu
#docker-ce: Questo è il nome del pacchetto che desideri installare
sudo apt install docker-ce -y
```
```
#sudo="super user do" --> forzatura per costringere il sistema ad eseguire un comando a lvl superiore
#systemcl> system control, ovvero gestore dei servizi
sudo systemctl start docker
```
```
#quando avvio la vm in automatico si avvia docker // questo comando serve proprio a dare questo input
sudo systemctl enable/disable docker
```
```
#permette di verificare lo stato del servizio (per verificare es. se è attivo)
sudo systemctl status docker
![image](https://github.com/user-attachments/assets/e9363588-dc75-45c9-ae0c-0ea90cce3ff1)

```
## Installazione di portainer su ubuntu server
```
#creo un volume
sudo docker volume create portainer_data
```
```
#installo il container nel volume
sudo docker run -d -p 8000:8000 -p 9443:9443 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:lts
```

