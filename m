Return-Path: <linux-hyperv+bounces-3468-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B135D9EE140
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Dec 2024 09:28:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D5C2188810E
	for <lists+linux-hyperv@lfdr.de>; Thu, 12 Dec 2024 08:28:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72BD920C495;
	Thu, 12 Dec 2024 08:28:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="N5/y837y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9404558BA;
	Thu, 12 Dec 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733992121; cv=none; b=ndG1iaqDemNXFta4PCxfy0rZx/cIBWq1/fhloOTOudMUGqcc11ss/i8oxF9KmIpNSPZf0iuiXLwMihVBVDf3uzrLuemz/vsUCahbcbO6hRoe0z16saMwyDBpcUEkOwr1+cCm5/YBXz/6FRb4fwJ4eCt1m0AZhdvC0Wh98qSdzwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733992121; c=relaxed/simple;
	bh=oyi0+49mkb2V9ZQTgaTzcjk3FjXvGKxD1y6nVU4+9RY=;
	h=From:To:Cc:Subject:Date:Message-Id; b=V7Levit66vG9PkiUzDlQvPruNLFv33SPdrxe8rGKz3awuLFjGkL5FdbWGMmMu2Za+M9fFvciki68+GQvNFQqGB3LUWsEeoOG67Kk/9YUZ0Bw7YmGd5/WyJszk4nMCEY48e7Cijay/HzN/iV91IMJiXZeByIwggs8veG18CMCLUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=N5/y837y; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5F18720ACD66;
	Thu, 12 Dec 2024 00:28:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5F18720ACD66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733992119;
	bh=k4I45kyxnDNzHp98bbNcFbcUeN1YhvrRo8OzgJx/BxU=;
	h=From:To:Cc:Subject:Date:From;
	b=N5/y837yvlUvwy09IS0zYw5cnCSW5zzYRwKfd0y8+58FVs54Bih77jp1I0NGMHmNg
	 v/awkANfqxR4gAHHNyCN6KmIthAoslBsmnzZeSd+RadCVdI2vWN8AV52R7eeF3sJvh
	 owBhWCAAXc9pUfbt4UvoE6Z+Er/jPdgzBZ+XWzT4=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com,
	avladu@cloudbasesolutions.com
Subject: [PATCH] tools: hv: Fix cross-compilation
Date: Thu, 12 Dec 2024 00:28:34 -0800
Message-Id: <1733992114-7305-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Use the native ARCH only incase it is not set, this will allow
the cross complilation where ARCH is explicitly set. Add few
info prints as well to know what arch and toolchain is getting
used to build it.

Additionally, simplify the check for ARCH so that fcopy daemon
is build only for x86_64.

Fixes: 82b0945ce2c2 ("tools: hv: Add new fcopy application based on uio driver")
Reported-by: Adrian Vladu <avladu@cloudbasesolutions.com>
Closes: https://lore.kernel.org/linux-hyperv/Z1Y9ZkAt9GPjQsGi@liuwe-devbox-debian-v2/
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 tools/hv/Makefile | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index 34ffcec264ab..d29e6be6309b 100644
--- a/tools/hv/Makefile
+++ b/tools/hv/Makefile
@@ -2,7 +2,7 @@
 # Makefile for Hyper-V tools
 include ../scripts/Makefile.include
 
-ARCH := $(shell uname -m 2>/dev/null)
+ARCH ?= $(shell uname -m 2>/dev/null)
 sbindir ?= /usr/sbin
 libexecdir ?= /usr/libexec
 sharedstatedir ?= /var/lib
@@ -20,18 +20,26 @@ override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 override CFLAGS += -Wno-address-of-packed-member
 
 ALL_TARGETS := hv_kvp_daemon hv_vss_daemon
-ifneq ($(ARCH), aarch64)
+ifeq ($(ARCH), x86_64)
 ALL_TARGETS += hv_fcopy_uio_daemon
 endif
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
 
 ALL_SCRIPTS := hv_get_dhcp_info.sh hv_get_dns_info.sh hv_set_ifconfig.sh
 
-all: $(ALL_PROGRAMS)
+all: info $(ALL_PROGRAMS)
 
 export srctree OUTPUT CC LD CFLAGS
 include $(srctree)/tools/build/Makefile.include
 
+info:
+	@echo "---------------------"
+	@echo "Building for:"
+	@echo "CC $(CC)"
+	@echo "LD $(LD)"
+	@echo "ARCH $(ARCH)"
+	@echo "---------------------"
+
 HV_KVP_DAEMON_IN := $(OUTPUT)hv_kvp_daemon-in.o
 $(HV_KVP_DAEMON_IN): FORCE
 	$(Q)$(MAKE) $(build)=hv_kvp_daemon
-- 
2.43.0


