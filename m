Return-Path: <linux-hyperv+bounces-4968-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE9DA92EE0
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Apr 2025 02:43:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F55E4665D9
	for <lists+linux-hyperv@lfdr.de>; Fri, 18 Apr 2025 00:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DF31481A3;
	Fri, 18 Apr 2025 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="tD/yyzsS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8D82A1D7;
	Fri, 18 Apr 2025 00:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744937002; cv=none; b=Z3TWQJ2ZKa7gVYgK0xqSm0wQmC1GX2u3VnVGm8UNEtGi0ofVjN/OBO6UfiR1aVRVEfu2o7gJIFXBXxYzlGs+fJsmeE2+X9wO3dV385F6dzUGHsvpVOtqQEyhhHOgaobC2Fh+OvuQsmEBUcHMMC1GSuaPstacTTszd2Sa6ZISe3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744937002; c=relaxed/simple;
	bh=wPsRF+g0CgGHIn8Cu2/Fm5NCeD5ZL4NsGfulFAUvTHg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=hRMva9BpWzSoMhevLrNFU2XkfGSjjifTE7/VjRNN1avk8UDGkWZPaXIfRpYivCVr8EBIUIr7JUC7zJgkg2jGVBaWGkc7REKPoJAaVmVrX+5Gc8kJOOfbGMYiwW1xzDPDei3MogqNsGXVaVH+d2ahwmgwj8vqZCquFvZHAJlhU2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=tD/yyzsS; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 919042052516; Thu, 17 Apr 2025 17:43:20 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 919042052516
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1744937000;
	bh=ngeSLap9FR3I8QT9yiNwCoXHVRvVw9uTKGk8eFA6FUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tD/yyzsSlHwDfXqbv66esrz1SlxSt8JVfxW7bGDLeJ1uzRnpVa45FyQITd39TMS3U
	 gSjOWs7EECBVH0wICKfaFOMJZRpckqzCUjAcCr+p3GdWzqZp+nbkqI2xP/IEdit5mP
	 1hvWbkpX4AXNPzVhR8KKyo15y/g8zQxcPC5HAO7U=
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
Subject: [PATCH 1/2] Drivers: hv: Allocate interrupt and monitor pages aligned to system page boundary
Date: Thu, 17 Apr 2025 17:43:16 -0700
Message-Id: <1744936997-7844-2-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744936997-7844-1-git-send-email-longli@linuxonhyperv.com>
References: <1744936997-7844-1-git-send-email-longli@linuxonhyperv.com>
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
 drivers/hv/hv_common.c | 29 +++++++----------------------
 1 file changed, 7 insertions(+), 22 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index a7d7494feaca..f426aaa9b8f9 100644
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
 
-- 
2.34.1


