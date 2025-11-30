#!/usr/bin/env python3

# Read the lcov.info file and calculate coverage
total_lines = 0
hit_lines = 0

with open('coverage/lcov.info', 'r') as f:
    for line in f:
        if line.startswith('LF:'):
            total_lines += int(line.split(':')[1].strip())
        elif line.startswith('LH:'):
            hit_lines += int(line.split(':')[1].strip())

if total_lines > 0:
    coverage_percentage = (hit_lines / total_lines) * 100
    print(f"Total lines: {total_lines}")
    print(f"Hit lines: {hit_lines}")
    print(f"Coverage: {coverage_percentage:.2f}%")
else:
    print("No coverage data found")