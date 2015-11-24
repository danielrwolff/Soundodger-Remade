// Daniel Wolff
// 01/05/2015
// Culminating Project: Soundodger (remade by Daniel Wolff)

// Creating a new environment object.
Environment environment;

// Variables that hold the screen width and height. Used for referencing the positions of shapes on the screen.
int screenWidth = 1200;
int screenHeight = 800;


// Decides whether or not the exit(); command can be executed (false for Javascript mode)
boolean exitable = true; 

void setup() {
    // Set the size of the screen (cannot use the variables above due to Javascript complaining that I must use integer numbers, not a variable).
    size(1200, 800);

    // Aligning shapes and text to either their centers or corners.
    textAlign(CENTER);
    ellipseMode(CENTER);
    rectMode(CORNER);

    // Instantiating the environment object.
    environment = new Environment();
}

void draw() {

    // Updating and drawing the environment.
    environment.update();
    environment.draw();
}

void keyReleased() {
    if (keyCode == 80) {    // if "p" is released, tell the environment to pause the game.
        environment.pauseGame(true);
    }
}

void mouseReleased() {    // if the mouse is released, tell the environment where the click was.
    environment.doMouseClicked(mouseX, mouseY);
}

//menuData is the array that holds all the coordinates and sizes of all the shapes on all of the menus.
//Having all this data in one array allows editting menus to be easy.
//menuData[menu][shape][shapeInfo] = {int(x),int(y),int(sizeX),int(sizeY),inflationLimit,gameStateTransitionIndex,textSize}.
int[][][] menuData = {
    {    //main Menu
        {    //Shape 1
            int(screenWidth/2), int(screenHeight/2), int(screenHeight/3.5), int(screenHeight/3.5), int(20), int(3), int(40)
        }
        , 
        {    //Shape 2
            int(screenWidth/4), int(screenHeight/2), int(screenHeight/3.5), int(screenHeight/3.5), int(20), int(1), int(40)
        }
        , 
        {    //Shape 3
            int(screenWidth-(screenWidth/4)), int(screenHeight/2), int(screenHeight/3.5), int(screenHeight/3.5), int(20), int(2), int(40)
        }
    }
    , 
    {  //options menu
        {    
            int(75), int(screenHeight-75), int(screenHeight/8), int(screenHeight/8), int(5), int(0), int(40)
        }
        , 
        {
            int(screenWidth/2), int(screenHeight/2), int(screenHeight/3.5), int(screenHeight/3.5), int(15), int(-1), int(40)
        }
    }
    , 
    {  //credits menu
        {    
            int(75), int(screenHeight-75), int(screenHeight/8), int(screenHeight/8), int(5), int(0), int(40)
        }
        , 
        {
            int(screenWidth/4), int(screenHeight/3), int(screenHeight/1.75), int(screenHeight/1.75), int(20), int(-1), int(30)
        }
        , 
        {
            int(screenWidth-screenWidth/3), int(screenHeight/2.75), int(screenHeight/2.25), int(screenHeight/2.25), int(20), int(-1), int(20)
        }
        , 
        {
            int(screenWidth/2 - 20), int(screenHeight/2 + 20), int(screenHeight/8), int(screenHeight/8), int(10), int(-1), int(20)
        }
        , 
        {
            int(screenWidth/2), int(screenHeight/1.25), int(screenHeight/2.75), int(screenHeight/2.75), int(5), int(-1), int(20)
        }
    }
    , 
    {  //levelSel menu
        {    
            int(75), int(screenHeight-75), int(screenHeight/8), int(screenHeight/8), int(5), int(0), int(40)
        }
        , 
        {    //Shape 1
            int(screenWidth/3), int(screenHeight/3), int(screenHeight/3.5), int(screenHeight/3.5), int(20), int(6), int(40)
        }
        , 
        {    //Shape 2
            int(screenWidth - (screenWidth/3)), int(screenHeight/3), int(screenHeight/3.5), int(screenHeight/3.5), int(20), int(7), int(40)
        }
        , 
        {    //Shape 3
            int(screenWidth/3), int(screenHeight - (screenHeight/3)), int(screenHeight/3.5), int(screenHeight/3.5), int(20), int(8), int(40)
        }
        , 
        {    //Shape 4
            int(screenWidth-(screenWidth/3)), int(screenHeight - (screenHeight/3)), int(screenHeight/3.5), int(screenHeight/3.5), int(20), int(9), int(40)
        }
    }
    , 
    {  //pause menu
        {    
            int(75), int(screenHeight-75), int(screenHeight/8), int(screenHeight/8), int(5), int(0), int(40)
        }
        , 
        {    //Shape 1
            int(screenWidth/2), int(screenHeight/2), int(screenHeight/3.5), int(screenHeight/3.5), int(20), int(-3), int(40)
        }
    }
    , 
    {  //score menu
        {    //Shape 1
            int(screenWidth/2), int(screenHeight/2), int(screenHeight/1.5), int(screenHeight/1.5), int(0), int(-1), int(100)
        }
        , 
        {    //Shape 2
            int(screenWidth/4), int(screenHeight/2), int(screenHeight/3.5), int(screenHeight/3.5), int(20), int(-4), int(40)
        }
        , 
        {    //Shape 3
            int(screenWidth - screenWidth/4), int(screenHeight/2), int(screenHeight/3.5), int(screenHeight/3.5), int(20), int(0), int(40)
        }
    }
    , 
    {  //tutorial
        {    //Shape 1
            int(screenWidth/2), int(screenHeight/2), int(screenHeight/1.25), int(screenHeight/1.25), int(0), int(-1), int(40)
        }
    }
    , 
    {  //level1
        {    //Shape 1
            int(screenWidth/2), int(screenHeight/2), int(screenHeight/1.25), int(screenHeight/1.25), int(0), int(-1), int(0)
        }
    }
    , 
    {  //level2
        {    //Shape 1
            int(screenWidth/2), int(screenHeight/2), int(screenHeight/1.25), int(screenHeight/1.25), int(0), int(-1), int(0)
        }
    }
    , 
    {  //level3
        {    //Shape 1
            int(screenWidth/2), int(screenHeight/2), int(screenHeight/1.25), int(screenHeight/1.25), int(0), int(-1), int(0)
        }
    }
};

