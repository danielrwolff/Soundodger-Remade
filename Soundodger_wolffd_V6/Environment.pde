// Daniel Wolff
// 01/05/2015
// Culminating Project: Soundodger (remade by Daniel Wolff)

//Defining the environment class:
//  - Manages all objects.
//  - Passes important information to the player, gameplayControllers, and UI
class Environment {

    // Creates a byte that manages what gameState to update and display.
    byte gameStateIndex = 0;

    // Creates an array of strings that outlines what gameStateIndex is what.
    String[] allGameStates = {  
        "main", //0
        "options", //1
        "credits", //2
        "levelSel", //3
        "pause", //4
        "scoreScreen", //5
        "tutorial", //6
        "level1", //7
        "level2", //8
        "level3" //9
    };

    // Creates a byte that stores the number of different gameStates.
    byte numGameStates = byte(allGameStates.length);

    // Creates a byte that stores the number of levels.
    byte numLevels = 4;

    // Creates a boolean variable for the paused state and gameOver state.
    boolean paused = false;
    boolean gameOver = false;


    //Initialzing game objects
    // - Creates object array's for backgrounds, userInterfaces, and gameplayControllers.
    // - Creates a player object.
    Background[] backgrounds = new Background[numGameStates];
    UI[] userInterfaces = new UI[numGameStates];
    Gameplay[] gameplayControllers = new Gameplay[numLevels];
    Player player = new Player(0, 0, 25);

    //Environment constructor:
    // - Builds environment.
    // - Instantiates all of the backgrounds, userInterfaces, and gameplayControllers. 
    Environment() {
        // Instantiates each Background_Anim with a specific BG and FG colour.
        // Instantiates the pause and scoreScreen menu with Background_NoAnim.
        backgrounds[0] = new Background_Anim(color(255), color(255, 130, 0));
        backgrounds[1] = new Background_Anim(color(255), color(20, 180, 255));
        backgrounds[2] = new Background_Anim(color(255), color(255, 40, 40));
        backgrounds[3] = new Background_Anim(color(255), color(255, 130, 0));
        backgrounds[4] = new Background_NoAnim();
        backgrounds[5] = new Background_NoAnim();
        backgrounds[6] = new Background_Anim(color(255), color(255, 130, 0));
        backgrounds[7] = new Background_Anim(color(255), color(0, 0, 255));
        backgrounds[8] = new Background_Anim(color(255), color(255, 0, 0));
        backgrounds[9] = new Background_Anim(color(0), color(255));

        // Instantiates a userInterface for every gameState except for the scoreScreen gameState.
        // The scoreScreen gameState is instantiated with the UI_ScoreScreen class.
        // Each object gets passed its corresponding gameStateIndex. 
        for (int i = 0; i < numGameStates; i++) {
            if (i != 5) {
                userInterfaces[i] = new UI(i);
            } 
            else {
                userInterfaces[i] = new UI_ScoreScreen(i);
            }
        }

        // Instantiates Gameplay_Tutorial for the tutorial gameState, and Gameplay for the other levels. 
        // Each object gets passed its corresponding gameStateIndex, the number of game objects, the radii of the game objects,
        //    and the colour for each type of enemy.
        gameplayControllers[0] = new Gameplay_Tutorial((numGameStates - numLevels), byte(4), int((height/1.1)/2), 
        color(0, 150, 255), color(100, 240, 255), color(235, 100, 255));
        gameplayControllers[1] = new Gameplay((numGameStates - numLevels + 1), byte(4), int((height/1.1)/2), 
        color(125, 125, 255), color(0, 185, 255), color(0, 255, 200));
        gameplayControllers[2] = new Gameplay((numGameStates - numLevels + 2), byte(4), int((height/1.1)/2), 
        color(255, 125, 125), color(255, 145, 180), color(255, 150, 0));
        gameplayControllers[3] = new Gameplay((numGameStates - numLevels + 3), byte(10), int((height/1.1)/2), 
        color(0, 150, 255), color(100, 240, 255), color(235, 100, 255));
    }

    //Update:
    //  - Updates the objects in the environment based on the gameStateIndex, and the paused and gameOver states.
    void update() {
        // if the game is paused, update the paused screen background and userInterface.
        if (paused) {
            backgrounds[4].update();
            userInterfaces[4].update();
        } 
        // if the game is over, update the scoreScreen background and userInterface.
        else if (gameOver) {
            backgrounds[5].update();
            userInterfaces[5].update();
        } 
        // if the game is not paused and the game is not over, update the background and userInterface based on the current gameStateIndex.
        else {
            backgrounds[gameStateIndex].update();
            userInterfaces[gameStateIndex].update();

            // if the gameStateIndex is greater than or equal to the number of gameStates minus the number of levels (in other words, if the user is playing a level), continue.
            if (gameStateIndex >= (numGameStates-numLevels)) {
                // Update the background of the score screen. This eliminates a flash between the current screen and the scoreScreen.
                backgrounds[5].update();
                // Update the player.
                player.update();
                // Update the corresponding gameplayController.
                gameplayControllers[gameStateIndex - (numGameStates-numLevels)].update(player.x, player.y, player.size);
            }
        }
    }

