# Description
You have been sent back to your Freshman year at Dartmouth. All your friends are talking about Pong, the game created here, spread across the nation, but played differently here than anywhere else. Despite all this talk, you're unable to play as Frat Ban is still in effect. As Winter term hits and the frat ban is over, your friends start playing while going out and bragging about how good they are. As you play more, you start to wish there was a better way of ranking people and seeing who's actually the best at Pong. Well, that's where Sink comes in. Sink allows you to track your pong games,  see a leaderboard (coming soon), and see the games other people are playing. Currently, a user is able to create an account; log in; add games of pong with their teammate, opponents, and how much they won or lost by; and you can see your own and search for other people's profiles where you can see the games of pong they have recently played. The features we are planning on immediately implementing are a leaderboard with an elo system to show how good different people are and general summary statistics of how many games people have played, won, lost, etc. In the future, we are going implement ways of preventing people from putting in fake games through a timer between the game start and when you can enter who won, GPS checking to ensure you are in a Greek space, and potentially requiring photo proof that you actually played the game. The games also show up on the profiles of people you play with so the other users would also be able to confirm or deny the results.

# Impact
Honestly, this will have very little impact, especially for any meaningful change. The hope would be people enjoy tracking their games, seeing what games others are playing, and use it as a means to see how good different people are. I've heard the idea of some sort of Pong tracking system talked about from many different people in many different circumstances so we thought it would be fun to actually try to make an app to do this. Eventually, the app could be used to run pong tournaments like Masters and Senior Masters to make that easier.

# Deployed Application Link
We do not have anything deployed yet.

# Video Demo of Application
sink-test/SinkTest/MVP Demo.mov
This file contains a 2~ minute video showing hwo the app work

# Setup Instructions
Ensure you have an updated MacOS so that you have the most recent Swift version
Download entire repository, run the SinkTest.xcodeproj file
Entire coding environment should show up and by running the code at the top a simulator of an iPhone will build and install the app onto.

# Learning Journey
## Inspiration
We all had heard this idea from many people on many occasions and decided to try to create it so we could track our own Pong games. Most people we have pitched the ideas to said it's really cool and they would use it which gave us further encouragement to complete it.

## New Technology Learned, and Why This Technology
This was our first time using Swift, SwiftUI, Xcode, and FireBase. From our research, these were the best free tools to easily create an iOS app. Frankie has a little experience with Swift previously, but we essentially went in with 0 experience. We used the Apple SwiftUI tutorial (https://developer.apple.com/tutorials/swiftui) to get a general understanding of how to use Swift and its formatting. Another tutorial (https://kavsoft.dev/swiftui_4.0_social_media_dec) was used to get an understanding of how to interface with Firebase, user log-in and register, and the general format of a social media app. The UI of our app is almost entirely different and the Firebase calls had to be changed to handle games instead of social media posts. The use of this starter is further documented in the Master README. The Search tool was unchanged along with the ability to delete an account. The default icon is also from the tutorial. Also how the app handles things loading is unchanged. How games are liked is also largely unchanged.

## Challenges
The biggest challenge was going in with almost no knowledge. Because we wanted to get this largely done for this application, we did not have the time to create a smaller app to get an understanding of how everything worked and then build from there. We did a little preliminary research and then just did our best to create everything through reading documentation, asking LLMs how different functions worked, and relying on each other to find our mistakes. Personally, my knowledge from my previous failed project helped me learn how important communication is and so the entire project I made sure we were all very clearly on the same page about what we were doing. This was not always the case so through open dialogue with good friends we were able to come to conclusions we all agreed with which, I think, has resulted in a good-looking app with almost enough functionality to try to start testing. 

## What I worked on
I created the GameCardView. This is how each individual game is shown. I also changed the profile page to look a lot cleaner and work better with our games. I implemented the pseudocode for how to interact with the server for when we add a game. I made sure fetching games with the new information would also work. I also implemented a UI Frankie created for the UI so it would work with how the tutorial worked.
