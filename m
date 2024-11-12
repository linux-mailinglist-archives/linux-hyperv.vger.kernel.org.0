Return-Path: <linux-hyperv+bounces-3327-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9169C6035
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Nov 2024 19:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9735E1F21935
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Nov 2024 18:18:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC10320695A;
	Tue, 12 Nov 2024 18:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Lmg4rfNI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01505216449;
	Tue, 12 Nov 2024 18:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731435484; cv=none; b=aUcp6Yu6ElAw0rPreU+NIEobSjlWNxYOHcpwrGHWFrGk7G/iE5UX10dMZGrsCdg5fSwAfjaPgHmlKmrm+aQDHCr9xmYbtG8bDky8N2ae0xTPrfByMYcva45quGdYjyJvhpu9/QYQsZW9AHWgYmIXejzlAWz4+xZ63JJV3m06450=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731435484; c=relaxed/simple;
	bh=osPNVirkNM5xqTLDAHs2JoexATW4FTnt1jKV4aslXms=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=A6XD2oNXc3SLPRTfLvFhGnuOyf4EZdrkTKV3FJJK0ogHjA8rczMJZd/zpwS8FPhD/hLie6elp7l1EMtK5lak1Uy5TAE2PDYsG4112O3gxSVH31/gptx8S0bzJLaNFEHELDkXmu1orbjIoxYosqZjfG+DFzTZO2/oooSqZMUR3SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Lmg4rfNI; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [40.64.70.95])
	by linux.microsoft.com (Postfix) with ESMTPSA id 90ED4238AF4D;
	Tue, 12 Nov 2024 10:18:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 90ED4238AF4D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1731435481;
	bh=VMNZsKLVoyYK8cODP7SJX/vrUgYhh2czgAioy3TYuFE=;
	h=Subject:From:To:Cc:Date:From;
	b=Lmg4rfNIUU8VybLrpDonDPJF0QBHGG8ELpVlLp10Ib/C6XYNQCrDCn+j/+AKA0I5j
	 c+9CJ0ABQ6I9P5WiXviwgdjv+/UzsCWf61+3r+Hpf5gmPqUp/+CUNEdpvEY+z1AQQl
	 FhOhZvhIB8FwXl1PQyxqVKQPltb194WIx3ZJgAds=
Subject: [PATCH] x86/hyperv: Set X86_FEATURE_TSC_RELIABLE unconditionally
From: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, x86@kernel.org, hpa@zytor.com,
 linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 12 Nov 2024 18:18:01 +0000
Message-ID: 
 <173143547242.3415.16207372030310222687.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

Enable X86_FEATURE_TSC_RELIABLE by default as X86_FEATURE_TSC_RELIABLE is
independent from invariant TSC and should have never been gated by the
HV_ACCESS_TSC_INVARIANT privilege.

To elaborate, the HV_ACCESS_TSC_INVARIANT privilege allows certain types of
guests to opt-in to invariant TSC by writing the
HV_X64_MSR_TSC_INVARIANT_CONTROL register. Not all guests will have this
privilege and the hypervisor will automatically opt-in certain types of
guests (e.g. EXO partitions) to invariant TSC, but this functionality is
unrelated to the TSC reliability.

Signed-off-by: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
---
 arch/x86/kernel/cpu/mshyperv.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index d18078834ded..14412afcc398 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -515,7 +515,7 @@ static void __init ms_hyperv_init_platform(void)
 	machine_ops.crash_shutdown = hv_machine_crash_shutdown;
 #endif
 #endif
-	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT) {
+	if (ms_hyperv.features & HV_ACCESS_TSC_INVARIANT)
 		/*
 		 * Writing to synthetic MSR 0x40000118 updates/changes the
 		 * guest visible CPUIDs. Setting bit 0 of this MSR  enables
@@ -526,8 +526,8 @@ static void __init ms_hyperv_init_platform(void)
 		 * is called.
 		 */
 		wrmsrl(HV_X64_MSR_TSC_INVARIANT_CONTROL, HV_EXPOSE_INVARIANT_TSC);
-		setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
-	}
+
+	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
 	/*
 	 * Generation 2 instances don't support reading the NMI status from



