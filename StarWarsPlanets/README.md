## StarWarsPlanets

StarWarsPlanets is an iOS application that explores planets from the Star Wars universe. This app fetches data from [SWAPI](https://swapi.dev/documentation), presents detailed planet information.
 


### Requirements

iOS 14.0+

Xcode 13.0+

Swift 5.5+

## Features

```Planet List```: Browse through a list of planets from the Star Wars universe.

```Detailed Planet View```: View detailed information about a selected planet, including climate, population, and terrain.

```Offline mode```: App support offline storage to browse pre-saved planets.

## Project Structure

The project is organized into the following directories:

### Core
Contains core utilities and base functionality used across the app.

### App
 Entry points such as AppDelegate and SceneDelegate.

### Networking
Handles API requests and network communication.

### Resources: 
Includes assets such fonts and images

### Extensions: 
Extensions for existing classes to add reusable functionality.

### Model: 
Defines the data structures and models for the app
- Planet
- PlanetEntity

### Services:
- PlanetService
Provides service layers or business logic
