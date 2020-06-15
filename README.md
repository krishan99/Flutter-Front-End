# Flutter Front End (Business App and User App)

## Overview (Read Me First!)
This is a guide to get you from zero to hero on our app. It will likely take multiple days to fully complete, but please do not try to take shortcuts. Otherwise you'll end up wasting many days like I did. Bad code can result in random bugs and likely days of misused time fixing dumb things. We're all pretty new at this, so best not to rush in.

## Installation (Mac OS)
[Flutter Guide For Additional Help](https://flutter.dev/docs/get-started/install/macos)

### Pre-Reqs
1. Xcode with Simulator (App Store)
2. [Android Studio](https://developer.android.com/studio#downloads)
3. Visual Studio Code with Dart and Flutter plugins

### Installing Flutter
1. Download and unzip flutter from [here](https://storage.googleapis.com/flutter_infra/releases/stable/macos/flutter_macos_1.17.3-stable.zip).
2. Create a folder in your home directory (usually "/Users/your_username/") called "Utils"
3. Move the unzipped flutter folder to this location.
4. add 'export PATH="$PATH:/Users/your_username/Utils/flutter/bin"' to the end of your .bash_profile.
5. Ensure flutter works by running 'flutter' in the terminal.
6. Run 'flutter doctor' in terminal to see whatever else needs to be setup for your particular computer.

#### Setup Web Support
<pre><code>$ flutter channel beta
$ flutter upgrade
$ flutter config --enable-web
</pre></code>

### Running the App
#### VSCode
1. Open in VSCode
2. Select "Run" tap from left side.
3. In the upper drop down, select "Business App".
4. Hit Play and select a simulator to run on.

#### Terminal
1. Open terminal and navigate to "bussiness_app" folder.
2. To get list of active devices
<pre><code>$ flutter devices
</pre></code>
3. To run a specific device, run
<pre><code>flutter run -d SELECTED_DEVICE_ID -t lib/mains/main.dart
</pre></code>


## Learning Dart
Flutter uses their own language called Dart. It's a weird cross between python and javascript.

### Syntax
This is a 1 hour video on the syntax, however if you're lazy like me just read the cheat sheet in the description.
https://www.youtube.com/watch?v=OLjyCy-7U2U&t=3878s

### Essential Knowledge
To have a good understanding of how the app works, make sure you understand the unique pieces of dart. Basically, just don't try to write code like it's python or c++ and really try to take advantage of Dart.

Main Things to Understand
* Mixins
* Futures and Streams
* Generics (same as c++)
* Factories
* Optionals

### Effective Dart
[Google's Guide on how to Dart.](https://dart.dev/guides/language/effective-dart/)
Read through it; it can save you a fair bit of time when coding.


### Warnings
Dart doesn't have any safety features, so program defensively! Basically, just make sure the data passed in is the data you expect (ex. nulls, dynamics, etc).

## Learning Flutter
### Essentials
I've watched upwards of 60 flutter tutorials (I wish I was kidding), and this is by far the best one to get started.
https://www.youtube.com/watch?v=MkFjtCov62g

#### Key Points to Understand
* [Stateful](https://www.youtube.com/watch?v=AqCMFXEmf3w&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=6) vs. [Stateless Widgets](https://www.youtube.com/watch?v=wE7khGHVkYY&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=5)
* [Keys](https://www.youtube.com/watch?v=kn0EOS-ZiIc&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=8)
* [Async/Await](https://www.youtube.com/watch?v=SmTCmDMi4BY&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=17)
* [Generator Functions](https://www.youtube.com/watch?v=TF-TBsgIErY&list=PLjxrf2q8roU2HdJQDjJzOeO6J3FoFLWr2&index=18)

Hopefully you'll have a good idea of how flutter works after watching these videos. It took me a while to figure everything out, and even now I'm not that good at it.

### State Management
#### Overview
When learning flutter, you'll undoubtedly hear the term "State Management". This basically refers to how data is passed around. There's a lot of argument of which is the best one to use (bloc, mobx, redux, etc).

I've done a fair bit of research on this and have come to the following conclusion. Most of these are overkill and seem to just add unnecessary complexity and boilerplate code. For our app, we use a package called "Provider" to pass data easily. If we eventually need a more complicated system, it's very easy to switch to "bloc" as they're very similar.

#### Learning Provider
There are 4 Parts totaling about an hour. Ideally watch them all - it'll save you so much time.
https://www.youtube.com/watch?v=j8P__wcq2YM&t=587s

## App Structure (Read Before Writing Code in the App)

### The Idea
A big part of the app is the use of *dependency injection*. The idea is that objects should have their dependancies/requirements passed in instead of being referenced from somewhere else. Essentially, any part of the code should be able to be tested individually. This prevents coupled code and makes testing and debugging very nice.

We use Provider, which makes this very easy.

### The Specifics
In our app, we use an object called "ModelData" which basically contains all of the necessary information for the app (ex. User Data, Queues, etc). By doing this, bug reports are simplified greatly as we can easily replicate the user's situation by just instantiating their instance of the "ModelData".


#### Folder Organization
The organization style is copied directly from [here](https://medium.com/flutter-community/flutter-code-organization-de3a4c219149)

##### The Mains
The foundation of any Flutter app, the main.dart file, should hold very little code and only serve as an overview to an app.
The MaterialApp itself should have no heavy code in it, instead pulling the Theme and the widget screens from other files.

We will have multiple mains in our project. Each corresponding to a different app.
* The **Business App** Itself
* **A Font Test App** (Fonts are weird in flutter and this lets you verify the font weights.)
* A **Testing App** (This is generally just to try out certain widgets or ideas before implementing them in the main app. May be an issue going forward with conflicts.)
* Eventually a **User App**

##### Sub Folders
**Theme Folder:** This just contains a style.dart with the app theme which I access in the main.dart file.

**Services Folder:** holds some web APIs and native interaction code
The components folder has custom widgets which are used in multiple different screens.

**Models Folder:** contains files each with a custom class of an object widely used throughout the app.

**Screens Folder** This holds many different folders, each of which corresponds to a different screen of the app. Each screen folder holds two things: a primary screen file which serves to organize each component, and a “components” folder which holds each component in its own separate file. (I got lazy and haven't done the last part yet).


## Adobe XD Layout
https://xd.adobe.com/view/8523fc7d-8922-4dc9-6ddb-60099099c19b-f312/
