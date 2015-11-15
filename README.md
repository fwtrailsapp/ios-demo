# ios-demo

## Introduction

ios-demo is a demo iOS mobile application for the City of Fort Wayne in Fort Wayne, IN. They have requested
our team create cross-platform mobile applications on Android and iOS for their Rivergreenway Trails system. 
The app's purpose is to collect trail usage data to aid the City in planning and trail maintenance. As such,
the app's functionality focuses around its GPS capabilities. This will allow users to track their positioning
on the trails as well as trail activity statistics (e.g. distance traveled, average speed, activity duration).

## Features

### Account System

Users will be able to save the state of their app instance using our account system. The accounts, and the
associated information, will be stored on our database. 

### GPS

The app will allow users to track their positioning on the trails. This same GPS data will also be saved for
use by the City of Fort Wayne.

### Activity System

Within the context of our app, each session of trail usage is considered an Activity. Activities encapsulate
the GPS tracking associated with trail use as well as other features such as calorie, duration, distance, and 
speed monitoring. Some of these features are dependent on option account data (e.g. weight).

### Achievement System

Achievements are milestones shared by all users. Submission of Activities into the database logs progress towards
Achievements. Users will be able to earn these Achievements, view earned Achievements, and view progress towards
unearned Achievements.

## Dependencies

So far, this project is dependent on the following projects:

1. [Google Maps SDK iOS](https://developers.google.com/maps/documentation/ios-sdk/?hl=en)
2. [iOS-KML-Framework](https://github.com/FLCLjp/iOS-KML-Framework)
