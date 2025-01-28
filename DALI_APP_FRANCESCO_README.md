# Description
SinkTest is an IOS application to track Pong games played by everyone anywhere: an MVP of the future "Sink" IOS application. It features a login feature to accomodate distinct users (Users consist of an email, photo, about me, and previous games), a search user feature, and a profile page to show these features. When inspecting a user, every game they have been involved in will show up. Storing and creating user data is standard: duplicate data is prohibited (except passwords), and users can retrieve their password through "Forgot Password."
The app tracks the winner of a game, date and time, as well as the points (cups) won by. The app will reflect changes in the score based on whether the losers nearly won, were crushed, or treed/shrubbed. 

# Deployed application link
In progress...
                                                                
# Video Demo
- See MVP Demo.mov inside of SinkTest
                                                                
# Setup instructions for running locally
1) Download raw code from Github
2) Open Project in XCode
3) Build Project in XCode
    a) ensure MacOS is up to Date

It may be necessary to copy the files onto an independent project to get the bundleIDs and certification correct. Releasing a deployed application will improve this process.

# Learning Journey

## Inspiration
I did not come up with this idea, but I was immediately thrilled when Nic and Andrew told me about it. I was also extremely appreciative that they wanted me to help with their project, as my programming experience pales in comparison to theirs. When I was brought on board, I realized how perfect this app idea is: 1. Pong is the most popular drinking game at Dartmouth. 2. Enough people are competitive about Pong, or are interested in how they rank compared to their peers. 3. A tangible view of Pong statistics is valuable to many people and is a previously untapped idea. At first, we were excited to implement a leaderboard, ranking system, and ELO (adapted from Chess). However, we quickly realized these features would have to be implemented at a later date. My work on the UI was inspired, interestingly, from a feature not present in Pong: red solo cups. The main color of the app is a deep crimson color (185,15,20), reflected in the app icon, top banner, and add game button. I wanted to have the app feature this color because we hope to push this app to include other games, and perhaps, reach other schools. Restricting Sink to Dartmouth would be a waste and feels gimmicky. Thus, the bold red color invokes imagery of hanging out with friends at a party without implying that this fun needs to stay at Dartmouth. 
                        
## Impact
Ideally, this app will take Dartmouth by storm much like Fizz or even a non-app like MarriagePact. We have very deliberate plans for marketing the app to try to spread it through the school, using a more word-of-mouth approach. But in terms of this app's impact on the world, Nic puts it well: "this app isn't saving the world by any means." However, we do want to make an impact on the culture at Dartmouth and sincerely hope that this project will not be another silly startup to be forgotten when the flyers get taken down.
                        
## New Tech
Unlike my Co-creators Nic and Andrew, I have worked with Swift before in some other more amateur projects. However, implementing FireStore and fully exploring SwiftUI's capabilities was completely new to me, proving to be challenging and rewarding. I have also never used GitHub or interacted with Git before, and Nic helped Andrew and I setup GitHub and use it for the first time. 
                        
### Tools Used & Why
For an IOS app, Swift/SwiftUI is required. This is the only programming language we used for this project, and building it from the ground up called for a lot of learning. We used ChatGPT and ClaudeAI to draft out code for UI elements, before tuning, tweaking, or rewriting it for our own purposes. We frequently visited StackOverflow for help, and the Apple SwiftUI documentation is extensive and extremely helpful. For the UI elements and icons, I used Adobe Illustrator to make vector objects.                         
                                                                
## Challenges 
Firstly, connecting the application to the database was especially difficult for us. We scrapped the project a few times, resetting or recreating FireStore to get it right. Eventually, we looked up a tutorial on creating a social media app and used insights from that program to figure out how to create a login system. Only then did the project begin to take form. Another challenge was setting up the UI. Getting the icons to fit within the other elements, creating the element stacks, and reflecting database changes in the UI was an incredible challenge that seemed impossible at first. At one point, the bottom icons were covering the entire screen, and no amount of resizing methods would fix the issue. Eventually, this was solved by switching to vector objects and sizing the canvas down, but there are still some issues with CreateGameView when displaying the app on smaller devices. I know we aren't inventing any wheels with this project, but acquiring the knowledge to get a baseline level of functionality was a serious obstacle.   

## My Contribution
My contribution involves most of fine-tuning the UI, creating all of the icons, and the general theme of the app. Unfortunately, a lot of my work has been scrapped for the MVP, including some work for the leaderboard and algorithm, but that is simply part of the design process. I did not organize the UI for displaying the recent games: that was Andrew. However, getting the bottom navbar to work with the top banner across every tab was my (tedious) effort. CreateGameView was also my work (except Nic prepared it for launch and added "I won"/"I lost" buttons), including the pictures and layout. The algorithm is adapted from Chess ELO and is not included in the MVP, but will be coming soon. 

## Acknowledgements to my Teammates
Nic did most of the organizational work, and GitHub, including the Master ReadME for the project. He got us up to speed on Github, including teaching us Git terminology.
He also made sure our code was completely commented and ready for submission.

Andrew did a lot of debugging and smoothing. A lot.
Andrew suggested a row of cups of alternating orientation at the top, I only drew it out in Illustrator.



