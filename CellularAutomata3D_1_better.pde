import peasy.test.*;
import peasy.org.apache.commons.math.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;
boolean go=true;
boolean shouldStop=true;
int cellSize=5;
PeasyCam camera;
static int matrixSize=50;//These statics are some dirty stuff just to make it work
static int neighbour = 3;
int fr = 10; //Frames

void setup(){
  size(400,400,P3D);
  camera = new PeasyCam(this, 500);
  camera.lookAt(125, 125, 0);
  CellMatrix.falseMatrix();
  CellMatrix.matrix[matrixSize/2][matrixSize/2][matrixSize/2]=1;
  frameRate(fr);
  lights();
  background(0);
}
void draw(){
background(0);frameRate(fr);
    for(int x = 0; x<CellMatrix.matrixX; x++){
        for(int y = 0; y<CellMatrix.matrixY; y++){
          for(int z = 0; z<CellMatrix.matrixZ; z++){
            if(CellMatrix.matrix[x][y][z]>0 && CellMatrix.matrix[x][y][z]<neighbour){
              pushMatrix();
              stroke(#000000,20);
              int maxnum = max(abs(matrixSize/2-x),abs(matrixSize/2-y),abs(matrixSize/2-z));
              fill(maxnum*10,maxnum*8,maxnum*10);
              translate(x*cellSize, y*cellSize, z*cellSize);
              box(cellSize);
              popMatrix();
            }
          }
        }
      }
  if(go){   
    CellMatrix.iterate();
    if (shouldStop)go=false;
  }
  
}

/**
*  This class sets the 3dimensional boolean matrix from which we obtain the information
*  regarding the position of the active cells.
*/
static class CellMatrix{
  public static int matrixX=matrixSize,matrixY=matrixSize,matrixZ=matrixSize;
  public static int[][][] matrix = new int[matrixX][matrixY][matrixZ];  
  public static int[][][] nextMatrix = new int[matrixX][matrixY][matrixZ]; 
  
  /**
  *  Sets every cell in the matrix to False
  */
  public static void falseMatrix(){
    for(int x = 0; x<matrixX; x++){
      for(int y = 0; y<matrixY; y++){
        for(int z = 0; z<matrixZ; z++){
          CellMatrix.matrix[x][y][z] = 0;
        }
      }
    }
  }
  
  /**
  *  Updates every cell
  */
  public static void iterate(){
    int counter;
    for(int x = 0; x<matrixX; x++){
      for(int y = 0; y<matrixY; y++){
        for(int z = 0; z<matrixZ; z++){//For each cell in the matrix
          if (CellMatrix.matrix[x][y][z]>0 && CellMatrix.matrix[x][y][z]<neighbour){//If it is active
            for(int i = -1; i<2; i++){
              for(int j = -1; j<2; j++){
                for(int k = -1; k<2; k++){//For each of it's neighbours 
                    
                  //Tell 'em he's active!
                    if(!(i==0 && j==0 && k==0)){//if the neighbour is not the cell
                    int newX=x,newY=y,newZ=z;//these new values are just to avoid indexOutOfRange errors
                      if(x+i==matrixX)newX=-1;
                      if(y+j==matrixY)newY=-1;
                      if(z+k==matrixZ)newZ=-1;
                      if(x+i==-1)newX=matrixX;
                      if(y+j==-1)newY=matrixY;
                      if(z+k==-1)newZ=matrixZ;
                      CellMatrix.nextMatrix[newX+i][newY+j][newZ+k]++; //++ it's "neighbours", that is it's value
                    }
                  
                }
              }
            }
          }

        }
      }
    }
    CellMatrix.matrix = CellMatrix.nextMatrix;//We update the real matrix with the nextMatrix
    CellMatrix.nextMatrix = new int[matrixX][matrixY][matrixZ]; //and reset the nextMatrix
  }
    
}







void keyPressed(){
if (key == 'p') {//PAUSE
  go=false;
  shouldStop=true;
  }
else if (key == 'g') {//GO!
  go=true;
  shouldStop=false;
  }
else if (key == 's') {//STEP
  go=true;
  shouldStop=true;
  }
  else if (key == 'r') {//RESET
    camera = new PeasyCam(this, 500);
    camera.lookAt(125, 125, 0);
    CellMatrix.falseMatrix();
  CellMatrix.matrix[matrixSize/2][matrixSize/2][matrixSize/2]=1;
  go=true;
  shouldStop=true;
  }
  
  else if (key == '1') {
   neighbour=2;
  }
  else if (key == '2') {
   neighbour=3;
  }
  else if (key == '3') {
   neighbour=4;
  }
  else if (key == '4') {
   neighbour=5;
  }
  else if (key == '5') {
   neighbour=6;
  }
  else if (key == '6') {
   neighbour=7;
  }
  else if (key == '7') {
   neighbour=8;
  }
  else if (key == '8') {
   neighbour=9;
  }
  else if (key == '9') {
   neighbour=10;
  }
  
  else if (key == '+') {
   fr++;
  }
  else if (key == '-') {
   if(fr>1)fr--;
  }
}
