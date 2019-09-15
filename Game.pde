void drawButtons() {
  if (hints) {
    if (buttonHover(width/2 -  buttonX, height - buttonY, buttonX, buttonY) && mousePressed) {
      extraCardsButton();
    }
    if (buttonHover(width/2, height - buttonY, buttonX, buttonY) && mousePressed) {
      hintButton();
    }
    if (buttonHover(width/2 + buttonX, height - buttonY, buttonX, buttonY) && mousePressed) {
      startUp = true;
      screenStatus = ENDGAME;
    }
    stroke(0);
    fill(255);
    rectMode(CORNER);
    rect(width/2 -  (buttonX * 2), height - buttonY, buttonX, buttonY);
    textAlign(CENTER);
    fill(0);
    textSize(textSize * 1.2);
    text("Amount of cards in deck:", width/2 -  (buttonX * 1.5), height - buttonY + textSize * 2);
    text(invisibleCards.length - nInvisibleCards, width/2 -  (buttonX * 1.5), height - buttonY + textSize * 3.5);
    text("Sets on table:", width/2 -  (buttonX * 1.5), height - buttonY + textSize * 5.5);
    text(sets, width/2 -  (buttonX * 1.5), height - buttonY + textSize * 7);
    fill(255);
    startButtons(width/2 -  buttonX, height - buttonY, buttonX, buttonY, "No set visible");
    startButtons(width/2, height - buttonY, buttonX, buttonY, "Hint");
    startButtons(width/2 + buttonX, height - buttonY, buttonX, buttonY, "End game");
    textSize(textSize);
  } else {
    rectMode(CORNER);
    textAlign(CENTER);
    startButtons(width/2 - (buttonX / 2), height - buttonY, buttonX, buttonY, "End game");
    if (buttonHover(width/2 - (buttonX / 2), height - buttonY, buttonX, buttonY) && mousePressed) {
      startUp = true;
      screenStatus = ENDGAME;
    }
  }
  if (multiplayer) {
    multiplayer();
  }
  textSize(textSize);
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void isSetTrue() {
  if (isSet) {
    if (!multiplayer) {
      score++;
    } else {
      addScore(1);
    }
    isSet = false;
    amountCardsSelected = 0;
    clickedHint = false;

    for (int m = 0; m < 3; m++) {
      if (nInvisibleCards < invisibleCards.length) {
        if (clickedNoCard && (isSelectedArray() == (cardsOnTable.length- 1) || isSelectedArray() == (cardsOnTable.length - 2) || isSelectedArray() == (cardsOnTable.length - 3))) {
          drawSpecificCard[isSelectedArray()] = false;
          nInvisibleCards--;
          checkAllCards();
        } else
          cardsOnTable[isSelectedArray()] = shuffledCards[nInvisibleCards];
        checkAllCards();
        nInvisibleCards++;
      } else {
        drawSpecificCard[isSelectedArray()] = false;
        checkAllCards();
      }
      cardsSelected[isSelectedArray()] = false;
    }
    println("cards in deck = " + (invisibleCards.length - nInvisibleCards));
    println(nInvisibleCards);
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void visibleCards() {
  for (int i = 0; i < cardsOnTable.length; i++) {
    cardsOnTable[i] = shuffledCards[i];
    nInvisibleCards++;
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------

int isSelectedArray() {
  int returnSelected = 0;
  for (int i = 0; i < cardsSelected.length; i++) {
    if (cardsSelected[i]) {
      returnSelected = i;
    }
  }
  return returnSelected;
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void cardSelecting(int i, int xSize, int ySize) {
  if (buttonHover(cardPosition[i][0], cardPosition[i][1], xSize, ySize) && mousePressed) {

    if (cardsSelected[i] && drawSpecificCard[i]) {
      cardsSelected[i] = false;
      amountCardsSelected--;
    } else if (!cardsSelected[i]) {
      cardsSelected[i] = true;
      amountCardsSelected++;
      if (amountCardsSelected >= 4) {
        cardsSelected[i] = false;
        amountCardsSelected--;
      }
    }
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void drawAllCards() {

  int xSize = cardWidth;
  int ySize = cardHeight;
  for (int i = 0; i < cardsOnTable.length; i++) {
    cardSelecting(i, xSize, ySize);
    if (amountCardsSelected == 3) {
      int counter = 0;
      String card[][] = new String[3][invisibleCards[0].length];
      for (int j = 0; j < cardsSelected.length; j++) {
        if (cardsSelected[j]) {
          card[counter] = cardsOnTable[j]; 
          counter++;
        }
      }
      if (checkCards(card)) {
        isSet = true;
      } else if (multiplayer) {
        amountCardsSelected = 4;
        cardsSelected = new boolean[nonVisibleCardsNumber];
      }
    }
    if (cardsSelected[i] && drawSpecificCard[i]) {
      fill(255);
    } else {
      fill(0);
    }
    isSetTrue();
    if (sets == 0 && (invisibleCards.length - nInvisibleCards == 0)) {
      stopGame = true;
    }
    if (drawSpecificCard[i]) {
      drawCards(cardPosition[i][0], cardPosition[i][1], xSize, ySize, cardsOnTable[i]);
    }
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------

boolean checkCards(String[][] checkArray) {
  for (int i = 0; i < checkArray[0].length; i++) {
    if (!(checkArray[0][i] == checkArray[1][i] && checkArray[0][i] == checkArray[2][i] && checkArray[1][i] == checkArray[2][i])
      && !(checkArray[0][i] != checkArray[1][i] && checkArray[0][i] != checkArray[2][i] && checkArray[1][i] != checkArray[2][i])) {
      return false;
    }
  }
  return true;
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void drawCards(int x, int y, int xSize, int ySize, String[] counter) {
  int drawAmount = 0;
  int placingX = x + (cardWidth / 2);
  int placingY = y + (cardHeight / 2);
  int triangleY = y + (cardHeight / 2) + 15;
  int[] colour = new int[3];
  int colour2 = 0;
  stroke(255);
  rectMode(CORNER);
  rect(x, y, xSize, ySize);
  rectMode(CENTER);

  if (counter[0] == "r") {
    stroke(255, 0, 0);
    colour[0] = 255;
    colour2 = #FFD3D3;
  } else if (counter[0] == "g") {
    stroke(0, 255, 0);
    colour[1] = 255;
    colour2 = #D8FFD3;
  } else if (counter[0] == "b") {
    colour[2] = 255;
    colour2 = #D3DDFF;
    stroke(0, 0, 255);
  }

  if (counter[1] == "1") {
    drawAmount = 1;
  }
  if (counter[1] == "2") {
    drawAmount = 2;
  }
  if (counter[1] == "3") {
    drawAmount = 3;
  } 

  if (propertiesAmount == 4) {
    if (counter[3] == "c") {
      fill(colour[0], colour[1], colour[2]);
    }
    if (counter[3] == "h") {
      fill(colour2);
    }
  }

  if (counter[2] == "e") {
    if (drawAmount == 1 || drawAmount == 3) {
      ellipse(placingX, placingY, symbolSize, symbolSize);
    }
    if (drawAmount == 3) {
      ellipse(placingX, placingY - threeOffset, symbolSize, symbolSize);
      ellipse(placingX, placingY + threeOffset, symbolSize, symbolSize);
    }
    if (drawAmount == 2) {
      ellipse(placingX, placingY - twoOffset, symbolSize, symbolSize);
      ellipse(placingX, placingY + twoOffset, symbolSize, symbolSize);
    }
  }

  if (counter[2] == "v") {
    if (drawAmount == 1 || drawAmount == 3) {
      rect(placingX, placingY, symbolSize, symbolSize);
    }
    if (drawAmount == 3) {
      rect(placingX, placingY - threeOffset, symbolSize, symbolSize);
      rect(placingX, placingY + threeOffset, symbolSize, symbolSize);
    }
    if (drawAmount == 2) {
      rect(placingX, placingY - twoOffset, symbolSize, symbolSize);
      rect(placingX, placingY + twoOffset, symbolSize, symbolSize);
    }
  }

  if (counter[2] == "d") {
    if (drawAmount == 1 || drawAmount == 3) {

      triangle(placingX, triangleY, placingX - symbolSize, triangleY - symbolSize, placingX + symbolSize, triangleY - symbolSize);
    }
    if (drawAmount == 2) {
      triangle(placingX, triangleY - twoOffset, placingX - symbolSize, triangleY - symbolSize - twoOffset, placingX + symbolSize, triangleY - symbolSize - twoOffset);
      triangle(placingX, triangleY + twoOffset, placingX - symbolSize, triangleY - symbolSize + twoOffset, placingX + symbolSize, triangleY - symbolSize + twoOffset);
    }
    if (drawAmount == 3) {
      triangle(placingX, triangleY - threeOffset, placingX - symbolSize, triangleY - symbolSize - threeOffset, placingX + symbolSize, triangleY - symbolSize - threeOffset);
      triangle(placingX, triangleY + threeOffset, placingX - symbolSize, triangleY - symbolSize + threeOffset, placingX + symbolSize, triangleY - symbolSize + threeOffset);
    }
  }
  fill(255);
  stroke(0);
}
