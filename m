Return-Path: <linux-hyperv+bounces-8683-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Djq7J6B5gmlyVQMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8683-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 23:41:36 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11337DF542
	for <lists+linux-hyperv@lfdr.de>; Tue, 03 Feb 2026 23:41:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEFF5301AA98
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Feb 2026 22:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D95B3164C2;
	Tue,  3 Feb 2026 22:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="WAnht4F3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EC5830F7F8;
	Tue,  3 Feb 2026 22:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770158493; cv=none; b=UR1prAt64gbM473Q62jLlSu/8IRmJ3eIOE3wUBbrxpIGRmFynMfIns1m3xp65sZXgjSaKgMjKqiauFK7KQDY41mWeyAIx0PWQX3ho5Xm7Y6226vYokEmYVlHuQhGmde1bmHSmJwCCXinIFQUqcqx/rZRf5j71465zpO4D7EBP0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770158493; c=relaxed/simple;
	bh=pAwOMVQOktQZ7RfBs75en64h4h+pLMftpQlUty0BEaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ESTKd4qRecvqinznMIN63IGNGKO9FhKLnLhLCji7CPy2JowK7x3iGak3Cn4xjkbgskoxcGI7QBKi8gdWSZn7wGaNAH+Z6RJGiyV1rEcdAvpiruu328dw8/DpWWm9ItPA37HCu73/ScqY2TJj66xRuslQmaM4VQf3vTbVn1G9NfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=WAnht4F3; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from mrdev.corp.microsoft.com (192-184-212-33.fiber.dynamic.sonic.net [192.184.212.33])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9565220B7168;
	Tue,  3 Feb 2026 14:41:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9565220B7168
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1770158491;
	bh=u5I47r4aWkcPavrKtJYiS7PI5teNMjkvGYhEBL2IyWA=;
	h=From:To:Cc:Subject:Date:From;
	b=WAnht4F3GsN+ZFLRkCZyR36Mnxi8zYlIMSXIFCtmLs1aHRuFQtmaHNLNvcDroOx7b
	 XEBvbG+1LwL0ZnBzLOAahcXpLEDeZfUTiiHwIoZi4ZJQ4Pku13a03NXlzWaaHiJsmQ
	 oTxHfHdMcyAeG24LbxYZBKKHhXHym+kbkDCqsZa0=
From: Mukesh R <mrathor@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: wei.liu@kernel.org
Subject: [PATCH v0] x86/hyperv: Move hv crash init after hypercall pg setup
Date: Tue,  3 Feb 2026 14:41:21 -0800
Message-ID: <20260203224121.26711-1-mrathor@linux.microsoft.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8683-lists,linux-hyperv=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11337DF542
X-Rspamd-Action: no action

Fix a regression where hv_root_crash_init() fails a hypercall because
the hypercall page is not fully setup. The regression is caused by
following commit:

commit c8ed0812646e ("x86/hyperv: Use direct call to hypercall-page")

Fix is simple, just move the crash init call after the hypercall
page setup.

Signed-off-by: Mukesh R <mrathor@linux.microsoft.com>
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


