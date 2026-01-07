Guía original: [Self Host a Ghost Blog on Your Homelab Using Docker](https://noted.lol/self-host-ghost/)

### 13/3/25

- Me pitié el servidor al instalar un servidor CUPS para la impresora en la raspberry fuera de docker y sin cuidados específicos.
- Tuve que partir de cero, formateando la raspberry. No fue difícil, me topé con algunas panas que pude resolver preguntándole a Claude.
#### Primera pana: Servidor ghost deja de publicar sus puertos por problema de autenticación en la BBDD.

I see the problem now! This error clearly shows a database authentication issue that's causing your Ghost container to shut down almost immediately after starting. Let's break down what's happening and fix it step by step.


#### Segunda pana: Cloudflare no puede conectar con el servidor local porque no especifiqué puerto en la URL
I can see from the error logs that your Cloudflare Tunnel is successfully connecting to Cloudflare's network, but it's having trouble reaching your local service. The specific error is:

```
Unable to reach the origin service. The service may be down or it may not be responding to traffic from cloudflared: dial tcp 192.168.1.106:80: connect: connection refused
```

This indicates that Cloudflare's tunnel agent (cloudflared) cannot establish a connection to your local web server at 192.168.1.106 on port 80. Let's analyze what's happening and how to fix it.

#### Mejoras: Automatizar reinicio del túnel en el comando que lo crea
No, this Docker command won't automatically restart after a power outage. The way you're running the container doesn't include any restart policy, so if your Raspberry Pi reboots after a power outage, the tunnel container won't automatically start again.

To make your Cloudflare tunnel restart automatically, you should add the `--restart always` flag to your Docker run command. Here's how to modify your command:

```bash
docker run -d --restart always cloudflare/cloudflared:latest tunnel --no-autoupdate run --token eyJhIjoiYmIwYmNiZTg0Y2E2NTJlNjg3ZjI0ZDA1YWQ3YmZhYWIiLCJ0IjoiMWQyZGFkMTEtMDZmMi00NzhjLThjZGYtOTY0MGMwMTMyMWQyIiwicyI6IllXTTBOemszT1dNdE5XUm1aUzAwTTJWaExUa3dZVEl0Wldaak5UWTJZMkV6T1RBOCJ9
```

The `--restart always` policy tells Docker to always restart the container:

- When the Docker daemon starts (like after a reboot)
- When the container exits for any reason (crash, error, etc.)
- When the container is manually stopped, it will restart unless you explicitly remove it

If you already have the container running, you can update its restart policy without recreating it:

```bash
docker update --restart always <container-id-or-name>
```

For even better reliability, I would recommend creating a proper service for your tunnel. You can do this in two ways:

1. **Using Docker Compose** - Create a docker-compose.yml file:

```yaml
version: '3'
services:
  cloudflared:
    image: cloudflare/cloudflared:latest
    restart: always
    command: tunnel --no-autoupdate run --token eyJhIjoiYmIwYmNiZTg0Y2E2NTJlNjg3ZjI0ZDA1YWQ3YmZhYWIiLCJ0IjoiMWQyZGFkMTEtMDZmMi00NzhjLThjZGYtOTY0MGMwMTMyMWQyIiwicyI6IllXTTBOemszT1dNdE5XUm1aUzAwTTJWaExUa3dZVEl0Wldaak5UWTJZMkV6T1RBOCJ9
```

Then run it with:

```bash
docker-compose up -d
```

2. **Using a systemd service** - Create a service file to start the Docker container automatically:

```bash
sudo nano /etc/systemd/system/cloudflared-tunnel.service
```

With this content:

```
[Unit]
Description=Cloudflare Tunnel
After=docker.service
Requires=docker.service

[Service]
TimeoutStartSec=0
Restart=always
ExecStart=/usr/bin/docker run --rm --name cloudflared-tunnel cloudflare/cloudflared:latest tunnel --no-autoupdate run --token eyJhIjoiYmIwYmNiZTg0Y2E2NTJlNjg3ZjI0ZDA1YWQ3YmZhYWIiLCJ0IjoiMWQyZGFkMTEtMDZmMi00NzhjLThjZGYtOTY0MGMwMTMyMWQyIiwicyI6IllXTTBOemszT1dNdE5XUm1aUzAwTTJWaExUa3dZVEl0Wldaak5UWTJZMkV6T1RBOCJ9
ExecStop=/usr/bin/docker stop cloudflared-tunnel

[Install]
WantedBy=multi-user.target
```

Then enable and start the service:

```bash
sudo systemctl enable cloudflared-tunnel
sudo systemctl start cloudflared-tunnel
```

This systemd approach is particularly good because it will not only restart your container after reboot but also monitor it and restart it if it crashes for any reason.

Remember to stop and remove any existing tunnel containers before setting up these more permanent solutions to avoid running duplicate tunnels.



### 7/3/25

- Me percaté que dejó de funcionar la página.
- En el Raspberry docker estaba operativo, podía acceder a la página en la red local. El problema estaba en cloudflare.
- Seguí las instrucciones del blog, pero la página "Tunnel" dentro de "Zero Trust" ahora estaba en "Network" y no en "Access".
- Me metí a revisar, decía que el enlace estaba OK. Actualicé el certificado y corrí nuevamente el comando en docker, que corrió bien. Seguía sin funcionar.
- Después caché que estaba asociada a una ip interna incorrecta (192.168.1.92, cuando ahora el raspberry tenía asignado una terminada en .137). La actualicé y comenzó a funcionar de inmediato.

### Notas

- Para actualizar Ghost tuve que borrar el stack de portainer y crear uno nuevo utilizando el de la guía original.
- Antes de eso, respaldé todo el contenido, descargué los redirects y routes, etc.
- Tuve que cargar todo de nuevo, pero quedó igual. Me demoré 5 minutos y quedó actualizado.

