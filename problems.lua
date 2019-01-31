local geom = require "geom"

local P,L,C = geom.Point, geom.Line, geom.Circle

local problems = {}

table.insert(problems,
{
	code = "euclidea1.1",
	name = "Euclidea 1.1: Angle of 60°",
	steps = 3,
	setup = function()
		
		local p1 = P(-100,0)
		local p2 = P(100,0)
		local p3 = P(0, 200 * math.sin(math.rad(60)))
		
		return
		{
			points = {p1, p2},
			objects = {L(p1,p2)},
			targets = {L(p1,p3)}
		}
		
	end
})

table.insert(problems,
{
	code = "euclidea1.2",
	name = "Euclidea 1.2: Perpendicular Bisector",
	steps = 3,
	setup = function()
		
		local p1 = P(-100,0)
		local p2 = P(100,0)
		
		local p3,p4 = P(0,200), P(0,0)
				
		return
		{
			points = {p1, p2},
			objects = {L(p1,p2)},
			targets = {L(p3,p4)}
		}
		
	end
})

table.insert(problems,
{
	code = "euclidea1.3",
	name = "Euclidea 1.3: Midpoint",
	steps = 4,
	setup = function()
		
		local p1 = P(-100,-20)
		local p2 = P(100,20)
		local p3 = P(0,0)
				
		return
		{
			points = {p1, p2},
			objects = {},
			targets = {p3}
		}
		
	end
})

table.insert(problems,
{
	code = "euclidea1.4",
	name = "Euclidea 1.4: Circle in Square",
	steps = 5,
	setup = function()
		
		local k = 80
		
		local p1 = P(-k,k)
		local p2 = P(k,k)
		local p3 = P(k,-k)
		local p4 = P(-k,-k)
		
		local l1,l2,l3,l4 = L(p1,p2), L(p2,p3), L(p3,p4), L(p4,p1)
		local c = C(P(0,0), P(k,0))
			
		return
		{
			points = {p1, p2, p3, p4},
			objects = {l1, l2, l3, l4},
			targets = {c}
		}
		
	end
})

table.insert(problems,
{
	code = "euclidea1.5",
	name = "Euclidea 1.5: Rhombus in Rectangle",
	steps = 3,
	setup = function()
		
		local k = 81.123
		local l = 33.987
	
		local p1 = P(-k,l)
		local p2 = P(k,l)
		local p3 = P(k,-l)
		local p4 = P(-k,-l)
		
		local l1,l2,l3,l4 = L(p1,p2), L(p2,p3), L(p3,p4), L(p4,p1)
		
		local x = (k*k - l*l)/k
		local s1 = P(-k + x, l)
		local s2 = P(k -x, -l)
		
		return
		{
			points = {p1, p2, p3, p4},
			objects = {l1, l2, l3, l4},
			targets = {s1, s2}
		}
		
	end
})

table.insert(problems,
{
	code = "euclidea1.6",
	name = "Euclidea 1.6: Circle Center",
	steps = 5,
	setup = function()
		
		local alpha = 25.12
		local beta = -18.1
		local r = 150
		local p1 = P(0,0)
		local p2 = P(r * math.cos(math.rad(alpha)), r * math.sin(math.rad(alpha)))
		local p3 = P(r * math.cos(math.rad(beta)), r * math.sin(math.rad(beta)))
		
		return
		{
			points = {p2,p3},
			objects = {C(p1,p2)},
			targets = {p1}
		}
		
	end
})

table.insert(problems,
{
	code = "euclidea1.7",
	name = "Euclidea 1.7: Inscribed Square",
	steps = 7,
	setup = function()
		
		local r = 150
		local center = P(0,0)
		local p1 = P(0,r)
		local p2 = P(r,0)
		local p3 = P(0,-r)
		local p4 = P(-r,0)
		
		local l1 = L(p1,p2)
		local l2 = L(p2,p3)
		local l3 = L(p3,p4)
		local l4 = L(p4,p1)
		
		return
		{
			points = {center, p1},
			objects = {C(center,p1)},
			targets = {l1,l2,l3,l4}
		}
		
	end
})

return problems