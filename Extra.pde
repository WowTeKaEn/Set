void multiplayer() {
  int playerNumber;
  rect(0, height - buttonY, buttonX, buttonY);
  startButtons(width - buttonX, height - buttonY, buttonX, buttonY, "Next player");
  if (buttonHover(width - buttonX, height - buttonY, buttonX, buttonY) && mousePressed) {
    clickedHint = false;
    amountCardsSelected = 0;
    cardsSelected = new boolean[nonVisibleCardsNumber];
    player = !player;
  }
  if (player) {
    playerNumber = 1;
  } else {
    playerNumber = 2;
  }
  fill(0);
  textSize(textSize * 2);
  text("Player: " + playerNumber, buttonX / 2, height - buttonY + textSize * 2.1);
  textSize(textSize * 1.2);
  text("Player 1 Score: " + playerScore1, buttonX / 2, height - buttonY + textSize * 4);
  text("Player 2 Score: " + playerScore2, buttonX / 2, height - buttonY + textSize * 6);
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void addScore(int scoreChange) {
  if (player) {
    playerScore1 += scoreChange;
  }
  if (!player) {
    playerScore2 += scoreChange;
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void extraCardsButton() {
  if (clickedNoCard) {
    pointlessClicks++;
  }
  if (!drawSpecificCard[cardsOnTable.length - 1] && !drawSpecificCard[cardsOnTable.length - 2] && !drawSpecificCard[cardsOnTable.length - 3]) {
    clickedNoCard = false;
  }
  fill(155); 
  if (!clickedNoCard && (invisibleCards.length - nInvisibleCards) > 0) {
    extraCardsUsed++;
    if (!multiplayer) {
      score--;
    } else {
      addScore(-1);
    }
    for (int i = 1; i <= 3; i++) {
      drawSpecificCard[cardsOnTable.length - i] = true;
    }
    clickedNoCard = true;
    visibleCardsNumber = nonVisibleCardsNumber;
    String[][] cardsOnTableTransfer = new String[visibleCardsNumber][invisibleCards[0].length];
    cardsOnTableTransfer = cardsOnTable;
    cardsOnTable = new String[nonVisibleCardsNumber][invisibleCards[0].length];
    for (int i = 0; i < cardsOnTable.length - 3; i++) {
      cardsOnTable[i] = cardsOnTableTransfer[i];
    }
    for (int i = 0; i < 3; i++) {
      cardsOnTable[cardsOnTable.length - i - 1] = shuffledCards[nInvisibleCards];
      nInvisibleCards++;
    }
    checkAllCards();
    println("cards in deck = " + (invisibleCards.length - nInvisibleCards));
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void hintButton() {
  if (clickedHint) {
    pointlessClicks++;
  }
  if (!clickedHint) {
    hintUsed++;
    if (!multiplayer) {
      score--;
    } else {
      addScore(-1);
    }
    clickedHint = true; 
    for (int i = 0; i < cardsOnTable.length; i++) {
      if (hintArray[0] == cardsOnTable[i]) {
        cardsSelected[i] = true;
        amountCardsSelected++;
      }
      if (hintArray[1] == cardsOnTable[i]) {
        cardsSelected[i] = true;
        amountCardsSelected++;
      }
    }
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void checkAllCards() {
  sets = 0;
  String card[][] = new String[3][invisibleCards[0].length];
  for (int i = 0; i < cardsOnTable.length; i++) {
    for (int j = i; j < cardsOnTable.length; j++) {
      for (int k = j; k < cardsOnTable.length; k++) {
        if (!(j == i && j == k)) {
          if (drawSpecificCard[i]) {
            card[0] = cardsOnTable[i];
          } else {
            continue;
          }
          if (drawSpecificCard[j]) {
            card[1] = cardsOnTable[j];
          } else {
            continue;
          }
          if (drawSpecificCard[k]) {
            card[2] = cardsOnTable[k];
          } else {
            continue;
          }
          if (checkCards(card)) {
            sets++;
            hintArray[0] = card[0];
            hintArray[1] = card[1];
          }
        }
      }
    }
  }
}
