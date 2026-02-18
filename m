Return-Path: <linux-hyperv+bounces-8896-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJnINS7RlWlEVAIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8896-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 15:48:14 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CA80157266
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 15:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 473BE30065E2
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Feb 2026 14:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20647331A55;
	Wed, 18 Feb 2026 14:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RXzxAHB7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124442D8762
	for <linux-hyperv@vger.kernel.org>; Wed, 18 Feb 2026 14:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771426089; cv=none; b=NdLdyl8BjiE9JXs3zCDsvlYhI7ocnthZJmQcPuEg5MP4+A+tZkUOV/A0azNjKltcYb1EFgKXSir8Um/RVCBlcOtaBhZnhVphp3ztQCmYOKDPDYDr+vj4QI+mbGA0SgL0YTG4Y7fF6fyxnKexQRopCGtuu6Xfx32/NQOz/eiexDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771426089; c=relaxed/simple;
	bh=d264Tcwh8GBF0cGfHwZaeitJpK6kdvlasj+E/Amz17A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JiW0l7OPc7DuBX6l8rrUikNPSpJ4/t2FgxBQfXf1Qa/MU8vFkXlxz48Ewgi9UD5+gdcuueclbpDfUgsqmaYL/GLsEuOVDIBLkSqv4YtbdoQEXnPxaBz4/0hMH7tyPlZBkOr/k/+ecDAEgFDjF4l0Ig3BkPEOdW0C4u1CP8HCqm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RXzxAHB7; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from anbelski-virt-work-5.irsgb21fvobu5fvmalxug44hib.xx.internal.cloudapp.net (unknown [172.171.99.74])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8058020B6F03;
	Wed, 18 Feb 2026 06:48:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8058020B6F03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1771426083;
	bh=4o7jsg+cJyqm0A7uDR6kwp+oAaNoaE6MDBGeCWDoGr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RXzxAHB7PGO/bjVYUouaIRHw1iJEa20G58pqhH0uhf6MLP6rKbIHRSC0NI22pa1y8
	 CJqgdWrYG5WeTHFFLRgtIUtRR+JuwHq6t3f3Fdx1/vusCjCaWgNbT/J83NhovgjdBb
	 WDXPRR0xQz6eKWXrJZL23TnNuGRO0ciGKbkl0wko=
From: Anatol Belski <anbelski@linux.microsoft.com>
To: linux-hyperv@vger.kernel.org
Cc: wei.liu@kernel.org,
	muislam@microsoft.com
Subject: [PATCH 3/4] drivers: hv: enable nested virtualization
Date: Wed, 18 Feb 2026 14:48:01 +0000
Message-Id: <20260218144802.1962513-3-anbelski@linux.microsoft.com>
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
	TAGGED_FROM(0.00)[bounces-8896-lists,linux-hyperv=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 7CA80157266
X-Rspamd-Action: no action

From: Muminul Islam <muislam@microsoft.com>

Based on the bits provided by VMM, enable the nested
virtualization in the partition creation flag.

Signed-off-by: Muminul Islam <muislam@microsoft.com>
---
 drivers/hv/mshv_root_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 681b58154d5e..fb3ade44e1f1 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1921,6 +1921,8 @@ static long mshv_ioctl_process_pt_flags(void __user *user_arg, u64 *pt_flags,
 		*pt_flags |= HV_PARTITION_CREATION_FLAG_X2APIC_CAPABLE;
 	if (args.pt_flags & BIT_ULL(MSHV_PT_BIT_GPA_SUPER_PAGES))
 		*pt_flags |= HV_PARTITION_CREATION_FLAG_GPA_SUPER_PAGES_ENABLED;
+	if (args.pt_flags & BIT(MSHV_PT_BIT_NESTED_VIRTUALIZATION))
+		*pt_flags |= HV_PARTITION_CREATION_FLAG_NESTED_VIRTUALIZATION_CAPABLE;
 
 	isol_props->as_uint64 = 0;
 
-- 
2.34.1


