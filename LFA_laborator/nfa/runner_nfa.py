import sys
import json

def get_nfa(filepath):
    with open(filepath, 'r') as f:
        return json.load(f)

def get_eps_closure(states, transitions):
    if isinstance(states, str):
        states = [states]
    
    closure = set(states)
    stack = list(states)

    while stack:
        curr_st = stack.pop()
        new_destinations = transitions.get(curr_st, {}).get("", [])
        if isinstance(new_destinations, str):
            new_destinations = [new_destinations]

        for new_st in new_destinations:
            if new_st not in closure:
                closure.add(new_st)
                stack.append(new_st)

    return closure

def run_nfa(nfa, string):
    start_states = nfa['start_state']
    current_states = get_eps_closure(start_states, nfa['transitions'])

    for ch in string:
        next_states = set()
        for state in current_states:
            destinations = nfa['transitions'].get(state, {}).get(ch, [])
            if isinstance(destinations, str):
                destinations = [destinations]
            next_states.update(destinations)

        current_states = get_eps_closure(next_states, nfa['transitions'])

        if not current_states:
            break
    return current_states

def validation(nfa, validation_states, string):
    accept_sts = set(nfa['accept_states'])
    if validation_states.intersection(accept_sts):
        print(f"{string} -> ACCEPTED")
    else:
        print(f"{string} -> REJECTED")

def main():
    if len(sys.argv) < 3:
        print("Usage: python runner_nfa.py <json_config_path> <input_string>")
        return

    json_path = sys.argv[1]
    input_string = sys.argv[2]

    try:
        nfa = get_nfa(json_path)
        results = run_nfa(nfa, input_string)
        validation(nfa, results, input_string)
    except FileNotFoundError:
        print(f"Error: File {json_path} not found.")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    main()

