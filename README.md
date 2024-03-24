# Cinematrix
This project is an implementation of the TMDB api using SwiftUI.

## Setup
Insert your MOVIE_API_KEY on build settings. 

## Running the Project
To run the project, open TinyBeans.xcodeproj and execute it on the iOS Simulator. We use Swift Package Manager to manage dependencies.

## Features
The app allows users to see popular movies using the [TMDB API](https://developer.themoviedb.org/reference/intro/getting-started). Upon opening the app, it initially displays a list of popular movies. The list is paginated, with new pages loading as the user scrolls. By clicking on a movie the user can see the movie details.

## Architecture
We adopt the MVVM architecture. For networking and storage, we utilize repositories, clients, providers and services.

## Configurations
MOVIE_API_KEY, MOVIE_BASE_URL and MOVIE_IMAGE_BASE_URL are configured as build settings.

## Running Tests
The project includes unit tests; run them with the command + u shortcut.

## Packages
Nuke is employed for image download and image cache handling. 

## Supported Destinations
The project is designed for iOS, with a minimum deployment target of iOS 16.0.

## Project Structure
.
├── Cinematrix
│   ├── Cinematrix.entitlements
│   ├── CinematrixApp.swift
│   ├── Client
│   │   ├── DTOs
│   │   │   ├── ErrorResponseDTO.swift
│   │   │   ├── MovieDetailsResponseDTO.swift
│   │   │   └── MovieResponseDTO.swift
│   │   ├── MovieClient.swift
│   │   ├── NetworkClient.swift
│   │   └── NetworkManager.swift
│   ├── Components
│   │   ├── BorderedText.swift
│   │   ├── LazyImageWrapperView.swift
│   │   └── PositionObservingView.swift
│   ├── CoreData
│   │   ├── BaseRepository.swift
│   │   ├── Cinematrix.xcdatamodeld
│   │   │   └── Cinematrix.xcdatamodel
│   │   │       └── contents
│   │   ├── Movie.swift
│   │   └── MovieRepository.swift
│   ├── Features
│   │   ├── MovieDetails
│   │   │   ├── MovieBackdropsView.swift
│   │   │   ├── MovieCastListView.swift
│   │   │   ├── MovieDetailsView.swift
│   │   │   ├── MovieDetailsViewContent.swift
│   │   │   ├── MovieDetailsViewModel.swift
│   │   │   └── MovieGeneralInfoView.swift
│   │   └── PopularMovies
│   │       ├── PopularMovieCell.swift
│   │       ├── PopularMovieListView.swift
│   │       └── PopularMoviesViewModel.swift
│   ├── Info.plist
│   ├── Models
│   │   ├── MovieDetails.swift
│   │   ├── MovieListMetaData.swift
│   │   └── MovieSummary.swift
│   ├── Persistence.swift
│   ├── Preview Content
│   │   └── Preview Assets.xcassets
│   │       └── Contents.json
│   ├── Resources
│   │   ├── Assets.xcassets
│   │   │   ├── AccentColor.colorset
│   │   │   │   └── Contents.json
│   │   │   ├── AppIcon.appiconset
│   │   │   │   └── Contents.json
│   │   │   └── Contents.json
│   │   └── Localizable.xcstrings
│   ├── Services
│   │   └── MovieService.swift
│   └── Utils
│       ├── LozalizableStrings.swift
│       └── UserDefaultWrapper.swift
└── README.md

## Author
Mateus Forgiarini da Silva
mateusforgiarini@hotmail.com

