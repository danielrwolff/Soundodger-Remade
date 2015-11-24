// Daniel Wolff
// 01/05/2015
// Culminating Project: Soundodger (remade by Daniel Wolff)

// UI class:
// - Creates a friendly user interface for the user.
// - Manages user interactions and gameState switches.
class UI {

    // Creates an array of user interface objects.
    Menu_Object[] ui_Objects;

    // Creates an integer variable to hold the number of user interface objects, transitionTime, and the fadeAlpha.
    int numObjects;
    int transitionTime = 0;
    int fadeAlpha = 0;

    // Creates a boolean variable that reports whether or not there is a transition beteen menus.
    boolean transition = false;

    // Creates a 2-dimensional integer array that holds all of the shape data for the gameState.
    int[][] uiData;
    // Creates a String array that holds all of the text data for the gameState.
    String[] uiText;

    // UI constructor:
    // - Receives a gameStateIndex.
    // - Finds its corresponging uiData and uiText.
    // - Instantiates its ui_Objects.
    UI(int _gameStateIndex) {

        // Uses the gameStateIndex to get the uiData and uiText.
        uiData = menuData[_gameStateIndex];
        uiText = menuText[_gameStateIndex];

        // Finds the number of objects by finding the length of the uiData array.
        numObjects = uiData.length;

        //Create the menu objects.
        ui_Objects = new Menu_Object[numObjects];

        //Loops through the menu objects and instantiates them. Passes through its corresponding uiData and uiText.
        for (int i = 0; i < numObjects; i++) {
            ui_Objects[i] = new Menu_Object(uiData[i], uiText[i]);
        }
    }

    // Update:
    // - Updates the menu objects.
    // - Checks for, updates, and manages transitions.
    // - Manages its fadeAlpha.
    void update() {

        // Loops through each menu object and updates it.
        for (Menu_Object i : ui_Objects) {
            i.update();
        }

        // if a transition is happening, continue.
        if (transition) {

            // Increase the transitionTime by 1.
            transitionTime++;

            // if the transitionTime is greater than or equal to 50, continue.
            if (transitionTime >= 50) {
                // End the transition.
                transition = false;
                // Loop through each menu object to see which one was clicked.
                for (Menu_Object i : ui_Objects) {
                    // When the one that was clicked is found, unpause the game and exit the showScore gameState, 
                    //       set the objects isClicked boolean to false, and set its inflation integer to 0. Also, 
                    //       set the transitionTime to 0, and call the environment's changeGameState method to change the gamestate.
                    if (i.isClicked) {
                        environment.pauseGame(false);
                        environment.showScore(false);
                        i.isClicked = false;
                        i.inflation = 0;
                        transitionTime = 0;
                        environment.changeGameState(byte(i.shapeData[5]));
                    }
                }
            }
        }

        // Always increase the fadeAlpha by a value of 5, unless fadeAlpha is greater than or equal to 255 (max).
        if (fadeAlpha < 255) {
            fadeAlpha+=5;
        }
    }

    // Draw:
    // - Receives the current BG and FG.
    // - Draws each menu object.
    void draw(int _currentBG, int _currentFG) {
        for (Menu_Object i : ui_Objects) {
            // Passes the current FG and BG, and the fadeAlpha.
            i.draw(_currentBG, _currentFG, transition, fadeAlpha);
        }
    }

    // checkClick:
    // - Receives the x and y coordinates of the mouse click.
    // - Checks each menu object to see if it was clicked.
    void checkClick(int _x, int _y) {
        // Loops through each menu object.
        for (Menu_Object i : ui_Objects) {
            // if the click was on the object, continue.
            if (i.checkMouse(_x, _y)) {
                // if the designated gameStateIndex was above or equal to zero, continue.
                if (i.shapeData[5] >= 0) {
                    // if the designated gameStateIndex was zero, reset the game.
                    if (i.shapeData[5] == 0) {
                        environment.reset();
                    }
                    // Set the objects isClicked boolean to true, and set the transition boolean to true.
                    i.isClicked = true;
                    transition = true;
                    break;
                } 
                // else, if the designated gameStateIndex was -3, pass false through the environments pauseGame method to unpause the game.
                else if (i.shapeData[5] == -3) {
                    environment.pauseGame(false);
                } 
                // else, if the designated gameStateIndex was -4, pass false through the environment showScore method to exit the showScore screen. 
                else if (i.shapeData[5] == -4) {
                    environment.showScore(false);
                }
            }
        }
    }