//menuText holds the strings of all the text on each menu. All text will be inside one of
//the shapes stated in menuData.
//Having all the text in one array allows editting menus to be easy.
//menuText[menu][shape] = "Text";.

String[][] menuText = {
    {    //main menu
        "Play", "Options", "Credits"
    }
    , 
    {    //options menu
        "Back", "Music: Off"
    }
    , 
    {    //credits menu
        "Back", "A StudioBean game", "Remade by Daniel Wolff", "", "Music by MonstercatMedia"
    }
    , 
    {    //levelSel menu
        "Back", "Tutorial", "Level 1", "Level 2", "Level 3"
    }
    , 
    {    //pause menu
        "Back", "Resume"
    }
    , 
    {    //score menu
        "", "Replay", "Menu"
    }
    , 
    {    //tutorial
        ""
    }
    , 
    {    //level 1
        ""
    }
    , 
    {    //level 2
        ""
    }
    , 
    {    //level 3
        ""
    }
};

// Daniel Wolff
// 01/05/2015
// Culminating Project: Soundodger (remade by Daniel Wolff)

// Background class:
// - Draws the blank background.
// - Controls and manages the background alpha values for transitioning.
// - Returns the BG and FG colors when requested by the environment.
class Background {

    // Creating the background and foreground variables.
    color bg;
    color fg;

    // Creating the fadeAlpha integer variable.
    int fadeAlpha = 0;


    // Background Constructor: 
    // - Receives the BG and FG colors from the environment.
    Background(color _bg, color _fg) {
        bg = _bg;
        fg = _fg;
    }

    // Update: 
    // - Updates the fadeAlpha value.
    void update() {

        // Always increase the fadeAlpha by a value of 5, unless fadeAlpha is greater than or equal to 255 (max).
        if (fadeAlpha < 255) {
            fadeAlpha+=5;
        }
    }

    // Draw:
    // - Placeholder to be overridden be child classes.
    void draw() {
    }

    // fadeIn: 
    // - Resets the fadeAlpha variable.
    void fadeIn() {
        // When reset, the update() method will then increase this every frame, giving a fade effect.
        fadeAlpha = 0;
    }

    // getBG:
    // - Returns the BG color value when requested.
    int getBG() {
        return bg;
    }

    // getFG:
    // - Returns the FG color value when requested.
    int getFG() {
        return fg;
    }
}

// Background_Anim class: 
// - Extends Background.
// - Creates a circle animation in the background.
class Background_Anim extends Background {

