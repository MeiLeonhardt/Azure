# Azure
Portal Azure Management

## Connessione con chiave pubblica a VM-Linux porta SSH
```
#create .ssh 
mkdir C:\Users\Tuonomeutente\.ssh
```
```
#spostare file da download a .ssh
move C:\Users\tuonomeutente\Downloads\nomefilescaricato_key.pem C:\Users\saras\.ssh
```
```
#eseguo la connessione
ssh -i C:\Users\tuonomeutente\.ssh\nomefilescaricato_key.pem userscelto@IPpubblicoVM
```
