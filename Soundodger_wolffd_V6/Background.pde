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

