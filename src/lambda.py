import numpy

def handler(event, context):
   print('hello lambda with dependencies')
   print(numpy.__version__)
