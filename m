Return-Path: <linux-hyperv+bounces-3495-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F10709F6F10
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Dec 2024 21:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E66016D0ED
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Dec 2024 20:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12851FC105;
	Wed, 18 Dec 2024 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="mRuzK2nD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71D531FBE85;
	Wed, 18 Dec 2024 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555269; cv=none; b=t7jzTv8j5R+PHtbRCh3Merp/B+u/BAHBvAqY5L9U+p2ARe7gPQTDS8otES1yXT7qRIXzVlGaa5PidAaIB1wF/h1gQRhf9qmT00OdFhcLs0asjfHhxxnqmgD49hbHgAwSTwT3FjCojnORAnE1/W4C7vqXmZYsvHoi2oK299fg910=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555269; c=relaxed/simple;
	bh=4Q2Al8os+V3krTFlVXkBKlYcoYCAa2JLfQ4Rk1j7reA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eaX7N35AnltI/szANYFRXsB6pZIzpZzGrMcvVuiCEIL2UMqb+mkpCRqmp8Cr6oHdmCtVZK/se099KZwlfQYQvTUQyvwGaByECqZIPWIAJbBkba3dVkoEHP7xHftBhI1YI9XEKeB9Ke4mKkJXOBpwRxrWempJhRQE9/UHmNQ7Utw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=mRuzK2nD; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 6CC5E203FC7A;
	Wed, 18 Dec 2024 12:54:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 6CC5E203FC7A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734555262;
	bh=fXVhuh/byezRSGvZCk91J8mf7KeTETtRa5rL9vk+Mro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mRuzK2nDnZYl1+mlQSLc8ZGSuWEnVvtzxqfKE3iiURokUOTqkxN/7oYFDf7z4EhVf
	 u9/icEDO2CL9yR9wFYiNshBwAeAqh/YU5bn/VOWrvPuijZXQbKgDkqTHrXK5NPytPG
	 XQeCy3A/ctlkfNym+JaJoZ74ea67rPI0ROIOSl1o=
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
Subject: [PATCH 2/2] hyperv: Do not overlap the input and output hypercall areas in get_vtl(void)
Date: Wed, 18 Dec 2024 12:54:21 -0800
Message-Id: <20241218205421.319969-3-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241218205421.319969-1-romank@linux.microsoft.com>
References: <20241218205421.319969-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Top-Level Functional Specification for Hyper-V, Section 3.6 [1, 2], disallows
overlapping of the input and output hypercall areas, and get_vtl(void) does
overlap them.

To fix this, enable allocation of the output hypercall pages when running in
the VTL mode and use the output hypercall page of the current vCPU for the
hypercall.

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
[2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs

Fixes: 8387ce06d70b ("x86/hyperv: Set Virtual Trust Level in VMBus init message")
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 2 +-
 drivers/hv/hv_common.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index c7185c6a290b..90c9ea00273e 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -422,7 +422,7 @@ static u8 __init get_vtl(void)
 
 	local_irq_save(flags);
 	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = (struct hv_get_vp_registers_output *)input;
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
 
 	memset(input, 0, struct_size(input, names, 1));
 	input->partition_id = HV_PARTITION_ID_SELF;
diff --git a/drivers/hv/hv_common.c b/drivers/hv/hv_common.c
index c4fd07d9bf1a..5178beed6ca8 100644
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


