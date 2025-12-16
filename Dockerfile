# From https://github.com/clearbluejar/ghidra-python
FROM ghcr.io/clearbluejar/ghidra-python:latest

ENV GHIDRA_INSTALL_DIR=/ghidra

USER vscode
WORKDIR /home/vscode/

# upgrade pip first
RUN pip install --upgrade pip

# If Ghidra major version is 11 (pre pyghidra 3.0), pin pyghidra==2.2.1
# Otherwise, allow latest pyghidra
RUN if [[ "$GHIDRA_VERSION" == 11.* ]]; then \
      echo "Detected Ghidra $GHIDRA_VERSION, pinning pyghidra==2.2.1..." && \
      pip install "pyghidra==2.2.1"; \
    fi

# install ghidrecomp (latest) after pyghidra handling
RUN pip install ghidrecomp

# point absolute ghidriffs dir to user
# supports absolute mapping: 
# "docker run --rm -it -v ${PWD}/ghidriffs:/ghidriffs ghidriff /bin/cat1 /bin/cat2"
RUN ln -s /ghidrecomps /home/vscode/

ENTRYPOINT ["/home/vscode/.local/bin/ghidrecomp"]
