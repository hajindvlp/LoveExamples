function love.load()
  windowWidth, windowHeight = love.window.getMode()

  click = {}
  click.x = nil
  click.y = nil

  player = {}
  player.x = windowWidth/2
  player.y = windowHeight/2;
  player.r = 10
  player.vx = 0
  player.vy = 0
  player.power = 3
end

function love.update()
  
  if dist(player.x, player.y, click.x, click.y) <= player.power / 2 then 
    player.vx = 0
    player.vy = 0
  end

  player.x = player.x + player.vx;
  player.y = player.y + player.vy;

end

function love.draw()
  love.graphics.setColor(1, 1, 1)
  love.graphics.circle("fill", player.x, player.y, player.r)

  love.graphics.setColor(1, 0, 0)
  love.graphics.circle("fill", click.x, click.y, 4)
end

function love.mousepressed(x, y, button, istouch, presses)
  click.x = x
  click.y = y
  
  local angle = getAngle(click.x, click.y, player.x, player.y)
  player.vx = -player.power * math.sin(angle)
  player.vy = -player.power * math.cos(angle)
end

function getAngle(sx, sy, ex, ey)
  return math.atan2(ex-sx, ey-sy)
end

function dist(x1, y1, x2, y2) 
  return math.sqrt((x1-x2)^2 + (y1-y2)^2)
end