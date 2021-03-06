#skip !0 testenv DPS_TEST_ROOT
#skip !0 testenv DPS_TEST_DIR
#skip !0 testenv DPS_TEST_DBADDR0
#skip !0 testenv DPS_SHARE_DIR
#skip !0 testenv INDEXER
skip !0 exec $(INDEXER) -Echeck  $(DPS_TEST_DIR)/indexer.conf >> $(DPS_TEST_LOG) 2>&1

fail !0 exec rm -rf $(DPS_TEST_DIR)/var/
fail !0 exec mkdir $(DPS_TEST_DIR)/var
fail !0 exec mkdir $(DPS_TEST_DIR)/var/cache
fail !0 exec mkdir $(DPS_TEST_DIR)/var/splitter
fail !0 exec mkdir $(DPS_TEST_DIR)/var/store
fail !0 exec mkdir $(DPS_TEST_DIR)/var/tree
fail !0 exec mkdir $(DPS_TEST_DIR)/var/url
fail 20 exec $(INDEXER) -Edrop   $(DPS_TEST_DIR)/indexer.conf >> $(DPS_TEST_LOG) 2>&1
fail !0 exec $(INDEXER) -Ecreate $(DPS_TEST_DIR)/indexer.conf >> $(DPS_TEST_LOG) 2>&1
fail !0 exec $(INDEXER) -Eindex  -v5 -N3 -p200   $(DPS_TEST_DIR)/indexer.conf >> $(DPS_TEST_LOG) 2>&1
fail !0 exec $(INDEXER) -Eindex  -amv5 -N3 $(DPS_TEST_DIR)/indexer.conf >> $(DPS_TEST_LOG) 2>&1
fail !0 exec $(INDEXER) -Esqlmon $(DPS_TEST_DIR)/indexer.conf < $(DPS_TEST_DIR)/query.tst > $(DPS_TEST_DIR)/query.rej 2>&1
#fail !0 exec $(SEARCH) "test-p&wf=01000000000000000000000000000000000000" > $(DPS_TEST_DIR)/search.rej 2>&1
fail !0 exec $(SEARCH) "test-p" > $(DPS_TEST_DIR)/search.rej 2>&1
fail !0 exec $(SEARCH) "allinp: test-p&m=bool" > $(DPS_TEST_DIR)/search2.rej 2>&1
fail !0 exec $(SEARCH) "link1" > $(DPS_TEST_DIR)/search3.rej 2>&1
fail !0 exec $(SEARCH) "link2" > $(DPS_TEST_DIR)/search4.rej 2>&1
fail !0 exec $(SEARCH) "xtternal" > $(DPS_TEST_DIR)/search5.rej 2>&1

fail !0 mdiff $(DPS_TEST_DIR)/search.rej $(DPS_TEST_DIR)/search.res
fail !0 exec rm -f $(DPS_TEST_DIR)/search.rej

fail !0 mdiff $(DPS_TEST_DIR)/search2.rej $(DPS_TEST_DIR)/search2.res
fail !0 exec rm -f $(DPS_TEST_DIR)/search2.rej

fail !0 mdiff $(DPS_TEST_DIR)/search3.rej $(DPS_TEST_DIR)/search3.res
fail !0 exec rm -f $(DPS_TEST_DIR)/search3.rej

fail !0 mdiff $(DPS_TEST_DIR)/search4.rej $(DPS_TEST_DIR)/search4.res
fail !0 exec rm -f $(DPS_TEST_DIR)/search4.rej

fail !0 mdiff $(DPS_TEST_DIR)/search5.rej $(DPS_TEST_DIR)/search5.res
fail !0 exec rm -f $(DPS_TEST_DIR)/search5.rej


fail !0 mdiff $(DPS_TEST_DIR)/query.rej $(DPS_TEST_DIR)/query.res
fail !0 exec rm -f $(DPS_TEST_DIR)/query.rej

fail !0 exec rm -rf $(DPS_TEST_DIR)/var/
pass 0 exec  $(INDEXER) -Edrop $(DPS_TEST_DIR)/indexer.conf >> $(DPS_TEST_LOG) 2>&1
