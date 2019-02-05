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
			targets = {L(p4,s1), L(p2,s2)}
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
			restrictions = {"circle", "circle", "circle", "line", "line"}
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
	code = "euclidea2.2",
	name = "Euclidea 2.2: Intersection of Angle Bisectors",
	steps = 6,
	setup = function()
		
		local p1 = P(-120,-25.4)
		local p2 = P(-5.54, 123)
		local p3 = P(211, -34.8)
		
		local l1 = L(p1,p2)
		local l2 = L(p2,p3)
		local l3 = L(p1,p3)
		
		local d1 = geom.distance(p2,p3)
		local d2 = geom.distance(p1,p3)
		local d3 = geom.distance(p1,p2)
		
		local x = (d1 * p1.x + d2 * p2.x + d3 * p3.x) / (d1 + d2 + d3)
		local y = (d1 * p1.y + d2 * p2.y + d3 * p3.y) / (d1 + d2 + d3)
		local c = P(x,y)
		
		return
		{
			points = {p1,p2,p3},
			objects = {l1,l2,l3},
			targets = {c},
			restrictions = {nil, nil, nil, L(p1,c)}			
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
			restrictions = {"line", "line", "line"}
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
	steps = 5,
	setup = function()
		
		local k,l = 150,122.2
		
		local p1 = P(k,0)
		local p2 = P(0,-l)
		local p3 = P(-k,0)
		local p4 = P(0,l)
		
		local l1 = L(p1,p2)
		local l2 = L(p2,p3)
		local l3 = L(p3,p4)
		local l4 = L(p4,p1)
		
		local center = P(0,0)
		local tmp = P(l,-k)
		local tmp2 = L(center,tmp)
		local i1 = geom.intersection(tmp2, l1)
		local c = C(center,i1)
		
		return
		{
			points = {p1,p2,p3,p4},
			objects = {l1,l2,l3,l4},
			targets = {c},
			restrictions = {"line", "line", "circle", "line", "circle"}
		}
	end
})

table.insert(problems,
{
	code = "euclidea3.1",
	name = "Euclidea 3.1: Chord Midpoint",
	steps = 4,
	setup = function()

		local l = 54.113		
		local p1 = P(0,0)
		local p2 = P(0,l)
		local p3 = P(111,126.9)
		local p4 = P(10,l)
		
		return
		{
			points = {p1,p2,p3},
			objects = {C(p1,p3)},
			targets = {L(p2,p4)}
		}
	end
})

table.insert(problems,
{
	code = "euclidea3.2",
	name = "Euclidea 3.2: Triangle by Angle and Orthocenter",
	steps = 6,
	setup = function()
		
		local p1 = P(-120.23,10)
		local p2 = P(145,0)
		local p3 = P(109.7,176.3)
		local c = P(87,56)
		
		local l1 = L(p1,p2)
		local l2 = L(p1,p3)
		
		local t1 = geom.project(c,l1)
		local t2 = geom.project(c,l2)
		
		local h1 = L(c,t1)
		local h2 = L(c,t2)
		
		local i1 = geom.intersection(h1,l2)
		local i2 = geom.intersection(h2,l1)
		
		return
		{
			points = {p1,p2,p3,c},
			objects = {l1,l2},
			targets = {L(i1,i2)},
			restrictions = {"circle", "circle", h1, "circle", h2}
		}
	end
})

table.insert(problems,
{
	code = "euclidea3.3",
	name = "Euclidea 3.3: Intersection of Perpendicular Bisectors",
	steps = 2,
	setup = function()
		
		local p1 = P(-100,-12.3)
		local p2 = P(175,0)
		local p3 = P(101.7,176.3)
		local c = P(87,56)
		
		local l1 = L(p1,p2)
		local l2 = L(p1,p3)
		
		-- Solution is in the construction :)
		
		local circle = C(c,p1)
		local i1,i2 = geom.intersection(circle,l1)
		local t1 = geom.equal(i1,p1) and i2 or i1
		
		local i1,i2 = geom.intersection(circle,l2)
		local t2 = geom.equal(i1,p1) and i2 or i1	
		
		return
		{
			points = {p1,p2,p3,c},
			objects = {l1,l2},
			targets = {L(t1,t2)}
		}
	end
})