    // Creating a 3x3 array that stores the data for the circles that create the animation.
    int[][] circles = new int[3][3];
    // Creating an integer variable that keeps track of the animation's progression. Set to 100 so that the animation starts right away.
    int animCount = 100;

    // Background_Anim Constructor:
    // - Receives the BG and FG colors from the environment.
    // - Assigns values for the circles in the animation.
    Background_Anim(color _bg, color _fg) {
        super(_bg, _fg);

        // For each item in circles, assign the following values.
        for (int[] i : circles) {
            // Circle X position.
            i[0] = width/2;
            // Circle Y position.
            i[1] = height/2;
            // Circle size. (-1 means non-existant).
            i[2] = -1;
        }
    }
    // Update:
    // - Calls its super.
    // - Increases  the animation's progression.
    // - Updates the circles in the animation.
    void update() {
        super.update();
        animCount++;

        // if the animation progression is greater than or equal to 100, add a circle and reset the progression.
        if (animCount >= 100) {
            animCount = 0;
            addCircle();
        }

        // Update the circles in the animation.
        updateCircles();
    }

    // Draw :
    // - Draws the background.
    // - Draws the circles in the animation.
    void draw() {
        background(bg);
        noFill();
        stroke(fg, fadeAlpha);
        strokeWeight(1);
        for (int[] i : circles) {
            if (i[2] > 0) {
                ellipse(i[0], i[1], i[2], i[2]);
            }
        }
    }

    // addCircle:
    // - Takes a non-existant circle and sets its size to 0. This will allow it to be updated.
    void addCircle() {
        for (int[] i : circles) {
            // If the circle is non-existant, make it exist.
            if (i[2] == -1) {
                i[2] = 0;
                break;
            }
        }
    }

    // updateCircles:
    // - Updates the size of each circle in the animation.
    void updateCircles() {
        for (int[] i : circles) {
            // if the size is greater than twice the height of the screen, reset the circles size.
            if (i[2] >= height*2) {
                i[2] = 0;
            }
            // else, if the size is not non-existant, increase the size by 5.
            else if (i[2] != -1) {
                i[2] += 5;
            }
        }
    }
}

// Background_NoAnim class:
// - Extends Background.
// - Creates a non-animated background thats color corresponds to the current gameStateIndex in the environment.
class Background_NoAnim extends Background {

    // Background_NoAnim constructor:
    // - Receives nothing.
    // - Tells its super to set the BG and FG to white.
    Background_NoAnim() {
        super(color(255), color(255));
    }

    // Update:
    // - Receives the current BG colour based on the current gameStateIndex.
    void update() {
        bg = environment.getCurrentBG();
    }

    // Draw:
    // - Draws the background.
    void draw() {
        background(bg);
    }
}

// Daniel Wolff
// 01/05/2015
// Culminating Project: Soundodger (remade by Daniel Wolff)

// Enemy class:
// - Manages a single enemies position, size, speed, angle, colour, and state.
class Enemy {

    // Creates a float variable for the x, y, originalX, originalY, and angle for the enemy.
    float x;
    float y;
    float originX;
    float originY;
    float angle;

    // Creates an integer variable for the size, speed, and position of the enemy.
    int size;
    int speed;
    int pos = 0;

    // Creates a color variable for the colour of the enemy.
    color colour;

    // Creates a boolean variable for the dead state, isHit state, and allowBoundaryCollision state of the enemy.
    boolean dead = false;
    boolean isHit = false;
    boolean allowBoundaryCollision = false;


    // Enemy constructor:
    // - Receives the x, y, size, speed, angle, and colour of the enemy from the gameplayControllers.
    Enemy(float _x, float _y, int _size, int _speed, int _angle, color _clr) {
        x = _x;
        y = _y;
        originX = _x;
        originY = _y;
        size = _size;
        speed = _speed;
        angle = _angle;
        colour = _clr;
    }

    // Update:
    // - Placeholder to be overridden be child classes.
    void update(int _playerX, int _playerY, int _playerSize) {
    }

    // Draw:
    // - Placeholder to be overridden be child classes.
    void draw() {
        // if it is hit, fill the enemy with the colour red.
        if (isHit) {
            fill(255, 0, 0);
        }
        // if it is not hit, fill the enemy with its original colour.
        else {
            fill(colour);
        }
        noStroke();
    }

    // getHyp:
    // - Returns length of the distance between the enemies x and y, and the inputted x and y coordinates.
    float getHyp(int _pointX, int _pointY) {
        return sqrt(sq(_pointX - x) + sq(_pointY - y));
    }

