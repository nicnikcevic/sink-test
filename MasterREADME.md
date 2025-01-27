NOTE: All three of Andrew Heller, Nic Nikcevic, and Frankie Severino worked on this project equally
Accordingly, we are all submitting this for our DALI Lab Application. Each individual has their own README detailing what specifically they did. See this MASTER README for General information about bugs, future features, and sources uses.

# SinkTest
SinkTest is a MVP of the Sink App, an IOS app to track and share games of Pong among Dartmouth students.
This Application was built by Francesco Severino '27, Andrew Heller '27, and Nic Nikcevic '27 in January of 2025

# Large Bugs
- The verb switching on the GameCardView should accomdate a "shrubbed" feature, right now it only calculates for "treed"
- some of the navigation links do not work: For example all displays of profiles should navigate to the users profile on click
- Functionality for liking and disliking games is built in, but there is no button on the GameCardView
- Users can currently input a number of cups when they add a game which is greater than the number of cups they started with
- Some icon sizes are hard coded in which makes the app uncompatible for screens smaller than the iphone 16

## Smaller Fixes/Cleaning
- GameRecap field still needed in Game struct

# Future Features

## Fundamental Functionality

- ELO + Algorithm implementation
    - every player will have an ELO score which will be computed by an algorithm that takes into account all games that player has played, when they played them, their respective ELO's of their opponents and teamates, and other factors such as intoxication and frequency
- A Ranked Leaderboard based on ELO
- A 7 minute timer in between starting a game and inputting the results, to make inputting fake games more difficult, assuming no game of pong takes less than 7 minutes

## UX convenience

- Recognize usernames of teamates and opponents are added to a game and suggesting them.
    - Updating the ELO of all registered users associated with a game, not just the creator
- Size limit for usernames
- Continue to clean up the add game screen

## Further Down the Road Additions
- GPT Generated game recaps/news section
- "Hall of Shame", displays all those who got treed/shrubbed for one week
                    

# Sources Used
- We relied moderately on ChatGPT and Claude AI for 
    - explanatory commenting
    - Debugging
    - Building out specifically prompted UI elements in SwiftUI
- KavSoft youtuber for template
    - We downloaded a "Social Media" template from Youtuber Kavsoft
    - We used this template to assist with 
        - saving and retrieving data from Firebase
        - File heirarchy
        - Rough UI outline
    - It's important to note that approx. 15% of the code remained unchanged from this template, We significantly overhauled new UI, File heirarchy, and underlying logic
    - The tutorial video and associated code referenced can be found here: https://www.youtube.com/watch?v=-pAQcPolruw



