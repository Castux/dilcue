local geom = require "geom"

local function make_context()
	return
	{
		points = {},
		objects = {}
	}
end

local function all_intersections(object, context)
	
	local points = {}
	
	for _, previous in ipairs(context.objects) do
		
		local i1,i2 = geom.intersection(previous, object)
		if i1 then table.insert(points, i1) end
		if i2 then table.insert(points, i2) end
	end
	
	return points
end

local function add_point_if_unique(point, context)

	-- Add point if unique
	local new = true
	for _,old_point in ipairs(context.points) do
		if geom.equal(point, old_point) then
			new = false
			-- TODO: update
			break
		end
	end

	if new then
		table.insert(context.points, point)
	end
end

local function add_if_unique(object, context)

	
	local new = true
	for _,old in ipairs(context.objects) do
		if geom.equal(object, old) then
			new = false
			-- TODO: update
			break
		end
	end

	if new then
		table.insert(context.objects, object)
		return true
	end 

	return false
end

local function step(context)

	local new_points = {}
	local new_objects = {}

	-- Make all new possible constructions from existing points

	for i = 1, #context.points do
		for j = i+1, #context.points do

			local p1,p2 = context.points[i], context.points[j]

			table.insert(new_objects, geom.Line(p1,p2))
			table.insert(new_objects, geom.Circle(p1,p2))
			table.insert(new_objects, geom.Circle(p2,p1))
		end
	end

	-- Add them to the context, creating all intersections possible
	
	for _,new_object in ipairs(new_objects) do
		
		local added = add_if_unique(new_object, context)
		if added then
			for _,new_point in ipairs(all_intersections(new_object, context)) do
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
		print(#c.points, #c.objects)
	end
end

test()