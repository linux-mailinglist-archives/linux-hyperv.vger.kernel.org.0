Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECC425A1C3
	for <lists+linux-hyperv@lfdr.de>; Fri, 28 Jun 2019 19:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbfF1RFq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 Jun 2019 13:05:46 -0400
Received: from mga09.intel.com ([134.134.136.24]:38589 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726056AbfF1RFq (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 Jun 2019 13:05:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 28 Jun 2019 10:05:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,428,1557212400"; 
   d="scan'208";a="170796904"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 28 Jun 2019 10:05:44 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 08BA7130; Fri, 28 Jun 2019 20:05:42 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-hyperv@vger.kernel.org, Sasha Levin <sashal@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] Tools: hv: move to tools buildsystem
Date:   Fri, 28 Jun 2019 20:05:42 +0300
Message-Id: <20190628170542.28481-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There is a nice buildsystem dedicated for userspace tools in Linux kernel tree.
Switch gpio target to be built by it.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 tools/hv/Build    |  3 +++
 tools/hv/Makefile | 51 +++++++++++++++++++++++++++++++++++++----------
 2 files changed, 44 insertions(+), 10 deletions(-)
 create mode 100644 tools/hv/Build

diff --git a/tools/hv/Build b/tools/hv/Build
new file mode 100644
index 000000000000..6cf51fa4b306
--- /dev/null
+++ b/tools/hv/Build
@@ -0,0 +1,3 @@
+hv_kvp_daemon-y += hv_kvp_daemon.o
+hv_vss_daemon-y += hv_vss_daemon.o
+hv_fcopy_daemon-y += hv_fcopy_daemon.o
diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index 5db5e62cebda..b57143d9459c 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -1,28 +1,55 @@
 # SPDX-License-Identifier: GPL-2.0
 # Makefile for Hyper-V tools
-
-WARNINGS = -Wall -Wextra
-CFLAGS = $(WARNINGS) -g $(shell getconf LFS_CFLAGS)
-
-CFLAGS += -D__EXPORTED_HEADERS__ -I../../include/uapi -I../../include
+include ../scripts/Makefile.include
 
 sbindir ?= /usr/sbin
 libexecdir ?= /usr/libexec
 sharedstatedir ?= /var/lib
 
-ALL_PROGRAMS := hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon
+ifeq ($(srctree),)
+srctree := $(patsubst %/,%,$(dir $(CURDIR)))
+srctree := $(patsubst %/,%,$(dir $(srctree)))
+endif
+
+# Do not use make's built-in rules
+# (this improves performance and avoids hard-to-debug behaviour);
+MAKEFLAGS += -r
+
+override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
+
+ALL_TARGETS := hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon
+ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
 ALL_SCRIPTS := hv_get_dhcp_info.sh hv_get_dns_info.sh hv_set_ifconfig.sh
 
 all: $(ALL_PROGRAMS)
 
-%: %.c
-	$(CC) $(CFLAGS) -o $@ $^
+export srctree OUTPUT CC LD CFLAGS
+include $(srctree)/tools/build/Makefile.include
+
+HV_KVP_DAEMON_IN := $(OUTPUT)hv_kvp_daemon-in.o
+$(HV_KVP_DAEMON_IN): FORCE
+	$(Q)$(MAKE) $(build)=hv_kvp_daemon
+$(OUTPUT)hv_kvp_daemon: $(HV_KVP_DAEMON_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
+
+HV_VSS_DAEMON_IN := $(OUTPUT)hv_vss_daemon-in.o
+$(HV_VSS_DAEMON_IN): FORCE
+	$(Q)$(MAKE) $(build)=hv_vss_daemon
+$(OUTPUT)hv_vss_daemon: $(HV_VSS_DAEMON_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
+
+HV_FCOPY_DAEMON_IN := $(OUTPUT)hv_fcopy_daemon-in.o
+$(HV_FCOPY_DAEMON_IN): FORCE
+	$(Q)$(MAKE) $(build)=hv_fcopy_daemon
+$(OUTPUT)hv_fcopy_daemon: $(HV_FCOPY_DAEMON_IN)
+	$(QUIET_LINK)$(CC) $(CFLAGS) $(LDFLAGS) $< -o $@
 
 clean:
-	$(RM) hv_kvp_daemon hv_vss_daemon hv_fcopy_daemon
+	rm -f $(ALL_PROGRAMS)
+	find $(if $(OUTPUT),$(OUTPUT),.) -name '*.o' -delete -o -name '\.*.d' -delete
 
-install: all
+install: $(ALL_PROGRAMS)
 	install -d -m 755 $(DESTDIR)$(sbindir); \
 	install -d -m 755 $(DESTDIR)$(libexecdir)/hypervkvpd; \
 	install -d -m 755 $(DESTDIR)$(sharedstatedir); \
@@ -33,3 +60,7 @@ install: all
 	for script in $(ALL_SCRIPTS); do \
 		install $$script -m 755 $(DESTDIR)$(libexecdir)/hypervkvpd/$${script%.sh}; \
 	done
+
+FORCE:
+
+.PHONY: all install clean FORCE prepare
-- 
2.20.1

