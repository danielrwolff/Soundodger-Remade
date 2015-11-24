// Daniel Wolff
// 01/05/2015
// Culminating Project: Soundodger (remade by Daniel Wolff)

// Gameplay class:
// - Manages game objects and enemies.
// - Manages collisions between enemies and players, and enemies and boundaries.
// - Manages game data.
class Gameplay {

    // Creates an array of enemy objects.
    Enemy[] enemies = new Enemy[1000];
    // Creates an double array of enemy data
    int[][] enemyBuffer = new int[1000][5];  //[entranceTime,gameObject,enemyType,angle,speed]

        // Creates a byte variable to hold the number of game objects, the stage of gameplay, and the highscore. 
    byte numGameObjects;
    byte stage = 0;
    byte highscore = 0;

    // Creates integer variables to hold the number of enemies spawned, the number of enemies not hit, and the transitionTime.
    int enemiesSpawned = 0;
    int enemiesNotHit = 0;
    int transitionTime = 0;

    // Creates float variables to hold the game rotation angle and the rotation speed.
    float gameRot = 0;
    float rotSpeed = 0;

    // Creates color variables to store the different enemy colours.
    color triangleEnemyColour;
    color squareEnemyColour;
    color circleEnemyColour;

    // Creates an array of gameplay objects.
    Gameplay_Object[] gameObjects;

    // Gameplay constructor:
    // - Receives the gameStateIndex, number of gameObjects, the gameObject radii, and the enemy colours.
    // - Instantiates the correct number of gameObjects.
    Gameplay(int _gameStateIndex, byte _numGameObjects, int _gameObjectRadii, color _triEnemCol, color _squEnemCol, color _cirEnemCol) {
        numGameObjects = _numGameObjects;

        triangleEnemyColour = _triEnemCol;
        squareEnemyColour = _squEnemCol;
        circleEnemyColour = _cirEnemCol;

        // Creating the received number of gameObjects.
        gameObjects = new Gameplay_Object[numGameObjects];

        // Instantiating each individual object. Passes through the size of the object, the angle offset of the gameObject, and its radius.
        for (int i = 0; i < numGameObjects; i++) {
            gameObjects[i] = new Gameplay_Object(byte(height/15), int((360/numGameObjects)*i), _gameObjectRadii);
        }
    }

