Return-Path: <linux-hyperv+bounces-11878-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Srz9N2EFT2rPZAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-11878-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 04:20:17 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C8FD672BEA1
	for <lists+linux-hyperv@lfdr.de>; Thu, 09 Jul 2026 04:20:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11878-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11878-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D7BB43009822
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jul 2026 02:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333B22E1C7C;
	Thu,  9 Jul 2026 02:20:12 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47818EEC0;
	Thu,  9 Jul 2026 02:20:09 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783563612; cv=none; b=N8Lj7uQonYGZDB1JewKBWbKn1RhWJX+pQLSUUwvRpTlRuNNNJ4syJSwhiZoYk6AszryFCtoNtALj+W+7ydKOVQlscBjAJsQj2UP3rgDPmcIZADMIaY0/TQ8IazYRPnTUTCelXVAgeIRkl4a4bTdv39QmcPolqC/i1f3/6auHOZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783563612; c=relaxed/simple;
	bh=h4qR9304yx7JbH96hcfgtM4AEZ+HmRAO2cH8QAndzFo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U9lYVTA+hQFKijnHuoHGnimDWHx4Jgqr2bdVoxRb1hMyqdRE8M1DMwbNg86mX8h4arFJ11BgZOarbrORP8J/dDWdenVo5k1Xg1PX/98y5eWHC27xPulvFA+lJRxeZIVFq/5l3ovcHCQnMJ3L/9h0Y4nJ3atqLIbC7V+kZ4lsFnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: b266609a7b3c11f1aa26b74ffac11d73-20260709
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:bf2dc774-384f-41a1-8903-f9ac0e00b7d6,IP:0,U
	RL:0,TC:0,Content:-5,EDM:-20,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTI
	ON:release,TS:-25
X-CID-META: VersionHash:e7bac3a,CLOUDID:f8c3ec0cf6f5b2db9cc20884ff051c20,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:1,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: b266609a7b3c11f1aa26b74ffac11d73-20260709
X-User: xieyi@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xieyi@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 2074210220; Thu, 09 Jul 2026 10:20:04 +0800
From: Yi Xie <xieyi@kylinos.cn>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yi Xie <xieyi@kylinos.cn>
Subject: [PATCH] mshv: bounds-check cpu index in vtl mmap fault handler
Date: Thu,  9 Jul 2026 10:19:47 +0800
Message-Id: <20260709021947.49436-1-xieyi@kylinos.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11878-lists,linux-hyperv=lfdr.de];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:decui@microsoft.com,m:longli@microsoft.com,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xieyi@kylinos.cn,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[xieyi@kylinos.cn,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xieyi@kylinos.cn,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:from_mime,kylinos.cn:email,kylinos.cn:mid,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C8FD672BEA1

cpu is taken from pgoff & 0xffff.  cpu_online() does not reject cpu >=
nr_cpu_ids, and per_cpu_ptr() can then walk off __per_cpu_offset.

Signed-off-by: Yi Xie <xieyi@kylinos.cn>
---
 drivers/hv/mshv_vtl_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 0d3d4161974f..fc50c44ac1bd 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -801,7 +801,7 @@ static vm_fault_t mshv_vtl_fault(struct vm_fault *vmf)
 	int cpu = vmf->pgoff & MSHV_PG_OFF_CPU_MASK;
 	int real_off = vmf->pgoff >> MSHV_REAL_OFF_SHIFT;
 
-	if (!cpu_online(cpu))
+	if (cpu >= nr_cpu_ids || !cpu_online(cpu))
 		return VM_FAULT_SIGBUS;
 	/*
 	 * CPU Hotplug is not supported in VTL2 in OpenHCL, where this kernel driver exists.
-- 
2.34.1

