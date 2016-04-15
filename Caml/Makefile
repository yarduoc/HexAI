DEBUG = -g
OBJECTS = hextile.zo funutil.zo lstutil.zo graph.zo hex.zo hextest.zo 
INTERFACE = hextile.zi funutil.zi lstutil.zi graph.zi hex.zi hextest.zi 

hextest: hextile.zo funutil.zo lstutil.zo graph.zo hex.zo hextest.zo 
	camlc -o hextest $(OBJECTS)

hextest.zo hextest.zi: hextest.ml hex.zi
	camlc $(DEBUG) -c hextest.ml

hex.zo hex.zi: hex.ml graph.zi hextile.zi lstutil.zi funutil.zi
	camlc $(DEBUG) -c  hex.ml

graph.zo graph.zi: graph.ml lstutil.zo
	camlc $(DEBUG) -c graph.ml

hextile.zo hextile.zi: hextile.ml
	camlc $(DEBUG) -c hextile.ml

lstutil.zo lstutil.zi: lstutil.ml
	camlc $(DEBUG) -c lstutil.ml

funutil.zo funutil.zi: funutil.ml
	camlc $(DEBUG) -c funutil.ml

clean:
	rm $(OBJECTS)
	rm $(INTERFACE)
