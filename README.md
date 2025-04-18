# Azure
Portal Azure Management

## Connessione con chiave pubblica a VM-Linux porta SSH
Nei sistemi Linux per avere accesso come root si può utilizzare su- ma è sconsigliato (soprattutto alle prime armi) perché hai poteri illimitati e rischi di rompere tutto >.<

In compenso, ogni volta che avrai bisogno di permessi superiori, ti basta inserire "sudo" prima di ogni comando.
sudo="super user do" --> forzatura per costringere il sistema ad eseguire un comando a lvl superiore
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
#per cambiare password
passwd
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
# Nuova webApp su portainer DOcker-Azure
Quando creo un nuovo container apro l'enviroment che ho creato da shell, poi seleziono "templates"
![image](https://github.com/user-attachments/assets/15295653-077e-4a72-9bd0-27ca871948e7)
Scelgo immagine (es.nginx)
![image](https://github.com/user-attachments/assets/c14bb5ba-2dd4-4ca6-933b-8dcdf970e773)
Configuro nome del container e scelgo network bridge
![image](https://github.com/user-attachments/assets/e95ebacd-387b-43c5-95cc-c128cd865eca)
In avanzate inserisco le porte 80:80 e 443:443. Se voglio posso anche inserire la porta 5000 ma devo inserire la regola di firewall su Azure in modo che se cerco con porta 5000 mi reindirizza sull'80.
![image](https://github.com/user-attachments/assets/559e1de8-c8ba-426c-a063-4b2c8e638ad9)

Infine, per verificare se la pagina è online mi connetto con l'ip pubblico della macchina, che è il dominio su cui lavora la macchina, posso anche risolvere il nome dell'ip se acquisto un dominio e lo associo all'IP pubblico della VM.
Il nostro sito è ufficialmente esposto su internet: Welcome to the internet!!
![image](https://github.com/user-attachments/assets/b3240397-7132-4402-b318-88bc7b896751)

# Modificare sito web
![image](https://github.com/user-attachments/assets/fd932e55-9180-4ab2-8b1f-0354d554f0a3)

```
apt-get update
```
```
apt install nano
```
```
#controllo che sia andato a buon fine
nano --version
![image](https://github.com/user-attachments/assets/86eccc7e-0e57-48eb-b9a3-228e35f7c158)

```
```
cd /usr/share/nginx/html
```
```
#per modificare homepage
nano index.html
```
```
#nuova pagina
nano nomepagina.html
#per inserire titolo <h1> TITOLO </h1>
#per inserire paragrafo <p> paragrafo </p>
```
