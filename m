Return-Path: <linux-hyperv+bounces-8897-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2qoPNy7RlWllVAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8897-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 15:48:14 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FB4157268
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 15:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6D6D23006466
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689782D8762;
	Wed, 18 Feb 2026 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="DCoG22QS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C033330670
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426089; cv=none; b=icijKRmY+XXBnIGfIwHs3LIByOHgA0rb/sF3BbPKWxqQ9vzXnY0bj0fdBLFIfmqUPO2G7P2BYzYXqckvFWfyyOsHlPLhY299oVH3h0BwaGFNvQoYFGaPaUGDIm4DtcApWdo9kNSyg37O0lc0eKro25NuAStVoG9VJ76R3kygSn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426089; c=relaxed/simple;
	bh=Pu3tW9gXW3slTF331KrZ9mMFrfDnkxFwi5x+HIl2pYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZoWDr9aMmuPj/98dinbym8jL/lnkq08XaKKEHjdAqWQLZ23sk5G1GpGyQuzX/TC/YTWDZTgophFdESnUMXlWHl+xXZQ3i92dEaBXzfIjlN/rYBnLFx0pGLBUtUJOYnILvVySW69oAEdgUQVjoPyQFx3+bAWOYlAlaa9lMCBB83g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=DCoG22QS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from anbelski-virt-work-5.irsgb21fvobu5fvmalxug44hib.xx.internal.cloudapp.net (unknown [172.171.99.74])
	by linux.microsoft.com (Postfix) with ESMTPSA id DDDE620B6F00;
	Wed, 18 Feb 2026 06:48:07 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DDDE620B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771426087;
	bh=ROwxED4NHHobTL4ksV0aMV108WrVrfecK+A6bByPoU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DCoG22QSFLTnOoK+B3yAizVTud0O246bOwBHbIqP0/tym15GTTh6WM9xfpGsX9PV6
	 +o+OgkT6BzJ9Zu2s53v+gxW2YNSsUh6+tZx76KhQ/sYPNaMTmdMYILWdxp7nQD8wqH
	 XEq9qCd3CaLM0NYKFNQ7oulX/u2DpCDRQ4nSQqz8=
From: Anatol Belski <anbelski@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: wei.liu@kernel.org,
	muislam@microsoft.com
Subject: [PATCH 4/4] mshv: Add SMT_ENABLED_GUEST partition creation flag
Date: Wed, 18 Feb 2026 14:48:02 +0000
Message-Id: <20260218144802.1962513-4-anbelski@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260218144802.1962513-1-anbelski@linux.microsoft.com>
References: <20260218144802.1962513-1-anbelski@linux.microsoft.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8897-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[anbelski@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A1FB4157268
X-Rspamd-Action: no action

Add support for HV_PARTITION_CREATION_FLAG_SMT_ENABLED_GUEST
to allow userspace VMMs to enable SMT for guest partitions.

Expose this via new MSHV_PT_BIT_SMT_ENABLED_GUEST flag in the UAPI.

Withouth this flag, the hypervisor schedules guest VPs incorrectly,
causing SMT unusable.

Signed-off-by: Anatol Belski <anbelski@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c | 2 ++
 include/hyperv/hvhdk.h      | 1 +
 include/uapi/linux/mshv.h   | 1 +
 3 files changed, 4 insertions(+)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index fb3ade44e1f1..899e055d975f 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1923,6 +1923,8 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
 		*pt_flags |= HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED;
 	if (args.pt_flags & BIT(MSHV_PT_BIT_NESTED_VIRTUALIZATION))
 		*pt_flags |= HV_PARTITION_CREATION_FLAG_NESTED_VIRTUALIZATION_CAPABLE;
+	if (args.pt_flags & BIT(MSHV_PT_BIT_SMT_ENABLED_GUEST))
+		*pt_flags |= HV_PARTITION_CREATION_FLAG_SMT_ENABLED_GUEST;
 
 	isol_props->as_uint64 = 0;
 
diff --git a/include/hyperv/hvhdk.h b/include/hyperv/hvhdk.h
index 03afb7d0412b..331cebc471e1 100644
--- a/include/hyperv/hvhdk.h
+++ b/include/hyperv/hvhdk.h
@@ -328,6 +328,7 @@ union hv_partition_isolation_properties {
 #define HV_PARTITION_ISOLATION_HOST_TYPE_RESERVED   0x2
 
 /* Note: Exo partition is enabled by default */
+#define HV_PARTITION_CREATION_FLAG_SMT_ENABLED_GUEST			BIT(0)
 #define HV_PARTITION_CREATION_FLAG_NESTED_VIRTUALIZATION_CAPABLE	BIT(1)
 #define HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED		BIT(4)
 #define HV_PARTITION_CREATION_FLAG_EXO_PARTITION			BIT(8)
diff --git a/include/uapi/linux/mshv.h b/include/uapi/linux/mshv.h
index 7ef5dd67a232..e0645a34b55b 100644
--- a/include/uapi/linux/mshv.h
+++ b/include/uapi/linux/mshv.h
@@ -28,6 +28,7 @@ enum {
 	MSHV_PT_BIT_GPA_SUPER_PAGES,
 	MSHV_PT_BIT_CPU_AND_XSAVE_FEATURES,
 	MSHV_PT_BIT_NESTED_VIRTUALIZATION,
+	MSHV_PT_BIT_SMT_ENABLED_GUEST,
 	MSHV_PT_BIT_COUNT,
 };
 
-- 
2.34.1


