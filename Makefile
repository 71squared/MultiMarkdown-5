BUILD_DIR = build

$(BUILD_DIR_):
	-mkdir $(BUILD_DIR_) 2>/dev/null
	-cd $(BUILD_DIR); rm -rf *; touch README.html

# The release target will perform additional optimization
.PHONY : release
release: $(BUILD_DIR)
	cd $(BUILD_DIR); touch README.html; \
	cmake -DCMAKE_BUILD_TYPE=Release ..

# Build zip file package
.PHONY : zip
zip: $(BUILD_DIR)
	cd $(BUILD_DIR); touch README.html; \
	cmake -DCMAKE_BUILD_TYPE=Release -DZIP=1 ..

# debug target enables CuTest unit testing
.PHONY : debug
debug: $(BUILD_DIR)
	cd $(BUILD_DIR); touch README.html; \
	cmake -DTEST=1 ..

# Create xcode project
.PHONY : xcode
xcode: $(BUILD_DIR)
	cd $(BUILD_DIR); touch README.html; \
	cmake -G Xcode ..

# Cross-compile for Windows using MinGW on *nix
.PHONY : windows
windows: $(BUILD_DIR)
	cd $(BUILD_DIR); touch README.html; \
	cmake -DCMAKE_TOOLCHAIN_FILE=../tools/Toolchain-MinGW-w64-64bit.cmake -DCMAKE_BUILD_TYPE=Release ..

# Build Windows zip file using MinGW on *nix
.PHONY : windows-zip
windows-zip: $(BUILD_DIR)
	cd $(BUILD_DIR); touch README.html; \
	cmake -DCMAKE_TOOLCHAIN_FILE=../tools/Toolchain-MinGW-w64-64bit.cmake -DCMAKE_BUILD_TYPE=Release -DZIP=1 ..

# Cross-compile for Windows using MinGW on *nix (32-bit)
.PHONY : windows-32
windows-32: $(BUILD_DIR)
	cd $(BUILD_DIR); touch README.html; \
	cmake -DCMAKE_TOOLCHAIN_FILE=../tools/Toolchain-MinGW-w64-32bit.cmake -DCMAKE_BUILD_TYPE=Release ..

# Build Windows zip file using MinGW on *nix (32-bit)
.PHONY : windows-zip-32
windows-zip-32: $(BUILD_DIR)
	cd $(BUILD_DIR); touch README.html; \
	cmake -DCMAKE_TOOLCHAIN_FILE=../tools/Toolchain-mingw32.cmake -DCMAKE_BUILD_TYPE=Release -DZIP=1 ..

# Build the documentation using doxygen
.PHONY : documentation
documentation: $(BUILD_DIR)
	cd $(BUILD_DIR); touch README.html; \
	cmake -DDOCUMENTATION=1 ..; cd ..; \
	doxygen build/doxygen.conf

# Clean out the build directory
.PHONY : clean
clean:
	rm -rf $(BUILD_DIR)/*
