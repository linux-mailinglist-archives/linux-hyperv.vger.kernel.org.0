Return-Path: <linux-hyperv+bounces-3528-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3BEE9FCDFE
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 22:31:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 49A371631F6
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 21:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6887B15DBBA;
	Thu, 26 Dec 2024 21:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="r4da50yv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126101411EB;
	Thu, 26 Dec 2024 21:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735248674; cv=none; b=of28iS+XYd9lmxzXTPPkMhptv2e+8G0TwGWDsuvx+ZCbD03QcqMNAdq/+jYFHNKDiBYI+R2q0B7z2jfqkcAhOv/iy9xcsksFQUrKDj8kxQzLRPMi2qyz/hlCt6Qov3feHgMv+NzJlK+T1jy1umz7sui6pPr7M9Rb/PGvgAL4jZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735248674; c=relaxed/simple;
	bh=HoFMyxPQ4+vHjO5aNu8dprTKaB0BfQ/OCxXps0eLfws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djWwPaHvwq2ykd1sOO+4z4BVa6GDpbUzWMG/gEyI5IHPZZJThSBKf7D1q2y679A5qga6O/STLQqf7aKgzqW5ei9hEAGrHj9eZ0tRMA3gBNXDZm+kJwYdkPo5NGrfCF4YfOg1zGzDBSAIT/589uXFe861mNM/O0dLsjiwSWq+JxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=r4da50yv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 75011203EC26;
	Thu, 26 Dec 2024 13:31:12 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 75011203EC26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735248672;
	bh=n/7BbD0J/6ZyeZxeLEf6nxi13TKSTWUcLtaICTY9HoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r4da50yvdLFm/hm9IPe7stmWuYCPFZSznNoHw50pT84OOCeEZktoEyF7qGm2TH0wR
	 YXlMFLt/4SDr3LFidMuws6092zNnktJy0FPxY/CA+0/i/jiNyswb0knWspAp5eXKgA
	 B9iX1fisSm8NOFZNE9vVd2I4SEmhTP2CPoTZhQVQ=
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
Subject: [PATCH v3 2/5] hyperv: Fix pointer type for the output of the hypercall in get_vtl(void)
Date: Thu, 26 Dec 2024 13:31:07 -0800
Message-Id: <20241226213110.899497-3-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241226213110.899497-1-romank@linux.microsoft.com>
References: <20241226213110.899497-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")
changed the type of the output pointer to `struct hv_register_assoc` from
`struct hv_get_vp_registers_output`. That leads to an incorrect computation,
and leaves the system broken.

Use the correct pointer type for the output of the GetVpRegisters hypercall.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 3cf2a227d666..ba469d6b8250 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -416,13 +416,13 @@ static u8 __init get_vtl(void)
 {
 	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
 	struct hv_input_get_vp_registers *input;
-	struct hv_register_assoc *output;
+	struct hv_output_get_vp_registers *output;
 	unsigned long flags;
 	u64 ret;
 
 	local_irq_save(flags);
 	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = (struct hv_register_assoc *)input;
+	output = (struct hv_output_get_vp_registers *)input;
 
 	memset(input, 0, struct_size(input, names, 1));
 	input->partition_id = HV_PARTITION_ID_SELF;
@@ -432,7 +432,7 @@ static u8 __init get_vtl(void)
 
 	ret = hv_do_hypercall(control, input, output);
 	if (hv_result_success(ret)) {
-		ret = output->value.reg8 & HV_X64_VTL_MASK;
+		ret = output->values[0].reg8 & HV_X64_VTL_MASK;
 	} else {
 		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
 		BUG();
-- 
2.34.1


