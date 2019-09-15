//Important for changing screens
boolean screenChangedGame, startUp = true;
int screenStatus;
final int STARTSCREEN = 0, SETTINGSCREEN = 1, GAMESCREEN = 2, ENDGAME = 3;

//Important for cards
int visibleCardsNumber, nonVisibleCardsNumber, cardPosition[][], nInvisibleCards;
String[][] cardsOnTable, invisibleCards, shuffledCards;
boolean[] cardsSelected, drawSpecificCard;

//Important for sets
boolean isSet;
int propertiesAmount, sets, amountCardsSelected;

//Important for ending screen or score
int credits, pointlessClicks, mouseClicks, score, playerScore1, playerScore2, hintUsed, extraCardsUsed, delayCounter;

//Important for settings screen
boolean multiplayer, hints = true, stopGame = false, player = true, threePressed = true;

//Important for extras
boolean clickedNoCard = false, clickedHint = false;
String hintArray[][] = new String[2][propertiesAmount];

//Important for drawing
int textSize = 12, buttonX = 200, buttonY = 100, margin = 50, symbolSize = 30, twoOffset = 20, threeOffset = 40, cardHeight = 200, cardWidth = 120;
int buttonHeight = 100, buttonWidth = buttonHeight * 2, buttonMargin = buttonHeight / 2, buttonHPlace, buttonWPlace;

//---------------------------------------------------------------------------------------------------------------------------------------------

void setup() {
  smooth();
  size(1200, 900);
  //fullScreen();
  textSize(textSize);
  buttonHPlace = height/3 - (buttonHeight / 2);
  buttonWPlace = width/2 - (buttonWidth / 2);
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void draw() {
  switch(screenStatus) {
  case STARTSCREEN:
    drawStartScreen();
    break;
  case GAMESCREEN:
    drawGameScreen();
    break;
  case SETTINGSCREEN:
    drawSettingScreen();
    break;
  case ENDGAME:
    drawEndGame();
    break;
  default:
    drawStartScreen();
    break;
  }
  if (mousePressed) {
    mouseClicks++;
  }
  mousePressed = false;
  fill(255);
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void startButtonsNoHover(int x, int y, int xSize, int ySize, String text) {
  rect(x, y, xSize, ySize);
  textAlign(CENTER);
  fill(0);
  text(text, x + (xSize / 2), y + (ySize / 2) + (textSize / 2));
  fill(255);
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void setVisibleCards() {
  int countPosition = 0;
  cardsOnTable = new String[visibleCardsNumber][invisibleCards[0].length];
  cardPosition =  new int[nonVisibleCardsNumber][2];
  for (int a = 0; a < nonVisibleCardsNumber / 3; a++) {
    for (int b = 0; b < 3; b++) {
      cardPosition[countPosition][0] = (margin * (a + 1)) + (cardWidth * a);
      cardPosition[countPosition][1] = (margin * (b + 1)) + (cardHeight * b);
      countPosition++;
    }
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void shuffleCards() {
  shuffledCards = new String[invisibleCards.length][invisibleCards[0].length];
  int counterDeck = 0;
  boolean notFullDeck = true;
  while (notFullDeck) {
    int random = int(random(invisibleCards.length));
    boolean notDuplicate = true;
    for (int j = 0; j < invisibleCards.length; j++) {
      if (invisibleCards[random] == shuffledCards[j]) {
        notDuplicate = false;
      }
    }
    if (notDuplicate) {
      shuffledCards[counterDeck] = invisibleCards[random];
      counterDeck++;
    }
    if (counterDeck == invisibleCards.length) {
      notFullDeck = false;
    }
  }
}

//---------------------------------------------------------------------------------------------------------------------------------------------

boolean buttonHover(int x, int y, int xSize, int ySize) {
  return mouseX > x &&
    mouseX < x + xSize &&
    mouseY > y &&
    mouseY < y + ySize;
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void startButtons(int x, int y, int xSize, int ySize, String text) {
  if (buttonHover(x, y, xSize, ySize)) {
    fill(155);
  }
  rect(x, y, xSize, ySize);
  textAlign(CENTER);
  fill(0);
  text(text, x + (xSize / 2), y + (ySize / 2) + (textSize / 2));
  fill(255);
}

//---------------------------------------------------------------------------------------------------------------------------------------------

void setInvisibleCards() {
  int counter;
  invisibleCards = new String[int(pow(3, propertiesAmount))][propertiesAmount];
  counter = 0;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      for (int k = 0; k < 3; k++) {
        if (i == 0) {
          invisibleCards[counter][0] = "r";
        }
        if (i == 1) {
          invisibleCards[counter][0] = "b";
        }
        if (i == 2) {
          invisibleCards[counter][0] = "g";
        }
        if (j == 0) {
          invisibleCards[counter][1] = "1";
        }
        if (j == 1) {
          invisibleCards[counter][1] = "2";
        }
        if (j == 2) {
          
          invisibleCards[counter][1] = "3";
        }
        if (k == 0) {
          invisibleCards[counter][2] = "e";
        }
        if (k == 1) {
          invisibleCards[counter][2] = "v";
        }
        if (k == 2) {
          invisibleCards[counter][2] = "d";
        }
        if (propertiesAmount == 4) {
          invisibleCards[counter][3] = "c";
          invisibleCards[counter + 27][3] = "h";
          invisibleCards[counter + 54][3] = "n";
        }
        counter++;
      }
    }
  }  
  counter = 0;
  if (propertiesAmount == 4) {
    for (int l = 0; l < 27; l++) {
      for (int m = 0; m < 3; m++) {
        invisibleCards[l + 54][m] = invisibleCards[l][m];
        invisibleCards[l + 27][m] = invisibleCards[l][m];
      }
    }
  }
}
