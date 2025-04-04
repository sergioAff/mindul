# Mindful Moments

![Mindful Moments](https://via.placeholder.com/800x400?text=Mindful+Moments+App)

Una aplicación de meditación diseñada para ayudarte a encontrar paz y equilibrio mental a través de sesiones guiadas de meditación y mindfulness.

## ✨ Características

- **Variedad de meditaciones** - Diferentes categorías como calma, sueño, energía y reducción de estrés
- **Reproductor de audio** - Reproduce sonidos relajantes durante tus sesiones de meditación
- **Notificaciones** - Te recuerda practicar y te notifica cuando completas sesiones
- **Interfaz intuitiva** - Diseño limpio y minimalista para una experiencia sin distracciones
- **Multiplataforma** - Disponible para iOS, Android y macOS

## 📱 Capturas de pantalla

<div style="display: flex; justify-content: space-between;">
    <img src="https://via.placeholder.com/250x500?text=Pantalla+Principal" width="30%" alt="Pantalla Principal">
    <img src="https://via.placeholder.com/250x500?text=Selección+de+Meditación" width="30%" alt="Selección de Meditación">
    <img src="https://via.placeholder.com/250x500?text=Sesión+de+Meditación" width="30%" alt="Sesión de Meditación">
</div>

## 🛠️ Tecnologías

- **[Flutter](https://flutter.dev/)** - Framework UI multiplataforma
- **[Dart](https://dart.dev/)** - Lenguaje de programación
- **[Get_It](https://pub.dev/packages/get_it)** - Para inyección de dependencias
- **[Just Audio](https://pub.dev/packages/just_audio)** - Reproducción de audio de alta fidelidad
- **[Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications)** - Manejo de notificaciones locales

## 📂 Estructura del Proyecto

```
lib/
├── config/               # Configuraciones generales de la app
├── core/                 # Funcionalidades centrales
│   ├── di/               # Inyección de dependencias
│   └── services/         # Servicios (audio, notificaciones)
├── data/                 # Capa de datos
│   ├── datasources/      # Fuentes de datos
│   └── models/           # Modelos de datos
├── domain/               # Lógica de negocio
│   ├── entities/         # Entidades
│   └── usecases/         # Casos de uso
├── presentation/         # Capa de presentación
│   ├── pages/            # Pantallas
│   └── widgets/          # Componentes reutilizables
└── main.dart             # Punto de entrada de la aplicación
```

## 🚀 Instalación

### Requisitos previos

- Flutter (versión 3.x o superior)
- Dart (versión 3.x o superior)
- Android Studio / XCode (para emuladores y publicación)

### Pasos

1. Clona el repositorio:
   ```bash
   git clone https://github.com/tu-usuario/mindful_moments.git
   cd mindful_moments
   ```

2. Instala las dependencias:
   ```bash
   flutter pub get
   ```

3. Ejecuta la aplicación:
   ```bash
   flutter run
   ```

## 📋 Uso

1. Inicia la aplicación desde el emulador o dispositivo
2. Explora las diferentes categorías de meditación
3. Selecciona una meditación de tu preferencia
4. Ajusta el volumen si es necesario
5. Presiona el botón Play para comenzar la sesión
6. Disfruta de tu momento de calma y mindfulness

## 📄 Licencia

Este proyecto está bajo la Licencia MIT - ver el archivo [LICENSE](LICENSE) para más detalles.

## 📬 Contacto

[Tu Nombre] - [@tu_twitter](https://twitter.com/tu_twitter) - tu.email@ejemplo.com

Link del proyecto: [https://github.com/tu-usuario/mindful_moments](https://github.com/tu-usuario/mindful_moments)
