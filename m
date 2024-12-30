Return-Path: <linux-hyperv+bounces-3560-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF1C9FE9A3
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Dec 2024 19:09:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B72B03A3C10
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Dec 2024 18:09:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53101B042D;
	Mon, 30 Dec 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XSe/fGTa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690551ACEC4;
	Mon, 30 Dec 2024 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735582185; cv=none; b=sCFhFjN80oBKSQBQOorCu9arm6sxAAIUemzrsS1l7RdAulNTk6uH9eGp3Q6YDHruJJ11tBgne846b1a7Rm6Wpkq2FS2MQzdpH07DJDUfuvEny1ZdEzl1wM2C0apfOxUimloa1C1vkdonV7MAcNY1uafMpWg1n+fcTcaFuQsilbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735582185; c=relaxed/simple;
	bh=EQ8qFQw69BNvqk+V1uNigvZI2v/00r9VxWFjPaIcGIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kNdXugDaO5biw9/vhLbM624S6xzK6xsP9aHV/n5wn1GcBUgy6XOhJTmM2B+BHREK0FuqbMl7PSxFbHiZ4M837FZGAWI2TuEJSMlb30Ihk/y1jqClw86C/yAbSdezUFxlvGnceTFD00D6bowTGaoZd2YI9hj0TArOb0+HfKWVMyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XSe/fGTa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id CE02D205A752;
	Mon, 30 Dec 2024 10:09:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CE02D205A752
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735582184;
	bh=VeuGFw7q+Hc9N0d/4qq8GlAi1foElxnJ5LOQzooRJZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XSe/fGTaSfpxFEUW2oQ1pNfJEGJoiFVxM/jNqfsbHdtFcRJv34sNok4ahNkGDc41c
	 AOGcHmQw1IHU/wuVo25XfhTpkuJs2rqPfaf4HzPjDOZ+stmYjDdzATpIfdrUUsreAj
	 uKRFqu+17IaF46ChzmWR6TBIo31gKd0qiKmtZaEk=
From: Roman Kisel <romank@linux.microsoft.com>
To: hpa@zytor.com,
	kys@microsoft.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	eahariha@linux.microsoft.com,
	haiyangz@microsoft.com,
	mingo@redhat.com,
	mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com,
	tglx@linutronix.de,
	tiala@microsoft.com,
	wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH v5 3/5] hyperv: Enable the hypercall output page for the VTL mode
Date: Mon, 30 Dec 2024 10:09:39 -0800
Message-Id: <20241230180941.244418-4-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241230180941.244418-1-romank@linux.microsoft.com>
References: <20241230180941.244418-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Due to the hypercall page not being allocated in the VTL mode,
the code resorts to using a part of the input page.

Allocate the hypercall output page in the VTL mode thus enabling
it to use it for output and share code with dom0.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 drivers/hv/hv_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index c6ed3ba4bf61..c983cfd4d6c0 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -340,7 +340,7 @@ int __init hv_common_init(void)
 	BUG_ON(!hyperv_pcpu_input_arg);
 
 	/* Allocate the per-CPU state for output arg for root */
-	if (hv_root_partition) {
+	if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
 		hyperv_pcpu_output_arg = alloc_percpu(void *);
 		BUG_ON(!hyperv_pcpu_output_arg);
 	}
@@ -435,7 +435,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	void **inputarg, **outputarg;
 	u64 msr_vp_index;
 	gfp_t flags;
-	int pgcount = hv_root_partition ? 2 : 1;
+	const int pgcount = (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) ? 2 : 1;
 	void *mem;
 	int ret;
 
@@ -453,7 +453,7 @@ int hv_common_cpu_init(unsigned int cpu)
 		if (!mem)
 			return -ENOMEM;
 
-		if (hv_root_partition) {
+		if (hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE)) {
 			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
 			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
 		}
-- 
2.34.1


