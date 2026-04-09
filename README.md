# 🎒 Schoolsurvival Game

**Gemaakt door:** Pieter
**Gemaakt in:** Godot Engine 4 (GDScript)

## 📖 Over de Game
Schoolsurvival is een 2D top-down survival game waarin je als leerling de ultieme test moet doorstaan: overleven op school! Ontwijk de gevaarlijke Boekmonsters, verdien XP en probeer level 10 te bereiken om de game uit te spelen en je "diploma" te halen.

## 🎮 Besturing
* **Bewegen:** W, A, S, D
* **Kijken / Richten:** Muis
* **Schieten:** Linkermuisknop

## ✨ Features (Wat ik heb geprogrammeerd)
Tijdens dit project heb ik verschillende game-systemen vanaf de grond opgebouwd met GDScript:
* **Volledige Game Loop:** Een vloeiende overgang tussen het Main Menu, de speelwereld, een Game Over-scherm en een Win-scherm (inclusief het pauzeren van de game state).
* **Player Stats & UI:** Een `CanvasLayer` HUD met een dynamische Health-bar, XP-balk en Level-teller die worden geüpdatet via *Signals*.
* **Combat & Upgrades:** De speler doet meer schade en schiet sneller bij elk nieuw level. Ook heb ik *i-frames* (tijdelijke onoverwinnelijkheid) toegevoegd nadat de speler geraakt wordt.
* **Enemy AI:** Boekmonsters die de speler detecteren, berekenen hoe dichtbij ze zijn en schade uitdelen via een cooldown-timer.
* **Audio Systeem (Autoload):** Ruimtelijke geluidseffecten (`AudioStreamPlayer2D`) bij inslagen en een geavanceerd `Globals` (Autoload) systeem dat zorgt dat de achtergrondmuziek naadloos blijft doorspelen tijdens het wisselen van menu naar game.

## 🚀 Hoe test je deze game?
1. Open Godot Engine (versie 4.4.1.stable) https://godotengine.org/download/archive/.
2. Importeer de projectmap of klik op het `project.godot` bestand.
3. Druk op de **Play** knop rechtsboven in de editor (of druk op **F5**).
4. De game start automatisch in het hoofdmenu (zorg dat `MainMenu.tscn` is ingesteld als Main Scene in de Project Settings).
