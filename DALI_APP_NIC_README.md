# Description
This project is the MVP of an IOS social media app created for Dartmouth students to share games of pong they have played. This version supports user registration and authentification, creating and posting new games which hold information about the participants, time, game type, and number of cups left on the table, a feed which recaps all the games played by users on the app, as well as a profile which shows only the games a user was involved in. This app was created in swift and swiftUI.

# Deployed application link (if possible)
App not yet deployed
                                                                
# Video Demo
- See MVP Demo.mov inside of SinkTest
                                                                
# Setup instructions for running locally
1) Download raw code from Github
2) Open Project in XCode
3) Build Project in XCode
    a) ensure MacOS is up to Date

# Learning Journey

## Inspiration
The inspiration for this project came from the popularity of Pong at Dartmouth, and for the friendly competition it breeds. For many people at Dartmouth, pong is a large part of social life, it is a game to play with friends, romantic interests, or complete strangers. It many ways the game brings people together because it is very simple to learn but hard to master, it also requires at least four people to play, and is distracting enough to keep interest but still allows for people to talk while they play. Co-creators Frankie Severino, Andrew Heller, and I realized that many people are concerned with how good they are at pong relative to their friends and are constantly trading anecdotes about games and who beat who, but there is no actual way to tell how good someone is without seeing their record. The rough original idea was an application to track games and then show a public leaderboard so students could empirically see who the best pong player in the school is. The MVP we have developed is close to that, with a global feed instead of a leaderboard.
                        
## Impact
We recognize that this app isn't saving the world by any means. And we also recognize that it gamifies and makes public drinking culture which is an issue at Dartmouth. But we also think that Pong is a unique and valubale tradition that brings people together and encourages competition and friendship, and that of the harmful habits of students at this college, it is one of the most benign. We hope that this app connects Dartmouth students through this shared game, and also breeds a fun competition between students.
                        
## New Tech
This project required me to work  explicitly with tools I've never used before, including XCode, SwiftUI, Swift, and the Firebase API. I learned everything I needed to know about all of these tools on the internet and from tutorials published by Apple. The experience was challenging and frustrating because I felt helpless at times to figure things out on my own, but it was rewarding in the end and challenged me to stretch my understanding of programming.
                        
### Why these tools?
We chose to use the Apple developer tools because we knew we wanted to create an IOS app. The nature of our platform is that it needs to be an app downloaded onto users phones so that they can add games with the most ease, or else they just won't.
                        
                                                                
## Challenges
Two major challenges I faced were in linking the back end to the UI and indepndently collaborating on different elements with sufficient communication. We had difficulty linking the backend because we began by mocking up the entire app in SwiftUI, without an understanding of how the logic would work. About half way through that we realized that we needed to somehow tie in the logic of storing the Game and Player structs somewhere, and writing them to the database at some point. We looked a multiple different resources which gave us contrasting information about how to do so. Originally we though we needed to read and write JSON files, but finally found a source that helped us setup a live time database. After that we had to back track to link that logic up with the UI elements we had already developed, but it was a worthwhile step. Ultimately from that challenge I learned that, especially when working in a new framework, it is hard to know exactly how something will work until you begin doing it, and so iteration is key. Similarly, we ran into issues when working on different elements without proper communication because certain Views in our project would assume different variables were contained in the game or user struct, or that another file was responsible for certain functionality. This created some issues with functionality or even UI elements being either implemented in two seperate places, or not implemented at all. In those cases we had to rehaul as a team. In these scenarios, we found it very helpful to practice Extreme Programming, and all work off one computer, with one person actually typing, and the other two watching for bugs and consistency. 

## What I did?
Roles were split pretty evenly between Andrew, Frankie, and I. With each of us doing different things each time we met. That being said, my major contributions were in implementing the Game and Players structs, psuedocoding the logic of creating a new game, imlementing the UI for CreateNewGame with Frankie, and debugging issues as they came. I also played a large hand in scheduling meeting times each weeks, organizing and delegating tasks, and defining which features we wanted to implement for the MVP.

