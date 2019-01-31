local geom = require "geom"
local draw = require "draw"

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
					p.is_target = true
					target.parent1 = p.parent1
					target.parent2 = p.parent2
					num_reached = num_reached + 1
					break
				end
			end
		
		else
			for _,o in ipairs(context.objects) do
				if geom.equal(o, target) then
					o.is_target = true
					num_reached = num_reached + 1
					break
				end
			end
		end
	end
	
	return num_reached == #context.targets
end

local function rec(context, depth, max_depth)

	if check_solved(context) then
		context.solved = true
		return
	end

	if depth > max_depth then
		return
	end
	
	-- Make all new possible constructions from existing points
	
	local objects = {}
	
	for i = 1, #context.points do
		for j = i+1, #context.points do

			local p1,p2 = context.points[i], context.points[j]
			
			for i = 1,3 do
				objects[i] = nil
			end
			
			local hint = context.hints and context.hints[depth]
			if not hint or hint == "line" then
				table.insert(objects, geom.Line(p1,p2))
			end
			
			if not hint or hint == "circle" then
				table.insert(objects, geom.Circle(p1,p2))
				table.insert(objects, geom.Circle(p2,p1))
			end
			
			for _,object in ipairs(objects) do
				
				local added = add_if_unique(object, context)
				if added then
					
					local num_points_before = #context.points
					
					for _,point in ipairs(all_intersections(object, context)) do
						add_point_if_unique(point, context)
					end
					
					rec(context, depth + 1, max_depth)
					
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

local function decorate(context)
	
	-- Assuming the problem is solved, name the useful points and objects
	
	local index = 0
	local function name_point(p)
		if not p.name then
			p.name = string.char(string.byte('A') + index)
			index = index + 1
		end
		
		return p.name
	end
		
	for _,obj in ipairs(context.objects) do
		
		if obj.type == "line" then
			obj.name = '(' .. name_point(obj.p1) .. name_point(obj.p2) .. ')'
		elseif obj.type == "circle" then
			obj.name = '⊙' .. name_point(obj.center) .. name_point(obj.p)
		else
			error("Bad type")
		end
		
	end
	
	for _,p in ipairs(context.points) do
		if p.is_target then
			name_point(p)
		end
	end

end

local function pretty_print(context)
	
	local res = {}
	local points_written = {}
	
	local function write_point(p)
		
		if points_written[p] then
			return
		end
		
		local pos = string.format("(%.2f,%.2f)", p.x, p.y)
		
		if p.given then
			table.insert(res, "* " .. p.name .. ": given " .. pos)		
		else
			table.insert(res, "* " .. p.name .. " = " .. p.parent1.name .. " x " .. p.parent2.name .. " " .. pos)
		end
		
		points_written[p] = true
	end

	for i,o in ipairs(context.objects) do
		if not o.given then
			if o.type == "line" then
				write_point(o.p1)
				write_point(o.p2)
				table.insert(res, "line: " .. o.name)
			else
				write_point(o.center)
				write_point(o.p)
				table.insert(res, "circle: " .. o.name)
			end
		end
	end
	
	for _,p in ipairs(context.points) do
		if p.is_target then
			write_point(p)
		end
	end
	
	return table.concat(res, '\n')
end

local function solve(context, steps)

	for _,p in ipairs(context.points) do
		p.given = true
	end
	
	for _,o in ipairs(context.objects) do
		o.given = true
	end
	
	for _,o in ipairs(context.targets) do
		o.is_target = true
	end
	
	rec(context, 1, steps)
	if context.solved then
		decorate(context)
	end
end

return
{
	solve = solve,
	pretty_print = pretty_print
}