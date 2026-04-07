Return-Path: <linux-hyperv+bounces-10043-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHhsAf321GkjywcAu9opvQ
	(envelope-from <linux-hyperv+bounces-10043-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 14:22:21 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBD93AE423
	for <lists+linux-hyperv@lfdr.de>; Tue, 07 Apr 2026 14:22:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0B9AC304D157
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Apr 2026 12:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBCF42EF67A;
	Tue,  7 Apr 2026 12:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="r4VTrlQm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E77B3B2FED;
	Tue,  7 Apr 2026 12:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775564497; cv=none; b=dbIi0YFii45V5UTuQTT0HnbFW+phJ6JMgLSZ08/ydwzCYANsnGr3VAlfYQUJWeOjnEkJLkthNrNr9DiI1dpXHM2LwcR84cV2fpr9vytNaCwEfbcGFj0PUY7dRLp6X+Mfi3bBCLiT+njO7DFaw8ym7jIuHKJ1r3lxaJ260C1sUEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775564497; c=relaxed/simple;
	bh=ctNZaIcnhUIr40hlmcciTinIdHIcRpkOpKSez5d5pR4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=s7/rGnca4loKxg9YBBtDHQv6ZeXnHHvbbAPJMzyEKa7rAGxCscU/egKjdksnM7r2ftxQXIM7d5uHfeF4mvIw8/M+4jTyQA72Jp8G2JO1UAoAmFLmQLhAhbUujCW22GF1mfySkOUPGewGQhhvXWGjFtUL6WEOXbHRiETC+niZmzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=r4VTrlQm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1231)
	id 0B49720B710C; Tue,  7 Apr 2026 05:21:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0B49720B710C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1775564496;
	bh=B4J1G0Kntc65GLotmGhjYuLC24AVYPv7/1g4UcPqmq8=;
	h=From:To:Subject:Date:From;
	b=r4VTrlQmWVBqanYi/5VRAMEFVWMZDr0I8wOx4Vkji0UkvWT/xPQsh3XgguQ1e1hFO
	 rj/g+stVbt24htu25zDVIX4zm5/8Ks1obmIUlGrD2Ia56rKJ7rOjPge8QXG8DYKceY
	 DTQNZ4Z7iDBlstfI7tIAOAO/MQx/CyGDmChJY+B4=
From: Aditya Garg <gargaditya@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com,
	gregkh@linuxfoundation.org,
	ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	romank@linux.microsoft.com,
	avladu@cloudbasesolutions.com,
	vdso@mailbox.org,
	gargaditya@microsoft.com,
	gargaditya@linux.microsoft.com
Subject: [PATCH v2] tools: hv: Fix cross-compilation
Date: Tue,  7 Apr 2026 05:20:40 -0700
Message-ID: <20260407122040.249733-1-gargaditya@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-10043-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gargaditya@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_TWELVE(0.00)[14];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 3FBD93AE423
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Use the native ARCH only in case it is not set, this will allow the
cross-compilation where ARCH is explicitly set.

Additionally, simplify the check for ARCH so that fcopy daemon is built
only for x86_64.

Fixes: 82b0945ce2c2 ("tools: hv: Add new fcopy application based on uio driver")
Reported-by: Adrian Vladu <avladu@cloudbasesolutions.com>
Closes: https://lore.kernel.org/linux-hyperv/PR3PR09MB54119DB2FD76977C62D8DD6AB04D2@PR3PR09MB5411.eurprd09.prod.outlook.com/
Co-developed-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
Signed-off-by: Aditya Garg <gargaditya@linux.microsoft.com>
Reviewed-by: Roman Kisel <romank@linux.microsoft.com>
---
Changes since v1:
    - Dropped the info target printing CC, LD and ARCH

v1: https://lore.kernel.org/all/1733992114-7305-1-git-send-email-ssengar@linux.microsoft.com/
---
 tools/hv/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/hv/Makefile b/tools/hv/Makefile
index 34ffcec264ab..e377caf89fb6 100644
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
@@ -20,7 +20,7 @@ override CFLAGS += -O2 -Wall -g -D_GNU_SOURCE -I$(OUTPUT)include
 override CFLAGS += -Wno-address-of-packed-member
 
 ALL_TARGETS := hv_kvp_daemon hv_vss_daemon
-ifneq ($(ARCH), aarch64)
+ifeq ($(ARCH), x86_64)
 ALL_TARGETS += hv_fcopy_uio_daemon
 endif
 ALL_PROGRAMS := $(patsubst %,$(OUTPUT)%,$(ALL_TARGETS))
-- 
2.43.0


