pulseX = 0 --Memory Location 0x0713
pulseY = 0 --Memory Location 0x070C
pulseTrig = 0 --Memory Location 0x0712
playerX = 0 --Memory Location 0x070F

ButtonNames = {
    'A',
    'B',
    'Left',
    'Right'
}
red = 0xFFFF0000
green = 0xFF00FF00
blue = 0xFF0000FF

boxEdge = 100
nesHeight = 240
nesWidth = 255
pulsePos = {}
-------------Getters--------------------
function getPosition()
    x =  mainmemory.readbyte(0x070F);
    
end
function isPulseDead()
   pulseTrig = mainmemory.readbyte(0x0712);
   return pulseTrig
end
function GetPulsePos()
    pulseX = mainmemory.readbyte(0x0713)
    pulseY = mainmemory.readbyte(0x0710)
    pulsePos[0] = math.floor(pulseX)
    pulsePos[1] = math.floor(pulseY)
    return pos
end
function GetPlayerX()
    playerX = mainmemory.readbyte(0x070F)
    return math.floor(playerX)
end

function GetPlayerY()
    return math.floor(mainmemory.readbyte(0x070C))
end
--------------Getters--------------------

--------------Cell Fns-------------------
for i = 1, boxEdge do
    cells[i] = {}
    for j = 1,boxEdge do
        cells[i][j] = 0
    end
end

function clearCells()
    for i = 1, boxEdge do
        for j = 1, boxEdge do
            cells[i][j] = 0
            print("hit")
        end
    end

end

function LoadCells()
    clearCells()
    if(isPulseDead() == 0) then
        pos = GetPulsePos()
        cells[toCellX(pulsePos[0])][toCellY(pulsePos[1])] = 3
    end
    x = toCellX(GetPlayerX())
    y = toCellY(GetPlayerY())
    print(tostring(y))
    cells[x][y] = 1
    
end

function toCellX(pos)
    return pos*boxEdge/nesWidth
end

function toCellY(pos)
    return pos*boxEdge/nesHeight
end


function WillDrawShit()
     gui.drawRectangle(0,0,100,100,0x33FFFFFF,0x33FFFFFF)
     for i = 1, boxEdge do
        for j = 1, boxEdge do 
            if(cells[i][j]== 3) then
                gui.drawBox(i,j,i+1,j+1,red,red)
            end
        end
    end


     x = toCellX(GetPlayerX())
     y = toCellY(GetPlayerY())
     
     gui.drawBox(x,y,x+1,y+1,red,blue)
end
--------------Cell Fns-------------------


-------------Game Loop------------------
while true do
    LoadCells()
    WillDrawShit()
    emu.frameadvance()
end
------------Game Loop------------------