    // Update:
    // - Receives the playerX, playerY, playerSize.
    // - Updates the transitionTime, stage, and sets the pattern of enemies.
    // - Manages and replaces dead enemies.
    // - Updates gameObject rotation.
    void update(int _playerX, int _playerY, int _playerSize) {

        // if the transitionTime is zero, check to see if the stage needs to be updated.
        if (transitionTime == 0) {
            // if the stage is not greater than the number of stages, receive the next pattern and rotation speed from the gameData.
            if (stage < gameData[environment.gameStateIndex-(environment.numGameStates-environment.numLevels)][0].length) {
                setPattern(byte(gameData[environment.gameStateIndex-(environment.numGameStates-environment.numLevels)][0][stage]));
                rotSpeed = gameData[environment.gameStateIndex-(environment.numGameStates-environment.numLevels)][1][stage];
                // Increases the stage by 1 after the pattern and rotation speed is selected.
                stage++;
            } 
            // if the stage is greater, end the game by calling the environments showScore method.
            else {
                environment.showScore(true);
                checkHighscore();
            }
        } 
        // if the transitionTime is not zero, subtract 1 from the transitionTime.
        else {
            transitionTime--;
        }

        // Loops through the enemyBuffer to find an enemy that needs to be created.
        for (int i = 0; i < enemyBuffer.length; i++) {
            // if the enemies spawn time is equal to the transitionTime, and the enemy type is 0 (non-existant), continue.
            if (enemyBuffer[i][0] == transitionTime && enemyBuffer[i][2] != 0) {
                // Loops through the enemies array.
                for (int j = 0; j < enemies.length; j++) {
                    // if the enemies slot is empty, or the enemy is dead, replace it.
                    if (enemies[j] == null || enemies[j].dead == true) {  
                        // if the enemy type is 1, then create a triangular enemy with the gameObject specified in the enemy buffer, as well
                        //         as its default size, speed, angle and colour.
                        if (enemyBuffer[i][2] == 1) {
                            enemies[j] = new TriangleEnemy(gameObjects[enemyBuffer[i][1]].x, gameObjects[enemyBuffer[i][1]].y, 20, enemyBuffer[i][4], int(gameObjects[enemyBuffer[i][1]].getTheta(environment.getUIObject(0)[0], environment.getUIObject(0)[1]) + enemyBuffer[i][3]), triangleEnemyColour);
                        } 
                        // if the enemy type is 2, then create a circular enemy.
                        else if (enemyBuffer[i][2] == 2) {
                            enemies[j] = new CircleEnemy(gameObjects[enemyBuffer[i][1]].x, gameObjects[enemyBuffer[i][1]].y, 30, enemyBuffer[i][4], int(gameObjects[enemyBuffer[i][1]].getTheta(environment.getUIObject(0)[0], environment.getUIObject(0)[1]) + enemyBuffer[i][3]), circleEnemyColour);
                        } 
                        // if the enemy type is 1, then create a square enemy.
                        else if (enemyBuffer[i][2] == 3) {
                            enemies[j] = new SquareEnemy(gameObjects[enemyBuffer[i][1]].x, gameObjects[enemyBuffer[i][1]].y, 20, enemyBuffer[i][4], int(gameObjects[enemyBuffer[i][1]].getTheta(environment.getUIObject(0)[0], environment.getUIObject(0)[1]) + enemyBuffer[i][3]), squareEnemyColour);
                        }

                        // Increase the number of enemies spawned by 1.
                        enemiesSpawned++;
                        // Set the enemies type to 0 so that it will not spawn more than once if another pattern is called.
                        enemyBuffer[i][2] = 0;
                        break;
                    }
                }
            }
        }

        // Loops through the enemies array, and updates every enemy that exists.
        for (int i = 0; i < enemies.length; i++) {
            if (enemies[i] != null) {
                // Passes through the playerX, playerY, and playerSize for collision detection.
                enemies[i].update(_playerX, _playerY, _playerSize);
            } 
            // if null is found, break from the loop.
            else {
                break;
            }
        }

        // Increase the game rotation by the rotation speed.
        gameRot += rotSpeed;

        // if the game rotation is greater than 360, set it to 0.
        if (gameRot > 360) {
            gameRot = 0.0;
        } 
        // if the game rotation is less than 0, set it to 360.
        else if (gameRot < 0) {
            gameRot = 360.0;
        }

        // Loops through the game objects and updates each one by passing in the current gameRot.
        for (int i = 0; i < numGameObjects; i++) {
            gameObjects[i].update(gameRot);
        }
    }

    // Draw:
    // - Receives the current FG and BG colours.
    // - Draws the gameObjects and the enemies.
    void draw(int _currentFG, int _currentBG) {

        // Loops through the gameObjects and draws each one.
        for (int i = 0; i < numGameObjects; i++) {
            gameObjects[i].draw(_currentFG, _currentBG);
        }

        // Loops through the enemies and draws them if they exist.
        for (int i = 0; i < enemies.length; i++) {
            if (enemies[i] != null) {
                enemies[i].draw();
            } 
            else {
                break;
            }
        }
    }

