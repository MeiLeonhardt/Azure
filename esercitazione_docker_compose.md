# Esercitazione
1. Creo una nuova cartella principale in cui andranno diverse sottocartelle e file, docker-compose.yml - nginx/ - app/
2. Creo i vari file Dockerfile, nginx.conf, index.js
```yaml
version: '3.8'

services:
  nginx:
    image: nginx:latest
    ports:
      - "81:80"
    volumes:
      - ./nginx/nginx.conf:/etc/nginx/nginx.conf
    depends_on:
      - app

  app:
    build:
      context: ./app
      dockerfile: Dockerfile
    ports:
      - "3001:3000"
    environment:
      - DATABASE_URL=postgres://user:password@db:5432/mydb
    depends_on:
      - db

  db:
    image: postgres:15
    restart: unless-stopped #riavvia il container a meno che non sia fermato manualmente
    environment:
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
      POSTGRES_DB: mydb
    volumes:
      - pgdata:/var/lib/postgresql/data

  pgadmin:
    image: dpage/pgadmin4
    ports:
      - "8080:80"
    environment:
      PGADMIN_DEFAULT_EMAIL: admin@example.com
      PGADMIN_DEFAULT_PASSWORD: admin
    depends_on:
      - db

volumes:
  pgdata:
```

### Struttura delle cartelle:
```
project/
│
├── docker-compose.yml
├── nginx/
│   └── nginx.conf
└── app/
    ├── Dockerfile
    └── index.js
```

### Esempio di `nginx.conf`:
```nginx
events {}

http {
    server {
        listen 80;

        location / {
            proxy_pass http://app:3000;
            proxy_set_header Host $host;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
            proxy_set_header X-Forwarded-Proto $scheme;
        }
    }
}
```
## file package.json
questo file ha la lista delle dipendenze che mancano per il deployment> si tratta di uno degli elementi che sere per deployare con Dockerfile. .json è un linguaggio che contiene valori con dipendenze, in questo caso l'unico valore di cui ha bisogo è express
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

### Esempio di `app/Dockerfile`:
```Dockerfile
FROM node:18

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install

COPY . .

EXPOSE 3000
CMD ["node", "index.js"]
```

### Esempio di `app/index.js`:
```js
const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.send('Hello from Node.js app behind Nginx!');
});

app.listen(3000, () => {
  console.log('Server listening on port 3001');
});
```
```
sudo docker-compose up --build


