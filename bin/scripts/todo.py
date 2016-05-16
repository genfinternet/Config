#!/usr/bin/env python3

import argparse
import os
import sys

parser = argparse.ArgumentParser(description='TODO Manager')
parser.add_argument('-f', action="store", default="TODO.md", dest="f",
        help='Specify the todo file')

args = parser.parse_args()
filepath=args.f

filename=os.path.basename(filepath)

class Tasks():
    name="Tasks"
    done=False

    def __init__(self, name="Task"):
        self.name = name
    
    def write(self, f):
        if self.done is True:
            f.write("     - [x] " + self.name + os.linesep)
        else:
            f.write("     - [ ] " + self.name + os.linesep)

class SubPart:
    name="SubPart"
    tasks = list()

    def __init__(self, name="Subpart"):
        self.name = name
        self.tasks = list()
        self.tasks.append(Tasks())

    def write(self, f):
        f.write("* " + self.name + os.linesep)
        f.write(os.linesep)
        for t in self.tasks:
            t.write(f)

class MainPart:
    name="MainPart"
    subparts=list()
    
    def __init__(self, name="MainPart"):
        self.name = name
        self.subparts=list()
        self.subparts.append(SubPart())

    def write(self, f):
        f.write(self.name + os.linesep)
        for i in range(0, len(self.name)):
            f.write("-")
        f.write(os.linesep)
        f.write(os.linesep)
        for s in self.subparts:
            s.write(f)

class Todo:
    name="Project"
    mainparts=list()

    def __init__(self, name="Project"):
        self.name = name
        self.mainparts=list()
        self.mainparts.append(MainPart())

    def load(self, lines):
        pass

    def write(self, f):
        f.write("#" + self.name + os.linesep)
        f.write(os.linesep)
        for m in self.mainparts:
            m.write(f)

def load(f):
    for line in f.readlines():
        sys.stdout.write(line)
    return None

def not_yet_implemented():
    print("Not yet implemented")

def display_help():
    print("Available commands:")
    print("  - exit     : exit the assistant")
    print("  - quit     : save and exit the assistant")
    print("  - help     : display this message")
    print("  - print    : print the current save of the todo")
    print("  - save     : save the todo to the file")


def menu(filepath, project : Todo):
    choice=query_menu("Enter a command")
    if choice == 0: # Quit without saving
        return False
    elif choice == 1: # Save and quit
        f = open(filepath, "w+")
        project.write(f)
        print("Project saved to file")
        return False
    elif choice == 2: #Help
        display_help()
        return True
    elif choice == 3: #Print
        not_yet_implemented()
        return True
    elif choice == 4: #Save
        f = open(filepath, "w+")
        project.write(f)
        print("Project saved to file")
        return True
    else:
        return True #Shall not happen

def menu_loop(filepath, project : Todo=None):
    if project is None:
        project=Todo()
        print("File created! Loading...")
    while menu(filepath, project):
        pass

def query_menu(question):
    valid = {"exit": 0, "quit" : 1, "help" : 2, "print" : 3, \
            "save" : 4 }
    prompt = " (help/exit): "

    while True:
        sys.stdout.write(question + prompt)
        choice = input().lower()
        if not choice == '' and choice in valid:
            return valid[choice]
        else:
            print("Please enter a valid command.")

def query_yes_no(question, default="yes"):
    valid = {"yes": True, "y": True, "ye": True,
             "no": False, "n": False}

    if default is None:
        prompt = " [y/n]: "
    elif default == "yes":
        prompt = " [Y/n]: "
    elif default == "no":
        prompt = " [y/N]: "
    else:
        raise ValueError("invalid default answer: '%s'" % default)

    while True:
        sys.stdout.write(question + prompt)
        choice = input().lower()
        if default is not None and choice == '':
            return valid[default]
        elif choice in valid:
            return valid[choice]
        else:
            print("Please respond with 'yes' or 'no' (or 'y' or 'n').")

if os.path.isfile(filepath):
    print(filename, "found! Loading...")
    f = open(filepath, "r+")
    project = Todo()
    project.load(f)
    menu_loop(filepath, project)

else:
    if query_yes_no(filename + " file not found, do you want to create it ?"):
        f = open(filepath, "w+")
        menu_loop(filepath)

    else:
        print("Aborting...")
        exit()
