Return-Path: <linux-hyperv+bounces-3627-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 169EAA06830
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 23:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 551843A43CB
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 22:22:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B710204C22;
	Wed,  8 Jan 2025 22:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="CG8UMldJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDD0204096;
	Wed,  8 Jan 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374903; cv=none; b=Y1OE00BFEVDy3L7P84dGBUV+q8M6qeROe4/Srb950LSZx4o+CDIUpp6LhfNiGLTCJVSzZNgYBZ+Q3ZmJzYIeUQ+z2C6ilOdoSDG0f6k8g8lAwiikGown9ZNmbqbpZsX00FGDgBDZ8gtyOOfrgUrv4Op/bodkAkVROgAHioNlvAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374903; c=relaxed/simple;
	bh=G4rn+yvSAzNF/clV9Ip6RW2KAw4DOZ+LxH8wpoequwM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=byvDu/uiFgZnSqbjTjYozi4bmE/5aLZFQWyMPAxA2KBZQX6KB7rfp/z8cGCHxTybvWo9WOVvpOwvHCOrheaWibGaE/I5W+Zodfy+7TorVN7FQx+g0WV9D0vJdUyNOjdtejHM1q8yz1Nl36TSBH+k00RE0FQEXCIVDcB+rVixyFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=CG8UMldJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 98103203E3AF;
	Wed,  8 Jan 2025 14:21:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 98103203E3AF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736374900;
	bh=448SOSWTgWAOry7zPz/Sg+z2e0JVJKUfOy+ZzFqPyLk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CG8UMldJ1WYnCifYnTEdcPliXRYnGt900/EmRW37uWaLIl4Lw1fvuS8QChlaL3r/i
	 bOv4Q4vjEGzHgEYqdUUnRI12r56sDBamyeQ6VgoCGfDNeZGchrzLSnEtURQvGan/9r
	 WZd+ezyrRAb/5jVbvlzLw7EDgSEO3GV8fWXxB/yM=
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
Subject: [PATCH v6 4/5] hyperv: Do not overlap the hvcall IO areas in get_vtl()
Date: Wed,  8 Jan 2025 14:21:37 -0800
Message-Id: <20250108222138.1623703-5-romank@linux.microsoft.com>
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

The Top-Level Functional Specification for Hyper-V, Section 3.6 [1, 2],
disallows overlapping of the input and output hypercall areas, and
get_vtl(void) does overlap them.

Use the output hypercall page of the current vCPU for the hypercall.

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
[2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs

Fixes: 8387ce06d70b ("x86/hyperv: Set Virtual Trust Level in VMBus init message")
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Tianyu Lan <tiala@microsoft.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 arch/x86/hyperv/hv_init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index f82d1aefaa8a..173005e6a95d 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -422,7 +422,7 @@ static u8 __init get_vtl(void)
 
 	local_irq_save(flags);
 	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
-	output = (struct hv_output_get_vp_registers *)input;
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
 
 	memset(input, 0, struct_size(input, names, 1));
 	input->partition_id = HV_PARTITION_ID_SELF;
-- 
2.34.1


