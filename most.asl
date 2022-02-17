state("MoST_Win")
{
    // ID of the currently loaded level. Main menu is 0, levels are 1-8
    int levelid : 0x92C620;

    // Player's current movement direction. Used for detecting first input
    int moveDir : 0x0095A784, 0x28, 0x10, 0x10, 0x14, 0x40, 0x24, 0x2C;

    // Set to 1 when the player enters the final doorway
    byte hasEntered_8 : 0x00959104, 0x8, 0x44, 0x48, 0x28, 0x64, 0x14, 0x14;
}

reset
{
    // If player has moved back to the menu or level 1 from a different level, reset
    if (current.levelid == 0 || (old.levelid != 1 && current.levelid == 1)){
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
    // On the final level, split on entering the door
    }else{
        if (current.hasEntered_8 == 1){
            return true;
        }
    }
}