Return-Path: <linux-hyperv+bounces-3626-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 391B4A0682C
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 23:21:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0C8B7A2C67
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 22:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E836204696;
	Wed,  8 Jan 2025 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Nu5xVvo0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3E871E1C3B;
	Wed,  8 Jan 2025 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374902; cv=none; b=hBs0GK5wROPbqrEE6ST31Y5Sv7kSlBhElBlpzDlBZ+4FHt+NQgl95qhDjmyjtUtEkADryctZx7Ydnk2l2EgYXUN/CAMzWvoNyr+2fes+pWrU9hGm0Io7uP4/B4MGB1hq6YCGZlChScCrmJqXN0DPnTIQKIZosRHgTUu1/wCw6Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374902; c=relaxed/simple;
	bh=yqySHNYOR7JGkEPuN+DLh9ECpz6ZXbtctwZrk+ie7Ck=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TuMa7J94KrMsBDPZZUHIobyw1yjHx05gJC2vaY0YaxXQYYw1OGNX5LyI2rPt3+newH1qtF8aCciHVV64DFqUnPrDLWIRffqCZsH8J5C6JoyuKWFdI99fPbTzi0h10uGGiHbgjpvwoBGr0tkiDpdDGmO51SYMLBNo/Huu5X3QBk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Nu5xVvo0; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 56C32203E3AE;
	Wed,  8 Jan 2025 14:21:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 56C32203E3AE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736374900;
	bh=ZywFVF8Yt9VYckKPyJkIwnvBVKrrGO227UQIbP1TxE4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nu5xVvo0EGwRql491N4u3a4hy58mIJwJYihAY+vzdvgP2y3mVWD3QukHHV01kyKRG
	 8qAKhXaj44GygcjSv3tUCWh+pEgOYLFP8X2FGda+EefxJ0L61IHg9bXRDJXydA+G6x
	 HAhjRYk2DMDD1E9Km6kHAihU33bpteLserlUhGJ0=
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
Subject: [PATCH v6 3/5] hyperv: Enable the hypercall output page for the VTL mode
Date: Wed,  8 Jan 2025 14:21:36 -0800
Message-Id: <20250108222138.1623703-4-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250108222138.1623703-1-romank@linux.microsoft.com>
References: <20250108222138.1623703-1-romank@linux.microsoft.com>
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
 drivers/hv/hv_common.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index c6ed3ba4bf61..af5d1dc451f6 100644
--- a/drivers/hv/hv_common.c
+++ b/drivers/hv/hv_common.c
@@ -278,6 +278,11 @@ static void hv_kmsg_dump_register(void)
 	}
 }
 
+static inline bool hv_output_page_exists(void)
+{
+	return hv_root_partition || IS_ENABLED(CONFIG_HYPERV_VTL_MODE);
+}
+
 int __init hv_common_init(void)
 {
 	int i;
@@ -340,7 +345,7 @@ int __init hv_common_init(void)
 	BUG_ON(!hyperv_pcpu_input_arg);
 
 	/* Allocate the per-CPU state for output arg for root */
-	if (hv_root_partition) {
+	if (hv_output_page_exists()) {
 		hyperv_pcpu_output_arg = alloc_percpu(void *);
 		BUG_ON(!hyperv_pcpu_output_arg);
 	}
@@ -435,7 +440,7 @@ int hv_common_cpu_init(unsigned int cpu)
 	void **inputarg, **outputarg;
 	u64 msr_vp_index;
 	gfp_t flags;
-	int pgcount = hv_root_partition ? 2 : 1;
+	const int pgcount = hv_output_page_exists() ? 2 : 1;
 	void *mem;
 	int ret;
 
@@ -453,7 +458,7 @@ int hv_common_cpu_init(unsigned int cpu)
 		if (!mem)
 			return -ENOMEM;
 
-		if (hv_root_partition) {
+		if (hv_output_page_exists()) {
 			outputarg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
 			*outputarg = (char *)mem + HV_HYP_PAGE_SIZE;
 		}
-- 
2.34.1


