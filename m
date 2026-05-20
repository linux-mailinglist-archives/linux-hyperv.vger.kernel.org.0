Return-Path: <linux-hyperv+bounces-11048-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALUmBgVhDWquwgUAu9opvQ
	(envelope-from <linux-hyperv+bounces-11048-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 09:21:41 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE8D588D4F
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 09:21:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FA4F3007E18
	for <lists+linux-hyperv@lfdr.de>; Wed, 20 May 2026 07:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD67D34DCC8;
	Wed, 20 May 2026 07:16:49 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B89313777E;
	Wed, 20 May 2026 07:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779261409; cv=none; b=ATOMpk9D8CJqj1sPzGte25b0blHAORaB/eqLDOLUThk3dOF7ff+CRK66JHfbV8VADz1b/EfqX1WH/IPBNpLa5H2Ht290HVSOuyq8+OMDSV5mStHgf/SFYb0SRp06DL4IxqPOkfG/tWUiN1qS02I4h4fFpWs5TsaOig8JCWN52II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779261409; c=relaxed/simple;
	bh=9DJG3T1hlF/qlOxpFqIQvRDI3SGps9Eu18Ct0joddd4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkCwwArwdUZ9NvatRF9h82GA8OhgW65QDBtQLgTV8YuGbCzz1OCEaqlSxTbPeYII4gCPW1PWqimyA9n4Sy4eD8GyAxa197ozEU3coI39IX/44XEX0Q1++gsfwSjkjPreOmfSEabS+O/cS72F5dhefvHMtw4/yZh6ESapuPGzDyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d78276e0541b11f1aa26b74ffac11d73-20260520
X-CID-CACHE: Type:Local,Time:202605201448+08,HitQuantity:1
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:84e9bfec-c14a-4afe-90a6-8b97d669df75,IP:0,U
	RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:20
X-CID-META: VersionHash:e7bac3a,CLOUDID:b6fb74a66bcce94bd2021e1a260b4923,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|865|898,TC:nil,Content:0|15|50,EDM:5
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d78276e0541b11f1aa26b74ffac11d73-20260520
X-User: pengcan@kylinos.cn
Received: from lenovo [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <pengcan@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 867985305; Wed, 20 May 2026 15:16:38 +0800
From: Can Peng <pengcan@kylinos.cn>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	longli@microsoft.com,
	decui@microsoft.com
Cc: linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	Can Peng <pengcan@kylinos.cn>
Subject: [PATCH] drivers: hv: use kmalloc_array in mshv_root_scheduler_init
Date: Wed, 20 May 2026 15:16:32 +0800
Message-ID: <20260520071632.557990-1-pengcan@kylinos.cn>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-11048-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[pengcan@kylinos.cn,linux-hyperv@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,kylinos.cn:mid,kylinos.cn:email]
X-Rspamd-Queue-Id: 6FE8D588D4F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Replace kmalloc() with kmalloc_array() to prevent potential
overflow, as recommended in Documentation/process/deprecated.rst.

Signed-off-by: Can Peng <pengcan@kylinos.cn>
---
 drivers/hv/mshv_root_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index bd1359eb58dd..146726cc4e9b 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -2241,7 +2241,7 @@ static int mshv_root_scheduler_init(unsigned int cpu)
 	outputarg = (void **)this_cpu_ptr(root_scheduler_output);
 
 	/* Allocate two consecutive pages. One for input, one for output. */
-	p = kmalloc(2 * HV_HYP_PAGE_SIZE, GFP_KERNEL);
+	p = kmalloc_array(2, HV_HYP_PAGE_SIZE, GFP_KERNEL);
 	if (!p)
 		return -ENOMEM;
 
-- 
2.53.0


