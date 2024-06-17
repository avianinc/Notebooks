import sys

def check_type(input):
    if isinstance(input, str):
        return "String"
    elif isinstance(input, int):
        return "Integer"
    elif isinstance(input, float):
        return "Float"
    else:
        return type(input).__name__

def multiply(a, b):
    return a * b

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python test.py <number1> <number2>")
        exit(1)

    number1 = sys.argv[1]
    number2 = sys.argv[2]

    # Check and report the type of input
    print(f"The type of number1 is: {check_type(number1)}")
    print(f"The type of number2 is: {check_type(number2)}")

    try:
        number1 = float(number1)
        number2 = float(number2)
    except ValueError:
        print("Both inputs should be numbers.")
        exit(1)

    result = multiply(number1, number2)
    print(f"The multiplication result is: {result}")
