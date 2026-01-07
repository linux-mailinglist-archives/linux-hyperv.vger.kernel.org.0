Return-Path: <linux-hyperv+bounces-8186-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BA0ECD00385
	for <lists+linux-hyperv@lfdr.de>; Wed, 07 Jan 2026 22:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BA516304EBC0
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jan 2026 21:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29F033A70E;
	Wed,  7 Jan 2026 21:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lq04gOFb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC5973016F5;
	Wed,  7 Jan 2026 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822371; cv=none; b=SfZPW3+iGCCgGupSBc7JUd48J6NKLolIgfSFpgiYKmIV9af6esS09V8uPLCMVQWmaVn6PddyYcFI0639Qp5MQ4AbBE3sAMyryOcHaD+/rjLDN7LumyjBX87lI91rdeGTwYZzEwDmTEVLjELL4o6fnXd7XFZrujZTlNkyp7u7D8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822371; c=relaxed/simple;
	bh=fOB9G2GRj0EWRDNGLEY7TkdAbfaGYmLPpeCfoQe1U1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k5gQUwxVRnLAAalXMnuYDV6nUCj7pPpxdgUhinN6fNoHQ8Vw9JYczJ56Ww2muzEqH+wmpDC/inZ6S8MAjIJcHG9nsbV/iVI3hedlHxqC6CIPZAWDJkegIN7p0xZJf8lyfZdPf3tH1BtWv8YNDzeWGCxWZtyA0FdSjuV5R8C3Cco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lq04gOFb; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767822370; x=1799358370;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=fOB9G2GRj0EWRDNGLEY7TkdAbfaGYmLPpeCfoQe1U1s=;
  b=Lq04gOFb3mAW7U8Rexa4tCoNryROjINop3Ru+CkLV5hE6i5M08AIaaXL
   fhCNGqRlxv+1Seq2NWwDQTOsTfqXUPIeZmdnjQjknFr2v+wlVvYsTioiP
   ZK/ZNr9xe86KmDZRoD2vbOH0gFdj4yvRNjfe06BzpeMsZ/tVhNjd01m1N
   RU/hdPODeeWizxYSduWxk0Hwj06+6HkI6w870839cfNkAbwXBb8QPfSiJ
   nc3ihqRWNekbYphFJJnsVNB9Oc9iPAzcSWpwvlDr0Smv+FiiRV8BodngL
   rSxBwMc2qwOS1rMthV+ECMo/MZZuIM5hJjAc5VsYLE39UhtaJmeKdI7RU
   A==;
X-CSE-ConnectionGUID: qsbELRsOR7qqNVXynpfdxA==
X-CSE-MsgGUID: 1pHp7VwUTl+LScDC0qBSTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69359307"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69359307"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:02 -0800
X-CSE-ConnectionGUID: fk+W+ENzRymukqbWqx9EIg==
X-CSE-MsgGUID: xd8yU/0BSwSemA26w6iL1Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="207510929"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:03 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 07 Jan 2026 13:44:46 -0800
Subject: [PATCH v8 10/10] x86/hyperv/vtl: Use the wakeup mailbox to boot
 secondary CPUs
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-rneri-wakeup-mailbox-v8-10-2f5b6785f2f5@linux.intel.com>
References: <20260107-rneri-wakeup-mailbox-v8-0-2f5b6785f2f5@linux.intel.com>
In-Reply-To: <20260107-rneri-wakeup-mailbox-v8-0-2f5b6785f2f5@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767822314; l=2032;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=fOB9G2GRj0EWRDNGLEY7TkdAbfaGYmLPpeCfoQe1U1s=;
 b=L/5OWWSyD5YTqCWqwEplNpYFC1FHa+KpbBhgNXpTVcykzNKodOasRh23B0p6MndBUm1Mk2AHT
 sLmjHdXdCVQDW140pUWd8N3GVRJbZHyqHgL0taNivhI1bMnxhTZI+ka
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
Changes in v8:
 - None

Changes in v7:
 - None

Changes in v6:
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes in v5:
 - None

Changes in v4:
 - Added Reviewed-by tag from Michael. Thanks!

Changes in v3:
 - Unconditionally use the wakeup mailbox in a TDX confidential VM.
   (Michael).
 - Edited the commit message for clarity.

Changes in v2:
 - None
---
 arch/x86/hyperv/hv_vtl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 2af825f7a447..fa4e7fda2868 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -272,7 +272,15 @@ int __init hv_vtl_early_init(void)
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


