DEBUG = -g
OBJECTS = hextile.zo funutil.zo lstutil.zo graph.zo board.zo hex.zo player.zo hextest.zo 
INTERFACE = hextile.zi funutil.zi lstutil.zi graph.zi hex.zi hextest.zi board.zi player.zi

all: hextest

hextest: $(OBJECTS)
	camlc -o hextest $(OBJECTS)

hextest.zo hextest.zi: hextest.ml hex.zi player.zi board.zi hextile.zi
	camlc $(DEBUG) -c hextest.ml

player.zo player.zi: player.ml hex.zi board.zi lstutil.zi graph.zi hextile.zi
	camlc $(DEBUG) -c player.ml

hex.zo hex.zi: hex.ml graph.zi hextile.zi lstutil.zi funutil.zi board.zi
	camlc $(DEBUG) -c  hex.ml

graph.zo graph.zi: graph.ml lstutil.zi
	camlc $(DEBUG) -c graph.ml

hextile.zo hextile.zi: hextile.ml
	camlc $(DEBUG) -c hextile.ml

lstutil.zo lstutil.zi: lstutil.ml
	camlc $(DEBUG) -c lstutil.ml

funutil.zo funutil.zi: funutil.ml
	camlc $(DEBUG) -c funutil.ml

board.zo board.zi: hextile.zi board.ml
	camlc $(DEBUG) -c board.ml

clean:
	rm $(OBJECTS)
	rm $(INTERFACE)
