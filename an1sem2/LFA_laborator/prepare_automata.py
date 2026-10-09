import sys
import yaml
import json
import os

# Ensure automatas directory exists
os.makedirs('automatas', exist_ok=True)

# Read YAML config
with open(sys.argv[1], 'r') as f:
    config = yaml.safe_load(f)

# Get output filename from input filename
input_filename = os.path.basename(sys.argv[1])
output_filename = os.path.splitext(input_filename)[0] + '.json'
output_path = os.path.join('automatas', output_filename)

# Save to JSON
with open(output_path, 'w') as f:
    json.dump(config, f, indent=4)

print(f"Saved to {output_path}")
