function love.load()
  math.randomseed(os.time())
  windowWidth, windowHeight = love.window.getMode()

  click = {}
  click.x = nil
  click.y = nil

  player = {}
  player.size = 20
  player.power = 3

  players = {}
  for i=1, 10 do
    addNewPlayer()
  end

  click = {}
  click.s = {}
  click.s.x = 0
  click.s.y = 0
  click.e = {}
  click.e.x = 0
  click.e.y = 0
  click.drag = false
end

function love.update()
end

function love.draw()
  for i=1, #players do
    if (
        click.drag and 
        insideBox(
         players[i].x, players[i].y, 
         click.s.x + player.size, click.s.y + player.size, 
         love.mouse.getX()-click.s.x - player.size, love.mouse.getY() - click.s.y - player.size
        )
       ) or (
         click.drag == false and
         insideBox(
          players[i].x, players[i].y,
          click.s.x + player.size, click.s.y + player.size, 
          click.e.x-click.s.x-player.size, click.e.y-click.s.y-player.size
         )
       ) then
      love.graphics.setColor(1, 1, 0)
    else
      love.graphics.setColor(1, 1, 1)
    end
    
    love.graphics.circle("fill", players[i].x, players[i].y, player.size)
  end

  love.graphics.setColor(1, 1, 0, 0.3)
  if click.drag then
    love.graphics.rectangle("fill", click.s.x, click.s.y, love.mouse.getX()-click.s.x, love.mouse.getY()-click.s.y)
  else
    love.graphics.rectangle("fill", click.s.x, click.s.y, click.e.x-click.s.x, click.e.y-click.s.y)
  end
end

function love.mousepressed(x, y, button, istouch, presses)
  click.drag = true
  click.s.x = x
  click.s.y = y
end

function love.mousereleased(x, y, button, istouch, presses)
  click.drag = false
  click.e.x = x
  click.e.y = y
end

function addNewPlayer()
  table.insert(players, {
    x = math.random(player.size, windowWidth-player.size),
    y = math.random(player.size, windowWidth-player.size),
    vx = 0,
    vy = 0
  });
end

function insideBox(x, y, sx, sy, w, h)
  if sx+w < sx then
    sx = sx+w
    w = -w
  end
  if sy+h < sy then
    sy = sy+h
    h = -h
  end

  if sx <= x and x <= sx + w and sy <= y and y <= sy + h then
    return true
  else
    return false
  end
end