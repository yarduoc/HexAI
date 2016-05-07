OBJECTS = hextile.zo lstutil.zo graph.zo board.zo hex.zo player.zo hextest.zo 
INTERFACE = hextile.zi lstutil.zi graph.zi hex.zi hextest.zi board.zi player.zi
TARGET = hextest
OPTIONS = 
DEBUG_SUFFIX = -debug

.PHONY: clean debug all

all: $(TARGET)

debug: OPTIONS := $(OPTIONS) -g
debug: TARGET := $(TARGET)$(DEBUG_SUFFIX)
debug: all

$(TARGET): $(OBJECTS)
	camlc -o $(TARGET) $(OBJECTS)

hextest.zo hextest.zi: hextest.ml hex.zi player.zi board.zi hextile.zi
	camlc $(OPTIONS) -c hextest.ml

player.zo player.zi: player.ml hex.zi board.zi lstutil.zi graph.zi hextile.zi
	camlc $(OPTIONS) -c player.ml

hex.zo hex.zi: hex.ml graph.zi hextile.zi lstutil.zi board.zi
	camlc $(OPTIONS) -c  hex.ml

graph.zo graph.zi: graph.ml lstutil.zi
	camlc $(OPTIONS) -c graph.ml

hextile.zo hextile.zi: hextile.ml
	camlc $(OPTIONS) -c hextile.ml

lstutil.zo lstutil.zi: lstutil.ml
	camlc $(OPTIONS) -c lstutil.ml

board.zo board.zi: hextile.zi board.ml
	camlc $(OPTIONS) -c board.ml

clean:
	rm -f $(OBJECTS)
	rm -f $(INTERFACE)
	rm -f $(TARGET)
	rm -f $(TARGET)$(DEBUG_SUFFIX)
