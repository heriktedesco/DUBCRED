imagemagick = "convert -background black -fill white -font ./font.ttf -size 1920x1080 -pointsize 32 -gravity center label:\"%s\" %s.jpg"
salta_cabecalho = 1

f = require "gen-funcs"
file = io.open(arg[1], "r")

for line in file:lines() do
  r = f.parse_csv_line(line)
  if salta_cabecalho < 2 then
    salta_cabecalho = salta_cabecalho + 1
  else
    cartela = "VERSÃO BRASILEIRA\n\n"
  	cartela = cartela..f.form2("Título Original", r[1], 80).."\n"
  	cartela = cartela..f.form2("Estúdio de Dublagem", r[2], 80).."\n"
  	cartela = cartela..f.form2("Tradutor", r[3], 80).."\n"
  	cartela = cartela..f.form2("Diretor de Dublagem", r[4], 80).."\n"
  	cartela = cartela..f.form2("Mixagem final", r[5], 80).."\n\n"
    i = 6
    cartela = cartela.."Vozes\n\n"
    repeat
      cartela = cartela..f.form2(r[i], r[i+1], 80).."\n"
      i = i + 2
    until r[i+1] == nil or r[i+1] == "" or r[i+1] == " "
    arquivo_destino = (r[1]):gsub(" ", "\\ ")

    os.execute(string.format(imagemagick, cartela, arquivo_destino))
  end
end
