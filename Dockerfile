# Creazione di un DockerFile
Passo 1 : Creare la struttura del progetto
```
mkdir hello-docker
cd hello-docker
```
## Node.js 
Caratteristiche di un'immagine Node.js
Node.js e NPM: Un'immagine Node.js include l'installazione di Node.js, che è un ambiente di runtime per JavaScript, e NPM (Node Package Manager), che è il gestore di pacchetti per Node.js. Questi strumenti sono essenziali per eseguire e gestire applicazioni JavaScript sul server.
Configurazione di base: Le immagini Node.js sono configurate con le impostazioni di base necessarie per eseguire applicazioni Node.js, come variabili d'ambiente e percorsi di installazione.
Versioni: Le immagini Node.js sono disponibili in diverse versioni, consentendo agli sviluppatori di scegliere la versione di Node.js più adatta alle loro applicazioni. Ad esempio, puoi trovare immagini per versioni specifiche come node:14, node:16, ecc.
Compatibilità: Utilizzando un'immagine Node.js, gli sviluppatori possono garantire che le loro applicazioni funzionino in modo coerente su diverse macchine e ambienti, poiché il container include tutte le dipendenze necessarie.

Passo 2 :
Creare l'applicazione Node.js:
Crea un file chiamato app.js con il seguente contenuto:
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
Passo 3:
Creare un file package.json:
Crea un file chiamato package.json con il seguente contenuto: esso contiene informazioni importanti riguardanti il progetto, le sue dipendenze e le configurazioni necessarie per gestire l'applicazione. Ecco una panoramica delle sue principali caratteristiche e utilizzi:
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
Esegui il seguente comando per installare Express:
```
npm install
```
Creare un Dockerfile:
```
# Usa un'immagine base di Node.js
FROM node:14
Questa riga specifica l'immagine base da cui partire per costruire la tua immagine Docker. In questo caso, stai utilizzando l'immagine ufficiale di Node.js, versione 14. Docker scaricherà questa immagine dal Docker Hub se non è già presente localmente.
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

Costruire l'immagine Docker:
```
sudo docker build -t hello-docker .
```


Eseguire il container:
Esegui il container con il seguente comando:
bash

```
sudo docker run -d -p 3000:3000 hello-docker
```

Testare l'applicazione:
Apri il tuo browser e vai su http://localhost:3000. Dovresti vedere il messaggio "Hello, World!".
