Return-Path: <linux-hyperv+bounces-3523-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CEADC9FCDA3
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 21:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E18D1882DA4
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 20:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3754189B83;
	Thu, 26 Dec 2024 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="s1WDabHG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704561494CC;
	Thu, 26 Dec 2024 20:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735245054; cv=none; b=Vs6I8SgrbdfK465jmoNqTqqmY2mc49Xr4yRtHJMwHRAhae53FbSg5eVOHBeRoq1hqDPlkfoL0vj3/MIAYnhmhYuYnRt/vG01rYepEPj14Oy+fJYgs6Kya/sVpEtipw+TI9RdMkcRa9iSPn5kkNeagknQ52FqHKACVLQ/JCHJh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735245054; c=relaxed/simple;
	bh=HoFMyxPQ4+vHjO5aNu8dprTKaB0BfQ/OCxXps0eLfws=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DL7IlrqKwodbobES2Wjnopi7/9CiYVD6a+mWTnnPKC+6H1Sk7YOHjOCh61dcczVlkZrdZGbrIOGzucUA0kbA4cOUahQ3tIvDng0i4sLU6dV42mqvOoGozhOgxxl4eKfQ0jnlGiAbssjv07HEFLtN6AhzYzzrL8Z3decJf7TUBBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=s1WDabHG; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id B85E2203EC26;
	Thu, 26 Dec 2024 12:30:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B85E2203EC26
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735245052;
	bh=n/7BbD0J/6ZyeZxeLEf6nxi13TKSTWUcLtaICTY9HoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=s1WDabHGwwVqTvucnCmigA1wNzXsCkYxzktf+NQ03yBw4tYsrSblO4tFLwymO3hll
	 np30Y5oDya8YYb4RUJy8bo/bPPxuWg78nrlkE6yZPhsiUlTOOd23H0yZJvxY0E6t/I
	 t7vFlBfp2FPWj8gZlBeMUjzXhXByz5AZf9SL6KuU=
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
Subject: [PATCH v2 2/3] hyperv: Fix pointer type for the output of the hypercall in get_vtl(void)
Date: Thu, 26 Dec 2024 12:30:49 -0800
Message-Id: <20241226203050.800524-3-romank@linux.microsoft.com>
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