    // rotX:
    // - Receives the originalX, position from the originalX, and angle to return a new x coordinate for the enemy.
    float rotX(float _x, int _lineLen, float _angle) {
        return cos(radians(_angle))*_lineLen + _x;
    }

    // rotY:
    // - Receives the originalY, position from the originalX, and angle to return a new y coordinate for the enemy.
    float rotY(float _y, int _lineLen, float _angle) {
        return sin(radians(_angle))*_lineLen + _y;
    }
}

// TriangleEnemy class:
// - Extends Enemy.
// - Updates the position and states of a triangular enemy.
class TriangleEnemy extends Enemy {

    // TriangleEnemy constructor:
    // - Receives the x, y, size, speed, angle, and colour of the enemy from the gameplayControllers and sends it to its super.
    TriangleEnemy(float _x, float _y, int _size, int _speed, int _angle, color _clr) {
        super(_x, _y, _size, _speed, _angle, _clr);
    }

    // Update:
    // - Receives the playerX, playerY, and playerSize from the environment.
    // - Updates the enemy position, and checks for boundaries and collisions.
    void update(int _playerX, int _playerY, int _playerSize) {
        // if the enemy is not dead, continue.
        if (!dead) {
            // Update position from its origin coordinates.
            pos += speed;
            // Update the x and y variables based on its new position.
            x = rotX(originX, pos, angle);
            y = rotY(originY, pos, angle);

            // Check collisions with the player.
            checkCollision(_playerX, _playerY, _playerSize);
            // Check collisions with the game boundaries. 
            checkBoundaries();
        }
    }

    // Draw:
    // - Controls the colour of the enemy based on whether it is hit.
    // - Draws the enemy.
    void draw() {
        // if the enemy is not dead, continue.
        if (!dead) {
            super.draw();
            // Draw the triangle using the rotX and rotY function to create the points.
            triangle(x, y, rotX(x, -size, angle-25), rotY(y, -size, angle-25), rotX(x, -size, angle+25), rotY(y, -size, angle+25));
        }
    }

    // checkBoundaries:
    // - Checks the boundary collision state, and check to see if the enemy has collided with the edge of the playing field.
    void checkBoundaries() {
        // if the distance between the enemies x and y coordinates and the center of the playing field is greater than the radius of the field, continue.
        if (getHyp((environment.getUIObject(0)[0]), (environment.getUIObject(0)[1])) >= (environment.getUIObject(0)[2])/2) {
            // if boundary collision is allowed, kill the enemy.
            if (allowBoundaryCollision) {
                dead = true;
                // if the enemy did not collide with the player, tell the environment to update the enemy counters.
                if (!isHit) {
                    environment.enemyUpdate();
                }
            }
        }
        // if the distance between the enemies x and y coordinates and the center of the playing field is lesser than the radius of the field, allow boundary collision.
        // This eliminates the possibility of an enemy colliding with the boundaries of the field before it even enters the field.
        else {
            allowBoundaryCollision = true;
        }
    }

    // checkCollision: 
    // - Receives the playerX, playerY, and playerSize.
    // - Checks to see if the enemy has collided with the player.
    void checkCollision(int _playerX, int _playerY, int _playerSize) {
        // if the distance between the playerX, playerY and the enemy x, y, is less than or equal to the radius of the player, the enemy has been hit.
        if (getHyp(_playerX, _playerY) <= _playerSize/2) {
            isHit = true;
        }
    }
}

// CircleEnemy class:
// - Extends Enemy.
// - Updates the position and states of a circular enemy.
class CircleEnemy extends Enemy {

    // CircleEnemy constructor:
    // - Receives the x, y, size, speed, angle, and colour of the enemy from the gameplayControllers and sends it to its super.
    CircleEnemy(float _x, float _y, int _size, int _speed, int _angle, color _clr) {
        super(_x, _y, _size, _speed, _angle, _clr);
    }

    // Update:
    // - Receives the playerX, playerY, and playerSize from the environment.
    // - Updates the enemy position, and checks for boundaries and collisions.
    void update(int _playerX, int _playerY, int _playerSize) {
        // if the enemy is not dead, continue.
        if (!dead) {
            // Update position from its origin coordinates.
            pos += speed;
            // Update the x and y variables based on its new position.
            x = rotX(originX, pos, angle);
            y = rotY(originY, pos, angle);

            // Check collisions with the player.
            checkCollision(_playerX, _playerY, _playerSize);
            // Check collisions with the game boundaries. 
            checkBoundaries();
        }
    }

