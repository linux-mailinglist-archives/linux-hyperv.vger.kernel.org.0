Return-Path: <linux-hyperv+bounces-10280-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHt7GdGL52lY9wEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10280-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 16:38:09 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 09FED43C281
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 16:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1FFE3302D648
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Apr 2026 14:36:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 160FF3D902E;
	Tue, 21 Apr 2026 14:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="pz/jgaVd"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 796773D88E4;
	Tue, 21 Apr 2026 14:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776782149; cv=none; b=gGe02hRG+ODye9zRGUWeTYATGjEgm65pua+wEwPU1x8IeYQwgtwyddqVZlbUOIR7J7IxnQS+o3ijc+gQrRc+i7ySGyDWz3Ii5RLKYFE48dk/wgZH8e0HPlZzB8QR97Piwsahhiad1sWQAgGNwnr4L7PzXhOktiBVCRuoivntRd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776782149; c=relaxed/simple;
	bh=KvawCPuy1UfxBuQ6vhW3nf3l3/xukHjHLn6eAdvEf7E=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ak3OlODSCrMNuj3ohgsnEpEV5189Wf2E3c6LXBSPgzJpJp6XMOljeklVHeRxLMNHiK29Xc/atRVPQs2CnJm8+QjrcHBiDqQpXLM3B0yg0OcF5CXvk/NRs8602ONv84E/ijMzaqcXxsTWBMNv8qTcOhRYRrW8mY2q5lnmgt13G5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=pz/jgaVd; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 86E4B20B6F01;
	Tue, 21 Apr 2026 07:35:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86E4B20B6F01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1776782148;
	bh=pZyHgsyWsOI158B9eFCiaQP3JGp5WaEqNBiTllvUvLM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=pz/jgaVdrWDDxvI+PKq571z4TBVHns3k5obJcSLFsD652nA1Pbn8tZk5pCSCvW/d0
	 10JOio2TXyx/MM2YYPdPrUUtFZQ2X71+qsZ6LXnA8fc71mJ1YX9TjXp2mvt5jqJzH1
	 SogdrG7uQze0/5j/L4Y+R9c3U9vVjLLGhQWyZLvs=
Subject: [PATCH v2 6/7] mshv: Extract MMIO region mapping into separate
 function
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 21 Apr 2026 14:35:48 +0000
Message-ID: 
 <177678214799.13344.13365309470623836963.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177678175995.13344.10130389779290396174.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177678175995.13344.10130389779290396174.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
	TAGGED_FROM(0.00)[bounces-10280-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Queue-Id: 09FED43C281
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Extract the MMIO region mapping logic from mshv_map_user_memory() into
a dedicated mshv_map_mmio_region() function. This improves code
organization and consistency with the existing mshv_map_pinned_region()
and mshv_map_movable_region() functions.

The new function encapsulates the hv_call_map_mmio_pfns() call,
making the switch statement in mshv_map_user_memory() more concise
and maintaining a uniform pattern for all region types.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c   |    9 +++++++++
 drivers/hv/mshv_root.h      |    2 ++
 drivers/hv/mshv_root_main.c |    5 +----
 3 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index c408d61a6ca6..f54f28ef13c5 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -832,3 +832,12 @@ int mshv_map_movable_region(struct mshv_mem_region *region)
 	return mshv_region_collect_and_map(region, 0, region->nr_pfns,
 					   false);
 }
+
+int mshv_map_mmio_region(struct mshv_mem_region *region,
+			 unsigned long mmio_pfn)
+{
+	struct mshv_partition *partition = region->partition;
+
+	return hv_call_map_mmio_pfns(partition->pt_id, region->start_gfn,
+				     mmio_pfn, region->nr_pfns);
+}
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index ce718056590f..aa22a08e5df2 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -374,5 +374,7 @@ void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
 int mshv_map_pinned_region(struct mshv_mem_region *region);
 int mshv_map_movable_region(struct mshv_mem_region *region);
+int mshv_map_mmio_region(struct mshv_mem_region *region,
+			 unsigned long mmio_pfn);
 
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 881edc5d6e2b..0111366fc2a9 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1301,10 +1301,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
 		ret = mshv_map_movable_region(region);
 		break;
 	case MSHV_REGION_TYPE_MMIO:
-		ret = hv_call_map_mmio_pfns(partition->pt_id,
-					    region->start_gfn,
-					    mmio_pfn,
-					    region->nr_pfns);
+		ret = mshv_map_mmio_region(region, mmio_pfn);
 		break;
 	}
 



