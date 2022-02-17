state("MoST_Win")
{
    // ID of the currently loaded level. Main menu is 0, levels are 1-8
    int levelid : 0x92C620;

    // Player's current movement direction. Used for detecting first input
    int moveDir : 0x0095A784, 0x28, 0x10, 0x10, 0x14, 0x40, 0x24, 0x2C;
}

reset
{
    // If player has moved back to level 1 from a different level, reset
    if (old.levelid != 1 && current.levelid == 1){
        return true;
    }
    //TODO: Reset if player presses 1 while already on level 1
}

start {
    // On first input in level 1, start timer
    if (current.levelid == 1 && current.moveDir != 0){
        return true;
    }
}

split
{
    // For all levels except the last, split on levelID increment
    if (old.levelid < 8){
        if (current.levelid == old.levelid + 1){
            return true;
        }
    // On the final level, split on levelID going back to 0 (menu)
    }else{
        if (current.levelid == 0){
            return true;
        }
    }
}