    // setPattern:
    // - Receives a pattern number, and adds enemies to the enemy buffer depending on that number.
    void setPattern(byte _patternNum) {

        // if the pattern number is -1, create a 500 frame break.
        if (_patternNum == -1) {
            transitionTime = 500;
        }
        // if the pattern number is 0, create a 100 frame break.
        else if (_patternNum == 0) {
            transitionTime = 100;
        } 
        // if the pattern number is 1, create a 100 frame pattern where a stream of triangles shoots out of every gameObject.
        else if (_patternNum == 1) {
            transitionTime = 100;
            for (int i = 0; i < numGameObjects; i++) {
                for (int j = 0; j < transitionTime/10; j++) {
                    createEnemyBuffer(i + (j*numGameObjects), transitionTime - (j+1)*10, i, 1, 15, 2);
                }
            }
        } 
        // if the pattern number is 2, create a 50 frame pattern where a burst of 5 triangles shoots out of every gameObject.
        else if (_patternNum == 2) {
            transitionTime = 50;
            for (int i = 0; i < numGameObjects; i++) {
                for (int j = 0; j < 5; j++) {
                    createEnemyBuffer((i + (j*numGameObjects)), 25, i, 1, (10*j) - 20, 2);
                }
            }
        } 
        // if the pattern number is 3, create a 200 frame pattern where a series of randomly angled triangles shoots out of every gameObject.
        else if (_patternNum == 3) {
            transitionTime = 200;
            for (int i = 0; i < numGameObjects; i++) {
                for (int j = 0; j < 5; j++) {
                    createEnemyBuffer((i + (j*numGameObjects)), j*40 + i*(40/numGameObjects), i, 1, int(random(-45, 45)), 2);
                }
            }
        } 
        // if the pattern number is 4, create a 10 frame pattern where a circle shoots out of every gameObject.
        else if (_patternNum == 4) {
            transitionTime = 10;
            for (int i = 0; i < numGameObjects; i++) {
                createEnemyBuffer(i, 5, i, 2, 0, 3);
            }
        } 
        // if the pattern number is 5, create a 10 frame pattern where a square shoots out of every other gameObject.
        else if (_patternNum == 5) {
            transitionTime = 10;
            for (int i = 0; i < numGameObjects/2; i++) {
                createEnemyBuffer(i, 5, i*2, 3, 45, 3);
            }
        } 
        // if the pattern number is 6, create a 180 frame pattern where a curved stream of triangles shoots out of every gameObject.
        else if (_patternNum == 6) {
            transitionTime = 180;
            for (int i = 0; i < numGameObjects/2; i++) {
                for (int j = 0; j < transitionTime; j+= 5) {
                    createEnemyBuffer(i + ((j/5)*(numGameObjects/2)), j, i*2, 1, j/5 - (j/5)*2, 2);
                }
            }
        } 
        // if the pattern number is 7, create a 180 frame pattern where 3 streams of triangles shoots out of every gameObject.
        else if (_patternNum == 7) {
            transitionTime = 180;
            for (int i = 0; i < numGameObjects; i++) {
                for (int j = 0; j < transitionTime; j+=10) {
                    createEnemyBuffer((i + ((j/10)*numGameObjects))*3, j, i, 1, -30, 2);
                    createEnemyBuffer((i + ((j/10)*numGameObjects))*3 + 1, j, i, 1, 0, 2);
                    createEnemyBuffer((i + ((j/10)*numGameObjects))*3 + 2, j, i, 1, 30, 2);
                }
            }
        } 
        // if the pattern number is 8, create a 1 frame pattern where 2 circles shoot out of oppositely position gameObjects.
        else if (_patternNum == 8) {
            transitionTime = 1;
            createEnemyBuffer(1, 1, 0, 2, int(random(-10, 10)), 3);
            createEnemyBuffer(2, 1, numGameObjects/2, 2, int(random(-10, 10)), 3);
        }
    }

    // createEnemyBuffer:
    // - Receives a position number, transitionTime, gameObject, enemyType, angle, and speed.
    // - Assigns each received value to the position number slot in the enemyBuffer array.
    void createEnemyBuffer(int _num, int _time, int _gameObject, int _enemyType, int _angle, int _speed) {
        enemyBuffer[_num][0] = _time;
        enemyBuffer[_num][1] = _gameObject;
        enemyBuffer[_num][2] = _enemyType;
        enemyBuffer[_num][3] = _angle;
        enemyBuffer[_num][4] = _speed;
    }

    // reset:
    // - Resets all the necessary variables in the Gameplay class to restart a level.
    void reset() {
        // Set the stage, game rotation, transition time, enemies spawned, and enemies not hit to 0.
        stage = 0;
        gameRot = 0;
        transitionTime = 0;
        enemiesSpawned = 0;
        enemiesNotHit = 0;

        // Loops through enemyBuffer array and resets all of the enemies to type 0.
        for (int i = 0; i < enemyBuffer.length; i++) {
            if (enemyBuffer[i][2] != 0) {
                for (int j = 0; j < enemyBuffer[i].length; j++) {
                    enemyBuffer[i][j] = 0;
                }
            } 
            else {
                break;
            }
        }

        // Loops through the enemies array and sets all active enemies to be dead.
        for (int i = 0; i < enemies.length; i++) {
            if (enemies[i] != null) {
                enemies[i].dead = true;
            } 
            else { 
                break;
            }
        }
    }

