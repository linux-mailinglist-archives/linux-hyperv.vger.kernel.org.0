Return-Path: <linux-hyperv+bounces-7242-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B243BE627E
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 04:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A5C55E1009
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 02:50:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6438728506C;
	Fri, 17 Oct 2025 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="csZCCPVi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FEE2765DF;
	Fri, 17 Oct 2025 02:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760669337; cv=none; b=uzZ4d9TEKvce04d4nFLmr03tNgvr77Vu5mHq//9iN9zzoUiFauISz1VMI8qwHT4bSBtUZR0ryKltiky4V7whgkLZBppiTPGGaQ19kMN5a0r2x0b1nsQeq7tIY1EdyRie0LBlMiLpn8514gglMto3aU7I5XhjOV1y5HuvacnjtEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760669337; c=relaxed/simple;
	bh=+KpwtyxJeSfj6pWERQrqIeuq+GTH4DEu4+tOmXkA/Mk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P5vV67V9fGdUEsYX7lhz9RqTLkCd1QuYViqbz8LNx9xNktggM1dwXn0Fii2IDeTz5IK7JlKqUibpuCLUOSPuC347a+qexiysajOEHMc3IeHJ9X0gLqLHhS0ywe+xVBZ5zGTa9rMT1L0x5gcBhqpy0GsW1vgW0MZNnkC3gLagXJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=csZCCPVi; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760669336; x=1792205336;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=+KpwtyxJeSfj6pWERQrqIeuq+GTH4DEu4+tOmXkA/Mk=;
  b=csZCCPVi9mxmYXpGC48Fv50QwIdkt4a0+CaioDZMFHG6J1D2yY067KVo
   InMtG1PCRG4qmfiGmsUt3xvE1S9st5RzvaKpjjb8czgp87bR3bMc3NUKc
   Lf/9smVCZPY2wQHIJLT8/9loOhljYiH7lFMHB9tQ1Xh0rQ+LPrsxUsEXj
   v+chiimd7vBcN2+V4Y25h4J1turDov3sNpSyE5VUYGEfIiGzYn2g07q5A
   H6wP7A3MKyB/UXbZvTtiMT537Pu3qgqb/TvoEmYlQB2vI6a7UxhiLO+Yg
   DWkkR5AlNfPasqJ2pZwqN0SXlSivbPy2qpAPGvWPZrvzb6Tvy5/KiOITW
   A==;
X-CSE-ConnectionGUID: ndk+8wwwQs61g9ph58McQQ==
X-CSE-MsgGUID: 3UoOmu/cT3qKXU6oxKaDMA==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="80321943"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="80321943"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:52 -0700
X-CSE-ConnectionGUID: 82sa8zURT06iVZCaD2ZeVg==
X-CSE-MsgGUID: zg8ovszQRze/jYnxfxqwOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="219776587"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:51 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 16 Oct 2025 19:57:32 -0700
Subject: [PATCH v6 10/10] x86/hyperv/vtl: Use the wakeup mailbox to boot
 secondary CPUs
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-rneri-wakeup-mailbox-v6-10-40435fb9305e@linux.intel.com>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
In-Reply-To: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
To: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
 linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Neri <ricardo.neri@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760669902; l=1993;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=+KpwtyxJeSfj6pWERQrqIeuq+GTH4DEu4+tOmXkA/Mk=;
 b=hwZ7BhzWn6VmkFX9QjrX58N7CABFCsTIXACm3eKIoC2mXPqWoS1xEGE5bxiJJTDwC3aL85ivn
 q7ZIekMtslUAIICV5TsuR41eTapQ+O+sHdogpHuTCHyTJCvH1dM20sf
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

The hypervisor is an untrusted entity for TDX guests. It cannot be used
to boot secondary CPUs. The function hv_vtl_wakeup_secondary_cpu() cannot
be used.

Instead, the virtual firmware boots the secondary CPUs and places them in
a state to transfer control to the kernel using the wakeup mailbox. The
firmware enumerates the mailbox via either an ACPI table or a DeviceTree
node.

If the wakeup mailbox is present, the kernel updates the APIC callback
wakeup_secondary_cpu_64() to use it.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes since v4:
 - None

Changes since v3:
 - Added Reviewed-by tag from Michael. Thanks!

Changes since v2:
 - Unconditionally use the wakeup mailbox in a TDX confidential VM.
   (Michael).
 - Edited the commit message for clarity.

Changes since v1:
 - None
---
 arch/x86/hyperv/hv_vtl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 4a15de4d5ec2..e866e643b66c 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -268,7 +268,15 @@ int __init hv_vtl_early_init(void)
 		panic("XSAVE has to be disabled as it is not supported by this module.\n"
 			  "Please add 'noxsave' to the kernel command line.\n");
 
-	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
+	/*
+	 * TDX confidential VMs do not trust the hypervisor and cannot use it to
+	 * boot secondary CPUs. Instead, they will be booted using the wakeup
+	 * mailbox if detected during boot. See setup_arch().
+	 *
+	 * There is no paravisor present if we are here.
+	 */
+	if (!hv_isolation_type_tdx())
+		apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
 
 	return 0;
 }

-- 
2.43.0


