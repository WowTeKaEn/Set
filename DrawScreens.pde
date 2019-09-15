void drawStartScreen() {
  rectMode(CORNER);
  stroke(0);
  background(0);
  amountCardsSelected = 0;
  if (startUp) {
    player = true;
    mouseClicks = 0;
    pointlessClicks = 0;
    hintUsed = 0;
    extraCardsUsed = 0;
    score = 0;
    startUp = false;
    stopGame = false;
    propertiesAmount = 3;
    visibleCardsNumber = 3 * propertiesAmount;
    nonVisibleCardsNumber = visibleCardsNumber+3;
    cardsOnTable = new String[visibleCardsNumber][3];
    drawSpecificCard = new boolean[nonVisibleCardsNumber];
    cardsSelected =new boolean[nonVisibleCardsNumber];
    clickedNoCard = false;
    clickedHint = false;
    nInvisibleCards = 0;
    setInvisibleCards();
    setVisibleCards();
    shuffleCards();
    playerScore1 = 0;
    playerScore2 = 0;
    threePressed = true;
  }
  if (buttonHover(buttonWPlace, buttonHPlace + (buttonHeight * 2), buttonWidth, buttonHeight) && mousePressed) {
    screenStatus = SETTINGSCREEN;
  }
  if (buttonHover(buttonWPlace, buttonHPlace, buttonWidth, buttonHeight) && mousePressed) {
    screenChangedGame = true;
    screenStatus = GAMESCREEN;
    mousePressed = false;
  }
  if (buttonHover(buttonWPlace, buttonHPlace + (buttonHeight * 4), buttonWidth, buttonHeight) && mousePressed) {
    exit();
  }
  startButtons(buttonWPlace, buttonHPlace, buttonWidth, buttonHeight, "Start Game");  
  startButtons(buttonWPlace, buttonHPlace + (buttonHeight * 2), buttonWidth, buttonHeight, "Settings");
  startButtons(buttonWPlace, buttonHPlace + (buttonHeight * 4), buttonWidth, buttonHeight, "Exit");
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void drawGameScreen() {
  if (!stopGame) {
    background(0);
    drawAllCards();
    drawButtons();
    textAlign(CENTER);
    if (clickedNoCard && sets == 0) {
      textSize(textSize*4);
      fill(255, 0, 0);
      text("Wow no sets with " +  nonVisibleCardsNumber + " cards?", width / 2, height / 2);
      text("the odds against no SET in " +  nonVisibleCardsNumber +  " cards is a whopping 2500:1", width / 2, (height / 2) + textSize * 4);
      fill(255);
    }
    textSize(textSize);
  } else if (invisibleCards.length - nInvisibleCards == 0 && sets == 0) {
    textSize(textSize*4);
    textAlign(CENTER);

    background(0);
    fill(255);
    text("Game has ended", width / 2, height / 2);
    drawButtons();
  }

  if (screenChangedGame) {
    stopGame = false;
    visibleCards();
    sets = 0;
    checkAllCards();
    for (int i = 0; i < nonVisibleCardsNumber; i++) {
      drawSpecificCard[i] = true;
    }
    checkAllCards();
    screenChangedGame = false;
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void drawEndGame() {
  if (delayCounter < 350 && !multiplayer) {
    background(0);
    textAlign(CENTER);
    textSize(textSize*2);
    text("Your score: " + score, width/2, height/2 - credits);
    text("Mouse clicks: " + mouseClicks, width/2, height/2 + textSize * 8 - credits);
    text("Pointless clicks: " + pointlessClicks, width/2, height/2 + textSize * 16 - credits);
    text("Hint used: " + hintUsed, width/2, height/2 + textSize * 24 - credits);
    text("Extra cards used: " + extraCardsUsed, width/2, height/2 + textSize * 32 - credits);
    textSize(textSize);
    fill(0);
    rect(0, 0, width, height/4);
    rect(0, height/1.5, width, height/3);
    fill(255);
    credits += 2;
    delayCounter++;
  } else {
    credits = 0;
    delayCounter = 0;
    screenStatus = STARTSCREEN;
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void drawSettingScreen() {
  background(0);
  if (threePressed) {
    fill(50);
  }
  startButtonsNoHover(width/2, buttonHPlace, buttonWidth / 2, buttonHeight, "3");
  fill(255);
  if (!threePressed) {
    fill(50);
  }
  startButtonsNoHover((width/2) - (buttonWidth / 2), buttonHPlace, buttonWidth / 2, buttonHeight, "4");
  fill(255);
  if (multiplayer) {
    fill(50);
  }
  startButtonsNoHover(width/2 - ( buttonWidth / 4), buttonHPlace + (int(buttonHeight * 1.5)), buttonWidth / 2, buttonHeight, "multiplayer");
  if (buttonHover(width/2 - ( buttonWidth / 4), buttonHPlace + (int(buttonHeight * 1.5)), buttonWidth / 2, buttonHeight) && mousePressed) {
    multiplayer = !multiplayer;
  }
  fill(255);
  if (hints) {
    fill(50);
  }
  startButtonsNoHover(width/2 - ( buttonWidth / 4), buttonHPlace - (int(buttonHeight * 1.5)), buttonWidth / 2, buttonHeight, "Hints");
  if (buttonHover(width/2 - ( buttonWidth / 4), buttonHPlace - (int(buttonHeight * 1.5)), buttonWidth / 2, buttonHeight) && mousePressed) {  
    hints = !hints;
  }
  fill(255);
  if (buttonHover(width/2, buttonHPlace, buttonWidth, buttonHeight) && mousePressed) {
    threePressed = true;
    visibleCardsNumber = 9;
    propertiesAmount = 3;
  }
  if (buttonHover((width/2) - buttonWidth, buttonHPlace, buttonWidth, buttonHeight) && mousePressed) {
    threePressed = false;
    visibleCardsNumber = 12;
    propertiesAmount = 4;
  }
  if (buttonHover(buttonWPlace, int(height / 1.2), buttonWidth, buttonHeight) && mousePressed) {
    nonVisibleCardsNumber = visibleCardsNumber + 3;
    drawSpecificCard = new boolean[nonVisibleCardsNumber];
    amountCardsSelected = 0;
    playerScore1 = 0;
    playerScore2 = 0;
    screenChangedGame = true;
    clickedNoCard = false;
    clickedHint = false;
    cardsSelected = new boolean[nonVisibleCardsNumber];
    screenStatus = GAMESCREEN;
    setVisibleCards();
    setInvisibleCards();
    shuffleCards();
    mousePressed = false;
  }
  startButtons(buttonWPlace, int(height / 1.2), buttonWidth, buttonHeight, "Start Game");
}
