Return-Path: <linux-hyperv+bounces-3787-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78CB8A20FE9
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 18:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5731316750F
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Jan 2025 17:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FED21F543E;
	Tue, 28 Jan 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o39EbA+K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73BFB1F5430;
	Tue, 28 Jan 2025 17:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738086847; cv=none; b=eJ6XCRrY7YCeEh0gvRgPnrXLTNFVyS0oHxdNGWl3ouCOZB60MqG0lgTSJIfv1DaHESGqxG494Hom6MtmYBXa6JXIK5IOYMGo0rywBMxvkNxx6OSLlxYPsY1ABikcHCvqWcX4OPWmDek0XlnJwZHrBEDlwIwU5gzxaGlXtfgjqnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738086847; c=relaxed/simple;
	bh=6qao0JXXyZP44kcHKZCb++yOVgr2jYvsFxsrA5N7CiQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NMGUdyc2tDWht+tGf4OPdkk/BbfuJE+UvGZYPR1x7OD5EEUgzhIkMngebvlNi5KpFQ8aNftNFXHdeLKlQRJmLVY6SUXRctRKXf8W1svHv23bIH6z5nu1RfRAoJdXaBpSAE7Z3MFCbYbIMbK1tpoo48ytd+oqn4SwRJ9mi/wLayw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o39EbA+K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19F09C4CED3;
	Tue, 28 Jan 2025 17:54:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738086846;
	bh=6qao0JXXyZP44kcHKZCb++yOVgr2jYvsFxsrA5N7CiQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o39EbA+KyvLmVqYkB7RQ1S5xlU/gkS9cwaExC52zgzzkul3EZItJTuoeZermtPDaa
	 6bnngZeg8Thwy5s2WailciBzQ/HTe5yDqUJwxANvONBdeOTpZduD7hjb4xb+z88gFz
	 mR3k3yIbygnREn7FC8ZtDEf3yZEwZzbuuDR+dwRo3SrlBLoxb4p2TDRhWCsf4iJWDs
	 2LMDHzhSLaiIh2BQM8M6xqYEZBw+VMlJXSKBZUV7vsQ2NLRbjg+J3fO+NIswcV1noi
	 Ke8VQYeTbMQScjEaN6KRAGR9DZ/AB9I9SLK/6FWPjutLPEAmJEcl2BAv9moRxUc57F
	 Tl7mgzTJHhuiQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Kisel <romank@linux.microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	linux-hyperv@vger.kernel.org
Subject: [PATCH AUTOSEL 6.13 11/15] hyperv: Do not overlap the hvcall IO areas in hv_vtl_apicid_to_vp_id()
Date: Tue, 28 Jan 2025 12:53:42 -0500
Message-Id: <20250128175346.1197097-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250128175346.1197097-1-sashal@kernel.org>
References: <20250128175346.1197097-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13
Content-Transfer-Encoding: 8bit

From: Roman Kisel <romank@linux.microsoft.com>

[ Upstream commit f285d995743269aa9f893e5e9a1065604137c1f6 ]

The Top-Level Functional Specification for Hyper-V, Section 3.6 [1, 2],
disallows overlapping of the input and output hypercall areas, and
hv_vtl_apicid_to_vp_id() overlaps them.

Use the output hypercall page of the current vCPU for the hypercall.

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
[2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs

Reported-by: Michael Kelley <mhklinux@outlook.com>
Closes: https://lore.kernel.org/lkml/SN6PR02MB4157B98CD34781CC87A9D921D40D2@SN6PR02MB4157.namprd02.prod.outlook.com/
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
Reviewed-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Link: https://lore.kernel.org/r/20250108222138.1623703-6-romank@linux.microsoft.com
Signed-off-by: Wei Liu <wei.liu@kernel.org>
Message-ID: <20250108222138.1623703-6-romank@linux.microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/x86/hyperv/hv_vtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 04775346369c5..4e1b1e3b56584 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -189,7 +189,7 @@ static int hv_vtl_apicid_to_vp_id(u32 apic_id)
 	input->partition_id = HV_PARTITION_ID_SELF;
 	input->apic_ids[0] = apic_id;
 
-	output = (u32 *)input;
+	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
 
 	control = HV_HYPERCALL_REP_COMP_1 | HVCALL_GET_VP_ID_FROM_APIC_ID;
 	status = hv_do_hypercall(control, input, output);
-- 
2.39.5


