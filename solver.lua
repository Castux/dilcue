local geom = require "geom"

local function make_context()
	return
	{
		points = {},
		lines = {},
		circles = {}
	}
end

local function all_line_intersections(line, context)

	local points = {}

	-- line-line
	for _,prev_line in ipairs(context.lines) do
		local inter = geom.ll_intersection(prev_line, line)
		if inter then
			table.insert(points, inter)
		end
	end

	-- line-circle
	for _,prev_circle in ipairs(context.circles) do
		for _,inter in ipairs(geom.lc_intersection(line, prev_circle)) do
			table.insert(points, inter)
		end
	end

	return points
end

local function all_circle_intersections(circle, context)

	local points = {}

	-- circle-line
	for i,prev_line in ipairs(context.lines) do
		for _,inter in ipairs(geom.lc_intersection(prev_line, circle)) do
			table.insert(points, inter)
		end
	end

	-- circle-circle
	for i,prev_circle in ipairs(context.circles) do
		for _,inter in ipairs(geom.cc_intersection(circle, prev_circle)) do
			table.insert(points, inter)
		end
	end

	return points
end

local function add_point_if_unique(point, context)

	-- Add point if unique
	local new = true
	for _,old_point in ipairs(context.points) do
		if geom.pp_equal(point, old_point) then
			new = false
			-- TODO: update
			break
		end
	end

	if new then
		table.insert(context.points, point)
	end
end

local function add_line_if_unique(line, context)

	local new = true
	for _,old_line in ipairs(context.lines) do
		if geom.ll_equal(line, old_line) then
			new = false
			-- TODO: update
			break
		end
	end

	if new then
		table.insert(context.lines, line)
		return true
	end

	return false
end

local function add_circle_if_unique(circle, context)

	local new = true
	for _,old_circle in ipairs(context.circles) do
		if geom.cc_equal(circle, old_circle) then
			new = false
			-- TODO: update
			break
		end
	end

	if new then
		table.insert(context.circles, circle)
		return true
	end 

	return false
end


local function step(context)

	local new_lines = {}
	local new_circles = {}
	local new_points = {}

	-- Make all new possible constructions from existing points

	for i = 1, #context.points do
		for j = i+1, #context.points do

			local p1,p2 = context.points[i], context.points[j]

			table.insert(new_lines, geom.Line(p1,p2))
			table.insert(new_circles, geom.Circle(p1,p2))
			table.insert(new_circles, geom.Circle(p2,p1))
		end
	end

	-- Add them to the context, creating all intersections possible

	for _,new_line in ipairs(new_lines) do

		local added = add_line_if_unique(new_line, context)

		if added then
			for _,new_point in ipairs(all_line_intersections(new_line, context)) do
				add_point_if_unique(new_point, context)
			end
		end
	end

	for _,new_circle in ipairs(new_circles) do

		local added = add_circle_if_unique(new_circle, context)

		if added then
			for _,new_point in ipairs(all_circle_intersections(new_circle, context)) do
				add_point_if_unique(new_point, context)		
			end
		end
	end

end

local function test()

	local c = make_context()

	local p1 = geom.Point(0,1)
	local p2 = geom.Point(1,0)

	c.points = {p1,p2}
	
	for i = 1,10 do
		step(c)
		print(#c.points, #c.lines, #c.circles)
	end
end

test()