Return-Path: <linux-hyperv+bounces-7830-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9042AC87C7A
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 03:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EDA23B547D
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Nov 2025 02:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8369530BF74;
	Wed, 26 Nov 2025 02:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ACmWVDg+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143A530C368;
	Wed, 26 Nov 2025 02:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764122959; cv=none; b=s6VrfGgui8bDOFhbJDE04KCx7QWnk5Tkk4FPBShhO/zKjS9Kvd7J4WTm7Sd6qx5dRItSz5n//dhCznpV0fdimV3g3ajSmjQSL/F/msTl5DAzTyk4TUX5+EMbLNPiZW9clC5NgwcQp8wUZxqW89e8CIRPBWpcAAyTUiJh9NT6WpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764122959; c=relaxed/simple;
	bh=Kuat2+GE4GCfk6pyqT469WYa2Pr3n4+Q86Z4006mb3c=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hjQJUaEOPXJaijbEq3ekfHANmBrGZP+YlWnyE/dTvdi81lnPM1HQA7e4WxeWP9DM9xuhivNaspDRoYPh0wa+iHnjTfX/mUY1p6APYMMiGIoNGRuFm1X7PQR0SIAHouBztQgTCzCCn4LXKJfHhOWgzIfPd9nbtD8HqFUyTvhRu8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ACmWVDg+; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [4.155.116.186])
	by linux.microsoft.com (Postfix) with ESMTPSA id 727A92120EAF;
	Tue, 25 Nov 2025 18:09:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 727A92120EAF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1764122957;
	bh=W+Fv/r0jRC245VbjepUDdAkEoZc2HVKJeWlhQZFgD8E=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=ACmWVDg+8LF5D/Z4QGajU9JY5qyzFd8LljB3geSl0fbkcxU9jIctFONkEwECdaicz
	 So00zsKK3dRK38gzg2lgV64jLsx0auaDUNZcnj7gQyp8JcHN8p9g5vtmyymgwkdFuh
	 sakTRllROjtpW2k+RwKjneAoYOjysB43hDYTormc=
Subject: [PATCH v7 5/7] Drivers: hv: Improve region overlap detection in
 partition create
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com
Cc: linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 26 Nov 2025 02:09:17 +0000
Message-ID: 
 <176412295734.447063.5692907557041244468.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
In-Reply-To: 
 <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
References: 
 <176412196000.447063.4256335030026363827.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Refactor region overlap check in mshv_partition_create_region to use
mshv_partition_region_by_gfn for both start and end guest PFNs, replacing
manual iteration.

This is a cleaner approach that leverages existing functionality to
accurately detect overlapping memory regions.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 drivers/hv/mshv_root_main.c |    8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/hv/mshv_root_main.c b/drivers/hv/mshv_root_main.c
index 5dfb933da981..ae600b927f49 100644
--- a/drivers/hv/mshv_root_main.c
+++ b/drivers/hv/mshv_root_main.c
@@ -1086,13 +1086,9 @@ static int mshv_partition_create_region(struct mshv_partition *partition,
 	u64 nr_pages = HVPFN_DOWN(mem->size);
 
 	/* Reject overlapping regions */
-	hlist_for_each_entry(rg, &partition->pt_mem_regions, hnode) {
-		if (mem->guest_pfn + nr_pages <= rg->start_gfn ||
-		    rg->start_gfn + rg->nr_pages <= mem->guest_pfn)
-			continue;
-
+	if (mshv_partition_region_by_gfn(partition, mem->guest_pfn) ||
+	    mshv_partition_region_by_gfn(partition, mem->guest_pfn + nr_pages - 1))
 		return -EEXIST;
-	}
 
 	rg = mshv_region_create(mem->guest_pfn, nr_pages,
 				mem->userspace_addr, mem->flags,



