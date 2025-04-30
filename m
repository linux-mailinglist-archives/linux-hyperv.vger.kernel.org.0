Return-Path: <linux-hyperv+bounces-5269-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 20300AA57D6
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 00:06:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7C9E1B67F0A
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 22:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254FA22424E;
	Wed, 30 Apr 2025 22:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="GoVn4/UD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10FF2236FD;
	Wed, 30 Apr 2025 22:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746050764; cv=none; b=fuqYRZhaO2mXM+mZnq9i543X2ABiBDEKbR+QP6N5voWWbrwZ84l8YK9BVtv+scq46VX/HnWpVgrk8Sdnkmt5p7wdQl71HbPbhPa22aqlxTkJvuYW0OdMpNHNj2578dsMfxFoSO4FEsKRpiPPskR/mXhiKcGJh9YhNkDz1dvG3rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746050764; c=relaxed/simple;
	bh=TFis9gHNrqk1OOK9/GuBTdb5nDgh6BXGx7Wi6DhZdyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=ieRX/SBv9zjwKEIbMSCUQXKIxcdAxtTEmhWLUY63AYJAH+7BXbw4HXvQan15QteDFIVAOs+a6WFOiFYMtJX6vDL3YY8aOGi4OeqIEV7XAKKOotpQ66f9xcoM02vi3XdgMSq05grkQo67i3waUeaw0TDWz2rfO9uH3dX9p4soCcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=GoVn4/UD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 281E6204E7FF; Wed, 30 Apr 2025 15:06:01 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 281E6204E7FF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1746050761;
	bh=PqxNSFralGdoPjwbpzjkm4fl3Ci7ss7SzZhupHdZjQk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GoVn4/UDSvqHiDhx+vVXHpJQ4TmgXiSK0tnWw69d1s64ZPxMnc6FlHPD8OMEtlD2a
	 h5L1h6iWW0dddyZMAGrTDMWjka7+Zku0uoQYUPh3aexNoHqf5Qa4Dd8QirW56NUpnB
	 Y3G+XSVhaFhsNBk8y5MmZsRZlF43yrsxNPWJdaUE=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>,
	stable@vger.kernel.org
Subject: [Patch v2 1/4] Drivers: hv: Allocate interrupt and monitor pages aligned to system page boundary
Date: Wed, 30 Apr 2025 15:05:55 -0700
Message-Id: <1746050758-6829-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746050758-6829-1-git-send-email-longli@linuxonhyperv.com>
References: <1746050758-6829-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

There are use cases that interrupt and monitor pages are mapped to
user-mode through UIO, they need to be system page aligned. Some Hyper-V
allocation APIs introduced earlier broke those requirements.

Fix those APIs by always allocating Hyper-V page at system page boundaries.

Cc: stable@vger.kernel.org
Fixes: ca48739e59df ("Drivers: hv: vmbus: Move Hyper-V page allocator to arch neutral code")
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/hv/hv_common.c | 35 ++++++++++-------------------------
 1 file changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index a7d7494feaca..297ccd7d4997 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -106,41 +106,26 @@ void __init hv_common_free(void)
 }
 
 /*
- * Functions for allocating and freeing memory with size and
- * alignment HV_HYP_PAGE_SIZE. These functions are needed because
- * the guest page size may not be the same as the Hyper-V page
- * size. We depend upon kmalloc() aligning power-of-two size
- * allocations to the allocation size boundary, so that the
- * allocated memory appears to Hyper-V as a page of the size
- * it expects.
+ * A Hyper-V page can be used by UIO for mapping to user-space, it should
+ * always be allocated on system page boundaries.
  */
-
 void *hv_alloc_hyperv_page(void)
 {
-	BUILD_BUG_ON(PAGE_SIZE <  HV_HYP_PAGE_SIZE);
-
-	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
-		return (void *)__get_free_page(GFP_KERNEL);
-	else
-		return kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
+	return (void *)__get_free_page(GFP_KERNEL);
 }
 EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
 
 void *hv_alloc_hyperv_zeroed_page(void)
 {
-	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
-		return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-	else
-		return kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
+	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
+	return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 }
 EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
 
 void hv_free_hyperv_page(void *addr)
 {
-	if (PAGE_SIZE == HV_HYP_PAGE_SIZE)
-		free_page((unsigned long)addr);
-	else
-		kfree(addr);
+	free_page((unsigned long)addr);
 }
 EXPORT_SYMBOL_GPL(hv_free_hyperv_page);
 
@@ -272,7 +257,7 @@ static void hv_kmsg_dump_unregister(void)
 	atomic_notifier_chain_unregister(&panic_notifier_list,
 					 &hyperv_panic_report_block);
 
-	hv_free_hyperv_page(hv_panic_page);
+	kfree(hv_panic_page);
 	hv_panic_page = NULL;
 }
 
@@ -280,7 +265,7 @@ static void hv_kmsg_dump_register(void)
 {
 	int ret;
 
-	hv_panic_page = hv_alloc_hyperv_zeroed_page();
+	hv_panic_page = kzalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
 	if (!hv_panic_page) {
 		pr_err("Hyper-V: panic message page memory allocation failed\n");
 		return;
@@ -289,7 +274,7 @@ static void hv_kmsg_dump_register(void)
 	ret = kmsg_dump_register(&hv_kmsg_dumper);
 	if (ret) {
 		pr_err("Hyper-V: kmsg dump register error 0x%x\n", ret);
-		hv_free_hyperv_page(hv_panic_page);
+		kfree(hv_panic_page);
 		hv_panic_page = NULL;
 	}
 }
-- 
2.34.1


