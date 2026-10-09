import sys
import json

# Load the prepared DFA
with open('dfa.json', 'r') as f:
    dfa = json.load(f)

# Run the string through the DFA
current_state = dfa['start_state']
for symbol in sys.argv[1]:
    current_state = dfa['transitions'].get(current_state, {}).get(symbol)
    if current_state is None:
        break

# Output the result
if current_state in dfa['accept_states']:
    print(f"{sys.argv[1]} -> ACCEPTED")
else:
    print(f"{sys.argv[1]} -> REJECTED")
