// Game values
final int fpsGoal = 60; // bestemmer hvor mange fps spillet viser
final int gameSpeed = 12; // bestemmer hvor mange opdateringer af slangens bevægelse der er per sekund - her 5

// Game size - definerer størrelsen af spillebanen
final byte blockSize = 30;

// Constants - ting, som ikke ændres. final betyder, at variablen ikke kan ændres i programmet.
// Colors
final int[] backColor = {255, 255, 255};
final int[] fillColor = {0, 120, 0};

// Variables
int[] headPos = {0, 0};

char direction = 'n';
char oldDirection = 'n';
boolean gameOver = false; // en boolean variabel, som er true, når slangen er død

// setup til canvas størrelse, framerate og startende setup til spillet
void setup(){
  size(1800, 900);
  frameRate(fpsGoal);
  gameReset();
}

// Draw
void draw(){
  // New frame - laver ny frame
  clearScreen(backColor, fillColor);
  
  // Indtegner slangen med dens position
  rect(headPos[0], headPos[1], blockSize, blockSize);
  
  // Denne kontrolstruktur opdaterer slangens position, når der er gået 12 frames, og slangen ikke er død
  if(frameCount % gameSpeed == 0 && gameOver == false){
    moveUpdate();
    // Denne if-statement tjekker, om slangen skal være død, hvis den er stopper spillet
    if(headPos[0] < 0 || headPos[0] > width || headPos[1] < 0 || headPos[1] > height){
      gameOver = true;
    }
  }
  // Denne funktion udskriver udvalgte data - den er ikke aktiv her
  //showData();
}

// Event functions
void keyPressed(){
    // Switch statement, som sætter direction til samme knap som key, altså det indtastede, hvis knappen ikke er omvendt af forrige knap/retning, f.eks. a og d.
    switch(key){
    case 'w':
      if(oldDirection != 's'){
        direction = 'w';
      }
      break;
    case 's':
      if(oldDirection != 'w'){
        direction = 's';
      }
      break;
    case 'a':
      if(oldDirection != 'd'){
        direction = 'a';
      }
      break;
    case 'd':
      if(oldDirection != 'a'){
        direction = 'd';
      }
      break;
    }
  // Tjekker om slangen er død og giver muligheden for at trykke p for at genstarte spillet
    if(gameOver == true && key == 'p'){
    gameReset();
  }
}

// Move snake - funktion som bevæger slangen
void moveUpdate(){
  oldDirection = direction; // gemmer forrige retning, så man ikke kan gå den retning igen, du ved, for ikke at gå ind i sig selv.
  // Switch, som bevæger slangen, alt efter retning af slangen
  switch(direction){
    case 'w':
      headPos[1] -= blockSize;
      break;
    case 's':
      headPos[1] += blockSize;
      break;
    case 'a':
      headPos[0] -= blockSize;
      break;
    case 'd':
      headPos[0] += blockSize;
      break;
  }
}

// Functions
// Game reset funktion
void gameReset(){
  gameOver = false;
  direction = 'n';
  oldDirection = 'n';
  headPos[0] = width/2;
  headPos[1] = height/2;
}
// Optegner spilleområdet. Den bliver kaldt hver gang i starten af en ny frame.
void clearScreen(int[] backColor, int[] fillColor){
  background(backColor[0], backColor[1], backColor[2]);
  fill(fillColor[0], fillColor[1], fillColor[2]);
  for(int i = 0; i < width; i += blockSize){
    line(i, 0, i, height);
  }
  for(int i = 0; i < height; i += blockSize){
    line(0, i, width, i);
  }
}

// Funktion, som bruges til at debugge og vise værdier i spillet
void showData(){
  textSize(12);
  text(str(headPos[0]), 12, 12);
  text(str(headPos[1]), 12, 12 * 2);
  text("key: " + str(key), 12, 12 * 3);
  text("direction: " + str(direction), 12, 12 * 4);
}
