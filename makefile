# Build
OUTPUT = main.exe
OBJS = main.obj image.obj paint.obj
# Configuration
SrcPath = src

Assembler = D:\ProgramFilesP\masm32\bin\ml.exe
AssemblerOption = -c -coff 

ResourceCompiler = D:\ProgramFilesP\masm32\bin\rc.exe

Linker = D:\ProgramFilesP\masm32\bin\link32.exe
LinkOption = -subsystem:windows -OUT:$(OUTPUT)

# Targets Rule
$(OUTPUT): $(OBJS)
	$(Linker) $(OBJS) $(RESS) $(LinkOption)
%.obj: $(SrcPath)/%.asm
	$(Assembler) $(AssemblerOption) -Fo $@ $<
clean:
	- rm $(BuildPath)/$(OBJS)
	- rm $(BuildPath)/$(RESS)
