CC = gcc
CFLAGS = -O3 -Wall
DEBUGFLAGS = -g -Wall -D DEBUG --sanitize=address
TARGET = not-dig
TARGET_PATH = ./src/stub_resolver/
INSTALL_PATH = /usr/local/bin/
TEST_TARGET = dns-test
TEST_PATH = ./test/test_dns_packet.c

.PHONY: all
all: $(TARGET)

$(TARGET): $(TARGET_PATH)$(TARGET).c
	$(MAKE) $(TEST_TARGET)
	$(CC) $(CFLAGS) $(TARGET_PATH)$(TARGET).c -o $(BUILD_PATH)$(TARGET)

.PHONY: debug
debug:
	$(CC) $(DEBUGFLAGS) $(TARGET_PATH)$(TARGET).c -o $(BUILD_PATH)$(TARGET)

.PHONY: install
install:
	mv $(BUILD_PATH)$(TARGET) $(INSTALL_PATH)$(TARGET)

.PHONY: clean
clean:
	$(RM) $(TARGET)
	$(RM) $(TEST_TARGET)

.PHONY: format
format:
	find . -iname *.c | xargs -I% clang-format -i --style=Webkit %

test: $(TEST_TARGET)

$(TEST_TARGET): $(TEST_PATH)
	$(CC) $(CFLAGS) -o $(TEST_TARGET) $(TEST_PATH)
	./dns-test
