// Daniel Wolff
// 01/05/2015
// Culminating Project: Soundodger (remade by Daniel Wolff)

// Creating a new environment object.
Environment environment;

// Variables that hold the screen width and height. Used for referencing the positions of shapes on the screen.
int screenWidth = 1200;
int screenHeight = 800;

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
    if (keyCode == 80) {    // if "p" is released, continue.
        // if the game is paused, unpause. If it isn't paused, then pause.
        if (environment.paused) {
            environment.pauseGame(false);
        }
        else {
            environment.pauseGame(true);
        }
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
            int(screenWidth-screenWidth/3), int(screenHeight/2.85), int(screenHeight/2.25), int(screenHeight/2.25), int(20), int(-1), int(20)
        }
        , 
        {
            int(screenWidth/2 - 20), int(screenHeight/2), int(screenHeight/8), int(screenHeight/8), int(10), int(-1), int(20)
        }
        , 
        {
            int(screenWidth/2), int(screenHeight - screenHeight/4.5), int(screenHeight/2.5), int(screenHeight/2.5), int(5), int(-1), int(20)
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
        "Back", "A StudioBean game", "Remade by Daniel Wolff", "", "Bug tested by Ben Ecclestone"
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

