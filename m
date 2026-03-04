Return-Path: <linux-hyperv+bounces-9131-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kLsPCQR8p2kshwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9131-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 01:25:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A534B1F8E5E
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Mar 2026 01:25:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA8BF307D80D
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 00:23:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D976D29D27A;
	Wed,  4 Mar 2026 00:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ouWrxPbJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B15219301;
	Wed,  4 Mar 2026 00:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772583832; cv=none; b=Hwo6hxx/4Rs+gvkB6oePaDjwHSCMK21PVlT40kOhCZhVxUKYyLLhmtYccqdtCgqcUYuC00/gxX3jddvVxUQdgMC7OR1FYLrIZkBceWwSTIhsp8TCkuExA5yQM9Jb992jGSBlyjdLg7zuHIrFJm4iE55qMgw76xWcUrunBjKyVE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772583832; c=relaxed/simple;
	bh=1i0GRX2SYAfii4KzTUfR+MBSt5jyahQCaYE1d30BWIk=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SNrKksczfUAKGnIL6hBByhS72KWU3/HSA/S77/HLuTZYz1yWK46HI243Os7iAmcTmWxaervlcDBBM4MSrGJ90gmdE48H5HIpAkJ/DG1zPG3H/IKng4tl44ZSfIL81Ns9MeWO32lqswPJBzyR2WaytKzEpnqgmMYm9r5TyZK5ZGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ouWrxPbJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3DDE520B6F02;
	Tue,  3 Mar 2026 16:23:51 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3DDE520B6F02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772583831;
	bh=Sa1jJV2khjDPmNMbQ2QysiqWJkab4qWCgNGdBWMlbEg=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ouWrxPbJVBh+hKlKJ0mN+7f2AjHHXGxeJI7suP7oK1D6RjPYHJHSAIZ5Azow+pmbC
	 3kg68FUmAmb8eY8y8e6u1bj73V1oSEI96H7daVGjzwfn88GNvloBBs1u21V0H8rtOI
	 nOXBq47WKPVjNyi2ScL1HZVvXgiNJnTbAD9AisK0=
Subject: [PATCH 4/4] mshv: Pre-deposit pages for SLAT creation
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 04 Mar 2026 00:23:51 +0000
Message-ID: 
 <177258383107.229866.16867493994305727391.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
X-Rspamd-Queue-Id: A534B1F8E5E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	TAGGED_FROM(0.00)[bounces-9131-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Action: no action

Deposit enough pages up front to avoid guest address space region creation
failures due to low memory. This also speeds up guest creation.

Calculate the required number of pages based on the guest's physical
address space size, rounded up to 1 GB chunks. Even the smallest guests are
assumed to need at least 1 GB worth of deposits. This is because every
guest requires tens of megabytes of deposited pages for hypervisor
overhead, making smaller deposits impractical.

Estimating in 1 GB chunks prevents over-depositing for larger guests while
accepting some over-deposit for smaller ones. This trade-off keeps the
estimate close to actual needs for larger guests.

Also withdraw the deposited pages if address space region creation fails.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |   25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 48c842b6938d..cb5b4505f8eb 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -39,6 +39,7 @@
 #define MSHV_PARTITION_DEPOSIT_PAGES		(SZ_512K >> PAGE_SHIFT)
 #define MSHV_PARTITION_DEPOSIT_PAGES_NESTED	(20 * SZ_1M >> PAGE_SHIFT)
 #define MSHV_VP_DEPOSIT_PAGES			(1 * SZ_1M >> PAGE_SHIFT)
+#define MSHV_1G_DEPOSIT_PAGES			(6 * SZ_1M >> PAGE_SHIFT)
 
 MODULE_AUTHOR("Microsoft");
 MODULE_LICENSE("GPL");
@@ -1324,6 +1325,18 @@ static int mshv_prepare_pinned_region(struct mshv_mem_region *region)
 	return ret;
 }
 
+static u64
+mshv_region_deposit_slat_pages(struct mshv_mem_region *region)
+{
+	u64 region_in_gbs, slat_pages;
+
+	/* SLAT needs 6 MB per 1 GB of address space. */
+	region_in_gbs = DIV_ROUND_UP(region->nr_pages << HV_HYP_PAGE_SHIFT, SZ_1G);
+	slat_pages = region_in_gbs * MSHV_1G_DEPOSIT_PAGES;
+
+	return slat_pages;
+}
+
 /*
  * This maps two things: guest RAM and for pci passthru mmio space.
  *
@@ -1364,6 +1377,11 @@ mshv_map_user_memory(struct mshv_partition *partition,
 	if (ret)
 		return ret;
 
+	ret = hv_call_deposit_pages(NUMA_NO_NODE, partition->pt_id,
+				    mshv_region_deposit_slat_pages(region));
+	if (ret)
+		goto free_region;
+
 	switch (region->mreg_type) {
 	case MSHV_REGION_TYPE_MEM_PINNED:
 		ret = mshv_prepare_pinned_region(region);
@@ -1392,7 +1410,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 				   region->hv_map_flags, ret);
 
 	if (ret)
-		goto errout;
+		goto withdraw_memory;
 
 	spin_lock(&partition->pt_mem_regions_lock);
 	hlist_add_head(&region->hnode, &partition->pt_mem_regions);
@@ -1400,7 +1418,10 @@ mshv_map_user_memory(struct mshv_partition *partition,
 
 	return 0;
 
-errout:
+withdraw_memory:
+	hv_call_withdraw_memory(mshv_region_deposit_slat_pages(region),
+				NUMA_NO_NODE, partition->pt_id);
+free_region:
 	vfree(region);
 	return ret;
 }



