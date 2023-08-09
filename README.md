# GoParty

This project is the GoParty application for iOS. This app will be used to create chat groups for users who wan't to create parties. You can add your friends on it, add them to a group, and the group will be automatically deleted when the party is over.

## Users

Users will first need to register using a Username, a unique Email, and a Password. After the user logged in, the main UI is shown, with the list of his online friends, as well as the list of the groups of the user.

## Groups

Every user can create a group. When creating a groups, some informations are asked:
- Name: The name for the group
- Location: The location where the users will have to go for the party
- Date: The date of the party (the group will be deleted one day after this date)
- Food & Drinks: A list of food and drinks that the users will need to brought
- Users: Based on the friends of the user that creates the group, the user wille be able to choose who to invite to the party.

When the group is created, a chat view is shown where all the users can talk. In the top right corner, there is an information button used to know every information about the group:
- Location ;
- Date ;
- Things to bring to the party ;
- Users ;

The group owner can at any time remove a user from the group, or even delete the group. Each user can as well leave the group at any time if they don't want to go to the party.
