local eps = 1e-5

--[[ Point ]]--

local function Point(x,y)
	return { x = x, y = y }
end

local function pp_squared_distance(p1,p2)
	return (p1.x - p2.x)^2 + (p1.y - p2.y)^2
end

local function pp_distance(p1,p2)
	return math.sqrt(pp_squared_distance(p1,p2))
end

local function pp_equal(p1,p2)
	return pp_squared_distance(p1,p2) < eps*eps
end

local function pppp_cross(a1,b1,a2,b2)

	local ux, uy = b1.x-a1.x, b1.y-a1.y
	local vx, vy = b2.x-a2.x, b2.y-a2.y

	return ux*vy - vx*uy
end

--[[ Line ]]--


local function Line(p1,p2)
	return { p1 = p1, p2 = p2 }
end

local function pl_point_on_line(p,l)

	local det = pppp_cross(p, l.p1, p, l.p2)

	return math.abs(det) < eps
end

local function ll_equal(l1,l2)

	return pl_point_on_line(l2.p1, l1) and pl_point_on_line(l2.p2, l1)
end

local function ll_intersection(l1,l2)

	local x1,x2,x3,x4 = l1.p1.x, l1.p2.x, l2.p1.x, l2.p2.x
	local y1,y2,y3,y4 = l1.p1.y, l1.p2.y, l2.p1.y, l2.p2.y

	local det = (x1-x2)*(y3-y4) - (y1-y2)*(x3-x4)

	if math.abs(det) < eps then
		-- Lines are equal or parallel
		return nil
	end

	local ix = (x1*y2 - y1*x2)*(x3-x4) - (x1 - x2)*(x3*y4 - y3*x4)
	local iy = (x1*y2 - y1*x2)*(y3-y4) - (y1 - y2)*(x3*y4 - y3*x4)

	ix = ix / det
	iy = iy / det

	return Point(ix,iy)
end

--[[ Circle ]]--

local function Circle(center, p)
	local sqrad = pp_squared_distance(center, p)
	local rad = math.sqrt(sqrad)
	
	return { center = center, p = p, sqrad = sqrad, rad = rad }
end

local function pc_point_on_circle(p,c)

	return math.abs(pp_squared_distance(c.center, p) - c.sqrad) < eps
end


local function cc_equal(c1,c2)
	
	return pp_equal(c1.center, c2.center) and pc_point_on_circle(c1.p, c2)	
end

local function lc_intersection(l,c)

	-- http://mathworld.wolfram.com/Circle-LineIntersection.html

	local x1,x2 = l.p1.x - c.center.x, l.p2.x - c.center.x
	local y1,y2 = l.p1.y - c.center.y, l.p2.y - c.center.y

	local dx,dy = x2 - x1, y2 - y1
	local dr2 = dx * dx + dy * dy
	local D = x1 * y2 - x2 * y1

	local delta = c.sqrad * dr2 - D * D

	if math.abs(delta) < eps then
		local ix = D * dy / dr2
		local iy = -D * dx / dr2
		return { Point(ix + c.center.x, iy + c.center.y) }

	elseif delta < 0 then
		return {}

	else
		local signdy = dy < 0 and -1 or 1

		local tmpx = signdy * dx * math.sqrt(delta)
		local tmpy = math.abs(dy) * math.sqrt(delta)

		return
		{
			Point((D * dy + tmpx) / dr2 + c.center.x, (-D * dx + tmpy) / dr2 + c.center.y),
			Point((D * dy - tmpx) / dr2 + c.center.x, (-D * dx - tmpy) / dr2 + c.center.y),
		}
	end
end

local function cc_intersection(c1,c2)
	
	-- http://paulbourke.net/geometry/circlesphere/
	
	local d = pp_distance(c1.center, c2.center)
	local r0 = c1.rad
	local r1 = c2.rad
	
	if d > r0 + r1 + eps or d < math.abs(r0 - r1) - eps or cc_equal(c1,c2) then
		return {}
	end
	
	local a = (r0 * r0 - r1 * r1 + d * d) / (2 * d)
	
	local px = c1.center.x + a * (c2.center.x - c1.center.x) / d
	local py = c1.center.y + a * (c2.center.y - c1.center.y) / d
	
	local h = math.sqrt(r0 * r0 - a * a)
	
	if h < eps then
		return { Point(px,py) }
	end
	
	local tmpx = h * (c2.center.y - c1.center.y) / d
	local tmpy = -h * (c2.center.x - c1.center.x) / d
	
	return
	{
			Point(px + tmpx, py + tmpy),
			Point(px - tmpx, py - tmpy)
	}	
