
ifeq ($(USER),root)
    $(info )
    $(info "$0 can't run by $(USER). exit." )
    $(info )
    $(error exit )
endif

dateX1:=$(shell LC_ALL=C date +%Y_%m%d_%H%M%P_%S )

projName:=BlinkLED_MSP430FR2433_03
projName:=u2

# dstDir01:=~/workspace_v10/$(projName)/
dstDir01:=$(shell realpath $(projName)/)

dstDir02:=$(shell realpath $(dstDir01))
dstDir11:=$(dstDir02)/Debug
dstDir12:=$(dstDir02)/Debug__GNU
dstDir13:=$(dstDir02)/Debug__TI
dstDir21:=$(wildcard $(realpath $(dstDir11)))
dstDir22:=$(wildcard $(realpath $(dstDir12)))
dstDir23:=$(wildcard $(realpath $(dstDir13)))

$(if $(dstDir23),,$(error "dstDir23 don't exit. check <projName> and run again. Exit."))


all:
	@echo ; echo "$${helpText}" ; echo

wwa:=ww1 ww2 ww3
bba:= ba1 ba2 ba3
w2la:= w2l1 w2l2 w2l3
wwa:$(wwa)
bba:$(bba)
w2la:$(w2la)

ba1:=$(dstDir21)
ba2:=$(dstDir22)
ba3:=$(dstDir23)
ba1:$(ba1)
ba2:$(ba2)
ba3:$(ba3)

ww1:=$(dstDir21)
ww2:=$(dstDir22)
ww3:=$(dstDir23)
ww1:$(ww1)
ww2:$(ww2)
ww3:$(ww3)

w2l1:=$(dstDir21)
w2l2:=$(dstDir22)
w2l3:=$(dstDir23)
w2l1:$(w2l1)
w2l2:$(w2l2)
w2l3:$(w2l3)

#	(cd $< && make) > log.$(shell echo $<|tr './' '__'|sed -e 's;^_\+;;g' -e 's;__\+;_;g' ).txt
ba1 ba2 ba3 :
	export dd1=log.$(shell echo $<|tr './' '__'|sed -e 's;^_\+;;g' -e 's;__\+;_;g' ).txt ; \
		echo ; echo ==$@==$<==$(projName).txt==start==; \
		( \
		cd $< && make clean ) >  $${dd1} \
		&& echo && tail -n 10 $${dd1} \
		&& echo "make on ($<) clean succeed" \
		|| ( echo "make on ($<) clean error" ; exit 31) ; \
		\
		(\
		cd $< && make)        >> $${dd1} \
		&& echo   "make on ($@ ,$< == $(projName).txt == ) succeed"       \
		&& echo && tail -n 10 $${dd1} \
		|| ( echo "make on ($@ ,$< == $(projName).txt == ) error"       ; exit 33)
	cd $< && grep 'Grand Total' ../Debug*/$(projName).map

# ~/bin/msp430flasher.sh -i USB -n MSP430FR2433 -w /home/dyn/Debug/$(projName).txt -v -g -z [VCC]
# LD_LIBRARY_PATH=~/ti/MSPFlasher/ \
# LD_PRELOAD=
ww1 ww2 ww3 :
	export dd1=log.$@.$(shell echo $<|tr './' '__'|sed -e 's;^_\+;;g' -e 's;__\+;_;g' ).txt ; \
		echo ; echo      ==$@==$< == $(projName).txt == ==start==; \
		( cd $< && \
		LD_PRELOAD=~/ti/MSPFlasher/libmsp430.so \
		~/ti/MSPFlasher/MSP430Flasher \
		-i USB \
		-n MSP430FR2433 \
		-v -g -z [VCC] \
		-w $(projName).txt \
		) > $${dd1} \
		&& echo && cat $${dd1}|sed -e '1,3d' -e '/^*[\/ -\|]*$$/d' \
		&& echo   "make on ($@ ,$< == $(projName).txt == ) succeed" \
		|| ( echo "make on ($@ ,$< == $(projName).txt == ) error" ; exit 31) ; \

w2lfile:=objects.mk  sources.mk  subdir_rules.mk  subdir_vars.mk makefile
w2l1 w2l2 w2l3 :
	cd $< && \
		dos2unix $(w2lfile)
	cd $< && \
		sed -i \
		-e 's;\bC:/ti/energia;/home/ti/ti/energia/;g' \
		-e 's;^SHELL\b;\#SHELL;g' \
		-e 's;^RM\b.*$$;RM := rm -fr ;g' \
		-e 's;^RMDIR\b.*$$;RMDIR := rm -fr ;g' \
		$(w2lfile)

ca: 
	cd $(dstDir02) && rm -f ` \
		find -type f \
		-name "*.o" \
		-o -name "*.d" \
		-o -name "*.d_raw" \
		-o -name "*.obj" \
		-o -name "*.map" \
		-o -name "*~" \
		-o -name "BlinkLED*.out" \
		`

m:
	vim Makefile ; echo

vp : vim_prepare
vim_prepare :
	mkdir -p _vim/
	find $(dstDir01)/ -type f -name "*.c" -o -name "*.h" > _vim/file01.txt
	echo /home/ti/ti/ccs1040/ccs/ccs_base/msp430/include_gcc/msp430fr2433.h \
		>>                                                 _vim/file01.txt
	cscope -q -R -b -i                                     _vim/file01.txt
	ctags -L                                               _vim/file01.txt

v1:=$(dstDir01)/main.c

#~/workspace_v10/$(projName)/_cable_tester_mainloop_once.c
v2:=$(dstDir01)/_cable_tester_mainloop_once.c

v1 v2: 
	vim $($@)

gs:
	cd $(dstDir01)/ && git status
gss:
	git status

gc:
	cd $(dstDir01)/ && git commit -a
gcc:
	git commit -a

gd :
	cd $(dstDir01)/ && git diff
gdd :
	git diff

up:
	cd $(dstDir01)/ && git push -u origin main
upp:
	git push -u origin main


# workspace_v10/$(projName)/
dstDir30:=workspace_v10
dstDir31:=$(dstDir30).bak01
dstDir32:=$(projName)
dstDir33:=$(dstDir30)/$(dstDir32)

bk01:=$(dstDir31)/$(dstDir32).$(dateX1).tar.gz
bk01:=$(dstDir31)/$(dstDir32).$(dateX1).tgz
bk01:=$(dstDir31)/$(dstDir32).$(dateX1).xz
bk01:=$(dstDir31)/$(dstDir32).$(dateX1).zip


bk01 : backup01
backup01 :
	@echo
#     tar cfz    ~/$(bk01)    ~/$(dstDir33)/
#     tar cfJ    ~/$(bk01)    ~/$(dstDir33)/
	zip -9 -q -r     ~/$(bk01)    ~/$(dstDir33)/
	@ls -l            ~/$(bk01)    
	@echo



define helpText
	dstDir01 -> $(dstDir01)
	dstDir02 -> $(dstDir02)
	dstDir21 -> $(dstDir21)
	dstDir22 -> $(dstDir22)
	dstDir23 -> $(dstDir23)
vp : vim_prepare
v1 : vim $(v1)
v2 : vim $(v2)

bba : build_all $(bba) 
ba1: make in directory $(ba1)
ba2: make in directory $(ba2)
ba3: make in directory $(ba3)

wwa: msp430flash all : $(wwa)
ww1: msp430flash in directory $(ww1)
ww2: msp430flash in directory $(ww2)
ww3: msp430flash in directory $(ww3)

w2la: win to linux all : $(w2la)

endef
export helpText

