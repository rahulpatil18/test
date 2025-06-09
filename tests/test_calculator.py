# tests/test_calculator.py
import sys
import os

# Add project root to PYTHONPATH
sys.path.insert(0, os.path.abspath(os.path.join(os.path.dirname(__file__), "..")))

from calculator import add, subtract

def test_add():
    assert add(2, 3) == 5

def test_subtract():
    assert subtract(5, 3) == 2
