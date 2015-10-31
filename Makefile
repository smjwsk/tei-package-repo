WHICH=binary
GPGKEY=330E5C27
PASS=

go:
	(cd ${WHICH}; apt-ftparchive sources  . > Sources)
	(cd ${WHICH}; apt-ftparchive packages . > Packages)
	(cd ${WHICH}; for i in Packages Sources; \
	do gzip -c $$i > $$i.gz; bzip2 -c $$i > $$i.bz2;done) 
	apt-ftparchive release ${WHICH} > ${WHICH}/Release
	gpg --sign --default-key ${GPGKEY} --passphrase '${PASS}' -ba -o ${WHICH}/Release.gpg ${WHICH}/Release

clean:
	rm -f ${WHICH}/Release* ${WHICH}/Packages* ${WHICH}/Sources*


.PHONY: clean go