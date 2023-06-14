bindir=$(DESTDIR)/bin

all: xxd
	
%.o: %.c $(DEPS)
	$(CC) -c -o $@ $< $(CFLAGS)
	
xxd: xxd.o
	$(CC) $(CFLAGS) -o $@ $^ $(LDFLAGS)

$(bindir):
	mkdir -p $@

install: xxd $(bindir)
	cp -t $(bindir) xxd

.PHONY: install
