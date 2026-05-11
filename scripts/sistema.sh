#!/bin/bash 

 

# ============================================ 

# sistema.sh — Automatización de 3 tareas 

# Autor: tu-nombre 

# TP01 — Operaciones1 

# ============================================ 

 

set -euo pipefail 

FECHA=$(date +"%Y-%m-%d_%H-%M-%S") 

DIR_BASE="$(cd "$(dirname "$0")/.." && pwd)" 

DIR_LOGS="$DIR_BASE/logs" 

DIR_BACKUPS="$DIR_BASE/backups" 

DIR_ORIGEN="${1:-$DIR_BASE}" 

DIAS_RETENTION="${2:-7}" 

 

log() { 

    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$DIR_LOGS/sistema.log" 

} 

 

# ── TAREA 1: Backup con timestamp ──────────────────────── 

tarea_backup() { 

    log "=== TAREA 1: Iniciando backup ===" 

    local destino="$DIR_BACKUPS/backup_$FECHA" 

    mkdir -p "$destino" 

 

    cp -r "$DIR_ORIGEN"/*.sh "$destino/" 2>/dev/null || true 

 

    local cantidad=$(ls "$destino" 2>/dev/null | wc -l) 

    log "Backup completado en: $destino ($cantidad archivos)" 

} 

 

# ── TAREA 2: Limpieza de logs viejos ───────────────────── 

tarea_limpieza() { 

    log "=== TAREA 2: Limpieza de archivos mayores a $DIAS_RETENTION días ===" 

    local eliminados=0 

 

    while IFS= read -r -d '' archivo; do 

        rm -f "$archivo" 

        log "Eliminado: $archivo" 

        ((eliminados++)) 

    done < <(find "$DIR_BACKUPS" -type f -mtime +"$DIAS_RETENTION" -print0 2>/dev/null) 

 

    log "Limpieza completa. Archivos eliminados: $eliminados" 

} 

 

# ── TAREA 3: Reporte de salud del sistema ──────────────── 

tarea_reporte() { 

    log "=== TAREA 3: Reporte de salud del sistema ===" 

    local reporte="$DIR_LOGS/reporte_$FECHA.txt" 

 

    { 

        echo "===============================" 

        echo "  REPORTE DE SALUD — $FECHA" 

        echo "===============================" 

        echo "" 

        echo "--- CPU ---" 

        top -bn1 | grep "Cpu(s)" | awk '{print "Uso CPU: " $2 "%"}' 

        echo "" 

        echo "--- MEMORIA ---" 

        free -h | awk '/^Mem:/ { 

            printf "Total: %s | Usado: %s | Libre: %s\n", $2, $3, $4 

        }' 

        echo "" 

        echo "--- DISCO ---" 

        df -h / | awk 'NR==2 { 

            printf "Total: %s | Usado: %s | Libre: %s | Uso: %s\n", $2, $3, $4, $5 

        }' 

        echo "" 

        echo "--- PROCESOS TOP 5 (por CPU) ---" 

        ps aux --sort=-%cpu | head -6 | awk 'NR>1 {printf "%-20s CPU: %s%%\n", $11, $3}' 

        echo "" 

        echo "--- UPTIME ---" 

        uptime 

    } > "$reporte" 

 

    log "Reporte guardado en: $reporte" 

    cat "$reporte" 

} 

 

# ── MAIN ───────────────────────────────────────────────── 

main() { 

    log "============================================" 

    log "Iniciando script de automatización del sistema" 

    log "Directorio base: $DIR_BASE" 

    log "============================================" 

 

    tarea_backup 

    tarea_limpieza 

    tarea_reporte 

 

    log "============================================" 

    log "Todas las tareas completadas exitosamente" 

    log "============================================" 

} 

 

main "$@" 