    // Draw:
    // - Controls the colour of the enemy based on whether it is hit.
    // - Draws the enemy.
    void draw() {
        // if the enemy is not dead, continue.
        if (!dead) {
            super.draw();
            // Draw the circle.
            ellipse(x, y, size, size);
        }
    }

    // checkBoundaries:
    // - Checks the boundary collision state, and check to see if the enemy has collided with the edge of the playing field.
    void checkBoundaries() {
        // if the distance between the enemies x and y coordinates and the center of the playing field is greater than the radius of the field minus the radius of the enemy, continue.
        if (getHyp((environment.getUIObject(0)[0]), (environment.getUIObject(0)[1])) >= (environment.getUIObject(0)[2])/2 - size/2) {
            // if boundary collision is allowed, kill the enemy.
            if (allowBoundaryCollision) {
                dead = true;
                // if the enemy did not collide with the player, tell the environment to update the enemy counters.
                if (!isHit) {
                    environment.enemyUpdate();
                }
            }
        }
        // if the distance between the enemies x and y coordinates and the center of the playing field is lesser than the radius of the field, allow boundary collision.
        // This eliminates the possibility of an enemy colliding with the boundaries of the field before it even enters the field.
        else {
            allowBoundaryCollision = true;
        }
    }

    // checkCollision: 
    // - Receives the playerX, playerY, and playerSize.
    // - Checks to see if the enemy has collided with the player.
    void checkCollision(int _playerX, int _playerY, int _playerSize) {
        // if the distance between the playerX, playerY and the enemy x, y, is less than or equal to the radius of the player plus the radius of the enemy, the enemy has been hit.
        if (getHyp(_playerX, _playerY) <= _playerSize/2 + size/2) {
            isHit = true;
        }
    }
}

// SquareEnemy class:
// - Extends Enemy.
// - Updates the position and states of a square enemy.
class SquareEnemy extends Enemy {

    // Creates a short that keeps track of the follow time of the square enemy (default -> 3 seconds / 180 frames).
    short followTime = 180;

    // SquareEnemy constructor:
    // - Receives the x, y, size, speed, angle, and colour of the enemy from the gameplayControllers and sends it to its super.
    SquareEnemy(float _x, float _y, int _size, int _speed, int _angle, color _clr) {
        super(_x, _y, _size, _speed, _angle, _clr);
    }


    // Update:
    // - Receives the playerX, playerY, and playerSize from the environment.
    // - Updates the enemy position, and checks for boundaries and collisions.
    void update(int _playerX, int _playerY, int _playerSize) {
        // if the enemy is not dead, continue.
        if (!dead) {
            // if the followTime is not zero, and the player is not hit, update the angle and decrease the followTime.
            if (followTime > 0 && !isHit) {
                angle = getTheta(_playerX, _playerY);
                followTime--;
            }

            // Update the x and y variables based on its new angle.
            x = rotX(x, speed, angle);
            y = rotY(y, speed, angle);

            // Check collisions with the player.
            checkCollision(_playerX, _playerY, _playerSize);
            // Check collisions with the game boundaries. 
            checkBoundaries();
        }
    }

    // Draw:
    // - Controls the colour of the enemy based on whether it is hit.
    // - Draws the enemy.
    void draw() {
        // if the enemy is not dead, continue.
        if (!dead) {
            super.draw();
            // Draw the square.
            rect(x, y, size, size);
        }
    }

    // checkBoundaries:
    // - Checks the boundary collision state, and check to see if the enemy has collided with the edge of the playing field.
    void checkBoundaries() {
        // if the distance between the enemies x and y coordinates and the center of the playing field is greater than the radius of the field minus the radius of the enemy, continue.
        if (getHyp((environment.getUIObject(0)[0]), (environment.getUIObject(0)[1])) >= (environment.getUIObject(0)[2])/2 - size/2) {
            // if boundary collision is allowed, kill the enemy.
            if (allowBoundaryCollision) {
                dead = true;
                // if the enemy did not collide with the player, tell the environment to update the enemy counters.
                if (!isHit) {
                    environment.enemyUpdate();
                }
            }
        }
        // if the distance between the enemies x and y coordinates and the center of the playing field is lesser than the radius of the field, allow boundary collision.
        // This eliminates the possibility of an enemy colliding with the boundaries of the field before it even enters the field.
        else {
            allowBoundaryCollision = true;
        }
    }

