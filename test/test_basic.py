from mathutils.basic import double, halve

def test_double():
    assert double(4) == 8

def test_halve():
    assert halve(10) == 5