    //Display:
    //  - Draws the objects in the environment based on the gameStateIndex, and the paused and gameOver states.
    void draw() {
        // if the game is paused, draw the paused screen background and userInterface.
        if (paused) {
            backgrounds[4].draw();
            userInterfaces[4].draw(getCurrentBG(), getCurrentFG());
        } 
        // if the game is over, draw the scoreScreen background and userInterface.
        else if (gameOver) {
            backgrounds[5].draw();
            userInterfaces[5].draw(getCurrentBG(), getCurrentFG());
        } 
        // if the game is not paused and the game is not over, draw the background and userInterface based on the current gameStateIndex.
        else {
            backgrounds[gameStateIndex].draw();
            userInterfaces[gameStateIndex].draw(getCurrentBG(), getCurrentFG());

            // if the gameStateIndex is greater than or equal to the number of gameStates minus the number of levels (in other words, if the user is playing a level), continue.
            if (gameStateIndex >= (numGameStates-numLevels)) {
                // Draw the player and the corresponding gameplayController.
                player.draw(getCurrentFG());
                gameplayControllers[gameStateIndex - (numGameStates-numLevels)].draw(getCurrentFG(), getCurrentBG());
            }
        }
    }

    // getCurrentBG:
    // - Calls the getBG method in the background object corresponding to the gameStateIndex.
    int getCurrentBG() {
        return backgrounds[gameStateIndex].getBG();
    }
    // getCurrentFG:
    // - Calls the getFG method in the background object corresponding to the gameStateIndex.
    int getCurrentFG() {
        return backgrounds[gameStateIndex].getFG();
    }

    // getUIObject :
    // - Receives either an index, or both an index and a gameStateIndex.
    // - Returns an array of the data of the UI Object requested.
    int[] getUIObject(int _index) {
        return userInterfaces[gameStateIndex].uiData[_index];
    }
    int[] getUIObject(int _gameStateIndex, int _index) {
        return userInterfaces[_gameStateIndex].uiData[_index];
    }

    // enemyUpdate: 
    // - Increases the enemiesNotHit counter by one.
    void enemyUpdate() {
        gameplayControllers[gameStateIndex - (numGameStates-numLevels)].enemiesNotHit++;
    }

    // doMouseClicked:
    // - Receives the mouse coordinates.
    // - Sends the coordinates to the correct userInterface based on the paused state, the gameOver state, and the gameStateIndex.
    void doMouseClicked(int x, int y) {
        if (paused) {
            userInterfaces[4].checkClick(x, y);
        } 
        else if (gameOver) {
            userInterfaces[5].checkClick(x, y);
        } 
        else {
            userInterfaces[gameStateIndex].checkClick(x, y);
        }
    }

    // changeGameState:
    // - Receives the desires gameStateIndex.
    // - Calls the fadeIn methods in the corresponding background and userInterface.
    void changeGameState(byte _gameStateIndex) {
        gameStateIndex = _gameStateIndex;
        backgrounds[gameStateIndex].fadeIn();
        userInterfaces[gameStateIndex].fadeIn();
    }

    // pauseGame:
    // - Receives a boolean doPause.
    // - Decides the state of the paused boolean based on the gameStateIndex, doPause, and gameOver states.
    void pauseGame(boolean doPause) {
        // if the gameStateIndex is greater than or equal to the number of game states minus the number of levels (if the user is playing a level,
        //      and doPause is true, and gameOver is false, set the paused variable to true.
        if (gameStateIndex >= (numGameStates-numLevels) && doPause && !gameOver) { 
            paused = true;
        } 
        // else, if doPause is false, set paused to false.
        else if (!doPause) {
            paused = false;
        }
    }

    // showScore:
    // - Receives a boolean doScores.
    // - Decides the state of the gameOver boolean based on the doScores boolean.  
    void showScore(boolean doScores) {
        // if doScores is true, gameOver is true.
        if (doScores) {
            gameOver = true;
        } 
        // else, reset the game and set gameOver to false.
        else {
            reset();
            gameOver = false;
        }
    }

    // reset:
    // - Loops through the gameplayControlls and calls the reset method in each.
    void reset() {
        for (int i = 0; i < numLevels; i++) {
            gameplayControllers[i].reset();
        }
    }
}

