import re
import argparse

def load_replacements(file_path):
    """Load regex replacements from a file with 'pattern;replacement' rows."""
    replacements = []
    with open(file_path, encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line or ";" not in line:
                continue
            pattern, repl = line.split(";", 1)
            replacements.append((pattern, repl))
    return replacements

def apply_replacements(text, replacements):
    """Apply regex replacements sequentially to the text."""
    for pattern, repl in replacements:
        text = re.sub(pattern, repl, text)
    return text

def main():
    parser = argparse.ArgumentParser(
        description="Apply regex replacements from a file to an input text file."
    )
    parser.add_argument("replacements_file", help="File containing pattern;replacement rows")
    parser.add_argument("input_file", help="File containing text to process - changes are made in place")
    args = parser.parse_args()

    # Load replacements
    replacements = load_replacements(args.replacements_file)

    # Read input text
    with open(args.input_file, encoding="utf-8") as f:
        text = f.read()

    # Write backup of file
    with open(args.input_file + '.bak', "w", encoding="utf-8") as f:
        f.write(text)

    # Apply replacements
    result = apply_replacements(text, replacements)

    # Write output
    with open(args.input_file, "w", encoding="utf-8") as f:
        f.write(result)
 
if __name__ == "__main__":
    main()
