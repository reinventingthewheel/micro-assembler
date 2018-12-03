#! /usr/bin/python
import re
import sys

if __name__ == "__main__":
    labels = {}

    label_pattern = re.compile("^;#(\w+)$")
    jump_pattern = re.compile("^J\s+\d*\s*;\s*goto\s+#(\w+)$")

    with open("/dev/stdin") as file:
        lines = file.readlines()

        for line_number, line in enumerate(lines):
            match = label_pattern.match(line.strip())
            if match:
                labels[match.group(1)] = line_number + 1

        for line in lines:
            match = jump_pattern.match(line.strip())
            if match:
                label = match.group(1)
                target_line = labels[label]
                sys.stdout.write("J %d; goto #%s\n" % (target_line, label))
            else:
                sys.stdout.write(line)
