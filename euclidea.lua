local problems = require "problems"
local solver = require "solver"
local draw = require "draw"

local html_header = [[
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>%s</title>
</head>
<body>
]]

local html_title = [[
<h1>%s</h1>
]]

local html_footer = [[
</body>
</html>
]]

local output_dir = "solutions"

local function treat_problem(p)
	
	print(p.name)

	local svg_path = output_dir .. "/" .. p.code .. ".svg"
	local txt_path = output_dir .. "/" .. p.code .. ".txt"

	-- Check existing
	local fp = io.open(svg_path, "r")
	local fp2 = io.open(txt_path, "r")
	if fp and fp2 then
		
		print('', "Already solved")
		
		local svg = fp:read("*a")
		fp:close()
		
		local txt = fp2:read("*a")
		fp2:close()
		
		return svg, txt
	end

	-- Solve!
	
	local context = p.setup()
	solver.solve(context, 6)
	
	if context.solved then
		
		local svg = draw.draw(context)
		local txt = solver.pretty_print(context)
		
		local fp = io.open(svg_path, "w")
		fp:write(svg)
		fp:close()
		
		local fp = io.open(txt_path, "w")
		fp:write(txt)
		fp:close()
		
		print('', "Solved")
		return svg, txt
	else
		print('', "No solution")
	end	
end

local function run()
	
	local res = {}
	table.insert(res, string.format(html_header, "Euclidea Solutions"))
	
	for _,p in ipairs(problems) do
		local svg, txt = treat_problem(p)
		
		if svg and txt then
			table.insert(res, string.format(html_title, p.name))
			table.insert(res, svg)
			
			local corrected_text = "<p>" .. txt:gsub("\n", "<br />") .. "</p>"
			table.insert(res, corrected_text)
		end
	end
	
	table.insert(res, html_footer)
	
	local fp = io.open(output_dir .. "/solutions.html", "w")
	fp:write(table.concat(res, '\n'))
	fp:close()
end

run()