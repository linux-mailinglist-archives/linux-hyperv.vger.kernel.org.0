Return-Path: <linux-hyperv+bounces-3628-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E86A06832
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 23:22:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60C6A16087E
	for <lists+linux-hyperv@lfdr.de>; Wed,  8 Jan 2025 22:22:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171EC204F76;
	Wed,  8 Jan 2025 22:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="FoEpZ+B5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AED75204095;
	Wed,  8 Jan 2025 22:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736374904; cv=none; b=Bde3kxqjEvsfQkK74M/mpc0//T863DR5Zoou2rsvJ+oK0cgWDZvqxclZFT3gmsENbA3zTMfXYOBwdKGs/T+VWdCD5u/dU+RcFpkgPGorpF0VUCh+rEBAVTPeSlGNueJMn1JqTVba70ciaaHEZi8ktKmMb39tDXtxSpG6Nga1DiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736374904; c=relaxed/simple;
	bh=5SiC6CGRokdAmWq10sS4FRECfu4OtPdVhJAkYMlzJKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n6QvKbTSUU/Hm0rPRF5ber8QD3FLe4GucccYXzgJgaSIvm66SYZ3uY63Lv2F4wL32B+MYmfvgjEkproDQSj4A2q2CJN0REqbdIyJqUyO0B6zZmB+6W/CRkQTpdMnHQpKkWKNwc6yNept8kvmTEdF6ragUM5JE1R3V8OSMx89azE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=FoEpZ+B5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id D73F2203E3B0;
	Wed,  8 Jan 2025 14:21:40 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D73F2203E3B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1736374901;
	bh=8WiwdrwxYid9TP2KN6SPCoazL0yGKj1OCkPzSlA+1hs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FoEpZ+B5qF13JGzezKgnuM6s8YcLIvt9PWVsQ2ECO6V1Gqg2Z7tBK6xq4lrHsBSsa
	 nYi/wP4Y2HnC4pvx3y9TKNxvgAhhMXG4qR7mMqsHZWJLgbreOHxGBKHfMoLQyy9f1R
	 EaAxnUFOIWEBEp2R1wuCMcUk51d4esG7VxEBtlv8=
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
Subject: [PATCH v6 5/5] hyperv: Do not overlap the hvcall IO areas in hv_vtl_apicid_to_vp_id()
Date: Wed,  8 Jan 2025 14:21:38 -0800
Message-Id: <20250108222138.1623703-6-romank@linux.microsoft.com>
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
hv_vtl_apicid_to_vp_id() overlaps them.

Use the output hypercall page of the current vCPU for the hypercall.

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
[2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs

Reported-by: Michael Kelley <mhklinux@outlook.com>
Closes: https://lore.kernel.org/lkml/SN6PR02MB4157B98CD34781CC87A9D921D40D2@SN6PR02MB4157.namprd02.prod.outlook.com/
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
Reviewed-by: Easwar Hariharan <eahariha@linux.microsoft.com>
---
 arch/x86/hyperv/hv_vtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 04775346369c..4e1b1e3b5658 100644
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
2.34.1


