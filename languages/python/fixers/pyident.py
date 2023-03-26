# python fix_indentation.py /path/to/your/python/script.py
import autopep8
import argparse
import os
def fix_indentation(file_path):
    # check if file exists
    if not os.path.isfile(file_path):
        print(f"Error: {file_path} does not exist")
        return

    # open the file and read its contents
    with open(file_path, 'r') as f:
        content = f.read()

    # fix indentation errors using autopep8
    fixed_content = autopep8.fix_code(content)

    # write the fixed content back to the file
    with open(file_path, 'w') as f:
        f.write(fixed_content)

    print(f"Indentation errors fixed for {file_path}")

if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Fix indentation errors in a Python script')
    parser.add_argument('file_path', type=str, help='path of the Python script')
    args = parser.parse_args()

    fix_indentation(args.file_path)

