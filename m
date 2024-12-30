Return-Path: <linux-hyperv+bounces-3562-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76D319FE9A9
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Dec 2024 19:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA1883A3BF9
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Dec 2024 18:10:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87061B4157;
	Mon, 30 Dec 2024 18:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lXLwhj51"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B3FB1B0410;
	Mon, 30 Dec 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735582186; cv=none; b=V3zV81pzbHyUOJsUvlFkFD3+lxqjy82J9Wh6zmIpijNgmBBnVY6k/A1OIOsubKhvWxr9FQdCTQ09tiK7uB+V1ltZ61uMaQ8v/WnHG/MS9tZrJIZmRVI1c456UZnFQth6yjBB7K0whft6cOIeQmTQR8HE+4/Zj2uk5EzDpL2AEOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735582186; c=relaxed/simple;
	bh=vbNPknnBFyyaONbs72riXQ40KDNtAJSol5gXMtlxeHo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tUPLsi+vwzhbntnAjUCuCC3jpy3MTbzDogcLJ0jRgK2xex3BHyde2nJnC0HoA6hYonKpuNJmhzQXZbz9OaCiahvK0qNuy+AMyraZfIezXdofDuH6ecdHCTvVtXNIBzZIo4hMqp8Y+YNxjQfXQm4H4CCRImmYbOefL8s2XcGFulc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=lXLwhj51; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 5949B23718AC;
	Mon, 30 Dec 2024 10:09:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5949B23718AC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735582184;
	bh=k2UmY66ftWXp8kYKen18EASwtXppJQxpkXiN3eKJ4Ns=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lXLwhj51YWPGMmZf80FPl80UqBBuSoZLiiKgROcTLU1WyxtJlT9pVi09kLcb20L7c
	 DlACxz6rSU1i1obrLX56f5Gxn44vqhlokR9zR4x2z/npGSuh/2Mz+LSGJubsB/h4/V
	 ttAnp6oS5vAhFOX/7hEVz7foade/xbfyOTd5GCbs=
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
Subject: [PATCH v5 5/5] hyperv: Do not overlap the hvcall IO areas in hv_vtl_apicid_to_vp_id()
Date: Mon, 30 Dec 2024 10:09:41 -0800
Message-Id: <20241230180941.244418-6-romank@linux.microsoft.com>
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
hv_vtl_apicid_to_vp_id() overlaps them.

Use the output hypercall page of the current vCPU for the hypercall.

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
[2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs

Reported-by: Michael Kelley <mhklinux@outlook.com>
Closes: https://lore.kernel.org/lkml/SN6PR02MB4157B98CD34781CC87A9D921D40D2@SN6PR02MB4157.namprd02.prod.outlook.com/
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
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


