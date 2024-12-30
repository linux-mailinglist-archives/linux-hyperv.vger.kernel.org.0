Return-Path: <linux-hyperv+bounces-3559-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 884319FE9A1
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Dec 2024 19:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 724571884C78
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Dec 2024 18:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888341B0422;
	Mon, 30 Dec 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="HSsEE1lu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220581ACEC1;
	Mon, 30 Dec 2024 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735582185; cv=none; b=eHPeTn0FSF0DISJpS6/LhZi3P7jkg6AfOyUuYzaRLSxVJ6kujHN1W7e157SpauHC/p8CFVy6N+EftMxehVYnkO0H79hXusNr6RatRLnDfgK/wNc48jkKnr9NElcZHSYw03N3yOopt/d6QEtFSd7a1dUisN+Rh9BQf3u59rFWt1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735582185; c=relaxed/simple;
	bh=lnd2bW+mEWgcyHDSppSYygV+U0xWEf88EcV6/K+ANU0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tOZdyUqhNzEAuCFYqaUlKxwdbsGWKXh4HSGRq2jA8G7RrV5kF1RxPCRXUwFbyzP6Bjtb/aU4KBF9KYSAXnhYz4oyWa7YcsyGpwSnmi8fga1ItdU3bRWHzD3hVBmiu/8z5RhBOT/IV2iWcaV0PrK9AU58k2DtBJBeFYaQNLMg1a0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=HSsEE1lu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8E987205A751;
	Mon, 30 Dec 2024 10:09:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E987205A751
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735582183;
	bh=Klz7yPqD0Eckrc+SA7sLQw6zV3C1NtM+cNODXl922cM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HSsEE1lul2GGlCXRsnarXApL+W1iRn9Az1Ak2Sfh0FqPX1zB7Gmm7QC6ajEiSxea7
	 LZNc+jWhnHpGnyv8NouN9W0bMBUN4Rsk9PGUouwECWNcDnnxTGJqUkmhKaABQehcNr
	 9JX/lAz20dJu+c0u2Ss2L6jnwxn/bu9j36ts90go=
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
Subject: [PATCH v5 2/5] hyperv: Fix pointer type in get_vtl(void)
Date: Mon, 30 Dec 2024 10:09:38 -0800
Message-Id: <20241230180941.244418-3-romank@linux.microsoft.com>
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
index 9e5e8328df6b..f82d1aefaa8a 100644
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