end

local function test()

	do
		local a = Point(1,2)
		local b = Point(-1,1)
		local c = Point(0, 1.5)

		assert(pp_equal(a,a))
		assert(not pp_equal(a,b))

		local l = Line(a,b)
		local l2 = Line(b,c)

		assert(pl_point_on_line(a,l))
		assert(pl_point_on_line(b,l))
		assert(ll_equal(l, l2))

		local d = Point(10,10)
		local l3 = Line(b,d)

		assert(not pl_point_on_line(d,l))
		assert(not ll_equal(l,l3))
	end

	do
		local p1 = Point(1,1)
		local p2 = Point(1,2)
		local p3 = Point(2,2)
		local p4 = Point(2,1)

		assert(pp_equal(ll_intersection(Line(p1,p3), Line(p2,p4)), Point(1.5, 1.5)) )
		assert(pp_equal(ll_intersection(Line(p1,p3), Line(p2,p3)), p3) )
		assert(ll_intersection(Line(p1,p2), Line(p3,p4)) == nil)
		assert(ll_intersection(Line(p1,p2), Line(p1,p2)) == nil)
	end

	do
		local center = Point(1,1)
		local p = Point(2,2)
		local c = Circle(center,p)

		assert(c.sqrad == 2)
		assert(pc_point_on_circle(p,c))
		assert(not pc_point_on_circle(center,c))
		assert(not pc_point_on_circle(Point(10,10),c))
		assert(pc_point_on_circle(Point(2,0),c))

	end

	do
		local c1 = Circle(Point(1,1), Point(0,1))
		local c2 = Circle(Point(1,1), Point(2,1))
		local c3 = Circle(Point(0,1), Point(1,1))
		
		assert(cc_equal(c1,c1))
		assert(cc_equal(c1,c2))
		assert(not cc_equal(c1,c3))
	end

	do
		local c = Circle(Point(10,10), Point(10,11))
		
		local l = Line(Point(9,12), Point(12,9))

		local intersections = lc_intersection(l,c)
		
		assert(#intersections == 2)
		table.sort(intersections, function(p1,p2)
				return p1.x < p2.x
		end)
		assert(pp_equal(intersections[1], Point(10,11)))
		assert(pp_equal(intersections[2], Point(11,10)))
		
		local l = Line(Point(0,9), Point(1,9))
		local intersections = lc_intersection(l,c)
		assert(#intersections == 1)
		assert(pp_equal(intersections[1], Point(10,9)))
		
		local l = Line(Point(0,0), Point(1,10))
		local intersections = lc_intersection(l,c)
		assert(#intersections == 0)
	end
	
	do
		local c1 = Circle(Point(-2,0), Point(1,0))
		local c2 = Circle(Point(2,0), Point(1,0))
		
		local inter = cc_intersection(c1,c2)
		assert(#inter == 1)
		assert(pp_equal(inter[1], Point(1,0)))
		
		local c3 = Circle(Point(-1,0), Point(-0.5,0.5))
		local inter = cc_intersection(c1,c3)
		assert(#inter == 0)
	end
	
	do
		local p1 = Point(10,1)
		local p2 = Point(10,-1)
		local c1 = Circle(p1,p2)
		local c2 = Circle(p2,p1)
		local inter = cc_intersection(c1,c2)
		assert(#inter == 2)
		table.sort(inter, function(p1,p2)
				return p1.x < p2.x
		end)
	
		assert(pp_equal(inter[1], Point(10 - math.sqrt(3), 0)))
		assert(pp_equal(inter[2], Point(10 + math.sqrt(3), 0)))
		
	end
	

end

test()

return
{
	Point = Point,
	Line = Line,
	Circle = Circle,
	
	pp_equal = pp_equal,
	ll_equal = ll_equal,
	cc_equal = cc_equal,
	
	ll_intersection = ll_intersection,
	lc_intersection = lc_intersection,
	cc_intersection = cc_intersection
}