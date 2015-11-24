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

