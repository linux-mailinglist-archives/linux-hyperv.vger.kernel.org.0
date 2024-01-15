Return-Path: <linux-hyperv+bounces-1435-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4508682DEB8
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jan 2024 18:58:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7347283376
	for <lists+linux-hyperv@lfdr.de>; Mon, 15 Jan 2024 17:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F3BA18C28;
	Mon, 15 Jan 2024 17:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="rl1OYcPB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BAC18C25;
	Mon, 15 Jan 2024 17:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id D849B20C80BA;
	Mon, 15 Jan 2024 09:57:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D849B20C80BA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1705341464;
	bh=M/7pcXQalXHcMoHN9ldxUjvdafJ22HCKPBnrDAVw1HQ=;
	h=From:To:Cc:Subject:Date:From;
	b=rl1OYcPBwsGLkD+Eq0xve8jCrB0U8W1ZjzLwEAnVDm5hW3UxPKKZ1Qin1249GLGKy
	 qPxzV3n08+ba5UaeAXqN4D+7/fWoQzqNLU1PYVQvb9kh7XsCeoZrx/0dTFTG6a1qmO
	 xqzxgip277E/ElAdmB7pM+KOVWQXk4PWMcP4zUs8=
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
Subject: [PATCH v2] x86/hyperv: Allow 15-bit APIC IDs for VTL platforms
Date: Mon, 15 Jan 2024 09:57:40 -0800
Message-Id: <1705341460-18394-1-git-send-email-ssengar@linux.microsoft.com>
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
supports 15-bit APIC IDs. This assumption is safe, as Hyper-V does not
employ any architectural MSIs at higher VTLs

This unblocks startup of VTL2 environments with more than 256 CPUs.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V2]
 - Modify commit message

 arch/x86/hyperv/hv_vtl.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 96e6c51..cf1b78c 100644
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
@@ -38,6 +43,8 @@ void __init hv_vtl_init_platform(void)
 	x86_platform.legacy.warm_reset = 0;
 	x86_platform.legacy.reserve_bios_regions = 0;
 	x86_platform.legacy.devices.pnpbios = 0;
+
+	x86_init.hyper.msi_ext_dest_id = hv_vtl_msi_ext_dest_id;
 }
 
 static inline u64 hv_vtl_system_desc_base(struct ldttss_desc *desc)
-- 
1.8.3.1


