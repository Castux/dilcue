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
	steps = 4,
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

return problems