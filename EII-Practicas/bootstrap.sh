# Actualizar repositorios
zypper refresh

# Cambiar configuración LOCALE 
localectl set-locale LANG=es_ES.UTF-8
localectl set-keymap es

# Configurar NTP
zypper --non-interactive install chrony-pool-openSUSE
systemctl start chronyd.service
systemctl enable chronyd.service

# Configurar nombre de VM usando el argumento que le pasemos al script
hostnamectl hostname $1

# Instalar CRM y sus dependencias
zypper --non-interactive install crmsh

#Añadir IP y nombre de cada VM del cluster en el fichero /etc/hosts  

# Se non hai entradas de execucións previas
if [[ ! $(grep "192.168.56" "/etc/hosts") ]]; then
# Inserir as liñas iniciais
echo >> /etc/hosts
echo "# acr2324-cluster" >> /etc/hosts
else
# Eliminar as entradas de execucións previas
sed -i "/192.168.56/d" /etc/hosts
fi
echo "192.168.56.2 acr2324-master" >> /etc/hosts
echo "192.168.56.3 acr2324-slave" >> /etc/hosts
echo "192.168.56.4 acr2324-spare" >> /etc/hosts