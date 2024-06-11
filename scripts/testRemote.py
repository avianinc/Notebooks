import sys

def multiply(a, b):
    return a * b * 2

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python test.py <number1> <number2>")
        exit(1)

    number1 = float(sys.argv[1])
    number2 = float(sys.argv[2])

    result = multiply(number1, number2)
    print(result)
