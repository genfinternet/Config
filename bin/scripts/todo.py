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

class Color():
    H1 = "\033[1;4m"
    H2 = "\033[1m"
    H3 = "\033[36m"
    G = "\033[32m"
    W = "\033[31m"
    R = "\033[0m"
    T = "\033[34;1m"


class Tasks():
    name="Tasks"
    done=False

    def __init__(self, name="Task"):
        self.name = name
    
    def write(self, f):
        if self.done is True:
            f.write("    - [x] " + self.name + os.linesep)
        else:
            f.write("    - [ ] " + self.name + os.linesep)

class SubPart:
    name="SubPart"
    tasks = list()

    def __init__(self, name="Subpart"):
        self.name = name
        self.tasks = list()
        self.tasks.append(Tasks())

    def write(self, f):
        f.write("* " + self.name + " **100%**" + os.linesep)
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
        f.write(self.name + " **100%**" + os.linesep)
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
        i = 1
        j = 1
        k = 1
        self.mainparts=list()
        main = None
        sub = None
        task = None
        oldline="@"
        for line in lines:
            if not line == os.linesep:
                if "-" == line[0]:
                    if not main is None:
                        if not sub is None:
                            main.subparts.append(sub)
                            sub=None
                        self.mainparts.append(main)
                    main=MainPart()
                    main.subparts=list()
                    main.name=oldline[:-10]
                    i = i + 1
                    j = 1
                    k = 1
                    #new main part
                if "*" == oldline[0]:
                    if not main is None:
                        if not sub is None:
                            main.subparts.append(sub)
                    sub=SubPart()
                    sub.tasks=list()
                    sub.name=oldline[2:-10]
                    #new subpart
                    k = 0
                    j = j + 1 
                if " " == oldline[0]:
                    task=Tasks()
                    task.name=oldline[10:-1]
                    if oldline[7] == "x":
                        task.done = True
                    else:
                        task.done = False
                    if not main is None:
                        if not sub is None:
                            if not task is None:
                                sub.tasks.append(task)
                    #new subpart
                    k = k + 1
                if "#" == oldline[0]:
                    # project name
                    self.name=oldline[1:]
                oldline=line

        if not os.linesep == oldline or " " == oldline[0]:
            task=Tasks()
            task.name=oldline[10:-1]
            if oldline[7] == "x":
                task.done = True
            else:
                task.done = False
            if not main is None:
                if not sub is None:
                    if not task is None:
                        sub.tasks.append(task)
        if not main is None:
            if not sub is None:
                main.subparts.append(sub)
            self.mainparts.append(main)


    def write(self, f):
        f.write("#" + self.name + os.linesep)
        f.write(os.linesep)
        for m in self.mainparts:
            m.write(f)

    def print(self):
        i = 0
        maxi = -1
        maxibis = -1
        for m in self.mainparts:
            i = i + 1
            roman=toRoman(i)
            j = 0
            k = 0
            for s in m.subparts:
                j = j + 1
                k = 0
                for t in s.tasks:
                    test = len("    " + roman + "." + str(j) + "." + str(k))
                    if maxi < test:
                        maxi=test
                    test = len(t.name)
                    if maxibis < test:
                        maxibis = test
        maxi = maxi + 1
        maxibis = maxibis + 1
        print(Color.T + "TODO file for project:", self.name[:-1] + Color.R)
        i = 0
        for m in self.mainparts:
            i = i + 1
            roman=toRoman(i)
            print(Color.T + (roman).ljust(maxi) +":" + Color.R, Color.H1 + m.name + Color.R)
            j = 0
            k = 0
            for s in m.subparts:
                j = j + 1
                print(Color.T + ("  " + roman + "." + \
                        str(j)).ljust(maxi) + ":" + Color.R , Color.H2 + \
                        s.name + Color.R)
                k = 0
                for t in s.tasks:
                    k = k + 1
                    if t.done:
                        print(Color.T + ("    " + roman + "." + str(j) + "." + \
                                str(k)).ljust(maxi) + ":" + Color.R, \
                                Color.H3 + t.name.ljust(maxibis) + Color.R, \
                                Color.G + "[x]" + Color.R)
                    else:
                        print(Color.T + ("    " + roman + "." + str(j) + "." + \
                                str(k)).ljust(maxi) + ":" + Color.R, \
                                Color.H3 + t.name.ljust(maxibis) + Color.R, \
                                Color.W + "[ ]" + Color.R)

#Define digit mapping
romanNumeralMap = (('M',  1000),
                   ('CM', 900),
                   ('D',  500),
                   ('CD', 400),
                   ('C',  100),
                   ('XC', 90),
                   ('L',  50),
                   ('XL', 40),
                   ('X',  10),
                   ('IX', 9),
                   ('V',  5),
                   ('IV', 4),
                   ('I',  1))

def toRoman(n):
    """convert integer to Roman numeral"""
    if not (0 < n < 5000):
        raise(OutOfRangeError, "number out of range (must be 1..4999)")
    if int(n) != n:
        raise(NotIntegerError, "decimals can not be converted")

    result = ""
    for numeral, integer in romanNumeralMap:
        while n >= integer:
            result += numeral
            n -= integer
    return result

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
        project.print()
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
