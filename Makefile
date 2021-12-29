
PRIORS = 0 1 2 4
VERSIONS = base rev
EXTS = tif pdf
MULT = 1
YEAR_MAX = 2030


.PHONY: all
all: shared natnhes natall subnat paper submission


## Objects shared across all models

.PHONY: shared
shared:
	$(MAKE) -C shared


## National-level model using only NHES data on obesity

make_natnhes = $(MAKE) -C natnhes PRIOR=$(PRIOR) YEAR_MAX=$(YEAR_MAX) MULT=$(MULT);
.PHONY: natnhes
natnhes:
	$(foreach PRIOR, $(PRIORS), $(make_natnhes))


## National-level model using NHES, DTC, and schools data on obesity

make_natall = $(MAKE) -C natall PRIOR=$(PRIOR) YEAR_MAX=$(YEAR_MAX) MULT=$(MULT);
.PHONY: natall
natall:
	$(foreach PRIOR, $(PRIORS), $(make_natall))


## Subnational model using NHES, DTC, and schools data on obesity

make_subnat = $(MAKE) -C subnat PRIOR=$(PRIOR) VERSION=$(VERSION) YEAR_MAX=$(YEAR_MAX) MULT=$(MULT) EXT=$(EXT);
.PHONY: subnat
subnat:
	$(foreach PRIOR, $(PRIORS), \
          $(foreach VERSION, $(VERSIONS), \
            $(foreach EXT, $(EXTS), \
              $(make_subnat))))


## Manuscript

.PHONY: paper
paper:
	$(MAKE) -C paper


## Files to submit

.PHONY: submission
submission:
	rm -rf submission
	mkdir submission
	cp paper/obesity.pdf submission
	cp paper/obesitysm.pdf submission
	cp paper/obesity.tex submission
	cp paper/obesitysm.tex submission
	cp paper/out/fig1.tif submission
	cp paper/out/fig2.tif submission
	cp paper/out/fig3.tif submission
	cp paper/out/fig4.tif submission
	cp paper/out/fig5.tif submission
	cp paper/out/fig6.tif submission
	cp paper/out/fig7.tif submission


## Clean up

.PHONY: clean
clean:
	rm -rf shared/out
	mkdir -p shared/out
	rm -rf natnhes/out
	mkdir -p natnhes/out
	rm -rf natall/out
	mkdir -p natall/out
	rm -rf subnat/out
	mkdir -p subnat/out
	rm -f paper/paper.pdf