    // checkHighscore:
    // - Updates the highscore variable when a score greater than the previous is made.
    void checkHighscore() {
        // if the current score is greater than the highscore, set the highscore to the current score.
        if (byte(float(enemiesNotHit) / float(enemiesSpawned)*100) > highscore) {
            highscore = byte(float(enemiesNotHit) / float(enemiesSpawned)*100);
        }
    }
}

// Gameplay_Tutorial class:
// - Extends Gameplay.
// - Adjusts the draw function of the Gameplay class to allow for the drawing of the tutorial text.
class Gameplay_Tutorial extends Gameplay {

    // Gameplay_Tutorial class:
    // - Receives the gameStateIndex, number of gameObjects, the gameObject radii, and the enemy colours.
    // - Passes the received values to 
    Gameplay_Tutorial(int _gameStateIndex, byte _numGameObjects, int _gameObjectRadii, color _triEnemCol, color _squEnemCol, color _cirEnemCol) {
        super(_gameStateIndex, _numGameObjects, _gameObjectRadii, _triEnemCol, _squEnemCol, _cirEnemCol);
    } 

    // Draw:
    // - Receives the current FG and BG values.
    // - Calls its super.draw()
    // - Draws tutorial text to the screen.
    void draw(int _currentFG, int _currentBG) {
        super.draw(_currentFG, _currentBG);

        // Set the textSize to 20.
        textSize(20);

        // if the stage is less than the number of tutorial text samples, continue.
        if (stage < tutorialData.length) {
            // Fill a rectangle with the BG colour, and stroke it with the FG colour.
            fill(_currentBG);
            stroke(_currentFG);

            // Draw the rectangle at the top of the screen.
            rect(0, 10, width, 60);

            // Fill the text with the FG colour and draw the text corresponding with the stage.
            fill(_currentFG);
            text(tutorialData[stage], width/2, 50);
        }
    }
}


// Gameplay_Object class:
// - Manages a single gameObject.
class Gameplay_Object {

    // Creates a integer variable to hold the x, y, size, offset, and radius  of the gameObject. 
    int x;
    int y;
    int size;
    int offset;
    int radius;

    // Gameplay_Object:
    // - Receives the size, offset, and radius of the gameObject.
    Gameplay_Object(byte _size, int _offset, int _radius) {
        size = _size;
        offset = _offset;
        radius = _radius;
    }

    //  Update:
    // - Receives an angle to update the x and y coordinates of the gameObject.
    void update(float _angle) {

        // Uses the rotX and rotY methods to update the x and y position.
        x = int(rotX(environment.getUIObject(0)[0], radius, _angle+offset));
        y = int(rotY(environment.getUIObject(0)[1], radius, _angle+offset));
    }

    // Draw:
    // - Receives the current FG and BG.
    // - Draws the gameObject.
    void draw(int _currentFG, int _currentBG) {
        strokeWeight(3);
        stroke(_currentFG);
        fill(_currentBG);
        ellipse(x, y, size, size);
    }

    // rotX:
    // - Receives the originalX, position from the originalX, and angle to return a new x coordinate for the gameObject.
    float rotX(float x, int lineLen, float angle) {
        return cos(radians(angle))*lineLen + x;
    }


    // rotY:
    // - Receives the originalY, position from the originalY, and angle to return a new y coordinate for the gameObject.
    float rotY(float y, int lineLen, float angle) {
        return sin(radians(angle))*lineLen + y;
    }

    // getTheta:
    // - Receives the originX and originY values.
    // - Returns the angle of the line represented by originX,originY and x,y of the game.
    float getTheta(int _originX, int _originY) {
        return degrees(atan2((_originY-y), (_originX-x)));
    }
}

