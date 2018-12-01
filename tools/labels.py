#! /usr/bin/python
import re

if __name__ == "__main__":
    labels = {}

    label_pattern = re.compile("^;#(\w+)$")
    jump_pattern = re.compile("^J\s+\d*\s*;goto\s+#(\w+)$")

    with open("/dev/stdin") as file:
        lines = file.readlines()

        for line_number, line in enumerate(lines):
            match = label_pattern.match(line.strip())
            if match:
                labels[match.group(1)] = line_number

        for line in lines:
            match = jump_pattern.match(line.strip())
            if match:
                label = match.group(1)
                target_line = labels[label]
                print "J %d; goto #%s" % (target_line, label)
            else:
                print line