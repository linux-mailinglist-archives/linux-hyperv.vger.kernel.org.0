Return-Path: <linux-hyperv+bounces-3524-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA3E9FCDA6
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 21:31:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05873163606
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B29155A4D;
	Thu, 26 Dec 2024 20:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="VWw8gEQL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A92AE15B12A;
	Thu, 26 Dec 2024 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735245055; cv=none; b=Tr1dIhc9gQ7136GbvIwQFqlonnmk2dcEKuL52Sd1CP3ooRvYpbwd1Fg/pnkBScOYUkyIXiEZHyqE+lTsON9UeTY2pyq6qTSIdQVL129EzO9UW23OBeLqO+Xix91RUSNrpdNEjKBeC2oNhz8rGcqQYR5R9J5stiNtsHNYl75yETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735245055; c=relaxed/simple;
	bh=8V3SdDAjo5hYZEYWGigqLpYTv9096EwohgpIUxpEcoQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=rH/VO2WgT640nOL+9q7oox4h4/2UxBMhqIlE/sHeLUvzKbyBhdsdc9ixr+m08Yr84BCQZp4KbcVIePY0voEVRv2bJyPw8plzO/eOlw08bb11JOul+Kz+lrxscx7055YRh/+aHQUbzyvONH6Xyyp+oqZYin9FcVnbB7pALpBoXd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=VWw8gEQL; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 032A1203EC25;
	Thu, 26 Dec 2024 12:30:53 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 032A1203EC25
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735245053;
	bh=n3Rya0oa1MLjPmSnHsEzA1dUh4UC9i89NnBD409hxC8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VWw8gEQLMfGA9C7XPWDGGktgxvMQnRJ9k2LysLPD+Hd+4ID4ZwggOdxOiTB6n89kP
	 eU3SM960wykfQqZEPXAClvXJNvuvi1ukYyg/ljjvAL3iCJmNdu20VuIgG2QPQ1q369
	 jiQIPD6ofrde/Gy/52y/NRH0cGiz8yWuIJoq/GfQ=
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
Subject: [PATCH v2 3/3] hyperv: Do not overlap the input and output hypercall areas in get_vtl(void)
Date: Thu, 26 Dec 2024 12:30:50 -0800
Message-Id: <20241226203050.800524-4-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226203050.800524-1-romank@linux.microsoft.com>
References: <20241226203050.800524-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Top-Level Functional Specification for Hyper-V, Section 3.6 [1, 2],
disallows overlapping of the input and output hypercall areas, and
get_vtl(void) does overlap them.

To fix this, enable allocation of the output hypercall pages when
running in the VTL mode and use the output hypercall page of the
current vCPU for the hypercall.

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
[2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs

Fixes: 8387ce06d70b ("x86/hyperv: Set Virtual Trust Level in VMBus init message")
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 2 +-
 drivers/hv/hv_common.c    | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index ba469d6b8250..cf3f7d30fcdd 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -422,7 +422,7 @@ static u8 __init get_vtl(void)
 
 	local_irq_save(flags);
 	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = (struct hv_output_get_vp_registers *)input;
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


