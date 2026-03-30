Return-Path: <linux-hyperv+bounces-9839-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Gh1AmPXymk1AgYAu9opvQ
	(envelope-from <linux-hyperv+bounces-9839-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 22:04:51 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 809EA360C39
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 22:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BB982301286E
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Mar 2026 20:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791CB393DC1;
	Mon, 30 Mar 2026 20:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="G1VrSqUP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0EB27B32C;
	Mon, 30 Mar 2026 20:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774901088; cv=none; b=na+fMylw1aBG9/MeCi7ytq1uVScq6bdOKuhI3OKNt0A9p4RfPJctu/EaSv/NwqTTMDVdAa6HRJ1bCTZ2C5Xrs3YmahcOABX6Lz2wpPWibYeispUfkjSlqvwXlBK16JTTEifuGk6cKhej9aDtJjwNpPyv4epDUQhdpj3vLd3n2aI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774901088; c=relaxed/simple;
	bh=3xQ1X1f02O73FNZgVNoF/R00VDlbxF0sp4XkWt/4NbA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uVSUd7YFeWWSZhZ1cEwOyCPQVQ04nei5Uv+R0BOlYh7ZvsYcviICwbfkxSDVpOBK73wvnxdV9QHnMu1KQ+zKT9cvR0jBycNz6OVsHwDzEd8d9LDcJJ8YOpxiCs/UYbdYhY2IKP6q6xAh/1bD4yLFbLh56mD5dGYggGHEOEPXMis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=G1VrSqUP; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 3520D20B6F12;
	Mon, 30 Mar 2026 13:04:47 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3520D20B6F12
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1774901087;
	bh=fovLyII8U0VmJ9kaz5XVsvMbVXucbjpZ8cWzPEDWL7o=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=G1VrSqUPe3sXRmzK/6KtBqYagNleuUSXJpqpe6swC0AtESTWA7FMS6fbbhUSTEJ5f
	 xLJTiLfPAvq8EeXNTcIaC34Qf0NjwRaK1pHZ1xqoQPOD3r0lCknkPe95EPs8kYqOWU
	 WF04EQYnCUSPzCDy73r188Yp7w2v8Um+1BaCDkmE=
Subject: [PATCH 6/7] mshv: Extract MMIO region mapping into separate function
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 30 Mar 2026 20:04:46 +0000
Message-ID: 
 <177490108669.81669.5173618560722960805.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177490099488.81669.3758562641675983608.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
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
	TAGGED_FROM(0.00)[bounces-9839-lists,linux-hyperv=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+]
X-Rspamd-Queue-Id: 809EA360C39
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
index 28d3f488d89f..6b703b269a4f 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -831,3 +831,12 @@ int mshv_map_movable_region(struct mshv_mem_region *region)
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
index 02c1c11f701c..1f92b9f85b60 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -375,5 +375,7 @@ void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
 int mshv_map_pinned_region(struct mshv_mem_region *region);
 int mshv_map_movable_region(struct mshv_mem_region *region);
+int mshv_map_mmio_region(struct mshv_mem_region *region,
+			 unsigned long mmio_pfn);
 
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 91dab2a3bc92..adb09350205a 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1302,10 +1302,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
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
 



