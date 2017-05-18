# Teaser
Teaser is a social trivia game. It is very similar to the popular app QuizUp, except the questions are more focused around brainteasers and math puzzles. Questions are posed once a day, and the user receives credit for answering correctly. The user can compete against himself or against groups of friends (up to 30 members).

This app is currently in development, and I am working on it as my Senior Project. It is on track to be completed by the end of May (as is required by my Senior Project deadline).

The app itself is written in Objective-C. For this app, I programmed my own backend. I am using a database I setup using mySQL, which I am communicating with using a REST API I built using PHP and SQL. I built a wrapper in Objective-C to communicate with my REST API, which can be found in the Teaser.h/Teaser.m files.

I have included the REST API in the Teaser REST API folder (although this normally wouldn't be in the project folder...I just included it for viewing purposes).
