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
<h1>Size %d</h1>
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
	if fp then
		print('', "Already solved")
		fp:close()
		return
	end

	-- Solve!
	
	local context = p.setup()
	solver.solve(context, 6)
	
	if context.solved then
		
		local fp = io.open(svg_path, "w")
		fp:write(draw.draw(context))
		fp:close()
		
		local fp = io.open(txt_path, "w")
		fp:write(solver.pretty_print(context))
		fp:close()
		
		print('', "Solved")
	else
		print('', "No solution")
	end	
end

local function run()
	for _,p in ipairs(problems) do
		treat_problem(p)
	end
end

run()