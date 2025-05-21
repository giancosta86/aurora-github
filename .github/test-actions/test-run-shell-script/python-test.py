import sys

arg_count = len(sys.argv[1:])

with open("result.txt", "w") as f:
  f.write(f"{2000 * arg_count}")