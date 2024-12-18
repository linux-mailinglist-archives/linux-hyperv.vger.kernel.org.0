Return-Path: <linux-hyperv+bounces-3494-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D70F9F6F0F
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Dec 2024 21:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C0B1188BDA6
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Dec 2024 20:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E93AC1FC0EC;
	Wed, 18 Dec 2024 20:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gxiuyBeo"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71CFB1FAC51;
	Wed, 18 Dec 2024 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555269; cv=none; b=jr3QCAjE5vMJufoW9TgxyqDTGiLfSKQx7lgPHDHlrrFJqxf9mmrOHeJL3xEs1aEu1tRn9C1aI4XwFFAXzsbU2qAYyqt38e04rIGfblPjL+NSbrB7jou2R7D5ChA6rKq8Ev4wIQm9+rSSDiwCMFYILUmVs3F9SF2vZLLZt8NF8G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555269; c=relaxed/simple;
	bh=ZzZ2JnZrtb2YILFB+pA8XMn7AYhsHZXoHmORZCcgv2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZlLYJZoxy/49lSkoWqGsbLoioJvWBxIP2dG3VInJwRhM//xL6piLoc4DjstWzKbxgMM38KZVTwfZMeiiGQotT4z4nkG1/Ih5Ss5/IiEF5/zpauPI1FyBFLR+QbtD1w6sHM4gsLOdlwvMuJFkaiVcU5GEoyGi1Azdw6pmeHtbc3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gxiuyBeo; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 2C6D1203FC79;
	Wed, 18 Dec 2024 12:54:22 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2C6D1203FC79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734555262;
	bh=heA/ZhQfNHWsYkvUc/EtILHKIXM4xEYeSsoa0DWJKGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gxiuyBeoObFXF/a5M0MyCBBSFAAAZfRO7XBU8t7CyOOFC9nXSDw3BNu/tCbKEv0Yd
	 mr/3/xxiK+gfsjPoB++zN2CkxQ2GaPYcWDZbTs4Iw9fLYWgO/TfoW5RmRZUokPE6Xv
	 M4rQTKCIRhpS9KKLFt8YLlQvw5nDQM6+GUd0rtNs=
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
Subject: [PATCH 1/2] hyperv: Fix pointer type for the output of the hypercall in get_vtl(void)
Date: Wed, 18 Dec 2024 12:54:20 -0800
Message-Id: <20241218205421.319969-2-romank@linux.microsoft.com>
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

Commit bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")
changed the type of the output pointer to `struct hv_register_assoc` from
`struct hv_get_vp_registers_output`. That leads to an incorrect computation,
and leaves the system broken.

Use the correct pointer type for the output of the GetVpRegisters hypercall.

Fixes: bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c   | 6 +++---
 include/hyperv/hvgdk_mini.h | 3 ---
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 3cf2a227d666..c7185c6a290b 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -416,13 +416,13 @@ static u8 __init get_vtl(void)
 {
 	u64 control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_REGISTERS;
 	struct hv_input_get_vp_registers *input;
-	struct hv_register_assoc *output;
+	struct hv_get_vp_registers_output *output;
 	unsigned long flags;
 	u64 ret;
 
 	local_irq_save(flags);
 	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = (struct hv_register_assoc *)input;
+	output = (struct hv_get_vp_registers_output *)input;
 
 	memset(input, 0, struct_size(input, names, 1));
 	input->partition_id = HV_PARTITION_ID_SELF;
@@ -432,7 +432,7 @@ static u8 __init get_vtl(void)
 
 	ret = hv_do_hypercall(control, input, output);
 	if (hv_result_success(ret)) {
-		ret = output->value.reg8 & HV_X64_VTL_MASK;
+		ret = output->as64.low & HV_X64_VTL_MASK;
 	} else {
 		pr_err("Failed to get VTL(error: %lld) exiting...\n", ret);
 		BUG();
diff --git a/include/hyperv/hvgdk_mini.h b/include/hyperv/hvgdk_mini.h
index db3d1aaf7330..0b1a10828f33 100644
--- a/include/hyperv/hvgdk_mini.h
+++ b/include/hyperv/hvgdk_mini.h
@@ -1107,7 +1107,6 @@ union hv_register_value {
 	union hv_x64_pending_interruption_register pending_interruption;
 };
 
-#if defined(CONFIG_ARM64)
 /* HvGetVpRegisters returns an array of these output elements */
 struct hv_get_vp_registers_output {
 	union {
@@ -1124,8 +1123,6 @@ struct hv_get_vp_registers_output {
 	};
 };
 
-#endif /* CONFIG_ARM64 */
-
 struct hv_register_assoc {
 	u32 name;			/* enum hv_register_name */
 	u32 reserved1;
-- 
2.34.1


