function love.load()
  math.randomseed(os.time())

  love.window.setMode(500, 600)

  windowWidth, windowHeight = love.window.getMode()

  bird = {}
  bird.size = 20
  bird.x = 150
  bird.y = 200
  bird.vy = 0
  bird.ay = 0.3

  bar = {}
  bar.sx = 500
  bar.vx = -2
  bar.width = 30

  bars = {}
  bars[1] = genNewBar()

  gameover = false
end

function love.update()
  if not gameover then
    bird.y = bird.y + bird.vy
    bird.vy = bird.vy + bird.ay
  
    for key, b in pairs(bars) do
      b.x = b.x + bar.vx
      if b.x + bar.width < 0 then
        table.remove(bars, key)
      end
  
      if circleRect(bird.x, bird.y, bird.size, b.x, 0, bar.width, b.upheight) or 
         circleRect(bird.x, bird.y, bird.size, b.x, windowHeight-b.downheight, bar.width, b.downheight) or
         bird.y + bird.size >= windowHeight or
         bird.y - bird.size <= 0
         then
        gameover = true
      end
      
      if b.x == 150 then
        table.insert(bars, genNewBar())
      end
    end
  end
end

function love.draw()
  if gameover then
    love.graphics.setBackgroundColor(153/255, 192/255, 255/255)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(love.graphics.newFont(30))
    love.graphics.print("GAMEOVER", windowWidth / 2 - 100, 250)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(love.graphics.newFont(20))
    love.graphics.print("Press Any Key", windowWidth / 2 - 80, 300)
  else
    love.graphics.setBackgroundColor(153/255, 192/255, 255/255)
  
    love.graphics.setColor(1, 1, 0)
    love.graphics.circle("fill", bird.x, bird.y, bird.size)
  
    love.graphics.setColor(77/255, 255/255, 85/255)
    for i=1, #bars do
      love.graphics.rectangle("fill", bars[i].x, 0, bar.width, bars[i].upheight)
      love.graphics.rectangle("fill", bars[i].x, windowHeight - bars[i].downheight, bar.width, bars[i].downheight)
    end
  end
end

function love.keypressed(key, scancode, isrepeat)
  if gameover then love.load() end
  if key == "space" then
    bird.vy = -7
  end
end

function genNewBar() 
  local newBar = {}
  newBar.x = bar.sx
  newBar.gap = math.random(150, 200)
  newBar.upheight = math.random(20, windowHeight - newBar.gap - 100)
  newBar.downheight = windowHeight - newBar.upheight - newBar.gap
  return newBar
end

function circleRect(cx, cy, size, rx, ry, rw, rh)
  local tx = cx
  local ty = cy

  if cx < rx then tx = rx
  elseif cx > rx+rw then tx = rx+rw
  end
  if(cy < ry) then ty = ry
  elseif(cy > ry+rh) then ty = ry+rh
  end

  local distX = cx - tx
  local distY = cy - ty
  local dist = math.sqrt(distX^2 + distY^2)

  if dist <= size then return true
  else return false
  end
end