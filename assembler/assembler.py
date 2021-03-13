
# regToBinary is a function that takes in the name of a register (e.g. r3) and
# returns the binary representation of the register number in a string format.
def regToBinary(reg):
    if reg == 'r0':
        return '00000'
    elif reg == 'r1':
        return '00001'
    elif reg == 'r2':
        return '00010'
    elif reg == 'r3':
        return '00011'
    elif reg == 'r4':
        return '00100'
    elif reg == 'r5':
        return '00101'
    elif reg == 'r6':
        return '00110'
    elif reg == 'r7':
        return '00111'
    elif reg == 'r8':
        return '01000'
    elif reg == 'r9':
        return '01001'
    elif reg == 'r10':
        return '01010'
    elif reg == 'r11':
        return '01011'
    elif reg == 'r12':
        return '01100'
    elif reg == 'r13':
        return '01101'
    elif reg == 'r14':
        return '01110'
    elif reg == 'r15':
        return '01111'
    else:
        return 'ERROR'


# instConverter is a function that takes in the name of the instruction and returns
# a concatenation of the opcode and funct code.
def instConverter(i):
    if i == 'add':
        return '0000'
    elif i == 'sub':
        return '0001'
    elif i == 'sll':
        return '0010'
    elif i == 'slr':
        return '0011'
    elif i == 'loi':
        return '0100'
    elif i == 'lor':
        return '0101'
    elif i == 'mov':
        return '0110'
    elif i == 'halt' or i == 'halt\n':
        return '0111'
    elif i == 'slt':
        return '1000'
    elif i == 'seq':
        return '1001'
    elif i == 'bp':
        return '1010'
    elif i == 'bn':
        return '1011'
    elif i == 'lw':
        return '1100'
    elif i == 'lwi':
        return '1101'
    elif i == 'sw':
        return '1110'
    elif i == 'swi':
        return '1111'
    else:
        return 'ERROR'


# Function that reads in the program assembly program code and writes it to a new
# file as machine code in the MIDS ISA.
def assembler():
    # Change to correct ISA Assembly Code file
    mids = open("square_root_code.txt", 'r')
    # Name output machine code file
    machine = open("machine_code_root.txt", 'w')
    mids_labels = {}
    mids_instr = []
    address = 0

    for line in mids:
        if line[len(line)-2] == ":":
            mids_labels[line[0:-2]] = address
        else:
            mids_instr.append({"instruction": line, "address": address})
            address += 1

    for line in mids_instr:
        instruction = line['instruction'].split(" ")
        address = line['address']
        machineCodeTranslation = ''

        # Decode and write instruction
        opCodeFunc = instConverter(instruction[0].lower())
        machineCodeTranslation += opCodeFunc

        # Check for reg, imm, branch
        if (opCodeFunc == '1010' or opCodeFunc == '1011'):
            # branch
            # First check for an error in the assembly code and reveal warning
            offset = abs(int(mids_labels[instruction[1][0:-1]]) - address)
            if offset > 31:
                print(("ERROR: Immediate larger than allowed - Target Address: {}, Current Address: {}, Instruction: {}").format(
                    address + offset, address, instruction))
                print("\tDistance: {}", offset)
                imm = 'ERROR'
            else:
                imm = format(offset, '05b')
            machineCodeTranslation = machineCodeTranslation + imm
        elif (opCodeFunc == '0100' or opCodeFunc == '1100' or opCodeFunc == '1101' or opCodeFunc == '1111'):
            # immediate
            # check for hash and remove it. If not, continue
            if '#' in instruction[1]:
                instruction[1] = instruction[1][1:-1]
                # First check for an error in the assembly code and reveal warning
            if int(instruction[1]) > 31:
                print(
                    ("ERROR: Immediate larger than allowed - Instruction: {}").format(line))
            machineCodeTranslation = machineCodeTranslation + \
                '{0:05b}'.format(int(instruction[1]))
        elif (opCodeFunc == '0111'):
            machineCodeTranslation = machineCodeTranslation + '00000'
        else:
            # reg
            machineCodeTranslation = machineCodeTranslation + \
                regToBinary(instruction[1][0:-1].lower())
            pass
        machine.write(machineCodeTranslation + '\n')

    mids.close()
    machine.close()


if __name__ == '__main__':
    assembler()
