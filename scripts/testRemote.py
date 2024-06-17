import sys

def multiply(a, b):
    return a * b

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python test.py <number1> <number2>")
        exit(1)

    number1 = sys.argv[1]
    number2 = sys.argv[2]

    # Report the types of input variables
    print(f"The type of number1 is: {type(number1)}")
    print(f"The type of number2 is: {type(number2)}")

    try:
        number1 = float(number1)
        number2 = float(number2)
    except ValueError:
        print("Both inputs should be numbers.")
        exit(1)

    result = multiply(number1, number2)
    print(f"The multiplication result is: {result}")
