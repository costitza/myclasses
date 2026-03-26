import sys
import json



def get_nfa(filepath):
    with open('nfa.json', 'r') as f:
        nfa = json.load(f)


def get_eps_closure(states, transitions):
    
    closure = set(states)
    stack = list(states)

    while stack:
        curr_st = stack.pop()

        new_destinations = transitions.get(curr_st, {}).get("", [])

        for new_st in new_destinations:
            if new_st not in closure:
                closure.add(new_st)

                stack.append(new_st)

    return closure

def run_nfa(nfa):
    current_states = get_eps_closure(nfa['start_state'], nfa['transitions'])

    string = sys.argv[1]

    for ch in string:

        next_states = set()

        for state in current_states:
            destinations = nfa['transitions'].get(state, {}).get(ch, [])
            next_states.update(destinations)

        current_states = get_eps_closure(next_states, nfa['transitions'])

        if not current_states:
            break
    return current_states


def validation(nfa, validation_states):
    accept_sts = nfa['accept_states']

    if validation_states.intersection(accept_sts):
        print(f"{sys.argv[1]} -> ACCEPTED")
    else:
        print(f"{sys.argv[1]} -> REJECTED")


def main():
    nfa = get_nfa('nfa.json')

    results = run_nfa(nfa)

    validation(nfa, results)


if __name__ == "__main__":
    main()

