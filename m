Return-Path: <linux-hyperv+bounces-3997-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7221EA3E5CA
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Feb 2025 21:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 028503BC851
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Feb 2025 20:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921D62641C3;
	Thu, 20 Feb 2025 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="qGpZCfGa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C9022116F4;
	Thu, 20 Feb 2025 20:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082986; cv=none; b=ABalqah1OV0QsTmQyEG/YGdAl0E13n/1K01Ol2lIf7NOzBWsf7rEt0UmCVk+K7bueUR51P+/6oRmMsC5tcntdy86wp4SxDDNECFuqeAkJBTmZz/9zv/0EfRYSw6f5sTHP9Rv68Q2UbJzS6E7BGWCNxWqEkgCwm6O4tpXgFjK+J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082986; c=relaxed/simple;
	bh=H0sc0Dzoy3F2dNp0PaU0lxzNo4cuwBbWvkCnJDbwqsA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biqgqYYVBvObJrJGDMQB5RW1HaXJYTSsbpntwGcy7RRBjiPxgrYAO8rcTcNnqCJbnTw/ZILYMYa85CdMqctgAqqosBsGbHH336CY+9RePQpl9L2QgpKqr6EPLOEtIHctHnhqzIEvJID8Tx3syk0SYfpf/b9ePA+Z3ObViLUD/go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=qGpZCfGa; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id B1B8B2043DFE;
	Thu, 20 Feb 2025 12:23:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B1B8B2043DFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740082984;
	bh=V+jj0mO8JyhApYoPayBDHN4fMJAhT0KBvP1icd3eeMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qGpZCfGa1ZG916s3BipBiLtFXgWJVeEPNMF4SilMqjxi16ZtabQ3LsBkMsjzvFOaZ
	 2YNCMN1v6EeHEzUCNm9bgSwaH0/5W+XkQWG3f+Dx3qcM7bTsXDPf9lW5Y9nZgXSarm
	 hAN4/HmrA9cyt7tqmtSAOdtug0pyjorfHUGmWXt8=
From: Roman Kisel <romank@linux.microsoft.com>
To: bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mingo@redhat.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v2 2/2] x86/hyperv: VTL mode callback for restarting the system
Date: Thu, 20 Feb 2025 12:23:02 -0800
Message-ID: <20250220202302.2819863-3-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250220202302.2819863-1-romank@linux.microsoft.com>
References: <20250220202302.2819863-1-romank@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel runs as a firmware in the VTL mode, and the only way
to restart in the VTL mode on x86 is to triple fault. Thus, one
has to always supply "reboot=t" on the kernel command line in the
VTL mode, and missing that renders rebooting not working.

Define the machine restart callback to always use the triple
fault to provide the robust configuration by default.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>
---
 arch/x86/hyperv/hv_vtl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 4421b75ad9a9..582fe820e29c 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -44,6 +44,15 @@ static void  __noreturn hv_vtl_emergency_restart(void)
 	}
 }
 
+/*
+ * The only way to restart in the VTL mode is to triple fault as the kernel runs
+ * as firmware.
+ */
+static void  __noreturn hv_vtl_restart(char __maybe_unused *cmd)
+{
+	hv_vtl_emergency_restart();
+}
+
 void __init hv_vtl_init_platform(void)
 {
 	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
@@ -258,6 +267,8 @@ static int hv_vtl_wakeup_secondary_cpu(u32 apicid, unsigned long start_eip)
 int __init hv_vtl_early_init(void)
 {
 	machine_ops.emergency_restart = hv_vtl_emergency_restart;
+	machine_ops.restart = hv_vtl_restart;
+
 	/*
 	 * `boot_cpu_has` returns the runtime feature support,
 	 * and here is the earliest it can be used.
-- 
2.43.0


