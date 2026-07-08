Return-Path: <linux-hyperv+bounces-11857-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 78u3CvCnTWoc8gEAu9opvQ
	(envelope-from <linux-hyperv+bounces-11857-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 03:29:20 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 11991720DA2
	for <lists+linux-hyperv@lfdr.de>; Wed, 08 Jul 2026 03:29:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11857-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11857-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4C0393001599
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jul 2026 01:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7BF3ACF1F;
	Wed,  8 Jul 2026 01:29:14 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB491A682C;
	Wed,  8 Jul 2026 01:29:11 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783474154; cv=none; b=TNHsa6kA2kVqYfIN2hfu6A7VoI9BrSteStpCd+IUnLh3P/8yCgzW9SrHZuQ2a3N2QGRBJ6kE94x2gdsd/OazjewlPmT34Z4ifjL/HZWKHhea95s71m25u2H9inJXBx+7bdas+pTt69emEgglgSt0J5w5d1OqupwyAdWCM/YyGB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783474154; c=relaxed/simple;
	bh=suAxvSIlLeZAV8VofgJEgY+pIj7jfrfnpRNsn2h2E68=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tmnp5NtuYCazNvmvfa/FehNXKdQwXCDamjVS3WxyjDX0yJFt9uUKSI3X0lnoxQIFA1q1eKS3OCTbSNlXx3+7QLaZZv0+W5oaqTM52soo3CP8IbfgukNHGNIk0VzRF0K6CmdyvF2F5W8hGyhMoAkPg522evFY/3IhPoNxq0wGKo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
X-UUID: 69ce80047a6c11f1aa26b74ffac11d73-20260708
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:2cb57043-93b0-47b0-a863-8edb0baf2c45,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:e7bac3a,CLOUDID:47c6110ebe0f5d5a891cdc2f7239c717,BulkI
	D:nil,BulkQuantity:0,Recheck:0,SF:102|850|865|898,TC:nil,Content:0|15|50,E
	DM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:
	0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 69ce80047a6c11f1aa26b74ffac11d73-20260708
X-User: xieyi@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <xieyi@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1419651894; Wed, 08 Jul 2026 09:29:07 +0800
From: Yi Xie <xieyi@kylinos.cn>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org
Cc: linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yi Xie <xieyi@kylinos.cn>
Subject: [PATCH] mshv: fix fd leak in mshv_ioctl_create_vtl()
Date: Wed,  8 Jul 2026 09:28:52 +0800
Message-Id: <20260708012852.36824-1-xieyi@kylinos.cn>
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
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_NA(0.00)[kylinos.cn];
	FORGED_RECIPIENTS(0.00)[m:kys@microsoft.com,m:haiyangz@microsoft.com,m:wei.liu@kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:xieyi@kylinos.cn,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-11857-lists,linux-hyperv=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[xieyi@kylinos.cn,linux-hyperv@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xieyi@kylinos.cn,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,kylinos.cn:from_mime,kylinos.cn:email,kylinos.cn:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 11991720DA2

put_unused_fd() if anon_inode_getfile() fails.

Signed-off-by: Yi Xie <xieyi@kylinos.cn>
---
 drivers/hv/mshv_vtl_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hv/mshv_vtl_main.c b/drivers/hv/mshv_vtl_main.c
index 0d3d4161974f..897a41b08d02 100644
--- a/drivers/hv/mshv_vtl_main.c
+++ b/drivers/hv/mshv_vtl_main.c
@@ -129,6 +129,7 @@ mshv_ioctl_create_vtl(void __user *user_arg, struct device *module_dev)
 	file = anon_inode_getfile("mshv_vtl", &mshv_vtl_fops,
 				  vtl, O_RDWR);
 	if (IS_ERR(file)) {
+		put_unused_fd(fd);
 		kfree(vtl);
 		return PTR_ERR(file);
 	}
-- 
2.34.1

