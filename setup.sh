#!/bin/bash

# Definindo o nome do arquivo de log
LOG_FILE="/var/log/setup_summary_$(date +'%Y-%m-%d_%H-%M-%S').log"

# Função para registrar mensagens no log
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a "$LOG_FILE"
}

log "Iniciando o setup."

log "Habilitando e iniciando Apache..."
sudo systemctl enable apache2 && sudo systemctl start apache2
log "Apache habilitado e iniciado."

log "Clonando repositório do GitHub..."
if sudo git clone /https://github.com/MatheusCodeCruz/AWS_Scripts.git var/www/html/; then
    log "Repositório clonado com sucesso."
else
    log "Erro ao clonar o repositório."
fi

log "Ajustando permissões..."
sudo chown -R www-data:www-data /var/www/html/
sudo chmod -R 755 /var/www/html/
log "Permissões ajustadas com sucesso."

log "Enviando requisição POST..."

if curl -X POST -d "nome= Matheus da Cruz Matos" https://difusaotech.com.br/lab/aws/index.php; then
    log "Requisição POST enviada com sucesso."
else
    log "Falha ao enviar requisição POST."
fi

log "Setup concluído com sucesso."

