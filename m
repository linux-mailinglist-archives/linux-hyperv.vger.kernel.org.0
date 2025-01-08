Return-Path: <linux-hyperv+bounces-3625-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C52A0682B
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 23:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0BF817A2B21
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 22:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C40220468D;
	Wed,  8 Jan 2025 22:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="KmeTC5Bu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CF01A070E;
	Wed,  8 Jan 2025 22:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374901; cv=none; b=qhC6+GlTM9xcvXfCpMWpOztKExYuedqd654MOSofj1k4Sg1DGH7GD3gRcTJm5uDdck03j+F1qI6KgnBqEd5c8hPfg55UG9Wb11FxyROPSeKMi7JujHiMSssJe12VzenvnxHPhAddFM/qxOsRlE7OihZ7CsEEqmVm6P9IkM6jn4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374901; c=relaxed/simple;
	bh=eheEiYFZ3ecvWH92ToTltGWJ+i40cLuC3Bo1qct+0Wo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fSW2FlZ6k2K+GSdco0642ePzpY6bU3BafboxRTIkPze7xdGagDyrzuFUujFwdjI/mz/gkHaNuMcki8y+VwB9/OfVIlIZSzMgA1BDQR5aN1pn3gssuUOKto8UPst3sqwp7IAc8jEMJge4J5DQThgUU+ZyR1wFQN7jqyLNEmxBwlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=KmeTC5Bu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 15BE1203E3AD;
	Wed,  8 Jan 2025 14:21:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 15BE1203E3AD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736374900;
	bh=NNIK9O8tqPQmhbHWuF6fEy3lgReXdhCmNwdOmKsHi4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KmeTC5Bu1+peWxH1qSNI3/I7fjGx6I6L+8STPiFruOATe7trPRDIxHphXpiP0pajU
	 J1zDVQsYiO9N3lS7gQwsdIDUdDGYUJovZRLzxRJwjzU5P+xYX1s0KJdsGs6vFVK11Y
	 gzQzQR1iV9oE9A9I+WzMTfZhtjTgssidmFWCkZDA=
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
Subject: [PATCH v6 2/5] hyperv: Fix pointer type in get_vtl(void)
Date: Wed,  8 Jan 2025 14:21:35 -0800
Message-Id: <20250108222138.1623703-3-romank@linux.microsoft.com>
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

Commit bc905fa8b633 ("hyperv: Switch from hyperv-tlfs.h to hyperv/hvhdk.h")
changed the type of the output pointer to `struct hv_register_assoc` from
`struct hv_get_vp_registers_output`. That leads to an incorrect computation,
and leaves the system broken.

Use the correct pointer type for the output of the GetVpRegisters hypercall.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
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


