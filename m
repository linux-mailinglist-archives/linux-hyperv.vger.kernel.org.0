Return-Path: <linux-hyperv+bounces-1965-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 142538A4AFB
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Apr 2024 10:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454EE1C2104B
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Apr 2024 08:57:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52EF3B28F;
	Mon, 15 Apr 2024 08:57:25 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from njjs-sys-mailin01.njjs.baidu.com (mx316.baidu.com [180.101.52.236])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 988C43B297
	for <linux-hyperv@vger.kernel.org>; Mon, 15 Apr 2024 08:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713171445; cv=none; b=eicyv0CoHhAzKFHScPObs25Wf3KMtYToHqCBaaiIG1BRIR2EzmiGddqb3w4/cxvmIq8LGzwkuZu3JdEF8ja6iryLDgfM94j99aS6n/WWjrvNF7PU4vE4/BDuhmlcfACaEeE0kBsn+uPEXz7NFE/lBsvf61IcH4YvNED2rEJTMGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713171445; c=relaxed/simple;
	bh=T9P5uTM884IxOltHHkiROmoIfKz0K1yPJSWzEzZqFRc=;
	h=From:To:Cc:Subject:Date:Message-Id; b=hADJx5tO+QHYwdIT5fffThOgCa+bk2MGsbgTgCnA6ji4vWaxTOAASSN/Ekd0N3UB/075kWQDf/VZx0mW6WGY/hlhMi21aLX6Yru7aNJHfCFiErmDqYWCszZHgCgxmOMkDp6mVhU6K3nxogIZk5FiF4MUDFu8P0zbMfEDMHGw+7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 0B2277F00043;
	Mon, 15 Apr 2024 16:57:14 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] x86/hyperv: Consider NUMA affinity when allocating memory for per-CPU vmsa
Date: Mon, 15 Apr 2024 16:57:12 +0800
Message-Id: <20240415085712.49980-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

per-CPU vmsa are dominantly accessed from their own local CPUs,
so allocate them node-local to improve performance.

And reorganized variables to be reverse christmas tree order

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 arch/x86/hyperv/ivm.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 768d73d..5bc2430 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -291,16 +291,18 @@ static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa)
 
 int hv_snp_boot_ap(u32 cpu, unsigned long start_ip)
 {
-	struct sev_es_save_area *vmsa = (struct sev_es_save_area *)
-		__get_free_page(GFP_KERNEL | __GFP_ZERO);
+	struct hv_enable_vp_vtl *start_vp_input;
 	struct sev_es_save_area *cur_vmsa;
+	struct sev_es_save_area *vmsa;
 	struct desc_ptr gdtr;
-	u64 ret, retry = 5;
-	struct hv_enable_vp_vtl *start_vp_input;
 	unsigned long flags;
+	u64 ret, retry = 5;
+	struct page *p;
 
-	if (!vmsa)
+	p = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO, 0);
+	if (!p)
 		return -ENOMEM;
+	vmsa = (struct sev_es_save_area *)page_address(p);
 
 	native_store_gdt(&gdtr);
 
-- 
2.9.4


