Return-Path: <linux-hyperv+bounces-5272-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE7BAA57DD
	for <lists+linux-hyperv@lfdr.de>; Thu,  1 May 2025 00:06:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 336204E5C12
	for <lists+linux-hyperv@lfdr.de>; Wed, 30 Apr 2025 22:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F030224B05;
	Wed, 30 Apr 2025 22:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="ATtOmQef"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2429922370A;
	Wed, 30 Apr 2025 22:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746050766; cv=none; b=Ec/GY+MZycOZ5IYOtv1cNSKndn5PM0n/ndDN4hGoR9gcDnx5CTrZlTS4lSsbd+uzLkE6U9RAq2BxxyM3mY/9euVqrcHdQ2bDltan2E+wCX3VBMrh/sGoztWjLQxg7GH1QNUD4dWBIQ5YjyMec2RQ6XMBUpqDGlE9jjqLFn7Bn/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746050766; c=relaxed/simple;
	bh=Ip8kCIs/NCxhLce9W0wi+ojRYSwPsFGesZ5pyNqongM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=V0gxJS7R3p5o1E63+805kV8QHfHKsLY27oCvScp5TmtycqlKt5ZivGcE2gnDfjEdcbJJ47WJrIaURxOtNuJmGU0s8PRPo+9zFkmsxZaXPJjj/xaNaNxyZMVTeMV36HlBd/8at5bbczVMLi23COvr27nP+6j2Hes7Yf96GYC1ccI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=ATtOmQef; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id C526021130A4; Wed, 30 Apr 2025 15:06:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C526021130A4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1746050763;
	bh=oEUBSZ8NILqC1QUWEk7J5DCevmeOgK9HDP3Grif/Ql8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ATtOmQefJCnNfY+URkn72qohw97BvneZDHlZ2fTk3PYu6CMVsqYOU8MbHanRKhlCD
	 qnErqWnZpWDes6gdMonAMAoN1G78LulTcm56cBGd5HyQ5bnwsYykhUsAR+h33CMjNx
	 o9X2sNajZGpSBacvyA7JXQUEbPhuC4LOhuL7/qPs=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>
Subject: [Patch v2 4/4] Drivers: hv: Remove hv_free/alloc_* helpers
Date: Wed, 30 Apr 2025 15:05:58 -0700
Message-Id: <1746050758-6829-5-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746050758-6829-1-git-send-email-longli@linuxonhyperv.com>
References: <1746050758-6829-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Those helpers are simply wrappers for page allocations.

Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/hv/connection.c        | 23 +++++++++++++++++------
 drivers/hv/hv_common.c         | 24 ------------------------
 include/asm-generic/mshyperv.h |  4 ----
 3 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 8351360bba16..a0160b73b593 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -206,11 +206,20 @@ int vmbus_connect(void)
 	INIT_LIST_HEAD(&vmbus_connection.chn_list);
 	mutex_init(&vmbus_connection.channel_mutex);
 
+	/*
+	 * The following Hyper-V interrupt and monitor pages can be used by
+	 * UIO for mapping to user-space, it should always be allocated on
+	 * system page boundaries. We use page allocation functions to allocate
+	 * those pages. We assume system page be bigger than Hyper-v page.
+	 */
+	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
+
 	/*
 	 * Setup the vmbus event connection for channel interrupt
 	 * abstraction stuff
 	 */
-	vmbus_connection.int_page = hv_alloc_hyperv_zeroed_page();
+	vmbus_connection.int_page =
+		(void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
 	if (vmbus_connection.int_page == NULL) {
 		ret = -ENOMEM;
 		goto cleanup;
@@ -225,8 +234,8 @@ int vmbus_connect(void)
 	 * Setup the monitor notification facility. The 1st page for
 	 * parent->child and the 2nd page for child->parent
 	 */
-	vmbus_connection.monitor_pages[0] = hv_alloc_hyperv_page();
-	vmbus_connection.monitor_pages[1] = hv_alloc_hyperv_page();
+	vmbus_connection.monitor_pages[0] = (void *)__get_free_page(GFP_KERNEL);
+	vmbus_connection.monitor_pages[1] = (void *)__get_free_page(GFP_KERNEL);
 	if ((vmbus_connection.monitor_pages[0] == NULL) ||
 	    (vmbus_connection.monitor_pages[1] == NULL)) {
 		ret = -ENOMEM;
@@ -342,21 +351,23 @@ void vmbus_disconnect(void)
 		destroy_workqueue(vmbus_connection.work_queue);
 
 	if (vmbus_connection.int_page) {
-		hv_free_hyperv_page(vmbus_connection.int_page);
+		free_page((unsigned long)vmbus_connection.int_page);
 		vmbus_connection.int_page = NULL;
 	}
 
 	if (vmbus_connection.monitor_pages[0]) {
 		if (!set_memory_encrypted(
 			(unsigned long)vmbus_connection.monitor_pages[0], 1))
-			hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
+			free_page((unsigned long)
+				vmbus_connection.monitor_pages[0]);
 		vmbus_connection.monitor_pages[0] = NULL;
 	}
 
 	if (vmbus_connection.monitor_pages[1]) {
 		if (!set_memory_encrypted(
 			(unsigned long)vmbus_connection.monitor_pages[1], 1))
-			hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
+			free_page((unsigned long)
+				vmbus_connection.monitor_pages[1]);
 		vmbus_connection.monitor_pages[1] = NULL;
 	}
 }
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index 297ccd7d4997..421376cea17e 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -105,30 +105,6 @@ void __init hv_common_free(void)
 	hv_synic_eventring_tail = NULL;
 }
 
-/*
- * A Hyper-V page can be used by UIO for mapping to user-space, it should
- * always be allocated on system page boundaries.
- */
-void *hv_alloc_hyperv_page(void)
-{
-	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
-	return (void *)__get_free_page(GFP_KERNEL);
-}
-EXPORT_SYMBOL_GPL(hv_alloc_hyperv_page);
-
-void *hv_alloc_hyperv_zeroed_page(void)
-{
-	BUILD_BUG_ON(PAGE_SIZE < HV_HYP_PAGE_SIZE);
-	return (void *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-}
-EXPORT_SYMBOL_GPL(hv_alloc_hyperv_zeroed_page);
-
-void hv_free_hyperv_page(void *addr)
-{
-	free_page((unsigned long)addr);
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


