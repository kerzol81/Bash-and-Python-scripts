class PlaneFigure(object):

    def __init__(self, name='default'):
        self.name = name


class Circle(PlaneFigure):
    # the class attributes
    kind = 'plane figure'
    pi = 3.1416

    def __init__(self, radius=1, color='black'):
        PlaneFigure.__init__(self)
        self.radius = radius
        self.color = color

    def area(self):
        return (self.radius ** 2 ) * Circle.pi

    def perimeter(self):
        return (Circle.pi * 2) * self.radius


class Triangular(PlaneFigure):

    kind = 'poligon'

    def __init__(self, a = 1, b = 1, c=1 ):
        PlaneFigure.__init__(self)
        self.a = a
        self.b = b
        self.c = c

    def area(self):
        self.s = ( self.a + self.b + self.c ) / 2
        return (self.s * ( self.s - self.a ) * ( self.s - self.b ) * ( self.s - self.c ) ) ** 0.5

    def perimeter(self):
        return self.a + self.b + self.c
