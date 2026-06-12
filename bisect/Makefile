SHELL=/bin/bash

test: 
	@CONTENIDO=$$(grep error archivo.txt || true) ; \
	if [[ "$$CONTENIDO" == "" ]]; \
	then \
	  echo "OK"; \
	else \
	  echo "Hay Error"; exit 1; \
	fi	
