%.html: venv
	mkdir -p out/$(dir $@)
	. $(VENV)/activate && pandoc -t html5 --template=template.html -F code-block-filter.py src/$*.md -o out/$*.html -s --syntax-definition=toml.xml --highlight-style=diesel.theme

guides: guides/all-about-updates.html guides/all-about-queries.html guides/all-about-inserts.html guides/composing-applications.html guides/configuring-diesel-cli.html guides/extending-diesel.html guides/getting-started.html guides/index.html guides/schema-in-depth.html
	cp -r src/guides/all-about-queries/ out/guides/all-about-queries/
	cp -r src/guides/all-about-inserts/ out/guides/all-about-inserts/
	cp -r src/guides/all-about-updates/ out/guides/all-about-updates/
	cp -r src/guides/composing-applications/ out/guides/composing-applications/
	cp -r src/guides/configuring-diesel-cli/ out/guides/configuring-diesel-cli/
	cp -r src/guides/extending-diesel/ out/guides/extending-diesel/
	cp -r src/guides/getting-started/ out/guides/getting-started/
	cp -r src/guides/schema-in-depth/ out/guides/schema-in-depth/


docs: docs/index.html

page: index.html guides docs
	cp -R assets out

clean:
	rm out -r

include Makefile.venv
