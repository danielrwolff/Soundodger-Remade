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

