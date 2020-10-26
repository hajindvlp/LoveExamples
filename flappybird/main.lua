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
end

function love.update()
  bird.y = bird.y + bird.vy
  bird.vy = bird.vy + bird.ay

  for key, b in pairs(bars) do
    b.x = b.x + bar.vx
    if b.x + bar.width < 0 then
      table.remove( bars, key )
    end
    
    if b.x == 100 then
      table.insert(bars, genNewBar())
      flag = true
    end
  end
end

function love.draw()
  love.graphics.setBackgroundColor(153/255, 192/255, 255/255)

  love.graphics.setColor(1, 1, 0)
  love.graphics.circle("fill", bird.x, bird.y, bird.size)

  love.graphics.setColor(77/255, 255/255, 85/255)
  for i=1, #bars do
    love.graphics.rectangle("fill", bars[i].x, 0, bar.width, bars[i].upheight)
    love.graphics.rectangle("fill", bars[i].x, windowHeight - bars[i].downheight, bar.width, bars[i].downheight)
  end
end

function love.keypressed(key, scancode, isrepeat)
  if key == "space" then
    bird.vy = -7
  end
end

function genNewBar() 
  local newBar = {}
  newBar.x = bar.sx
  newBar.gap = math.random(100, 150)
  newBar.upheight = math.random(20, windowHeight - newBar.gap - 100)
  newBar.downheight = windowHeight - newBar.upheight - newBar.gap
  return newBar
end