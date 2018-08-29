function notilde(str)
  x = 0
  sum = function() x = x + 1 end
	for _ in string.gmatch(str, '%W') do
    if _ ~= " " then sum() end
  end
  return x // 2
end

local _ = {}
	function _.parse_csv_line(line,sep)
		local res = {}
		local pos = 1
		sep = sep or ','
		while true do
			local c = string.sub(line,pos,pos)
			if (c == "") then break end
			if (c == '"') then
				local txt = ""
				repeat
					local startp,endp = string.find(line,'^%b""',pos)
					txt = txt..string.sub(line,startp+1,endp-1)
					pos = endp + 1
					c = string.sub(line,pos,pos)
					if (c == '"') then txt = txt..'"' end
				until (c ~= '"')
				table.insert(res,txt)
				assert(c == sep or c == "")
				pos = pos + 1
			else
				local startp,endp = string.find(line,sep,pos)
				if (startp) then
					table.insert(res,string.sub(line,pos,startp-1))
					pos = endp + 1
				else
					table.insert(res,string.sub(line,pos))
					break
				end
			end
		end
		return res
	end

	function _.form2(campo1, campo2, col)
	  str_final = ""
	  def_lado = function (campo, col, lado)
			if campo:sub(1,1) == " " then campo = campo:sub(2) end
			if campo:sub(-1,-1) == " " then campo = campo:sub(1,-2) end
	  	stop = string.len(campo) - notilde(campo)
	    for i=0, col / 2  do
	      if i > stop then
	        if lado == "E" then
	          campo = " "..campo
	        else
	          campo = campo.." "
	        end
				end
	    end
	    return campo
	  end
	  campo1 = def_lado(campo1, col, "E")
	  campo2 = def_lado(campo2, col, "D")
	  return campo1.."   "..campo2
	end
	return _
