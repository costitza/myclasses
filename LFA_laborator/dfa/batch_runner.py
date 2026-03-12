import subprocess
import sys


saved_file = "result_dfa.txt"
test_file = sys.argv[1]
print(test_file)

with open(test_file, 'r') as f, open(saved_file, 'w') as g:
    lines = f.readlines()
    for line in lines:
        clean_line = line.strip()
        result = subprocess.run(
            ["python", "run_dfa.py", clean_line],
            capture_output=True,
            text=True
        )
        
        dfa_status = result.stdout.strip()

        g.write(f"{dfa_status}\n")