table.insert(problems,
{
	code = "euclidea3.4",
	name = "Euclidea 3.4: Three equal segments - 1",
	steps = 6,
	setup = function()
		
		local p1 = P(-100,31.3)
		local p2 = P(165,0)
		local p3 = P(111.7,156.3)
		local c = P(97,65)
		
		local l1 = L(p1,p2)
		local l2 = L(p1,p3)
		
		-- Solution is in the construction :)
		
		local bisector = geom.bisector(p1,c)
		local i1 = geom.intersection(bisector,l2)
		local circle = C(c,i1)
		
		local j1,j2 = geom.intersection(circle,l1)
		local i2 = j1.x < j2.x and j2 or j1
		
		local res1, res2 = L(i1,c), L(c,i2)
		
		return
		{
			points = {p1,p2,p3,c},
			objects = {l1,l2},
			targets = {res1,res2},
			restrictions = {"circle", "circle", "line", res1, "circle", "line"}
		}
	end
})

table.insert(problems,
{
	code = "euclidea3.5",
	name = "Euclidea 3.5: Circle through Point Tangent to Line",
	steps = 6,
	setup = function()
		
		local r = 100
		local theta = math.rad(132)
		local p1 = P(0,0)
		local p2 = P(0,-r)
		local p3 = P(r * math.cos(theta), r * math.sin(theta))
		local p4 = P(100,-r)
		
		local l1 = L(p2,p4)
		
		return
		{
			points = {p2,p3},
			objects = {l1},
			targets = {C(p1,p2)},
			restrictions = {"circle","circle", "line", "line", "line", "circle"}
		}
	end
})


table.insert(problems,
{
	code = "euclidea3.6",
	name = "Euclidea 3.6: Midpoints Through Trapezoid Bases",
	steps = 3,
	setup = function()
		
		local s1,s2 = P(23,76), P(-12,-34.4)
		
		local w1,w2 = 45.4, 87.1
		local t1,t2 = P(s1.x - w1, s1.y), P(s1.x + w1, s1.y)
		local b1,b2 = P(s2.x - w2, s2.y), P(s2.x + w2, s2.y)
		
		local l1,l2,l3,l4 = L(t1,t2), L(t2,b2), L(b2,b1), L(b1,t1)
		
		local i = geom.intersection(l2,l4)
		
		return
		{
			points = {t1,t2,b1,b2,i},
			objects = {l1,l2,l3,l4},
			targets = {L(s1,s2)}
		}
	end
})

table.insert(problems,
{
	code = "euclidea3.7",
	name = "Euclidea 3.7: Angle of 45°",
	steps = 5,
	setup = function()
		
		local p1 = P(0,0)
		local p2 = P(100,0)
		local p3 = P(100,100)
		
		return
		{
			points = {p1,p2},
			objects = {L(p1,p2)},
			targets = {L(p1,p3)},
			restrictions = {"circle", "circle", "line"}	-- force a solution that doesn't use the initial half line
		}
	end
})


table.insert(problems,
{
	code = "euclidea3.8",
	name = "Euclidea 3.8: Lozenge",
	steps = 7,
	setup = function()
		
		local d = 165
		local p1 = P(0,0)
		local p2 = P(d,0)
		
		local h = d * math.sin(math.rad(45))
		local p3 = P(h,h)
		local p4 = P(d+h,h)
		
		local l1,l2,l3,l4 = L(p1,p2), L(p1,p3), L(p3,p4), L(p2,p4)
		
		local midpoint = P(d/2, 0)
		local restrictioncircle = C(midpoint, p1)
		
		return
		{
			points = {p1,p2},
			objects = {l1},
			targets = {l2,l3,l4}
		}
	end
})

