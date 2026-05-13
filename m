Return-Path: <linux-hyperv+bounces-10858-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDNXJlLJBGqnOgIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10858-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:56:18 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 120C3539659
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 20:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5517D30D3F41
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 May 2026 18:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D999B3A9D9F;
	Wed, 13 May 2026 18:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="k+4tGr07"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DA93AFAED;
	Wed, 13 May 2026 18:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698275; cv=none; b=K5/1VDASXjlhaFwEFOhTJDFmemx5eDrYC5piaaefGI4LYlJTLyVhCHnWOyGhjerAdHdYTFhLMd4RC6m73faSOg4QIg2vx82aIt7axuoyeW48sorc12ErjUXaJb+6i+4P6+KH+Bn2geAQn5bNRbpdul0o5E87X28j/ThGlYnM/HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698275; c=relaxed/simple;
	bh=uHNwzcj5UYBp1zo16CWwEbhfA8PqSFJQcmaYGaPKwfA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kaXLR1J19WLgi1LlArb/d+AVyxi6e2PgI3jTPDLG9A7exUNhjr4//o7OvZfsj7PqDTICUWOoLen3bHay7dfvTOHjZfdoPv5r42tQQlTGh4X6HlACuL6WhaJNzQbYrHlycK6s53+fFQS9b3Zse8yFnDEUOZwQogaeTiWjsjt1A/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=k+4tGr07; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 60B7320B7166;
	Wed, 13 May 2026 11:51:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 60B7320B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1778698271;
	bh=nw76xlqu/IgWMmHiqfaQQtuTe1jOE7blI7gM899Cx7A=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=k+4tGr071PGFsgTi/4udK7jNW4KxNZYeaKdq3FZJDVOK7xHMhmW5ifN6v0/LBYA74
	 Iv2FyUair3sAr7Jw/M3OzvGmcsO0809+5wZV5hlwO8aSDpB/ttgLQN/hlc6qaHYdF6
	 MOrS7zxqkNT9J8MCZcP7uDHr84hLMZF50VhJn2+k=
Subject: [PATCH v3 10/11] mshv: Extract MMIO region mapping into separate
 function
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, longli@microsoft.com, skinsburskii@gmail.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 13 May 2026 18:51:14 +0000
Message-ID: 
 <177869827402.18773.4714555853606551037.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <177869813422.18773.515308662914055136.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <177869813422.18773.515308662914055136.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 120C3539659
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[microsoft.com,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-10858-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[skinsburskii@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[skinsburskii-cloud-desktop.internal.cloudapp.net:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.microsoft.com:dkim]
X-Rspamd-Action: no action

Extract the MMIO region mapping logic from mshv_map_user_memory() into
a dedicated mshv_map_mmio_region() function. This improves code
organization and consistency with the existing mshv_map_pinned_region()
and mshv_map_movable_region() functions.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_regions.c   |    8 ++++++++
 drivers/hv/mshv_root.h      |    2 ++
 drivers/hv/mshv_root_main.c |    5 +----
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/mshv_regions.c b/drivers/hv/mshv_regions.c
index 85f8b7bddf939..7bcfba9ebac12 100644
--- a/drivers/hv/mshv_regions.c
+++ b/drivers/hv/mshv_regions.c
@@ -830,3 +830,11 @@ int mshv_map_movable_region(struct mshv_mem_region *region)
 
 	return 0;
 }
+
+int mshv_map_mmio_region(struct mshv_mem_region *region,
+			 unsigned long mmio_pfn)
+{
+	return hv_call_map_mmio_pfns(region->partition->pt_id,
+				     region->start_gfn,
+				     mmio_pfn, region->nr_pfns);
+}
diff --git a/drivers/hv/mshv_root.h b/drivers/hv/mshv_root.h
index 0f4fc57a14cd0..b091db06390b0 100644
--- a/drivers/hv/mshv_root.h
+++ b/drivers/hv/mshv_root.h
@@ -379,5 +379,7 @@ void mshv_region_movable_fini(struct mshv_mem_region *region);
 bool mshv_region_movable_init(struct mshv_mem_region *region);
 int mshv_map_pinned_region(struct mshv_mem_region *region);
 int mshv_map_movable_region(struct mshv_mem_region *region);
+int mshv_map_mmio_region(struct mshv_mem_region *region,
+			 unsigned long mmio_pfn);
 
 #endif /* _MSHV_ROOT_H_ */
diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index e38438c539c5d..d5197559d7650 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1394,10 +1394,7 @@ mshv_map_user_memory(struct mshv_partition *partition,
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
 



