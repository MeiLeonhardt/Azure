# Azure : Docker
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
```
![Screenshot 2025-04-18 125957](https://github.com/user-attachments/assets/4616cd3b-b3da-48b0-86dc-42fa77858a05)
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

![image](https://github.com/user-attachments/assets/f0f67c04-fab4-42f3-9057-90354ac3ddc6)

# ESERCIZIO
1 )Da ssh visualizzare tutti i container in esecuzione.
```
docker ps
```
2) sempre da ssh visualizzare tutti i comandi con il comando docker ps -a ( usare sudo se necessario)
```
docker ps -a
```
3) creare un nuovo container usare portainer web gui ( nginx ) mappare 3000 : 80 e 3001 : 443
```
sudo docker run -d --name Webnginx -p 3000:80 -p 3001:443 nginx
```
5) Aprire le porte necessarie su azure per visionare io container ( tips : dovreste vedere http://ip_azure:3000)
> direttamente da portale //
```
sudo az network nsg rule create --resource-group <nome_del_tuo_resource_group> --nsg-name <nome_del_tuo_nsg> --name Allow-HTTP --protocol Tcp --priority 500 --destination-port-range 3000 --access Allow --direction Inbound
```
6) fermare il container da ssh .
```
sudo docker stop Webnginx
```
6 ) verificare che anche portainer ha dato il container fermo ( f5 per ricaricare la pagina )

7 ) visionare da ssh i log del container
```
sudo docker logs Webnginx
```
8 ) cancellare il container da ssh  e controllare che non esista più
```
sudo docker rm Webnginx
```
_____________________________________________________________________________________________________________________________
# Creazione di un DockerFile
Passo 1 : Creare la struttura del progetto
```
mkdir hello-docker
cd hello-docker
```
> creazione di una nuova directory hello-docker> cd hello-docker> directory che contiene tutti i file necessari per il progetto.

## Node.js
Passo 2 :
Creare l'applicazione Node.js> file chiamato app.js con il seguente contenuto:
```
const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
    res.send('Hello, World!');
});

app.listen(port, () => {
    console.log(`App listening at http://localhost:${port}`);
});

```
Con questo passaggio creo una web-app con il framework Express. Risponde su porta 3000, "Hello,world!" quando viene effettuata la richiesta.

Un'immagine Node.js include l'installazione di Node.js, che è un ambiente di runtime per JavaScript, e NPM (Node Package Manager), che è il gestore di pacchetti per Node.js. 
Questi strumenti sono essenziali per eseguire e gestire applicazioni JavaScript sul server.

1. Le immagini Node.js sono configurate con le impostazioni di base necessarie per eseguire applicazioni Node.js, come variabili d'ambiente e percorsi di installazione.
2. Le immagini Node.js sono disponibili in diverse versioni, consentendo agli sviluppatori di scegliere la versione di Node.js più adatta alle loro applicazioni. Ad esempio, puoi trovare immagini per versioni specifiche come node:14, node:16, ecc.
3. Utilizzando un'immagine Node.js, gli sviluppatori possono garantire che le loro applicazioni funzionino in modo coerente su diverse macchine e ambienti, poiché il container include tutte le dipendenze necessarie.

Passo 3:
Creare un file package.json: questo file contiene informazioni importanti riguardanti il progetto, le sue dipendenze e le configurazioni necessarie per gestire l'applicazione. In questo caso è specificato che il progetto dipende dal pacchetto "express".

1. Contenuto di un package.json
- Nome e versione:
    - name: Il nome del pacchetto o del progetto.
    - version: La versione corrente del pacchetto, seguendo la convenzione di versioning semantico (semver).
2. Descrizione:
- description: Una breve descrizione del progetto.
3. Autore e licenza:
- author: Il nome dell'autore del progetto.
- license: La licenza sotto cui è distribuito il progetto (ad esempio, MIT, GPL).
4. Dipendenze:
- dependencies: Un oggetto che elenca le dipendenze necessarie per l'applicazione in fase di esecuzione. 
- devDependencies: Un oggetto simile a dependencies, ma per le dipendenze necessarie solo durante lo sviluppo (ad esempio, strumenti di test, linters, ecc.).
5. Script:
- scripts: Un oggetto che definisce comandi personalizzati che possono essere eseguiti tramite npm.
6. Configurazioni:
- Puoi includere altre configurazioni specifiche per il tuo progetto o per le dipendenze.

```
{
  "name": "hello-docker",
  "version": "1.0.0",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  },
  "dependencies": {
    "express": "^4.17.1"
  }
}
```
Passo 4:
Installare le dipendenze:
Esegui il seguente comando per installare Express. Questo comando legge il file package.json e installa le dipendenze specificate nella directory node_modules.
```
npm install
```
Passo 5: Creare un Dockerfile
```
# Usa un'immagine base di Node.js
FROM node:14
Specifica l'immagine da utilizzare per costruire l'immagine Docker. In questo caso, stai utilizzando l'immagine ufficiale di Node.js, versione 14. Docker scaricherà questa immagine dal Docker Hub se non è già presente localmente.
2. WORKDIR /usr/src/app
Questa riga imposta la directory di lavoro all'interno del container. Tutti i comandi successivi verranno eseguiti in questa directory. Se la directory non esiste, Docker la creerà automaticamente. In questo caso, stai impostando /usr/src/app come directory di lavoro.
3. COPY package*.json ./
Questa riga copia i file package.json e package-lock.json (se presente) dalla tua macchina locale nella directory di lavoro del container (/usr/src/app). Questi file contengono le informazioni sulle dipendenze del tuo progetto Node.js.
4. RUN npm install
Questo comando esegue npm install all'interno del container, installando tutte le dipendenze specificate nel file package.json. Le dipendenze verranno installate nella directory node_modules all'interno del container.
5. COPY . .
Questa riga copia il resto dei file e delle cartelle del tuo progetto dalla tua macchina locale nella directory di lavoro del container. Il primo punto (.) rappresenta la directory corrente sulla tua macchina locale, mentre il secondo punto (.) rappresenta la directory di lavoro nel container (/usr/src/app).
6. EXPOSE 3000
Questa riga indica che il container ascolterà sulla porta 3000. È una dichiarazione informativa per chi utilizza l'immagine, ma non apre effettivamente la porta. Quando esegui il container, dovrai mappare questa porta a una porta sulla tua macchina host per poter accedere all'applicazione.
7. CMD ["npm", "start"]
Questa riga specifica il comando predefinito da eseguire quando il container viene avviato. In questo caso, stai eseguendo npm start, che di solito avvia l'applicazione Node.js. Puoi sovrascrivere questo comando quando avvii il container, ma se non lo fai, verrà eseguito questo comando.

Passo 6: Costruire l'immagine Docker
Questo comando costruisce l'immagine Docker utilizzando il Dockerfile presente nella directory corrente e la etichetta con il nome hello-docker

```
sudo docker build -t hello-docker .
```

Passo 7: Eseguire il container
Esegui il container con il seguente comando bash

```
sudo docker run -d -p 3000:3000 hello-docker
```
1. Crea un nuovo container basato sull'immagine hello-docker.
2. Avvia il container in background.
3. Mappa la porta 3000 del container alla porta 3000 della tua macchina host, consentendoti di accedere all'applicazione Node.js in esecuzione nel container.

Testare l'applicazione:
Apri il tuo browser e vai su http://localhost:3000. Dovresti vedere il messaggio "Hello, World!".

