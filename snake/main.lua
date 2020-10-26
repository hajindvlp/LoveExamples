function love.load() 
  math.randomseed(os.time())

  padding = 3
  time = 0
  dy = {0, 1, 0, -1}
  dx = {1, 0, -1, 0}

  gridSize = 20
  gridWidth, gridHeight = love.window.getMode()
  gridWidth = gridWidth / gridSize
  gridHeight = gridHeight / gridSize

  snake = {}
  snake.length = 1
  snake.body = {}
  snake.body[1] = {}
  snake.body[1].x = math.random(0, gridWidth-1)
  snake.body[1].y = math.random(0, gridHeight-1)
  snake.vx = 1
  snake.vy = 0
  
  apple = {}
  apple.x = math.random(0, gridWidth-1)
  apple.y = math.random(0, gridHeight-1)

  score = 0
  gameover = false

  biggerFont = love.graphics.newFont(30)
end

function love.update(dt)
  time = time + dt
  if(time > 0.3) then
    time = 0

    for i=#snake.body, 2, -1 do
      snake.body[i].x = snake.body[i-1].x
      snake.body[i].y = snake.body[i-1].y
    end
    snake.body[1].x = snake.body[1].x + snake.vx 
    snake.body[1].y = snake.body[1].y + snake.vy
  
    if snake.body[1].x == apple.x and snake.body[1].y == apple.y then
      score = score + 1  
      table.insert(snake.body, {
        x = apple.x,
        y = apple.y
      })
      apple.x = math.random(0, gridWidth-1)
      apple.y = math.random(0, gridHeight-1)
    else
      isTouch = false
      for i=2, #snake.body, 1 do
        if snake.body[i].x == snake.body[1].x and snake.body[i].y == snake.body[1].y then 
          isTouch = true
        end
      end

      if isTouch then
        gameover = true
      end
    end

  end
end

function love.draw()
  if not gameover then
    love.graphics.setColor(1, 1, 1)
    love.graphics.setFont(biggerFont)
    love.graphics.print("Score : " .. score)
  
    love.graphics.setColor(1, 1, 1)
    for i=1, #snake.body do
      love.graphics.rectangle("fill", snake.body[i].x * gridSize + padding, snake.body[i].y * gridSize + padding, gridSize - padding, gridSize - padding)
    end
  
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", apple.x * gridSize + padding, apple.y * gridSize + padding, gridSize - padding, gridSize - padding)
  else 
    love.graphics.setColor(0, 0, 1)
    love.graphics.setFont(biggerFont)
    love.graphics.print("Game Over", 100, 100)
    love.graphics.print("Press Any Key to Restart", 100, 140)
  end
end

function love.keypressed(key)
  if not gameover then
    if key == 'right' then
      snake.vx = dx[1]
      snake.vy = dy[1]
    end
    if key == 'down' then
      snake.vx = dx[2]
      snake.vy = dy[2]
    end
    if key == 'left' then
      snake.vx = dx[3]
      snake.vy = dy[3]
    end
    if key == 'up' then
      snake.vx = dx[4]
      snake.vy = dy[4]
    end
  else
    love.load()
  end
end