    // checkCollision: 
    // - Receives the playerX, playerY, and playerSize.
    // - Checks to see if the enemy has collided with the player.
    void checkCollision(int _playerX, int _playerY, int _playerSize) {
        // if the distance between the playerX, playerY and the enemy x, y, is less than or equal to the radius of the player plus the radius of the enemy, the enemy has been hit.
        if (getHyp(_playerX, _playerY) <= _playerSize/2 + size/2) {
            isHit = true;
        }
    }

    // getTheta:
    // - Receives the playerX and playerY values.
    // - Returns the angle of the line represented by playerX,playerY and x,y of the enemy.
    float getTheta(int _playerX, int _playerY) {
        return degrees(atan2((_playerY-y), (_playerX-x)));
    }
}

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
            //0, 3, 0, 0, 7, 0, 0, 1, 8, 1, 8, 1, 8, 1, 8, 1, 8, 1, 
            //8, 0, 0, 2, 0, 0, 6, 0, 0, 6, 0, 0, 6, 0, 0, 3, 4, 3, 
            0, 0, 5, 5, 5, 5, 5, 0, 0, 7, 7, 7, -1
        }
        , 
        {  //rotation speed
            //1, 1, 1, 0.5, 0.5, 0.5, 0.5, 0.5, 0.5, -0.5, -0.5, -1, -1, -1.5, -1.5, 1.5, 1.5, 1, 
           // 1, 0.5, 0.5, -0.5, -0.5, -0.25, -0.25, -0.25, 0.25, 0.25, 0.25, -0.25, -0.25, -0.25, -0.5, -1, -1, -1, 
            -1, -1, -1, 1, -1, 1, -1, -0.5, -0.25, 0, 0.25, -0.25, 0.25
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

// Daniel Wolff
// 01/05/2015
// Culminating Project: Soundodger (remade by Daniel Wolff)

// Player class:
// - Manages the player data.
class Player {

    // Creates an integer variable for the players x, y, and size. 
    int x;
    int y;
    int size;

    // Player constructor:
    // - Receives an x position, y position, and size.
    Player(int _x, int _y, int _size) {
        x = _x;
        y = _y;
        size = _size;
    }    

    // Update:
    // - Checks the player boundaries.
    void update() {
        checkBoundaries();
    }

    // Draw:
    // - Draws the player.
    void draw(int _currentFG) {
        noStroke();
        fill(_currentFG);
        ellipse(x, y, size, size);
    }

    // checkBoundaries.
    // - Manipulates the player position to keep the player within the game boundaries.
    void checkBoundaries() {
        // if the distance between the players x and y coordinates and the center of the playing field is lesser than the radius of the field minus the radius of the player, continue.
        if (getHyp(environment.getUIObject(0)[0], environment.getUIObject(0)[1]) < environment.getUIObject(0)[2]/2 - size/2) {
            // Set the player's coordinates to the coordinates of the mouse.
            x = mouseX;
            y = mouseY;
        } 
        // if the distance between the players x and y coordinates and the center of the playing field is greater than the radius of the field minus the radius of the player, continue.
        else {
            // Rotate the player around the boundaries by using the rotX and rotY methods.
            x = int(rotX(width/2, environment.getUIObject(0)[2]/2  - size/2, getTheta(environment.getUIObject(0)[0], environment.getUIObject(0)[1])));
            y = int(rotY(height/2, environment.getUIObject(0)[2]/2  - size/2, getTheta(environment.getUIObject(0)[0], environment.getUIObject(0)[1])));
        }
    }



    // getHyp:
    // - Returns length of the distance between the players x and y, and the inputted x and y coordinates.
    float getHyp(int _originX, int _originY) {
        return sqrt(sq(_originX - mouseX) + sq(_originY - mouseY));
    }

    // getTheta:
    // - Receives the originX and originY values.
    // - Returns the angle of the line represented by originX,originY and x,y of the player (mouseX, mouseY).
    float getTheta(int _originX, int _originY) {
        return atan2((mouseY - _originY), (mouseX - _originX));
    }

    // rotX:
    // - Receives the originalX, position from the originalX, and angle to return a new x coordinate.
    float rotX(float x, int lineLen, float angle) {
        return cos(angle)*lineLen + x;
    }

    // rotY:
    // - Receives the originalY, position from the originalY, and angle to return a new y coordinate.
    float rotY(float y, int lineLen, float angle) {
        return sin(angle)*lineLen + y;
    }
}

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


