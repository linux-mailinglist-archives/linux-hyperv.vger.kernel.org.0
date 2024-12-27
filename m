Return-Path: <linux-hyperv+bounces-3541-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D6C9FD6F1
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 19:32:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2F781883420
	for <lists+linux-hyperv@lfdr.de>; Fri, 27 Dec 2024 18:32:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124761F8AD1;
	Fri, 27 Dec 2024 18:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BhngCs8g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A313B1F8693;
	Fri, 27 Dec 2024 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735324319; cv=none; b=ERANNn/sT5DVWNbL/nLG4NY0tIRCi04FC5ORfWD4uu+9cf9CIGBNvoBkN2C2dPZyTInWLU5khwIWq9yWp+FrKGsHpPrPbF9Ls9wFFRfXAKbe9iei7EAanrqW4S2adNTpJQ14uesM2Jt+QqCBzlWsYUr9LQDvmLWAwpqHSRL46mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735324319; c=relaxed/simple;
	bh=EQ8qFQw69BNvqk+V1uNigvZI2v/00r9VxWFjPaIcGIk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OqCQrPItSo+XmeIbJNa76D4uY540R8ZbSUjhYyWxOHRrAfdJPZSl/gUPkYOXqXLoJfFEILjrplyDmdBWFe8cJAGJj3WnLgY4IPu7G8Qm1+zpLIfXLynhmOnSINbYwqmDgkWFGFcviKPqb3miNNb3uAgt8EfH7YGbhiiMHr87jaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BhngCs8g; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 377B6203EC3E;
	Fri, 27 Dec 2024 10:31:57 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 377B6203EC3E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735324317;
	bh=VeuGFw7q+Hc9N0d/4qq8GlAi1foElxnJ5LOQzooRJZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BhngCs8gX58ll6YdEPAPAtnJ7AcuOTllcmC0l38vT9n+i5i6HnOdw8mZ2pHy87Pyd
	 bbvm9CxmK65oGyM3M1pVkWTPrMekd9PZ0xBmaORXIgr5WVCFI6Ce17+rFI1HDSVjQJ
	 SWIGgoP2ieizgFx7F2lLCzpg4ssdWiho05YBx7wg=
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
Subject: [PATCH v4 3/5] hyperv: Enable the hypercall output page for the VTL mode
Date: Fri, 27 Dec 2024 10:31:53 -0800
Message-Id: <20241227183155.122827-4-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241227183155.122827-1-romank@linux.microsoft.com>
References: <20241227183155.122827-1-romank@linux.microsoft.com>
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


