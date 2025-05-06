Return-Path: <linux-hyperv+bounces-5358-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFAEAAB909
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 08:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E853B7C32
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 06:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B131032A6F8;
	Tue,  6 May 2025 03:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="LAHLp1/z"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251CC34FAFD;
	Tue,  6 May 2025 00:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746493010; cv=none; b=YQzJM7PcGnNTQKOHLS3cndDVyQGoqGHRBKj0oSpWuExCCA1fwKDq3ck54YvONUGEjvZxY6a3t8dj/nXdJpZMUqHh7W70AhutkMVAV41DraLKUCsSDe4WcIsOWD2KTDBK2R4KrcwQmnR2dw68yQpwgtd++Qja8vDdTSrEMX+hfyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746493010; c=relaxed/simple;
	bh=JruDkI3GXfZf4tHR86VsgRMY60DqpXC3BKMs+rXCqF8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=f4qQM50VV4kQoTAuvedr25cYtR7yVd8PqUJxxqOLLC7Ms/2ctfR/BLwoCQnNnwHkV2beIzPbk1vjgUnFoQ/Drc7MHTQFFmqmx2gdVto3C7xc8AoXtZ3CUnye0mVfjz2+RsK+EI+ku1mCpQ0eBe9WItwso0sTG4053csUOHc5jwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=LAHLp1/z; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id EE4FB2115DC7; Mon,  5 May 2025 17:56:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EE4FB2115DC7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1746493008;
	bh=trr1tx7SJkPMB80H3ADWZz7ZMck5EyVgqKue45Oc6PI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LAHLp1/zxAngy3CbIhfsUJrm3vw2IhYMUe8iWEySu3BHdBoXx+Uxn0BwCDD8tEzL2
	 LQIWHuOBUX7TsVp3xY42AsuI09/j3AAvb7vy7yEW6ZLKDn064BJdma2uk0elZTfTSV
	 /FXoqyunXy57V3R9KuZSBxqtGjEHSPncsVh83NJI=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v3 5/5] Drivers: hv: Remove hv_alloc/free_* helpers
Date: Mon,  5 May 2025 17:56:37 -0700
Message-Id: <1746492997-4599-6-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
References: <1746492997-4599-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

There are no users for those functions, remove them.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/hv/hv_common.c         | 39 ----------------------------------
 include/asm-generic/mshyperv.h |  4 ----
 2 files changed, 43 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index a5a6250b1a12..421376cea17e 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -105,45 +105,6 @@ void __init hv_common_free(void)
 	hv_synic_eventring_tail = NULL;
 }
 
-/*
- * Functions for allocating and freeing memory with size and
- * alignment HV_HYP_PAGE_SIZE. These functions are needed because
- * the guest page size may not be the same as the Hyper-V page
- * size. We depend upon kmalloc() aligning power-of-two size
- * allocations to the allocation size boundary, so that the
- * allocated memory appears to Hyper-V as a page of the size
- * it expects.
- */
-
-void *hv_alloc_hyperv_page(void)
-{
-	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
-
-	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
-		return (void *)__get_free_page(GFP_KERNEL);
-	else
-		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
-}
-EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
-
-void *hv_alloc_hyperv_zeroed_page(void)
-{
-	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
-		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-	else
-		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
-}
-EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
-
-void hv_free_hyperv_page(void *addr)
-{
-	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
-		free_page((unsigned long)addr);
-	else
-		kfree(addr);
-}
-EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
-
 static void *hv_panic_page;
 
 /*
diff --git a/include/asm-generic/mshyperv.h b/include/asm-generic/mshyperv.h
index ccccb1cbf7df..4033508fbb11 100644
--- a/include/asm-generic/mshyperv.h
+++ b/include/asm-generic/mshyperv.h
@@ -236,10 +236,6 @@ int hv_common_cpu_init(unsigned int cpu);
 int hv_common_cpu_die(unsigned int cpu);
 void hv_identify_partition_type(void);
 
-void *hv_alloc_hyperv_page(void);
-void *hv_alloc_hyperv_zeroed_page(void);
-void hv_free_hyperv_page(void *addr);
-
 /**
  * hv_cpu_number_to_vp_number() - Map CPU to VP.
  * @cpu_number: CPU number in Linux terms
-- 
2.34.1


