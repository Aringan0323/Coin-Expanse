---
title: Usage
layout: default
---

# Application Usage

Our application is meant to be used by people not only interested in buying and selling cryptocurrency, but in setting up and managing automatic trading strategies.

## Elevator Pitch

Cryptocurrency is up and coming in terms of finance and creating passive income. Our application allows you to not only manage your BinanceUS (a popular site for storing cryptocurrency information and personal gains) account to make orders, but also view popular cryptocurrencies and metrics and create custom, automated strategies in an immersive GUI that can be managed and executed at any point in time, something no other popular platform offers!

## How to Use and Navigate our Site

We have the following pages on display on our site:

1. A home page, with a brief introduction and colorful navigation, as well as a series of news cards that ger updated every 24 hours.

2. A page to view all supported cryptocurrencies. Each cryptocurrency has its own link to a subpage, which shows all indicator metric data, which can be used as a reference in creating automate strategies

3. A set of pages related to your automated strategies. The Creation page allows you to play with an intuitve GUI with draggable, resizable, and droppable cards to create complex boolean expressions that get executed on a 15 minute period. There is also a library, which allows you to view and manage your strategies. Each entry has time created and updated, a brief description of what gets executed if the strategy is successful, a description of the algorithm created, and 3 buttons for editing the strategy, deleting the strategy, and manually executing the strategys

    1. On the strategies creation page, cards can be added by clicking an `Add to Creation Space` button, which will add it to the creation space to be dragged around and resized. Operation cards, the `AND`, `OR`, and `NOT`, are the only `droppable` cards, meaning other things can be dragged into them, including indicator cards and other operation cards. The indicator cards, however, are not droppable, and can only be dragged into droppable cards. Once a card is dropped into another, it becomes nested, and moves as the outer card is moved. The inner card can be moved out, at which point both move and act separately. Any configuration is possible, and all get converted into a convenient hash that gets stored in our database, which is interpreted and executed every 15 minutes.

4. An about page, which has a brief description of the website

5. An order page, which not only has a form that can be filled out to buy or sell cryptocurrency, but a list of order history, which only contains orders that have gone through our website. 
