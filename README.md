# GameOfDogs
Game of Dogs is a IOS application that is developed in Swift 3 and Xcodde v8.3.3.

Clean coding in any programming language is not just about naming the classes, variables, constants and functions right. It is important to design code so that each piece is easily identifiable, has a specific and obvious purpose, and fits together with other pieces in a logical fashion. In order to achieve this, the design pattern VIPER has been used in this project. VIPER also helps to improve the way I have tested the app. VIPER helps to divide an app's logocal structure into distinct layers of responsibility.

## File Structure
### View
    Contains the view controllers responsible for applications user interface.
### Interactor
    contains the business logic. 
### Presenter
    Contains view logic for preparing content for display (as received from the Interactor).
### Entity / Model
    Consists of 2 structs that model the data that are obtained from the apis.
### Wireframes
    Contains logic for Uni-directional navigation between view controllers.
### Helper 
    Contain miscellaneous files that help to generate random numbers to select question.


## Screen Shots
<img width="309" alt="screen shot 2017-08-27 at 6 09 49 pm" src="https://user-images.githubusercontent.com/10661833/29755855-2ed1719e-8b53-11e7-96f9-5fa6a051d257.png"> <img width="303" alt="screen shot 2017-08-27 at 6 02 26 pm" src="https://user-images.githubusercontent.com/10661833/29755857-30d55b86-8b53-11e7-8394-b9a592447a70.png">
<img width="310" alt="screen shot 2017-08-27 at 6 15 40 pm" src="https://user-images.githubusercontent.com/10661833/29755914-dc0bc10c-8b53-11e7-81fb-62153ab7bb91.png"> <img width="307" alt="screen shot 2017-08-27 at 6 12 40 pm" src="https://user-images.githubusercontent.com/10661833/29755895-9b0179fe-8b53-11e7-9513-a74403083394.png">
