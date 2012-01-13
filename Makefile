doc: *
	rm -rf doc && appledoc --no-create-docset --out doc --project-name Monsters2 --project-company RINIK  monsters2 && open doc/html/index.html 

opendoc: doc
	open doc/html/index.html