all: ./include.sh

master: ./include.sh ./m

slave: ./include.sh ./s

./include.sh:
	(cat include.sh.in | sed "s/{PORT}/${port}/g" | sed "s/{USER}/${user}/g" | sed "s|{DATADIR}|${datadir}|g" | sed "s|{BINDIR}|${bindir}|g") > ./include.sh
	chmod a+x ./include.sh
	./include.sh

./m:
	./master create

./s:
	./slave create

clean: clean-master clean-slave
	rm -rf ./include.sh

clean-master:
	rm -rf ./m

clean-slave:
	rm -rf ./s

install-master: ./include.sh ./m
	./master setup

install-slave: ./include.sh ./s
	./slave setup