    // fadeIn: 
    // - Resets the fadeAlpha variable.
    void fadeIn() {
        // When reset, the update() method will then increase this every frame, giving a fade effect.
        fadeAlpha = 0;
    }
}

// UI_ScoreScreen class:
// - Extends UI.
// - Manages the user interface for the scoreScreen gameState.
class UI_ScoreScreen extends UI {

    // UI_ScoreScreen constructor:
    // - Receives a gameStateIndex and passes it to its super.
    UI_ScoreScreen(int _gameStateIndex) {
        super(_gameStateIndex);
    }

    // Draw:
    // - Receives the current BG anf FG and passes it to its super.
    // - Draws the scoreScreen text.
    void draw(int _currentBG, int _currentFG) {
        super.draw(_currentBG, _currentFG);
        // if no transition is happening, fill text with FG colour, and draw "Your score:", the percentage ratio of enemiesSpawned to enemiesNotHit, and the highscore.
        if (!transition) {
            fill(_currentFG);
            textSize(environment.getUIObject(5, 0)[6]/2);
            text("Your score:", environment.getUIObject(0)[0], environment.getUIObject(0)[1] - 45);
            textSize(environment.getUIObject(5, 0)[6]);
            text(int((float(environment.gameplayControllers[environment.gameStateIndex-(environment.numGameStates-environment.numLevels)].enemiesNotHit)/float(environment.gameplayControllers[environment.gameStateIndex-(environment.numGameStates-environment.numLevels)].enemiesSpawned)) * 100) + "%", 
            environment.getUIObject(0)[0], environment.getUIObject(0)[1] + 55);
            textSize(environment.getUIObject(5, 0)[6]/4);
            text("Best: " + environment.gameplayControllers[environment.gameStateIndex-(environment.numGameStates-environment.numLevels)].highscore + "%", 
            environment.getUIObject(0)[0], environment.getUIObject(0)[1] + 100);
        }
    }
}

// Menu_Object class:
// - Manages a single user interface object.
class Menu_Object {

    // Creates an integer array that will store the shapeData of the menu object.
    int[] shapeData;
    // Creates a String that will hold the text for the menu object.
    String shapeText;
    // Creates an integer that keeps track of the inflation of the menu object.
    int inflation = 0;
    // Creates a boolean that states whether or not the menu object has been clicked.
    boolean isClicked = false;

    // Menu_Object constructor:
    // - Receives its shapeData and shapeText.
    Menu_Object(int[] _shapeData, String _shapeText) {
        shapeData = _shapeData;
        shapeText = _shapeText;
    }

    // Update:
    // - Controls the inflation of the menu object.
    void update() {
        // if it hasn't been clicked, continue.
        if (!isClicked) {
            // if the mouse is over the object, and the inflation is less than its inflationLimit, add 1 to the inflation.
            if (checkMouse(mouseX, mouseY) && inflation < shapeData[4]) {
                inflation+=1;
            } 
            // else, if the mouse is not over the object and the inflation is great than zero, subtract 1 from the inflation.
            else if (!checkMouse(mouseX, mouseY) && inflation > 0) {
                inflation-=1;
            }
        } 
        // if it has been clicked, increase the inflation by 50.
        else {
            inflation += 50;
        }
    }

    // Draw:
    // - Receives the current BG and FG, as well as the boolean transition, and the integer fadeAlpha.
    // - Draws the menu object shape and text to the screen.
    void draw(int _currentBG, int _currentFG, boolean _transition, int _fadeAlpha) {
        fill(_currentBG, _fadeAlpha);
        stroke(_currentFG, _fadeAlpha);
        strokeWeight(3);
        // if there is no transition, or there is a transition and this object was the one clicked, draw the circle.
        if (!_transition || (_transition && isClicked)) {
            ellipse(shapeData[0], shapeData[1], shapeData[2] + inflation, shapeData[3] + inflation);
        }
        // if there is no transition, draw the text.
        if (!_transition) {
            fill(_currentFG, _fadeAlpha);
            textSize(shapeData[6] + float(inflation/2));
            text(shapeText, shapeData[0], shapeData[1]+15);
        }
    }

    // checkMouse:
    // - Receives the x and y position of the mouse.
    // - Returns true if the mouse is over the menu object.
    boolean checkMouse(int _x, int _y) {
        // if the distance between the mouse coordinates and the center of the menu object is less than or equal to the radius of the menu object, return true.
        if (sqrt(sq(_x - shapeData[0])+sq(_y - shapeData[1])) <= shapeData[2]/2) {
            return true;
        }
        // else, return false.
        return false;
    }
}

