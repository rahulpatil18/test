# calculator.py
import sys
import os
sys.path.insert(0, os.path.abspath(os.path.dirname(__file__) + "/.."))

from calculator import add, subtract

def add(a, b):
    return a + b

def subtract(a, b):
    return a - b
