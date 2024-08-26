Return-Path: <linux-hyperv+bounces-2866-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C452B95EF01
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Aug 2024 12:54:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 567CC287F21
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Aug 2024 10:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A5415539F;
	Mon, 26 Aug 2024 10:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b="KcPpiaW1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from sender4-op-o15.zoho.com (sender4-op-o15.zoho.com [136.143.188.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF10155399;
	Mon, 26 Aug 2024 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724669478; cv=pass; b=VY3oep2PW6us62IEx9SMmSsc9wq+ArkyRgsCsSQP5w4G0W34Jg14lc6hB8WUja+3OMRUGJ7asxVsG20/D47Yxw0WWjWhpkno3P9p9Utdc0ei+V47tliYRe+Ny/NeLXIqkRfLB3/CfhtbQbU7tY4eojWvhOw59pBEkJ9rtuKrXH4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724669478; c=relaxed/simple;
	bh=W5+2nQZiwgd9oh8fjL1chMh9ssNGHLa3VbDluY76Cls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PbkyfgQMNmaXzf3qP8R1oLYg4BGufHIIwJvIHX4rtXocuTFGW2NSuToFWp9E0Y2t9YTmtaIQE2mmJimbKCYVl+7xpf7rCcKEXfXbbBDH+X7GTLrkeX1UhLHTrtOaugB/6mdBlLMYvcOZZnuw8FmcZ0ikwT4PzIFu/Xr3O1HuZqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com; spf=pass smtp.mailfrom=anirudhrb.com; dkim=fail (0-bit key) header.d=anirudhrb.com header.i=anirudh@anirudhrb.com header.b=KcPpiaW1 reason="key not found in DNS"; arc=pass smtp.client-ip=136.143.188.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=anirudhrb.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=anirudhrb.com
Delivered-To: anirudh@anirudhrb.com
ARC-Seal: i=1; a=rsa-sha256; t=1724669446; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=cYRxKkPA/V42K7yahz8U1FMJw/4wlS0JnPHy6TGZCezzP0PIhfDlLSLMvh6j69cN2dfw2F8tfF5LFoSvRXu0b8gXJBO+AHw2Zl+w70U0+itCiNRfjjhjXgVfqr6fqT5URPB2UphxxWPmvYEiUFyU4Xv/OxOABrVJTTnr6fi45RI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1724669446; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=1/23OMf4aWlagJ8xmOriveeKTGOTd7dntEF7lQZbVao=; 
	b=PMk+qMwuVWINs4sd8nl3VO3USVUxwWCY7nbadI/fa2p0PFoUAOhL69NtyyzdljjurGu3w90q5IKOAScvW0n6YYlaXzlfZOrF5JcBSpZD3SXrsS74WfYaWNSxnQNOpeSRibn10MT5lc5dNdgmxg1fIrb1PH+mM25Lk2IRh1JpKaI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=anirudhrb.com;
	spf=pass  smtp.mailfrom=anirudh@anirudhrb.com;
	dmarc=pass header.from=<anirudh@anirudhrb.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1724669446;
	s=zoho; d=anirudhrb.com; i=anirudh@anirudhrb.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-ID:MIME-Version:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=1/23OMf4aWlagJ8xmOriveeKTGOTd7dntEF7lQZbVao=;
	b=KcPpiaW1v7ltbCLoj5nFvEPJ3Du0QGsJ6bD76ROwQYfKQMLoNgb87KaMAs2FQbAx
	Q/1A7nc8FXInmw1b7jUUZxihr7PKbo7MTCb7nGlfJuFr8u0byMWdJ7Dt6Lb5PH0iZYH
	zD6bJcpD2vF+Bik1dK6hRDalSNToYqo24nXXVKbE=
Received: by mx.zohomail.com with SMTPS id 1724669444045253.87925989552468;
	Mon, 26 Aug 2024 03:50:44 -0700 (PDT)
From: Anirudh Rayabharam <anirudh@anirudhrb.com>
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Michael Kelley <mikelley@microsoft.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Anirudh Rayabharam <anirudh@anirudhrb.com>,
	stable@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] x86/hyperv: fix kexec crash due to VP assist page corruption
Date: Mon, 26 Aug 2024 16:20:29 +0530
Message-ID: <20240826105029.3173782-1-anirudh@anirudhrb.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>

9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go
online/offline") introduces a new cpuhp state for hyperv initialization.

cpuhp_setup_state() returns the state number if state is CPUHP_AP_ONLINE_DYN
or CPUHP_BP_PREPARE_DYN and 0 for all other states. For the hyperv case,
since a new cpuhp state was introduced it would return 0. However,
in hv_machine_shutdown(), the cpuhp_remove_state() call is conditioned upon
"hyperv_init_cpuhp > 0". This will never be true and so hv_cpu_die() won't be
called on all CPUs. This means the VP assist page won't be reset. When the
kexec kernel tries to setup the VP assist page again, the hypervisor corrupts
the memory region of the old VP assist page causing a panic in case the kexec
kernel is using that memory elsewhere. This was originally fixed in dfe94d4086e4
("x86/hyperv: Fix kexec panic/hang issues").

Set hyperv_init_cpuhp to CPUHP_AP_HYPERV_ONLINE upon successful setup so that
the hyperv cpuhp state is removed correctly on kexec and the necessary cleanup
takes place.

Cc: stable@vger.kernel.org
Fixes: 9636be85cc5b ("x86/hyperv: Fix hyperv_pcpu_input_arg handling when CPUs go online/offline")
Signed-off-by: Anirudh Rayabharam (Microsoft) <anirudh@anirudhrb.com>
---
 arch/x86/hyperv/hv_init.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
index 17a71e92a343..81d1981a75d1 100644
--- a/arch/x86/hyperv/hv_init.c
+++ b/arch/x86/hyperv/hv_init.c
@@ -607,7 +607,7 @@ void __init hyperv_init(void)
 
 	register_syscore_ops(&hv_syscore_ops);
 
-	hyperv_init_cpuhp = cpuhp;
+	hyperv_init_cpuhp = CPUHP_AP_HYPERV_ONLINE;
 
 	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_ACCESS_PARTITION_ID)
 		hv_get_partition_id();
@@ -637,7 +637,7 @@ void __init hyperv_init(void)
 clean_guest_os_id:
 	wrmsrl(HV_X64_MSR_GUEST_OS_ID, 0);
 	hv_ivm_msr_write(HV_X64_MSR_GUEST_OS_ID, 0);
-	cpuhp_remove_state(cpuhp);
+	cpuhp_remove_state(CPUHP_AP_HYPERV_ONLINE);
 free_ghcb_page:
 	free_percpu(hv_ghcb_pg);
 free_vp_assist_page:
-- 
2.45.2


