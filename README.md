# RedzExplorer

An Ios application that allows you to Explore Redz videos and Users.

> 💡NOTE: `This application supports IOS 15.0 as a minimum`

## Features
- [x] Master Detail Architecture Given a master view of Video thumbnail and basic information about video
- [x] Lazy loading and pagination are implemented to ensure smooth performance
- [x] Image caching using `SDWEBImage` 
- [x] Async loading of thumbnail Images with Skeletonise place holders using `SkeletonView` library
- [x] Video Details page that desiplays Users information in addition to different stats about the video `Like count, Comment and View count`
- [x] Utilized UIKit storyboard, and SwiftUI for the view desgins
- [x] A Simple splash screen using LaunchScreen.storyboard
- [x] Only supports Portrait mode on Iphones'

## Requirements
> 💡NOTE: `This application Uses Swift Package Manager to download needed libraries`
 - **IOS** 15.0
 - **XCode** 14+
 - **SDWebImage** library: `https://github.com/SDWebImage/SDWebImage/tree/master` for image caching and lazy loading
 - **Alamofire** library: `https://github.com/Alamofire/Alamofire` for Api calls
 - **SkeletonView** library: `https://github.com/Juanpe/SkeletonView` for Image placeholders

## How to Run the Project

Follow the steps below to set up and run the project on your local machine:

### 1. Clone the Repository

First, clone this repository to your local machine using the following command:

```bash
git clone https://github.com/lqasim/RedzExplorer.git
```

### 2. Open Project in Xcode
Navigate to the folder where you cloned the repository and open the .xcodeproj

### 3. Install dependencies mentioned upove

### 4. Run the application

 ### 5. Basic UseCase
 
  - The app displays a list of Videos Which you can filter based on keywords provided by the application.
  - When tapped on a cell a newtab is pushed which contains the User and Video details to be shown to you

