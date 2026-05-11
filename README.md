# TP01 - Operaciones1 — Automatización con Bash 

Script que automatiza 3 tareas de administración de sistemas Linux. 

## Tareas automatizadas 

1. **Backup con timestamp** — copia archivos del directorio actual 

2. **Limpieza de archivos viejos** — elimina backups con más de N días 

3. **Reporte de salud** — genera informe de CPU, memoria y disco 

## Uso 
# TP01 - Operaciones1 — Automatización con Bash 

Script que automatiza 3 tareas de administración de sistemas Linux. 

## Tareas automatizadas 

1. **Backup con timestamp** — copia archivos del directorio actual 

2. **Limpieza de archivos viejos** — elimina backups con más de N días 

3. **Reporte de salud** — genera informe de CPU, memoria y disco 

## Uso 

 

Ejecutar en bash 

bash scripts/sistema.sh [directorio_origen] [dias_retencion] 

Ejemplos 

bash scripts/sistema.sh           # usa defaults 

bash scripts/sistema.sh /var/log 3  # limpia archivos de más de 3 días 

Estructura 

devops-TP01/ 

├── scripts/ 

│   └── sistema.sh 

├── logs/ 

│   ├── sistema.log 

│   └── reporte_FECHA.txt 

├── backups/ 

└── README.md 

--- 
