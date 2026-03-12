import sys
import yaml
import json

# Read YAML config
with open(sys.argv[1], 'r') as f:
    config = yaml.safe_load(f)

# Save to dfa.json
with open('dfa.json', 'w') as f:
    json.dump(config, f, indent=4)

print("Saved to dfa.json")