table.insert(problems,
{
	code = "euclidea3.9",
	name = "Euclidea 3.9: Center of Quadrilateral",
	steps = 10,
	setup = function()
		
		local p1 = P(-201,124)
		local p2 = P(176,199)
		local p3 = P(109,-76)
		local p4 = P(-132,-120)
		
		local l1 = L(p1,p2)
		local l2 = L(p2,p3)
		local l3 = L(p3,p4)
		local l4 = L(p4,p1)
		
		local m1 = P((p1.x + p2.x) / 2, (p1.y + p2.y) / 2)
		local m2 = P((p3.x + p4.x) / 2, (p3.y + p4.y) / 2)
		
		local cx = (p1.x + p2.x + p3.x + p4.x) / 4
		local cy = (p1.y + p2.y + p3.y + p4.y) / 4
		
		return
		{
			points = {p1,p2,p3,p4},
			objects = {l1,l2,l3,l4},
			targets = {P(cx,cy)},
			-- This one has just too many points. We "help" all the way :(
			restrictions = { C(p1,p2), C(p2,p1), geom.bisector(p1,p2), C(p3,p4), C(p4,p3), geom.bisector(p3,p4), L(m1,m2), C(m1,m2), C(m2,m1)}
		}
	end
})

table.insert(problems,
{
	code = "euclidea4.1",
	name = "Euclidea 4.1: Double Segment",
	steps = 3,
	setup = function()
		
		local p1 = P(-100,0)
		local p2 = P(0,0)
		local p3 = P(100,0)
		
		return
		{
			points = {p1,p2},
			objects = {},
			targets = {p3},
			restrictions = { "circle", "circle", "circle" }	-- as per the instructions
		}
	end
})


table.insert(problems,
{
	code = "euclidea4.2",
	name = "Euclidea 4.2: Angle of 60° - 2",
	steps = 4,
	setup = function()
		
		local p1 = P(-70,0)
		local p2 = P(123.12,0)
		local p3 = P(0,140 * math.sin(math.rad(60)))
		
		local l1 = L(p1,p2)
		
		return
		{
			points = {p2,p3},
			objects = {l1},
			targets = {L(p1,p3)},
		}
	end
})

table.insert(problems,
{
	code = "euclidea4.3",
	name = "Euclidea 4.3: Circumscribed Equilateral Triangle",
	steps = 6,
	setup = function()
		
		local r = 100
		local p1 = P(0,0)
		local p2 = P(r,0)
		
		local t1 = P(-2*r, 0)
		local t2 = P(r, 2*r * math.sin(math.rad(60)))
		local t3 = P(t2.x, -t2.y)
		
		return
		{
			points = {p1,p2},
			objects = {C(p1,p2)},
			targets = { L(t1,t2), L(t2,t3), L(t3,t1)}
		}
	end
})

table.insert(problems,
{
	code = "euclidea4.4",
	name = "Euclidea 4.4: Equilateral Triangle in Circle",
	steps = 6,
	setup = function()
		
		local r = 100
		local c = P(0,0)
		
		local t0 = P(r,0)
		local t1 = P(r * math.cos(math.rad(120)), r * math.sin(math.rad(120)))
		local t2 = P(t1.x, -t1.y)
		
		local theta = math.rad(37.23)
		local h1 = P(r * math.cos(theta), r * math.sin(theta))
		
		return
		{
			points = {t0,h1},
			objects = {C(c,t0)},
			targets = { L(t1,t2), L(t2,t0), L(t0,t1)}
		}
	end
})

table.insert(problems,
{
	code = "euclidea4.5",
	name = "Euclidea 4.5: Cut Two Rectangles",
	steps = 5,
	setup = function()
		
		local k = 81.123
		local l = 33.987
		
		local dx = 201
		local dy = -45
	
		local p1 = P(-k + dx,l + dy)
		local p2 = P(k + dx,l + dy)
		local p3 = P(k + dx,-l + dy)
		local p4 = P(-k + dx,-l + dy)
		
		local l1,l2,l3,l4 = L(p1,p2), L(p2,p3), L(p3,p4), L(p4,p1)
		
		local k = 35.23
		local l = 87.1
		
		local dx = -225
		local dy = -156
	
		local q1 = P(k + dx,l + dy)
		local q2 = P(l + dx,k + dy)
		local q3 = P(-k + dx,-l + dy)
		local q4 = P(-l + dx,-k + dy)
		
		local m1,m2,m3,m4 = L(q1,q2), L(q2,q3), L(q3,q4), L(q4,q1)
		
		local cx = (p1.x + p2.x + p3.x + p4.x) / 4
		local cy = (p1.y + p2.y + p3.y + p4.y) / 4
		local dx = (q1.x + q2.x + q3.x + q4.x) / 4
		local dy = (q1.y + q2.y + q3.y + q4.y) / 4
		
		local tl = L(P(cx,cy), P(dx,dy))
		
		return
		{
			points = {p1,p2,p3,p4,q1,q2,q3,q4},
			objects = {l1,l2,l3,l4,m1,m2,m3,m4},
			targets = {tl},
			restrictions = {L(p1,p3), L(p2,p4), L(q1,q3), L(q2,q4)}
		}
	end
})

do return problems end

table.insert(problems,
{
	code = "euclidea4.6",
	name = "Euclidea 4.6: Square Root of 2",
	steps = 5,
	setup = function()
		
		local r = 80
		
		local p1 = P(-r,0)
		local p2 = P(0,0)
		
		local t = P(r * math.sqrt(2) - r,0)
		local l = L(p1,p2)
		
		return
		{
			points = {p1,p2},
			objects = {l},
			targets = {t}
		}
	end
})


table.insert(problems,
{
	code = "euclidea4.7",
	name = "Euclidea 4.7: Square Root of 3",
	steps = 3,
	setup = function()
		
		local r = 80
		
		local p1 = P(-r,0)
		local p2 = P(0,0)
		
		local t = P(r * math.sqrt(3) - r,0)
		local l = L(p1,p2)
		
		return
		{
			points = {p1,p2},
			objects = {l},
			targets = {t}
		}
	end
})

table.insert(problems,
{
	code = "euclidea4.8",
	name = "Euclidea 4.8: Angle of 15°",
	steps = 5,
	setup = function()
		
		local p1 = P(0,0)
		local p2 = P(100,0)
		local p3 = P(100 * math.cos(math.rad(15)), 100 * math.sin(math.rad(15)))
		
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
	code = "euclidea4.9",
	name = "Euclidea 4.9: Square by Opposite Midpoints",
	steps = 10,
	setup = function()
		
		local r = 75
		
		local t1 = P(r,r)
		local t2 = P(r,-r)
		local t3 = P(-r,-r)
		local t4 = P(-r,r)
		
		local l1 = L(t1,t2)
		local l2 = L(t2,t3)
		local l3 = L(t3,t4)
		local l4 = L(t4,t1)
		
		local p1 = P(-r,0)
		local p2 = P(r,0)
		
		return
		{
			points = {p1, p2},
			objects = {},
			targets = {l1,l2,l3,l4},
			restrictions = {"circle","circle", "line", "line", "circle", "line", "line", "line", "circle", "line"}
		}
	end
})


table.insert(problems,
{
	code = "euclidea4.10",
	name = "Euclidea 4.10: Square by Adjacent Midpoints",
	steps = 10,
	setup = function()
		
		local r = 75
		
		local t1 = P(r,r)
		local t2 = P(r,-r)
		local t3 = P(-r,-r)
		local t4 = P(-r,r)
		
		local l1 = L(t1,t2)
		local l2 = L(t2,t3)
		local l3 = L(t3,t4)
		local l4 = L(t4,t1)
		
		local p1 = P(0,r)
		local p2 = P(r,0)
		
		return
		{
			points = {p1, p2},
			objects = {},
			targets = {l1,l2,l3,l4},
			restrictions = {"line", "circle","circle", "line", "circle", "line", "line", "circle", "line", "line"}
		}
	end
})


return problems