local svg_inline_header = '<svg width="%d" height="%d" viewBox="%.2f %.2f %.2f %.2f">'
local svg_line = '<line x1="%.2f" y1="%.2f" x2="%.2f" y2="%.2f" style="stroke:%s;stroke-width:2" />'
local svg_circle = '<circle cx="%.2f" cy="%.2f" r="%.2f" stroke="%s" stroke-width="2" fill="none" />'
local svg_point = '<circle cx="%.2f" cy="%.2f" r="4" stroke="none" fill="%s" />'
local svg_text = '<text x="%.2f" y="%.2f" style="font-family:sans-serif;font-weight:bold;fill:#494949">%s</text>'

local given_color = "blue"
local normal_color = "grey"
local target_color = "gold"

local function draw_point(p)
	
	local color
	if p.is_target then
		color = target_color
	elseif p.parent1 and p.parent2 then
		color = normal_color
	else
		color = given_color
	end

	return string.format(svg_point, p.x, -p.y, color) .. string.format(svg_text, p.x + 10, -p.y + 20, p.name)
end

local function draw_line(l)
	
	local K = 20
	local vx = l.p2.x - l.p1.x
	local vy = l.p2.y - l.p1.y
	
	local ax = l.p1.x + K * vx
	local ay = l.p1.y + K * vy
	local bx = l.p1.x - K * vx
	local by = l.p1.y - K * vy
	
	local color = l.is_target and target_color or normal_color
	
	local res = string.format(svg_line, ax, -ay, bx, -by, color)
	return res
end

local function draw_circle(c)
	
	local color = c.is_target and target_color or normal_color
	local res = string.format(svg_circle, c.center.x, -c.center.y, c.rad, color)
	return res
end


local function draw(context)
	
	local res = {}
	
	res[1] = string.format(svg_inline_header, 600, 450, -400, -300, 800, 600)
	
	for _,obj in ipairs(context.objects) do
		
		if obj.type == "line" then
			table.insert(res, draw_line(obj))
			
		elseif obj.type == "circle" then
			table.insert(res, draw_circle(obj))
		else
			error("Wrong type")
		end
	end
	
	for _,p in ipairs(context.points) do
		if p.name then
			table.insert(res, draw_point(p))
		end
	end
	
	table.insert(res, '</svg>')
	
	return table.concat(res, '\n')
end

return
{
	draw = draw
}