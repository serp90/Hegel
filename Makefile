drafts_dir = Drafts
releases_dir = Releases
gitinfo_file = .git/gitHeadInfo.gin
branch = $(shell git branch --show-current)
tags = $(shell git describe --tags --long --always --dirty)
date = $(shell git --no-pager log -1 --date=short --decorate=short --pretty=format:"%cd" )

all: tom1 tom2 tom3

allg: tom1g tom2g tom3g cleand

tom1:
	latexmk -pdflatex gegel1 | tail -n20
	echo -e \\a

tom1g:git_checkout
	latexmk -pdflatex -output-directory=$(drafts_dir) -jobname=hegel1_$(date)_$(branch)_$(tags) gegel1 | tail -n20
	echo -e \\a

release_tom1:git_checkout
	latexmk -pdflatex -output-directory=$(releases_dir) -jobname=hegel1_$(date)_$(branch)_$(tags) gegel1 | tail -n20
	echo -e \\a

tom1v:git_checkout
	latexmk -pdflatex gegel1

tom2:git_checkout
	latexmk -pdflatex gegel2 | tail -n20
	echo -e \\a

tom2g:git_checkout
	latexmk -pdflatex -output-directory=$(drafts_dir) -jobname=hegel2_$(date)_$(branch)_$(tags) gegel2 | tail -n20
	echo -e \\a

tom2v:git_checkout
	latexmk -pdflatex gegel2

tom3:git_checkout
	latexmk -pdflatex gegel3 | tail -n20
	echo -e \\a

tom3g:git_checkout
	latexmk -pdflatex -output-directory=$(drafts_dir) -jobname=hegel3_$(date)_$(branch)_$(tags) gegel3 | tail -n20
	echo -e \\a

tom3v:git_checkout
	latexmk -pdflatex gegel3

.phony: clean cleanall cleand

clean:
	rm *.aux *.toc *.ent *.log *.fdb_latexmk *.fls *.gz

cleand:
	rm $(drafts_dir)/*.aux $(drafts_dir)/*.toc $(drafts_dir)/*.ent $(drafts_dir)/*.log $(drafts_dir)/*.idx $(drafts_dir)/*-dirty.pdf $(drafts_dir)/*.ent $(drafts_dir)/*.fdb_latexmk $(drafts_dir)/*.fls

cleanall: clean
	rm *.pdf

git_checkout:
	# Запускаем git-checkout хук для обновления gitinfo_file
	git checkout
