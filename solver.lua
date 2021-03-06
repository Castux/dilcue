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

local function exists_point(p, context)
	
	for _,old in ipairs(context.points) do
		if geom.equal(p, old) then
			return true
		end
	end
	
	return false
end

local function insert_point(p, context)
	
	if exists_point(p, context) then
		return false
	end
	
	table.insert(context.points, p)
	return true
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

local function exists(object, context)
	
	for _,old in ipairs(context.objects) do
		if geom.equal(object, old) then
			return true
		end
	end
	
	return false
end


local function check_solved(context)
	
	return context.lc_targets_built == context.lc_targets and
		context.point_targets_built == context.point_targets

end

local function matches_restriction(object, restriction)
	
	if type(restriction) == "table" then
		return geom.equal(object, restriction)
	
	elseif type(restriction) == "string" then
		return object.type == restriction
	
	elseif restriction == nil then
		return true
		
	else
		error("Bad restriction")
	end
	
end

local function candidates(context, restriction)
	
	local tmp = {}
	
	for i = 1, #context.points do
		for j = i+1, #context.points do

			local p1,p2 = context.points[i], context.points[j]
			table.insert(tmp, geom.Line(p1,p2))
			table.insert(tmp, geom.Circle(p1,p2))
			table.insert(tmp, geom.Circle(p2,p1))
			
		end
	end
	
	local res = {}
	
	-- Filter existing objects and according to restrictions
	
	for _,o in ipairs(tmp) do
		if matches_restriction(o, restriction) and not exists(o, context) then
			table.insert(res, o)
		end
	end
	
	return res
end

local function sort_candidates(candidates, context)
	
	-- Build targets first!
	
	local num_targets_found = 0
	
	for i = 1, #candidates do
		local obj = candidates[i]		
		for _,target in ipairs(context.targets) do
			if geom.equal(obj, target) then
				obj.is_target = true
				num_targets_found = num_targets_found + 1
				candidates[num_targets_found], candidates[i] = candidates[i], candidates[num_targets_found]
			end
		end
	end
	
end

local function is_point_target(p, context)
	
	for _,target in ipairs(context.targets) do
		if geom.equal(p, target) then
			p.is_target = true
			return true
		end
	end
	
	return false
end

local function rec(context, depth, max_depth)

	-- Stop if we're solved, obviously
	
	if depth > max_depth then
		if check_solved(context) then
			context.solved = true			
		end
		return
	end
	
	-- Stop if there aren't enough remaining steps to build all targets
	
	if context.lc_targets - context.lc_targets_built > max_depth - depth + 1 then
		return
	end
	
	-- Make all (uniquely) new possible constructions from existing points
	
	local objects = candidates(context, context.restrictions and context.restrictions[depth])
	sort_candidates(objects, context)
	
	for _,object in ipairs(objects) do
		
		-- Compute intersections
		
		local num_points_before = #context.points
		
		local points = all_intersections(object, context)
		
		for _,point in ipairs(points) do
			local inserted = insert_point(point, context)	-- these points might be duplicates, use function with check
			if inserted and is_point_target(point, context) then
				context.point_targets_built = context.point_targets_built + 1
			end
		end
		
		-- We already insured this object is new, insert directly
 		
		table.insert(context.objects, object)
		if object.is_target then
			context.lc_targets_built = context.lc_targets_built + 1
		end
		
		-- Recurse!
		
		rec(context, depth + 1, max_depth)
		
		if context.solved then
			return
		end
		
		-- Backtrack
		
		for i = num_points_before + 1, #context.points do
			if context.points[i].is_target then
				context.point_targets_built = context.point_targets_built - 1
			end
			context.points[i] = nil
		end
		
		context.objects[#context.objects] = nil
		if object.is_target then
			context.lc_targets_built = context.lc_targets_built - 1
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
	
	context.lc_targets = 0
	context.point_targets = 0
	
	for _,o in ipairs(context.targets) do
		if o.type == "point" then
			context.point_targets = context.point_targets + 1
		else
			context.lc_targets = context.lc_targets + 1
		end
		o.is_target = true
	end
	
	context.lc_targets_built = 0
	context.point_targets_built = 0
	
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