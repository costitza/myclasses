import subprocess
import sys
import os

if len(sys.argv) < 3:
    print("Usage: python batch_runner_nfa.py <json_config> <test_file>")
    sys.exit(1)

json_config = sys.argv[1]
test_file = sys.argv[2]
output_file = "result_nfa.txt"

print(f"Running tests from {test_file} using {json_config}...")

with open(test_file, 'r') as f, open(output_file, 'w') as g:
    lines = f.readlines()
    for line in lines:
        clean_line = line.strip()
        # Skip empty lines
        if not clean_line:
            continue
            
        # Adjust path to runner_nfa.py if needed. Assuming it's in the same dir as this script.
        script_dir = os.path.dirname(os.path.abspath(__file__))
        runner_path = os.path.join(script_dir, "runner_nfa.py")
        
        result = subprocess.run(
            ["python", runner_path, json_config, clean_line],
            capture_output=True,
            text=True
        )
        
        nfa_status = result.stdout.strip()
        if nfa_status:
            print(nfa_status)
            g.write(f"{nfa_status}\n")
        else:
            # Catch errors if any
            error_status = result.stderr.strip()
            if error_status:
                print(f"Error for '{clean_line}': {error_status}")
                g.write(f"Error for '{clean_line}': {error_status}\n")

print(f"Results saved to {output_file}")
