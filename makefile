# Build
OUTPUT = main.exe
OBJS = main.obj
# Configuration
SrcPath = src

Assembler = D:\masm32\bin\ml.exe
AssemblerOption = -c -coff 

ResourceCompiler = D:\masm32\bin\rc.exe

Linker = D:\masm32\bin\link.exe
LinkOption = -subsystem:windows -OUT:$(OUTPUT)

# Targets Rule
$(OUTPUT): $(OBJS)
	$(Linker) $(OBJS) $(RESS) $(LinkOption)
%.obj: $(SrcPath)/%.asm
	$(Assembler) $(AssemblerOption) -Fo $@ $<
clean:
	- rm $(BuildPath)/$(OBJS)
	- rm $(BuildPath)/$(RESS)