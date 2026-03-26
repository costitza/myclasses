import sys
import yaml
import json

# Read YAML config
with open(sys.argv[1], 'r') as f:
    config = yaml.safe_load(f)

# Save to nfa.json
with open('nfa.json', 'w') as f:
    json.dump(config, f, indent=4)

print("Saved to nfa.json")
