Return-Path: <linux-hyperv+bounces-7237-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1358BE624E
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 04:49:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E63D95E126E
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 02:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86BD26E717;
	Fri, 17 Oct 2025 02:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EG6TXahp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CE8256C9F;
	Fri, 17 Oct 2025 02:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760669334; cv=none; b=nPzCsZN7+Uto7IKw2/y0gZsyF2xMOU2g2XrDnDwCjJCRktddDrggQkpqVN3o2EUnBAc4WJh/9c5HBlKk+wih4GKeIfcGm910/kTMOS6iIsLhMKwgwkikK1QcRnjXy58WH6YRsu+J++3XT38x0dgLEwkV1dcpp0iUUmYS12+mg3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760669334; c=relaxed/simple;
	bh=5Wu0tzssz437M/fmfvFLdYEnIKI1oai+QjRSnwiVOd0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ed3h10ns27DvekrB2iPDaKW4cS0jNDdd2V3sMPmuTpPRXEoeF9ysc3X87XC5eiv1P21qikq9sBVbhpW9hvBtKbnj0bTSBWda39874e5oq0ZmujzoyY/01w7OcipWmR1h8Elvu/4rbWN2upyYp+tvj/Uu3TSv6pDSAOlMT2R0D34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EG6TXahp; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760669333; x=1792205333;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=5Wu0tzssz437M/fmfvFLdYEnIKI1oai+QjRSnwiVOd0=;
  b=EG6TXahpLxnXOmCYOdlQ/sh3lNtX77Wvg7nPiK+X82uZlKK1bjPDG+q/
   khLZnrH1n+6TDTf83J2qfGosNb4QkhSiKp5pVLC3jysFxekXFk/cTl+ZW
   7s156A9n3Fpo5Q51dgPOrbhDIr5ywbq1ggTnYVI7NDt7RYyDPB21Q+IAQ
   /im+jr4JycbOfMtei+P/kctAZjUunVEYNx/cUWVU0dtweOxqMrhBMxDF1
   m2kz06j/DnghMhXBWxXVjOS4kvjh7wbLZZUpbhQfidu9Z4uohsVrpb8hw
   xuV33GrVjtWkTESB/8iRwjxbTZ14Z3uuV6aTpLn00GIBlWV3mrGI2PrY7
   Q==;
X-CSE-ConnectionGUID: b9FpctpoQsOnU2e3mw3uyg==
X-CSE-MsgGUID: +Rw5TLAASc62YVZ1xm9EQw==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="80321914"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="80321914"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:50 -0700
X-CSE-ConnectionGUID: ir92dcntTsm74lgP1PjvCQ==
X-CSE-MsgGUID: 4KJuRnLnTM2zMGFrRPm/hg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="219776562"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:49 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 16 Oct 2025 19:57:27 -0700
Subject: [PATCH v6 05/10] x86/hyperv/vtl: Set real_mode_header in
 hv_vtl_init_platform()
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-rneri-wakeup-mailbox-v6-5-40435fb9305e@linux.intel.com>
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
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760669902; l=2298;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=+ekowMZ1bCY7lZxoOjoxO9xS7f2Jb/d6BCLxpG5SNTE=;
 b=wzpZ2fPjnkT/LQyMH1bOrbn2ElLnB4YN40/bw9t4nR13nY5qdZ4dQpASdYhzCMHF41db5Xkh8
 HXv6CUz8k8lCGQpziWsrjieqMOk+yR9rFu5JbX73dTzoNX1zX1PzPuT
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
Changes since v5:
 - Corrected reference to hv_vtl_init_platform() in the changelog.
   (Dexuan)
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes since v4:
 - None

Changes since v3:
 - Added Reviewed-by tag from Michael. Thanks!

Changes since v2:
 - Edited the commit message for clarity.

Changes since v1:
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


