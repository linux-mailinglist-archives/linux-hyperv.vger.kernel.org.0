Return-Path: <linux-hyperv+bounces-3561-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA1B9FE9A5
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Dec 2024 19:09:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1A951646CA
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Dec 2024 18:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE33E1B0437;
	Mon, 30 Dec 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SoF8AlMu"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918D61ACED2;
	Mon, 30 Dec 2024 18:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735582185; cv=none; b=O8VxU6+hgSmvdtIswyI8Lc5kdIsS+9oXLZkM/Gxx8xN/TAtOka5EbI1hpi1Q78KXpnR5MBu3fr82Bbi/wW7snEbhtalj8sdFILeD7Za+OEppq9S87aDemdUQNgLJB9RWznjSVcYyI5aYg8WRpEIk6Z9o4qXbWZYFG7oYj6qg/74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735582185; c=relaxed/simple;
	bh=zBviSLS9kQ/mVfxhHrN0UYzdLgDlBknZGPuabwGuqt8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bAg3MrdCKPE9U78EUJbvLnaHDPqDyfe/v/136ekxR6OPHODYlYkXLAIGPxtSU+WESwGJt85jhYycBxVOiG0aZedpaf+orRp1vteCBe5ptXY9p9U745RjPHhXfLmjRGBty4+LeVONA3EfnnjNqIVYL6eP11PgWbdaDnh0hPtWBzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=SoF8AlMu; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 18B77206ADF4;
	Mon, 30 Dec 2024 10:09:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 18B77206ADF4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735582184;
	bh=ciyKd7rGPt5CsHeucplU1xQpzjYtFfnwDF7tcKA0qZ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SoF8AlMu8oMdfSP75lCMFgxRCijSeXNF9MubO6LrOHA8iirLpFuImb8qM/Zblmfae
	 woq5oRv1DUH5+GqVDSn+0F5fIPoJsLIahrUm9YZxKVOaN52FOnTCdupQ4sswuU0NVf
	 2l8/glopMZ9KAm+qXZJDraGbYkdTFol79Og09//M=
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
Subject: [PATCH v5 4/5] hyperv: Do not overlap the hvcall IO areas in get_vtl()
Date: Mon, 30 Dec 2024 10:09:40 -0800
Message-Id: <20241230180941.244418-5-romank@linux.microsoft.com>
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

The Top-Level Functional Specification for Hyper-V, Section 3.6 [1, 2],
disallows overlapping of the input and output hypercall areas, and
get_vtl(void) does overlap them.

Use the output hypercall page of the current vCPU for the hypercall.

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
[2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs

Fixes: 8387ce06d70b ("x86/hyperv: Set Virtual Trust Level in VMBus init message")
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
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


