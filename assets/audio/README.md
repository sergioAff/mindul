# Archivos de Audio para Meditaciones

Esta carpeta contiene los archivos de audio utilizados en las sesiones de meditación.

## Estructura de archivos

Los archivos de audio deben seguir esta convención de nombres para que la aplicación pueda asociarlos automáticamente con el tipo de meditación:

- `calm_meditation.mp3` - Para meditaciones de calma
- `focus_meditation.mp3` - Para meditaciones de concentración
- `sleep_meditation.mp3` - Para meditaciones de sueño
- `energy_meditation.mp3` - Para meditaciones de energía
- `stress_reduction.mp3` - Para meditaciones de reducción de estrés
- `morning_meditation.mp3` - Para meditaciones matutinas
- `evening_meditation.mp3` - Para meditaciones nocturnas

## Formato de archivos

- Utiliza archivos MP3 para mejor compatibilidad
- Recomendaciones técnicas:
  - Bitrate: 128-192 kbps para balance entre calidad y tamaño
  - Frecuencia de muestreo: 44.1 kHz
  - Canales: Estéreo

## Incorporación de nuevos tipos de meditación

Si necesitas incorporar un nuevo tipo de meditación:

1. Agrega el archivo de audio con un nombre descriptivo
2. Actualiza el enum `MeditationType` en `lib/core/services/audio_service.dart`
3. Agrega el nuevo tipo y su archivo correspondiente al mapa `_meditationSounds`
4. Actualiza el método `getMeditationTypeFromTitle` para detectar el nuevo tipo 