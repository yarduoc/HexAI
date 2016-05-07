DEBUG =
OBJECTS = hextile.zo lstutil.zo graph.zo board.zo hex.zo player.zo hextest.zo 
INTERFACE = hextile.zi lstutil.zi graph.zi hex.zi hextest.zi board.zi player.zi
TARGET = hextest

all: hextest

$(TARGET): $(OBJECTS)
	camlc -o hextest $(OBJECTS)

hextest.zo hextest.zi: hextest.ml hex.zi player.zi board.zi hextile.zi
	camlc $(DEBUG) -c hextest.ml

player.zo player.zi: player.ml hex.zi board.zi lstutil.zi graph.zi hextile.zi
	camlc $(DEBUG) -c player.ml

hex.zo hex.zi: hex.ml graph.zi hextile.zi lstutil.zi board.zi
	camlc $(DEBUG) -c  hex.ml

graph.zo graph.zi: graph.ml lstutil.zi
	camlc $(DEBUG) -c graph.ml

hextile.zo hextile.zi: hextile.ml
	camlc $(DEBUG) -c hextile.ml

lstutil.zo lstutil.zi: lstutil.ml
	camlc $(DEBUG) -c lstutil.ml

board.zo board.zi: hextile.zi board.ml
	camlc $(DEBUG) -c board.ml

clean:
	rm $(OBJECTS)
	rm $(INTERFACE)
	rm $(TARGET)
