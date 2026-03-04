Return-Path: <linux-hyperv+bounces-9128-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EPXC4x7p2kshwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9128-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 01:23:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FB1F1F8DF9
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 01:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1E81F303C4F8
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 00:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572BA2BE7DC;
	Wed,  4 Mar 2026 00:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bIfATtrD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B7429D27A;
	Wed,  4 Mar 2026 00:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583816; cv=none; b=XpAmqR8TtVlG8JE/xBn8VHfDZL1fmkv/YOLeSRU3aI8Gs5Xt0QdAPSQ34aEZwgEZm796wyqnNwGINYKRWTmvDBeK/KY3+S+hGrLKT8nVXKxkAwJt1KXG8PnsfVnIiYQlY8swxh7k7cWHzW2tILIM8zBdOzbquxRrj+Zpw/fenJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583816; c=relaxed/simple;
	bh=K/4ZQ1gXDLAvfO3zeW6gE6kyxbEW+G9SeDbkoR3hKZw=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dumr+JUmIcwIo50mqmuY0Lm22gwL484oXzPYaUOqghEBtnb1Gb4Woa+VOShSvIpaURe6rnElSZwveWkKP5C8L3f0SO2Ro61VFOh1GofYSBp5nGpVpexj9aqwBjFH26g4BfiqpC+tFMYltcr2qvoeNM9+zaWA1Jc5/vEIGMyQj5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bIfATtrD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9E17020B6F03;
	Tue,  3 Mar 2026 16:23:34 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9E17020B6F03
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772583814;
	bh=vihJu6nMI57raf3X/5i+TTtk+5ZmTAbOozrt7hD01CA=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bIfATtrDASLOg3dLTIrYe+j9YdTC+HbUuSZQn9oEkTKNJcaFEJtW2O7lPsimciLnL
	 Td1ecLDO0UQvU+SsYtZfSYcF/Jo1qALPat8WVJQFtRtJ/yfQXX08nPjawR+Sb3dWAs
	 vV5uP46SIGSw/rxmTQWLnydyTDBV30UF/I8LzW2E=
Subject: [PATCH 1/4] mshv: Support larger memory deposits
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Mar 2026 00:23:34 +0000
Message-ID: 
 <177258381446.229866.108795434668770412.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177258296744.229866.4926075663598294228.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0FB1F1F8DF9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-9128-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Action: no action

Convert hv_call_deposit_pages() into a wrapper supporting arbitrary number
of pages, and use it in the memory deposit code paths.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/hv_proc.c |   50 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 49 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/hv_proc.c b/drivers/hv/hv_proc.c
index 5f4fd9c3231c..0f84a70def30 100644
--- a/drivers/hv/hv_proc.c
+++ b/drivers/hv/hv_proc.c
@@ -16,7 +16,7 @@
 #define HV_DEPOSIT_MAX (HV_HYP_PAGE_SIZE / sizeof(u64) - 1)
 
 /* Deposits exact number of pages. Must be called with interrupts enabled.  */
-int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
+static int __hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 {
 	struct page **pages, *page;
 	int *counts;
@@ -108,6 +108,54 @@ int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
 	kfree(counts);
 	return ret;
 }
+
+/**
+ * hv_call_deposit_pages - Deposit memory pages to a partition
+ * @node        : NUMA node from which to allocate pages
+ * @partition_id: Target partition ID to deposit pages to
+ * @num_pages   : Number of pages to deposit
+ *
+ * Deposits memory pages to the specified partition. The deposit is
+ * performed in chunks of HV_DEPOSIT_MAX pages to handle large requests
+ * efficiently.
+ *
+ * Return: 0 on success, negative error code on failure
+ */
+int hv_call_deposit_pages(int node, u64 partition_id, u32 num_pages)
+{
+	u32 done;
+	int ret = 0;
+
+	/*
+	 * Do a double deposit for L1VH. This reserves enough memory for
+	 * Hypervisor Hot Restart (HHR).
+	 *
+	 * During HHR, every data structure must be recreated in the new
+	 * ("proto") hypervisor. Memory is required by the proto hypervisor
+	 * to do this work.
+	 *
+	 * For regular L1 partitions, more memory can be requested from the
+	 * root during HHR by sending an asynchronous message. But this is
+	 * not supported for L1VHs. A guest must not be allowed to block
+	 * HHR by refusing to deposit more memory.
+	 *
+	 * So for L1VH a deposit is always required for both current needs
+	 * and future HHR work.
+	 */
+	if (hv_l1vh_partition())
+		num_pages *= 2;
+
+	for (done = 0; done < num_pages; done += HV_DEPOSIT_MAX) {
+		u32 to_deposit = min(num_pages - done, HV_DEPOSIT_MAX);
+
+		ret = __hv_call_deposit_pages(node, partition_id,
+					      to_deposit);
+		if (ret)
+			break;
+	}
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(hv_call_deposit_pages);
 
 int hv_deposit_memory_node(int node, u64 partition_id,



