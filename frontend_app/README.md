# frontend_app

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## Installer flutter 

1. [Install flutter](https://docs.flutter.dev/get-started/install)
2. Suivre précicément la partit **Get the Flutter SDK**

## Pour démarrer l'application

1. Ouvrir le simulateur de l'application

pour mac :
```
open -a Simulator
```

2. Aller a la racine du répertoire et lancer la commande pour pouvoir utiliser flutter.
```
export PATH="$PATH:`pwd`/flutter/bin"
```

3. aller dans le dossier **frontend_app**
```
flutter run
```

### Sur Chrome 

pour démarrer sur un port spécifique
```
flutter run -d chrome --web-port 8080
```

## Commande utile

Pour formater correctement un fichier
```
flutter format <filename>
```

Pour créer un fichier pour un model
```
flutter pub run build_runner build --delete-conflicting-outputs
```

## Clé API

AIzaSyAu2WU5ty2iMgm-A6AwrfWF-ybB_kuYX6c