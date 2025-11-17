Return-Path: <linux-hyperv+bounces-7632-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51867C65623
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 18:13:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id 6EEC52B900
	for <lists+linux-hyperv@lfdr.de>; Mon, 17 Nov 2025 17:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EAC533EB09;
	Mon, 17 Nov 2025 17:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="V7tFJcr+"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D779533E342;
	Mon, 17 Nov 2025 17:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763399048; cv=none; b=XvZmZJxQvPOOafKGEzYkRL3yytO9/zVD08+CJSJsYgEVHaUp7rnehPw3pP7xFwvqywrNhR/0F1OBhrau9XQ8ek54is6+AYQa0fQu11JkoBRmUtcYP5XNm63gxGPo1aktSQJPaOdAUZ0VZnYrllM0mKx1GG5JBUZGu3BQIvR3r28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763399048; c=relaxed/simple;
	bh=Ek8hMgumVPS1aDmufwBtX1sGfZaxTHAb1Zpjtl5/pno=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Kk1HVQo08BHTq8LoCcAtD4WQBOGk/SdsSw2NEV+3InpEiJbot6UBssdXCOwru/+QdLbOsH6TFWB/5XgOt9/toDEEgKolX7kq7SN5GKi9m0Ezxe0ddQna7cvUo9LjCl1QCZEssstPuJ0eDY/PO2av/2tESgdEap/AnPBHdPLr228=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=V7tFJcr+; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763399046; x=1794935046;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=Ek8hMgumVPS1aDmufwBtX1sGfZaxTHAb1Zpjtl5/pno=;
  b=V7tFJcr+icUkNTRzAfJFuFVVA9i35rUl9zdzGHZdPylSZ9u6vSFNQ6bM
   ZxlQv5eaT5EUeN7Yyy4PbKxkTQatiLFpxv/NcHBeF2fHNcxEhGWtGZ+Ub
   GhIHMqZfMCxkqMEuVSPS5w9j4i7xU5SsxISbm2qxU4cK2oqfdjYXQgqPp
   q31aiJAKPrz6egVw+boDVsz6lo1E3LcUjit0VEhmQb3+ATDjboy7xPVSQ
   gmaZkpT/ZwHYpr02/9HxPGnP4QvfAtBiprBAroyulDc1chadt85QpLGSS
   RxFGAAYe2EYt1Lrz6ThJwetBKK7yXZ7DGvzlWo1D/yHZWCVZeGKZrEaHy
   w==;
X-CSE-ConnectionGUID: fmAk7CZkSd201lhqFBtAcw==
X-CSE-MsgGUID: C9DsS7qDQ/OpA5KfBN7HWw==
X-IronPort-AV: E=McAfee;i="6800,10657,11616"; a="69253658"
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="69253658"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 09:04:02 -0800
X-CSE-ConnectionGUID: sos+IfFoTjaOmMHs+wq49A==
X-CSE-MsgGUID: XJwTCXvESEOOjDTTn6Fbdw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,312,1754982000"; 
   d="scan'208";a="195445182"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Nov 2025 09:04:01 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Mon, 17 Nov 2025 09:02:50 -0800
Subject: [PATCH v7 4/9] x86/hyperv/vtl: Set real_mode_header in
 hv_vtl_init_platform()
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251117-rneri-wakeup-mailbox-v7-4-4a8b82ab7c2c@linux.intel.com>
References: <20251117-rneri-wakeup-mailbox-v7-0-4a8b82ab7c2c@linux.intel.com>
In-Reply-To: <20251117-rneri-wakeup-mailbox-v7-0-4a8b82ab7c2c@linux.intel.com>
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
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1763398999; l=2310;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=M7UewUod3MOK5zJCQXv7Tn4QEwiTQKiYaOZWHnv+7es=;
 b=KyEQkku2t6wzyn+W+jpSOJ1YM3FCeR59qrAeQUBydFxp5iwYZuYjaZ7dY17Wb4wJQwOLnazf6
 CHlJBdmoTBaCgtPJx0oeo7gjXI7QsJ571rIE4/HMrHl/O+wxFsss/Vo
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

From: Yunhong Jiang <yunhong.jiang@linux.intel.com>

Hyper-V VTL clears x86_platform.realmode_{init(), reserve()} in
hv_vtl_init_platform() whereas it sets real_mode_header later in
hv_vtl_early_init(). There is no need to deal with the settings of real
mode memory in two places. Also, both functions are called much earlier
than x86_platform.realmode_init() (via an early_initcall), where the
real_mode_header is needed.

Set real_mode_header in hv_vtl_init_platform() to keep all code dealing
with memory for the real mode trampoline in one place. Besides making the
code more readable, it prepares it for a subsequent changeset in which the
behavior needs to change to support Hyper-V VTL guests in TDX a
environment.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes in v7:
 - None

Changes in v6:
 - Corrected reference to hv_vtl_init_platform() in the changelog.
   (Dexuan)
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes in v5:
 - None

Changes in v4:
 - Added Reviewed-by tag from Michael. Thanks!

Changes in v3:
 - Edited the commit message for clarity.

Changes in v2:
 - Introduced this patch.
---
 arch/x86/hyperv/hv_vtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 042e8712d8de..e10b63b7a49f 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -65,6 +65,7 @@ void __init hv_vtl_init_platform(void)
 
 	x86_platform.realmode_reserve = x86_init_noop;
 	x86_platform.realmode_init = x86_init_noop;
+	real_mode_header = &hv_vtl_real_mode_header;
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
 	x86_init.resources.probe_roms = x86_init_noop;
@@ -244,7 +245,6 @@ int __init hv_vtl_early_init(void)
 		panic("XSAVE has to be disabled as it is not supported by this module.\n"
 			  "Please add 'noxsave' to the kernel command line.\n");
 
-	real_mode_header = &hv_vtl_real_mode_header;
 	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
 
 	return 0;

-- 
2.43.0


