Return-Path: <linux-hyperv+bounces-3718-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC67A158CE
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 22:07:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8007B3A95C7
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 21:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEC71AF0D3;
	Fri, 17 Jan 2025 21:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="YQ3aotmH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CD41A9B23;
	Fri, 17 Jan 2025 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737148032; cv=none; b=pI2Elwg2z3zevqc1FLFTB4IzLv3FOazckdK5nzonKB5DGwKs9n8gnHnWaQVxHrFA7DuFIwIT7FGtiYsGKuW9Vuyk9joeC+L4LHsmlL95XXRcNPoVvD2ocT10UwjhZx8KAnz407rvtY+MHmj3Grxj8wOoGP0HR40pt9hvinPi8T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737148032; c=relaxed/simple;
	bh=NJ9VWFE68QrwwxvuhF/JQq4k4ZBkAfcWzlZGSWLh9lA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FLrBOvYasCb62Z11YnNs186IqSqIqHpg9oJiIzjbNqnrPFCIGH4DAAxHc2hitCvI+GHFv+1CckiBp9kTfZ9WxL5Umj0v40WNeziTjUFwl8QAgyznxxxiFfvradREpf5pVGTocZoMKMs9jkjBhf0dwg3wgWLTuK5+by7MmO49czk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=YQ3aotmH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 13792206BCDD;
	Fri, 17 Jan 2025 13:07:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 13792206BCDD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737148024;
	bh=MGGMd4WAVb/r9foiPnnQJH97JAv6RNcmTHqjeuLMXGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YQ3aotmH865NLerE8vf9WlO/6BVPB6qVYozWkIrKvcbBc/JgKw5VpEHDENFGRuh29
	 DN9JrucSJ35TVFTbdBQaXd8MD/fc/OnB/43MFGt4EgXE3R9o6SaNsX9Me7GgY7OgFG
	 rm9mdRwA8n3TmgjVLd1X6QRAVmS8/NDvTFqgkDIQ=
From: Roman Kisel <romank@linux.microsoft.com>
To: bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mingo@redhat.com,
	ssengar@linux.microsoft.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH hyperv-next 2/2] x86/hyperv: VTL mode callback for restarting the system
Date: Fri, 17 Jan 2025 13:07:02 -0800
Message-Id: <20250117210702.1529580-3-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250117210702.1529580-1-romank@linux.microsoft.com>
References: <20250117210702.1529580-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel runs as a firmware in the VTL mode, and the only way
to restart on x86 is to triple fault. Thus, one has to always
supply "reboot=t" on the kernel command line, and missing that
renders rebooting not working.

Define the machine restart callback to always use the triple
fault to provide the robust configuration by default.

Cc: stable@vger.kernel.org
Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/hyperv/hv_vtl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 8931fc186a5f..eb402362d738 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -44,6 +44,12 @@ static void  __noreturn hv_vtl_emergency_restart(void)
 	}
 }
 
+/* The only way to restart is triple fault */
+static void  __noreturn hv_vtl_restart(char *)
+{
+	hv_vtl_emergency_restart();
+}
+
 void __init hv_vtl_init_platform(void)
 {
 	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
@@ -269,6 +275,7 @@ int __init hv_vtl_early_init(void)
 	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
 
 	machine_ops.emergency_restart = hv_vtl_emergency_restart;
+	machine_ops.restart = hv_vtl_restart;
 
 	return 0;
 }
-- 
2.34.1


