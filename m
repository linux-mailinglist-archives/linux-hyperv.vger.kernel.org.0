Return-Path: <linux-hyperv+bounces-1377-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D538251F4
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jan 2024 11:29:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F2C81F21C9B
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jan 2024 10:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D088250F5;
	Fri,  5 Jan 2024 10:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="SDAQLXkn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D96250E7;
	Fri,  5 Jan 2024 10:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 8E4F120B3CC1;
	Fri,  5 Jan 2024 02:29:36 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8E4F120B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704450576;
	bh=ovwReRwgxvp0zRcHfp5lvTMwMqQKQ9zFOKT4nznwl9o=;
	h=From:To:Cc:Subject:Date:From;
	b=SDAQLXknt9VcjaxANAxYyvW559RuOTuhEYKcM2kcX2xYjuOJ9C3LuOmaWegH9Ucyl
	 bWyn0rlu7xxzL6ad+PvgSchTpWb2t3aN1o2aLhDaV/PDularhnhC8r3e2bLsxQlcnJ
	 YmQmQUHtalVCZ97FrsJuydD/vEZdLvNR1kws5esI=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ssengar@microsoft.com
Subject: [PATCH] x86/hyperv: Allow 15-bit APIC IDs for VTL platforms
Date: Fri,  5 Jan 2024 02:29:26 -0800
Message-Id: <1704450566-26576-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The current method for signaling the compatibility of a Hyper-V host
with MSIs featuring 15-bit APIC IDs relies on a synthetic cpuid leaf.
However, for higher VTLs, this leaf is not reported, due to the absence
of an IO-APIC.

As an alternative, assume that when running at a high VTL, the host
supports 15-bit APIC IDs. This assumption is now deemed safe, as no
architectural MSIs are employed at higher VTLs.

This unblocks startup of VTL2 environments with more than 256 CPUs.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/hyperv/hv_vtl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 539c7b5cfa2b..1c225362f88e 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -16,6 +16,11 @@
 extern struct boot_params boot_params;
 static struct real_mode_header hv_vtl_real_mode_header;
 
+static bool __init hv_vtl_msi_ext_dest_id(void)
+{
+	return true;
+}
+
 void __init hv_vtl_init_platform(void)
 {
 	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
@@ -39,6 +44,8 @@ void __init hv_vtl_init_platform(void)
 	x86_platform.legacy.warm_reset = 0;
 	x86_platform.legacy.reserve_bios_regions = 0;
 	x86_platform.legacy.devices.pnpbios = 0;
+
+	x86_init.hyper.msi_ext_dest_id = hv_vtl_msi_ext_dest_id;
 }
 
 static inline u64 hv_vtl_system_desc_base(struct ldttss_desc *desc)
-- 
2.25.1


