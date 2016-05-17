#!/usr/bin/env python3

import argparse
import os
import sys
import re

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
        f.write(os.linesep + self.name + " **100%**" + os.linesep)
        for i in range(0, len(self.name + " **100%**")):
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
                    self.name=oldline[1:-1]
                oldline=line

        if not os.linesep == oldline:
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
            if "*" == oldline[0]:
                sub=SubPart()
                sub.tasks=list()
                sub.name=oldline[2:-10]
                if not main is None:
                    if not sub is None:
                        main.subparts.append(sub)
        if not main is None:
            if not sub is None:
                main.subparts.append(sub)
            self.mainparts.append(main)


    def write(self, f):
        f.write("#" + self.name + os.linesep)
        for m in self.mainparts:
            m.write(f)

    def toggle(self, section, state):
        i = 0
        sections = section.split(".")
        size=len(sections)
        if size == 1:
            index1=fromRoman(sections[0]) - 1
            size=len(self.mainparts) 
            if size <= index1:
               return 
            for y in self.mainparts[index1].subparts:
                for x in y.tasks:
                    if state is None:
                        x.done = not x.done
                    else:
                        b = state.lower()
                        if b == "true" or b == "t":
                            x.done = True
                        elif b == "false" or b == "f":
                            x.done = False
                        else:
                            print("Incorrect value enter false or true")
        elif size == 2:
            index1=fromRoman(sections[0]) - 1
            index2=int(sections[1]) - 1
            size=len(self.mainparts) 
            if size <= index1:
               return 
            size=len(self.mainparts[index1].subparts) 
            if size <= index2:
               return 
            size=len(self.mainparts[index1].subparts[index2].tasks) 
            for x in self.mainparts[index1].subparts[index2].tasks:
                if state is None:
                    x.done = not x.done
                else:
                    b = state.lower()
                    if b == "true" or b == "t":
                        x.done = True
                    elif b == "false" or b == "f":
                        x.done = False
                    else:
                        print("Incorrect value enter false or true")
                        return
        elif size == 3:
            index1=fromRoman(sections[0]) - 1
            index2=int(sections[1]) - 1
            index3=int(sections[2]) - 1
            size=len(self.mainparts) 
            if size <= index1:
               return 
            size=len(self.mainparts[index1].subparts) 
            if size <= index2:
               return 
            size=len(self.mainparts[index1].subparts[index2].tasks) 
            if size <= index3:
               return 
            x=self.mainparts[index1].subparts[index2].tasks[index3]
            if state is None:
                x.done = not x.done
            else:
                b = state.lower()
                if b == "true" or b == "t":
                    x.done = True
                elif b == "false" or b == "f":
                    x.done = False
                else:
                    print("Incorrect value enter false or true")
                    return

    def remove(self, section):
        i = 0
        sections = section.split(".")
        size=len(sections)
        if size == 1:
            index1=fromRoman(sections[0]) - 1
            size=len(self.mainparts) 
            if size <= index1:
               return
            x=self.mainparts[index1]
            self.mainparts.remove(x)
        elif size == 2:
            index1=fromRoman(sections[0]) - 1
            index2=int(sections[1]) - 1
            size=len(self.mainparts) 
            if size <= index1:
               return 
            size=len(self.mainparts[index1].subparts) 
            if size <= index2:
               return 
            x=self.mainparts[index1].subparts[index2]
            self.mainparts[index1].subparts.remove(x)
        elif size == 3:
            index1=fromRoman(sections[0]) - 1
            index2=int(sections[1]) - 1
            index3=int(sections[2]) - 1
            size=len(self.mainparts) 
            if size <= index1:
               return 
            size=len(self.mainparts[index1].subparts) 
            if size <= index2:
               return 
            size=len(self.mainparts[index1].subparts[index2].tasks) 
            if size <= index3:
               return 
            x=self.mainparts[index1].subparts[index2].tasks[index3]
            self.mainparts[index1].subparts[index2].tasks.remove(x)

    def add(self, section, newname):
        i = 0
        sections = section.split(".")
        size = len(sections)
        if size == 1:
            main = MainPart()
            main.subparts = list()
            main.name = newname
            index1=fromRoman(sections[0]) - 1
            self.mainparts.insert(index1, main)
        elif size == 2:
            sub = SubPart()
            sub.tasks = list()
            sub.name = newname
            index1=fromRoman(sections[0]) - 1
            index2=int(sections[1]) - 1
            size=len(self.mainparts) 
            if size <= index1:
               self.add(sections[0], newname)
               self.mainparts[size].subparts.insert(index2, sub)
            else:
               self.mainparts[index1].subparts.insert(index2, sub)
        elif size == 3:
            task = Tasks()
            task.done = False
            task.name = newname
            index1=fromRoman(sections[0]) - 1
            index2=int(sections[1]) - 1
            index3=int(sections[2]) - 1
            size=len(self.mainparts)
            if size <= index1:
                self.add(sections[0] + "." + sections[1], newname)
                size=len(self.mainparts)
                size2=len(self.mainparts[size - 1].subparts)
                self.mainparts[size - 1].subparts[size2 - 1].tasks.insert(index3, task)
            else:
                size=len(self.mainparts[index1].subparts)
                if size <= index2:
                    self.add(sections[0] + "." + sections[1], newname)
                    size=len(self.mainparts[index1].subparts)
                    self.mainparts[index1].subparts[size - 1].tasks.insert(index3, task)
                else:
                    self.mainparts[index1].subparts[index2].tasks.insert(index3, task)

    def rename(self, section, newname):
        i = 0
        for m in self.mainparts:
            i = i + 1
            roman=toRoman(i)
            if roman == section:
                m.name=newname
                return
            j = 0
            k = 0
            for s in m.subparts:
                j = j + 1
                if roman + "." + str(j) == section:
                    s.name=newname
                    return
                k = 0
                for t in s.tasks:
                    k = k + 1
                    if roman + "." + str(j) + "." + str(k) == section:
                        t.name=newname
                        return
   
    def export(self, filename):
        if os.path.isfile(filename):
            if not query_yes_no("File exist do you want to override it",\
                    default="no"):
                return
        f = open(filename, "w+")
        maxi=-1
        for m in self.mainparts:
            test = len(m.name) + 3
            if maxi < test:
                maxi=test
            for s in m.subparts:
                test = len(s.name) + 6
                if maxi < test:
                    maxi = test
                for t in s.tasks:
                    test = len(t.name) + 10
                    if maxi < test:
                        maxi = test
        maxi = maxi + 5
        f.write("TODO file for project: " + self.name + os.linesep)
        f.write(os.linesep)
        barwide(f, "START", maxi + 17)
        f.write(os.linesep)

        i = 0
        for m in self.mainparts:
            i = i + 1
            roman=toRoman(i)
            f.write((" # " + m.name).ljust(maxi) + "|----------| 100%" +\
                    os.linesep)
            j = 0
            k = 0
            for s in m.subparts:
                j = j + 1
                f.write(os.linesep)
                f.write(("    * " + s.name).ljust(maxi) +\
                        "|----------| 100%" + os.linesep)
                f.write(os.linesep)
                k = 0
                for t in s.tasks:
                    k = k + 1
                    if t.done:
                        f.write(("        - " + t.name).ljust(maxi) + \
                                "|----------| 100%" + os.linesep)
                    else:
                        f.write(("        - " + t.name).ljust(maxi) + \
                                "|          |   0%" + os.linesep)
        f.write(os.linesep)
        barwide(f, "END", maxi + 17)

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
def barwide(f, text, size):
    size = (size - (len(text) + 4) + 1) // 2
    for i in range(0, size):
        f.write("-")
    f.write("| " + text + " |")
    for i in range(0, size):
        f.write("-")
    f.write(os.linesep)

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

