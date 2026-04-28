Return-Path: <linux-hyperv+bounces-10437-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gO1bJ5Tr8GmBbAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10437-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:17:08 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E64F7489C22
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:17:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6420D30875F7
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 17:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451C91FBEA8;
	Tue, 28 Apr 2026 17:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Qr8P794R"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out-173.mta0.migadu.com (out-173.mta0.migadu.com [91.218.175.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6D492D73A6
	for <linux-hyperv@vger.kernel.org>; Tue, 28 Apr 2026 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396293; cv=none; b=u99lDKum7fyjmBCMh60tNFQHtOuaXFwGWXWqbKqigPCeQDJYNeD/ruTBEa+zpFGibfmN7pYgMynfp4d7FB4W+pE/L9IAo2aTvTgQlGLm72eGv7+fRLp8BVp18yi28jEKPpr6v9b0LkvlYYtCMCd+4RdC8+sagYI3ep/DFlV71Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396293; c=relaxed/simple;
	bh=VzhCQIX+WF6O8N7B7/nriLlzoXg/COyBQ6enwW2r94M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KmBu8Q3Q0jkApsIKgtJHIEqxSYYzEXbcBOfhjUl1Wf/DOAcrva6IWjf7Sq4HguR24uxEz3myWiCZPndRFcAGr83ez5oTiAQ0TfM8uBve2xw1f0Y6DDW6yB50B6HQjBG1/8uP6n6HSysEWt6jXUDJJWHaiQ2IKN2oPZvbEVaklMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Qr8P794R; arc=none smtp.client-ip=91.218.175.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777396280;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KQYtvaVky6oAjcFKUGXH/dKN1krlRoDNZuxw3fuumpI=;
	b=Qr8P794R5GMT0UD9jDE1OgaBIL/5xYvhVei40CpaWH8NofoANb50dsr0jp7s5k6gLZ8Yrp
	/gj1i9qt5pZzIcVgtIfjH8jsflU/kL1bTRJmnIXTSoxjCQOxLj9616BASzGz9d8yK2nevo
	mW6inTMivoXyAvhPnXUN2Vn2PFbsxWk=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] hv: utils: replace deprecated strcpy with strscpy in kvp_register
Date: Tue, 28 Apr 2026 19:11:05 +0200
Message-ID: <20260428171104.591947-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1619; i=thorsten.blum@linux.dev; h=from:subject; bh=VzhCQIX+WF6O8N7B7/nriLlzoXg/COyBQ6enwW2r94M=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJkfXmloSP7eVXRT1PriW7XaTKYEXtWZtm6CamclZlS97 7BmVDLsKGVhEONikBVTZHkw68cM39Kayk0mETth5rAygQxh4OIUgIkEMzP8j1zufyj127O0yOzJ t/LsXgo8v3Vg4p/pq4tql0y48/viP01GhvvHVM79OspbafC3JP3z2U33D01QD573g/XSzlNTJku aCjAAAA==
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: E64F7489C22
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10437-lists,linux-hyperv=lfdr.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:dkim,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

strcpy() has been deprecated [1] because it performs no bounds checking
on the destination buffer, which can lead to buffer overflows. While the
current code works correctly, replace strcpy() with the safer strscpy()
to follow secure coding best practices. Use ->body.kvp_register.version
directly as the destination buffer and remove the local variable.

[1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strcpy

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Based on my other patch [1] which needs to be applied first.
[1] https://lore.kernel.org/lkml/20260414111008.307220-2-thorsten.blum@linux.dev/
---
 drivers/hv/hv_kvp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 6180ebe040ff..336b278b2182 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -27,6 +27,7 @@
 #include <linux/connector.h>
 #include <linux/workqueue.h>
 #include <linux/hyperv.h>
+#include <linux/string.h>
 #include <hyperv/hvhdk.h>
 
 #include "hyperv_vmbus.h"
@@ -130,18 +131,15 @@ static void kvp_register_done(void)
 static int
 kvp_register(int reg_value)
 {
-
 	struct hv_kvp_msg *kvp_msg;
-	char *version;
 	int ret;
 
 	kvp_msg = kzalloc_obj(*kvp_msg);
 	if (!kvp_msg)
 		return -ENOMEM;
 
-	version = kvp_msg->body.kvp_register.version;
 	kvp_msg->kvp_hdr.operation = reg_value;
-	strcpy(version, HV_DRV_VERSION);
+	strscpy(kvp_msg->body.kvp_register.version, HV_DRV_VERSION);
 
 	ret = hvutil_transport_send(hvt, kvp_msg, sizeof(*kvp_msg),
 				    kvp_register_done);

