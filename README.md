# Azure
Portal Azure Management

## Connessione con chiave pubblica a VM-Linux porta SSH
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
```
#connessione con password (-p) serve per richiamare la password di accesso
#Attenzione! è importante inserire la password manualmente, non copia-incolla
ssh -i -p nomeutente@IPpubblico
```
```
sudo apt update
```
```
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
```
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
```
```
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
```
```
sudo apt update
```
```
sudo apt install docker-ce -y
```