romanNumeralPattern = re.compile("""
    ^                   # beginning of string
    M{0,4}              # thousands - 0 to 4 M's
    (CM|CD|D?C{0,3})    # hundreds - 900 (CM), 400 (CD), 0-300 (0 to 3 C's),
                        #            or 500-800 (D, followed by 0 to 3 C's)
    (XC|XL|L?X{0,3})    # tens - 90 (XC), 40 (XL), 0-30 (0 to 3 X's),
                        #        or 50-80 (L, followed by 0 to 3 X's)
    (IX|IV|V?I{0,3})    # ones - 9 (IX), 4 (IV), 0-3 (0 to 3 I's),
                        #        or 5-8 (V, followed by 0 to 3 I's)
    $                   # end of string
    """ ,re.VERBOSE)

def fromRoman(s):
    """convert Roman numeral to integer"""
    if not s:
        raise(InvalidRomanNumeralError, 'Input can not be blank')
    if not romanNumeralPattern.search(s):
        raise(InvalidRomanNumeralError, 'Invalid Roman numeral: %s' % s)

    result = 0
    index = 0
    for numeral, integer in romanNumeralMap:
        while s[index:index+len(numeral)] == numeral:
            result += integer
            index += len(numeral)
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
    print("  - add      : add a new section")
    print("  - remove   : remove an existing section")
    print("  - toggle   : toggle the state of a task")
    print("  - export   : save on a more readable format")


def menu(filepath, project : Todo):
    choices=query_menu("Enter a command")
    choice=choices[0]
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
    elif choice == 5: #rename
        if len(choices[1]) != 3:
            print("Usage:")
            print("  rename section new_name")
        else:
            project.rename(choices[1][1], choices[1][2])
        return True
    elif choice == 6: # add
        if len(choices[1]) != 3:
            print("Usage:")
            print("  add section new_name")
        else:
            project.add(choices[1][1], choices[1][2])
        return True
    elif choice == 7: # add
        if len(choices[1]) != 2:
            print("Usage:")
            print("  remove section")
        else:
            project.remove(choices[1][1])
        return True
    elif choice == 8: # add
        size=len(choices[1])
        if size == 3:
            project.toggle(choices[1][1], choices[1][2])
        elif size == 2:
            project.toggle(choices[1][1], None)
        else:
            print("Usage:")
            print("  toggle section [True/False]")
        return True
    elif choice == 9: # add
        size=len(choices[1])
        if size == 2:
            project.export(choices[1][1])
        else:
            print("Usage:")
            print("  export FILE")
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
            "save" : 4, "rename" : 5, "add" : 6, "remove" : 7, \
            "toggle" : 8, "export" : 9 }
    prompt = " (help/exit): "
    while True:
        sys.stdout.write(question + prompt)
        choice = input()
        args=choice.split(" ", 2)
        if not choice == '' and args[0].lower() in valid:
            return (valid[args[0].lower()], args)
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
