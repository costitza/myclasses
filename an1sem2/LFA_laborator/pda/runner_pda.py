from os import access
import sys
import json


def get_pda(filename):
    
    with open(filename, "r") as f:
        return json.load(f)
    

def get_eps_closure(configs, transitions):
    """
    Computes the epsilon closure for a set of configurations.
    A configuration is a tuple: (state, stack_tuple)
    """
    closure = set(configs)
    stack = list(configs)

    while stack:
        curr_st, curr_stack = stack.pop()
        
        # Look for transitions on the empty string ""
        eps_transitions = transitions.get(curr_st, {}).get("", {})
        
        # Iterate through possible stack symbols to pop
        for pop_sym, actions in eps_transitions.items():
            can_transition = False
            new_stack_base = curr_stack
            
            # Check if we can pop without consuming (epsilon pop) 
            if pop_sym == "":
                can_transition = True
            # Or check if the top of our stack matches the required pop symbol
            elif curr_stack and curr_stack[0] == pop_sym:
                can_transition = True
                new_stack_base = curr_stack[1:] 

            if can_transition:
                for next_state, push_syms in actions:
                    
                    new_stack = tuple(push_syms) + new_stack_base
                    new_config = (next_state, new_stack)
                    
                    if new_config not in closure:
                        closure.add(new_config) 
                        stack.append(new_config) 

    return closure


def run_pda(pda, string):
    start_config = (pda['start_state'], pda['start_stack_symbol'])

    current_configs = get_eps_closure([start_config], pda['transitions'])

    for ch in string:
        next_configs = set()

        for state, curr_stack in current_configs:

            ch_transitions = pda['transitions'].get(state, {}).get(ch, [])

            for pop_sym, actions in ch_transitions.items():

                can_transition = False
                new_stack_base = curr_stack

                if pop_sym == "":
                    can_transition = True
                elif curr_stack and curr_stack[0] == pop_sym:
                    can_transition = True
                    new_stack_base = curr_stack[1:]

                if can_transition:
                    for next_state, push_sym in actions:
                        new_stack = tuple(push_sym) + new_stack_base

                        next_configs.add((next_state, new_stack))

        current_configs = get_eps_closure(next_configs, pda['transitions'])

        if not current_configs:
            break
    return current_configs



def validation(pda, final_configs, string):
    accept_sts = set(pda['accept_states'])

    for state, stack in final_configs:
        if state in accept_sts:
            print(f"{string} -> ACCEPTED (Final State: {state}, Final Stack: {stack})")
            return
            
    print(f"{string} -> REJECTED")



def main(): #[cite: 1]
    if len(sys.argv) < 3: #[cite: 1]
        print("Usage: python runner_pda.py <json_config_path> <input_string>") 
        return #[cite: 1]

    json_path = sys.argv[1]
    input_string = sys.argv[2]

    try:
        pda = get_pda(json_path)
        results = run_pda(pda, input_string)
        validation(pda, results, input_string)
    except FileNotFoundError: 
        print(f"Error: File {json_path} not found.") 
    except Exception as e: 
        print(f"Error: {e}") 

if __name__ == "__main__": 
    main()