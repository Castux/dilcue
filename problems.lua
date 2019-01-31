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
	steps = 5,
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
			points = {p2, p3, p4, p1},
			objects = {l1, l2, l3, l4},
			targets = {L(p4,s1), L(p2,s2), l1, l3},
			hints = {"circle", "circle", L(s1,s2), "line", "line"}
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
			targets = {p1},
			hints = {"circle", "circle", "circle", "line", "line"}
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
			targets = {l1,l2,l3,l4},
			hints = {"circle", "circle", "line", l2, "line", "line", "line"}
		}
		
	end
})

table.insert(problems,
{
	code = "euclidea2.1",
	name = "Euclidea 2.1: Angle Bissector",
	steps = 4,
	setup = function()
		
		local alpha = 47.12
		
		local r = 150
		local p1 = P(0,0)
		local p2 = P(r,0)
		local p3 = P(r * math.cos(math.rad(alpha)), r * math.sin(math.rad(alpha)))
		local p4 = P(r * math.cos(math.rad(alpha/2)), r * math.sin(math.rad(alpha/2)))
		
		return
		{
			points = {p1,p2},
			objects = {L(p1,p2), L(p1,p3)},
			targets = {L(p1,p4)}
		}
		
	end
})

table.insert(problems,
{
	code = "euclidea2.3",
	name = "Euclidea 2.3: Angle of 30°",
	steps = 3,
	setup = function()
		
		local alpha = 30
		
		local r = 150
		local p1 = P(-r,0)
		local p2 = P(0,0)
		local p3 = P(r * math.cos(math.rad(alpha)) - r, r * math.sin(math.rad(alpha)))
		
		return
		{
			points = {p1,p2},
			objects = {L(p1,p2)},
			targets = {L(p1,p3)}
		}
		
	end
})


table.insert(problems,
{
	code = "euclidea2.4",
	name = "Euclidea 2.4: Double Angle",
	steps = 3,
	setup = function()
		
		local alpha = 27.45
		
		local r = 150
		local p1 = P(-r,0)
		local p2 = P(0,0)
		local p3 = P(r * math.cos(math.rad(alpha)) - r, r * math.sin(math.rad(alpha)))
		local p4 = P(r * math.cos(math.rad(2*alpha)) - r, r * math.sin(math.rad(2*alpha)))
		
		return
		{
			points = {p1,p2},
			objects = {L(p1,p2), L(p1,p3)},
			targets = {L(p1,p4)}
		}
		
	end
})

table.insert(problems,
{
	code = "euclidea2.5",
	name = "Euclidea 2.5: Cut Rectangle",
	steps = 3,
	setup = function()
		
		local k = 81.123
		local l = 33.987
	
		local p1 = P(-k,l)
		local p2 = P(k,l)
		local p3 = P(k,-l)
		local p4 = P(-k,-l)
		
		local p5 = P(152.1, 146.78)
		
		local l1,l2,l3,l4 = L(p1,p2), L(p2,p3), L(p3,p4), L(p4,p1)
		
		return
		{
			points = {p5, p2, p3, p4, p1},
			objects = {l1, l2, l3, l4},
			targets = {L(P(0,0), p5)},
			hints = {"line", "line", "line"}
		}
	end
})

table.insert(problems,
{
	code = "euclidea2.6",
	name = "Euclidea 2.6: Drop a Perpendicular",
	steps = 3,
	setup = function()
		
		local p1 = P(-100,0)
		local p2 = P(-275.1,0)
		local p3 = P(0,79)
		local p4 = P(0,0)
				
		return
		{
			points = {p1,p2,p3},
			objects = {L(p1,p2)},
			targets = {L(p3,p4)}
		}
	end
})

table.insert(problems,
{
	code = "euclidea2.7",
	name = "Euclidea 2.7: Erect a Perpendicular",
	steps = 3,
	setup = function()
		
		local p1 = P(-100,0)
		local p2 = P(0,0)
		local p3 = P(0,10)
		local p4 = P(78,84)
		
		return
		{
			points = {p1,p2,p4},
			objects = {L(p1,p2)},
			targets = {L(p2,p3)}
		}
	end
})

table.insert(problems,
{
	code = "euclidea2.8",
	name = "Euclidea 2.8: Tangent to Circle at Point",
	steps = 3,
	setup = function()
		local r = 150
		local alpha = math.rad(56)
		local beta = math.rad(15.4)
		
		local p1 = P(0,0)
		local p2 = P(r * math.cos(alpha), r * math.sin(alpha))
		local p3 = P(p2.x - p2.y, p2.y + p2.x)
		local p4 = P(r * math.cos(beta), r * math.sin(beta))
		
		return
		{
			points = {p1,p2,p4},
			objects = {C(p1,p2)},
			targets = {L(p2,p3)}
		}
	end
})

table.insert(problems,
{
	code = "euclidea2.9",
	name = "Euclidea 2.9: Circle Tangent to Line",
	steps = 4,
	setup = function()
		
		local r = 125
		
		local p1 = P(0,0)
		local p2 = P(0,r)
		local p3 = P(112,0)
		
		return
		{
			points = {p2,p3},
			objects = {L(p3,p1)},
			targets = {C(p2,p1)}
		}
	end
})

table.insert(problems,
{
	code = "euclidea2.10",
	name = "Euclidea 2.10: Сircle in Rhombus",
	steps = 6,
	setup = function()
		
		local k,l = 150,46.4
		
		local p1 = P(k,0)
		local p2 = P(0,-l)
		local p3 = P(-k,0)
		local p4 = P(0,l)
		
		local l1 = L(p1,p2)
		local l2 = L(p2,p3)
		local l3 = L(p3,p4)
		local l4 = L(p4,p1)
		
		local f = function(c)
			
			if c.type ~= "circle" then
				return false
			end
			
			if not geom.equal(c.center, P(0,0)) then
				return false
			end
			
			local i1,i2 = geom.intersection(c, l1)
			if i1 and not i2 then
				return true
			end
		end
		return
		{
			points = {p1,p2,p3,p4},
			objects = {l1,l2,l3,l4},
			targets = {f}
		}
	end
})

return problems