// gameData is a 3 dimensional float array that holds all of the patterns and rotation speeds for each level in the game.
// gameData[gameStateIndex][pattern(0) or rotationSpeed(1)][stage]
// Each pattern number corresponds to a pattern in the Gameplay class.
float[][][] gameData = {
    {  //tutorial
        {  //pattern
            0, 0, 0, 0, 0, 0, 0, 3, 0, 0, 0, 0, 0, 0, 0, 0
        }
        , 
        {  //rotation speed
            0, 0, 0, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5
        }
    }
    , 
    {  //level 1
        {  //pattern
            0, 4, 0, 4, 0, 4, 0, 5, 0, 0, 1, 1, 0, 5, 0, 3, 0, 
            6, 0, 4, 0, 4, 0, 4, 0, 6, 0, 0, 5, 0, 1, 1, 1, 0, 
            0, 4, 6, -1
        }
        , 
        {  //rotation speed
            0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, -0.5, -0.5, -0.5, -0.5, -0.5, -0.5, 0.5, 0.5, 
            0.5, 0.5, 0.5, 0.5, 0.5, -0.5, -0.5, -0.5, -0.5, -0.5, 0.5, 0.5, -0.5, -0.5, 0.5, -0.5, -0.5, 
            -0.5, -0.5, 0.5, 0.5
        }
    }
    , 
    {  //level 2
        {  //pattern
            0, 1, 0, 1, 1, 4, 1, 0, 2, 0, 0, 0, 1, 1, 1, 0, 5, 0, 
            6, 6, 6, 6, 6, 6, 6, 0, 0, 2, 0, 2, 0, 2, 0, 0, 7, 7, 
            4, 7, 7, 8, 0, 0, 5, 5, 5, 3, 5, 5, 5, 3, -1
        }
        , 
        {  //rotation speed
            0, 0.5, 0.5, -0.5, -0.5, -0.5, -0.5, -0.5, -0.5, -0.5, -0.5, -0.5, -0.5, 0.5, -0.5, 0.5, 0.5, 0.5, 
            0.25, 0, 0, -0.25, -0.5, -0.6, -0.7, -0.8, -0.5, -0.5, -0.6, -0.7, -0.8, -0.9, -0.95, -0.5, 0, 0.25, 
            0.25, 0.4, 0.4, 0.4, 0.4, 0.4, 0.75, 0.75, 0.75, 1, 1.5, 1.5, 1.5, 1.5, 1.5
        }
    }
    , 
    {  //level 3
        {  //pattern
            0, 3, 0, 0, 7, 0, 0, 1, 8, 1, 8, 1, 8, 1, 8, 1, 8, 1, 
            8, 0, 0, 2, 0, 0, 6, 0, 0, 6, 0, 0, 6, 0, 0, 3, 4, 3, 
            0, 0, 5, 5, 0, 5, 5, 0, 5, 5, 0, 0, 4, 0, 4, 0, 4, -1
        }
        , 
        {  //rotation speed
            1, 1, 1, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, -0.5, -0.5, -1, -1, -1.5, -1.5, 1.5, 1.5, 1, 
            1, 0.5, 0.5, -0.5, -0.5, -0.25, -0.25, -0.25, 0.25, 0.25, 0.25, -0.25, -0.25, -0.25, -0.5, -1, -1, -1, 
            -1, -1, -1, 1, 1, -1, 1, 1, -1, -1, -0.25, 0.25, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5
        }
    }
};

// tutorialData is a String array that stores all of the text used in the tutorial level. 
// Each line corresponds to a stage. Lines are repeated twice in order to give the user a long enough time to read the text.
String[] tutorialData = {
    "Welcome to Soundodger!", 
    "Welcome to Soundodger!", 
    "You are the circle below. Use your mouse to move it around the playing field.", 
    "You are the circle below. Use your mouse to move it around the playing field.", 
    "The aim of the game is to dodge the enemies that appear from the rotating circles.", 
    "The aim of the game is to dodge the enemies that appear from the rotating circles.", 
    "Triangular and circular enemies travel in a straight line and square enemies follow you.", 
    "Triangular and circular enemies travel in a straight line and square enemies follow you.", 
    "Try dodging these enemies! Press \"P\" to pause!", 
    "Try dodging these enemies! Press \"P\" to pause!", 
    "", 
    "", 
    "You have infinite lives, but, the more enemies you dodge, the better the score you will get!", 
    "You have infinite lives, but, the more enemies you dodge, the better the score you will get!", 
    "Good luck!", 
    "Good luck!", 
    ""
};

