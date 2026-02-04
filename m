Return-Path: <linux-hyperv+bounces-8689-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GM/ZEa6ngmk2XgMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8689-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 02:58:06 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE4ECE09EB
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 02:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 384ED3051557
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 01:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0681D28980E;
	Wed,  4 Feb 2026 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Y+ho9QSX"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7C66274B58;
	Wed,  4 Feb 2026 01:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770170282; cv=none; b=ulh3ZQ8R+nIhNM/5dY8ERasRA3yjrAFae8HH1GTMaXSxUWSbfSy3DCrLtewgyEZ2INlCCf8y8m1dg/A4OmLBIAUySlKjRVJeQeFgRloyTU+KmiDJI4MzeaM4DMeDQ2mWskmGr3et1mdxiZ/h9axPVgKe1LVwTWi4aygaSxvO4QY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770170282; c=relaxed/simple;
	bh=Zu2OAyoi725Jwsr0j4/q3SOoFfeJyDXgdfC1uCBvups=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NuZHZKQjixhhtAXzBY4gpfLSFwA7hdvRHo5k3/vKUzYYVZvnECG9q0CrT1avwLCD2qWmwzt3c9Q3aXulcyD9+L5APDVsZpqw6a+wjFyQxiZwEQrUpWoggQ84Kecz4p8u67ElK8Af34sGIxaoVJcHDfltHKZRPk0dYJVcvOP/r8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Y+ho9QSX; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3DF5120B7168;
	Tue,  3 Feb 2026 17:58:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3DF5120B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770170281;
	bh=VY/RjybiXaRuR8fIfVJgYb0n1H4o8OLnPleGq+IMT9k=;
	h=From:To:Cc:Subject:Date:From;
	b=Y+ho9QSXe9JgeNVaKVbDEhAKBJqTXl10l8ibryJ0ufZFGNZ41GRxLv/n93WZr+9s+
	 Kw7gSIQqkN6tzzYS4NIzBkf18V2/ztCiUXKfUPkfHktzHg2Q+H/oBZZZLXyc32lcNv
	 x0dzSU0WlxCwUuRU1kTJ7Cf1fwpBeSPQOVOu2ayM=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wei.liu@kernel.org
Subject: [PATCH v1] x86/hyperv: Move hv crash init after hypercall pg setup
Date: Tue,  3 Feb 2026 17:58:00 -0800
Message-ID: <20260204015800.40843-1-mrathor@linux.microsoft.com>
X-Mailer: git-send-email 2.51.2.vfs.0.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8689-lists,linux-hyperv=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mrathor@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: DE4ECE09EB
X-Rspamd-Action: no action

hv_root_crash_init() is not setting up the hypervisor crash collection
for baremetal cases because when it's called, hypervisor page is not
setup. This got missed due to internal mirror falling behind.

Fix is simple, just move the crash init call after the hypercall
page setup.

Signed-off-by: Mukesh Rathor <mrathor@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 14de43f4bc6c..7f3301bd081e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -558,7 +558,6 @@ void __init hyperv_init(void)
 		memunmap(src);
 
 		hv_remap_tsc_clocksource();
-		hv_root_crash_init();
 		hv_sleep_notifiers_register();
 	} else {
 		hypercall_msr.guest_physical_address = vmalloc_to_pfn(hv_hypercall_pg);
@@ -567,6 +566,9 @@ void __init hyperv_init(void)
 
 	hv_set_hypercall_pg(hv_hypercall_pg);
 
+	if (hv_root_partition())        /* after set hypercall pg */
+		hv_root_crash_init();
+
 skip_hypercall_pg_init:
 	/*
 	 * hyperv_init() is called before LAPIC is initialized: see
-- 
2.51.2.vfs.0.1


