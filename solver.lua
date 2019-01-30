local geom = require "geom"

local function make_context()
	return
	{
		points = {},
		objects = {},
		targets = {}
	}
end

local function all_intersections(object, context)
	
	local points = {}
	
	for _, previous in ipairs(context.objects) do
		
		local i1,i2 = geom.intersection(previous, object)
		if i1 then
			i1.parent1 = previous
			i1.parent2 = object
			table.insert(points, i1)
		end
		
		if i2 then
			i2.parent1 = previous
			i2.parent2 = object
			table.insert(points, i2)
		end
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

local function exists(object, context)
	
	for _,old in ipairs(context.objects) do
		if geom.equal(object, old) then
			return true
		end
	end
	
	return false
end

local function check_solved(context)
	
	local num_reached = 0
	for i,target in ipairs(context.targets) do
	
		if target.type == "point" then
			for _,p in ipairs(context.points) do
				if geom.equal(p, target) then
					
					context.targets[i] = p		-- for parent information
					num_reached = num_reached + 1
					break
				end
			end
		
		else
			for _,o in ipairs(context.objects) do
				if geom.equal(o, target) then
					num_reached = num_reached + 1
					break
				end
			end
		end
	end
	
	return num_reached == #context.targets
end

local function rec(context, depth)

	if check_solved(context) then
		context.solved = true
		return
	end

	if depth < 0 then
		return
	end
	
	-- Make all new possible constructions from existing points
	
	local objects = {}
	
	for i = 1, #context.points do
		for j = i+1, #context.points do

			local p1,p2 = context.points[i], context.points[j]

			objects[1] = geom.Line(p1,p2)
			objects[2] = geom.Circle(p1,p2)
			objects[3] = geom.Circle(p2,p1)
			
			for _,object in ipairs(objects) do
				
				local added = add_if_unique(object, context)
				if added then
					
					local num_points_before = #context.points
					
					for _,point in ipairs(all_intersections(object, context)) do
						add_point_if_unique(point, context)
					end
					
					rec(context, depth-1)
					
					if context.solved then
						return
					end
					
					-- backtrack
					for i = num_points_before + 1, #context.points do
						context.points[i] = nil
					end
					
					context.objects[#context.objects] = nil
				end
			end
		end
	end
	
end


local function pretty_print(context)
	
	local point_num = 1
	local function point_name(p)
		if not p.name then
			p.name = "point" .. point_num
			point_num = point_num + 1
			
			local loc = '(' .. p.x .. ',' .. p.y .. ')'
			
			if p.parent1 and p.parent2 then
				print('*' .. p.name, p.parent1.name .. ' x ' .. p.parent2.name .. " " .. loc)
			else
				print('*' .. p.name, "given" .. " " .. loc)
			end
		end
		
		return p.name
	end
	
	for i,o in ipairs(context.objects) do
		
		o.name = o.type .. i
		if o.type == "line" then
			print(o.name, point_name(o.p1) .. ' -- ' .. point_name(o.p2))
		else
			print(o.name, point_name(o.center) .. ' -> ' .. point_name(o.p))
		end
		
	end
	
	for _,p in ipairs(context.targets) do
		if p.type == "point" then
			point_name(p)
		end
	end
	
end

local function test()

	local c = make_context()

	local p1 = geom.Point(-1,0)
	local p2 = geom.Point(1,0)

	c.points = {p1,p2}
	c.targets = {geom.Circle(geom.Point(2,0), geom.Point(3,0))}
	
	rec(c, 5)
	
	if c.solved then
		pretty_print(c)
	end
end

test()