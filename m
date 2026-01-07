Return-Path: <linux-hyperv+bounces-8183-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00722D0036D
	for <lists+linux-hyperv@lfdr.de>; Wed, 07 Jan 2026 22:46:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 59C4E30336B7
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jan 2026 21:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8C4D335BCC;
	Wed,  7 Jan 2026 21:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hYUy2RJ5"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B034031B812;
	Wed,  7 Jan 2026 21:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822369; cv=none; b=PVJ9hGN/qzpLD/Vyr/okNpHVazTv03AOnH47gYRfIzis3C8HF1N1sWhwYWoXajJI+zQ9lcSP9hLg3ujbEYJnT+YipUlv4u+UHcq+d/zzChRRWCTVAz5mYlkLHcHnC3Sju12CB49rA1lJzXSmuEoi6KCWKbWBIBi5ifblfcnGD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822369; c=relaxed/simple;
	bh=BflhoJPrnn1UEvZt5KLYM0R7+cqEwF6hsWQifwBuwOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UAe4WBwrzoJH3y1kJAPTAYL3KE2Cb+RxHyJQbaGwWfSQAzURiT7PgG20I6iHkZ0T4XeRotmnrYzKD4ghTuG3iFQ0yxbtcTlUQO3JM1dm7ufFhmi+z3DbFlQpCKtlsniMwNgXuTtmfl94ehM9kHkds6ODLcEdWJQTGqJT00YisMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hYUy2RJ5; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767822367; x=1799358367;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=BflhoJPrnn1UEvZt5KLYM0R7+cqEwF6hsWQifwBuwOM=;
  b=hYUy2RJ5h8aGwi95I98r2f32XxGrfIO1JFuxZ1joKAebnXBMe1Ui0Po/
   8MivvC79GIPYWCA7ujlDuNc2RO3gimYS8CPkavJYqhDvF+//uY2uBFG/J
   CGIVbq5yiwGYbjD5TXj5W3ao1neMsCl6blMnjwy8/sW+urAHMFPTLeYFG
   ZnxEoCWk+DDdvVDOO1/w2i+rPfC0PbodnYGV5Qj2WyDe4c9O5+I1Daul8
   guOXowB9AKlFnhKC8NhE3Z95GYaScdA7OmlPMlQHzNlIjsRUa+nmiPQ3s
   +AKwgt9ypuT33K661rRdTYwAF+JP33iwGIOKN7wgJdQDoFNm4GD3hHnw0
   Q==;
X-CSE-ConnectionGUID: SACvyKXVTiCxx/KWwbKTmw==
X-CSE-MsgGUID: BMfuqyauRNa8beAXa+wAFQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69359300"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69359300"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:02 -0800
X-CSE-ConnectionGUID: +FoZx/nvQYyf8uAhytX5qg==
X-CSE-MsgGUID: sibWz9pSQxOKz45/U4QUUA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="207510919"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:02 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 07 Jan 2026 13:44:43 -0800
Subject: [PATCH v8 07/10] x86/hyperv/vtl: Setup the 64-bit trampoline for
 TDX guests
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-rneri-wakeup-mailbox-v8-7-2f5b6785f2f5@linux.intel.com>
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
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767822314; l=2718;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=vhY14NkKZxOjAgHyadn8owqSXQZwp+wSl3FyExPxLjM=;
 b=imcOffMmJ4D28oznl/JuiSow1i2XcrcdUBwEk9Z6hIfgxUUy70AOosDy2CXgAaeKAmwbNNhZ9
 so1rxSIAYuHAy3WNEL7aQ7740cKmCRjPxkPEZCkVD72GGm+Ce9Ml3wX
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

From: Yunhong Jiang <yunhong.jiang@linux.intel.com>

The hypervisor is an untrusted entity for TDX guests. It cannot be used
to boot secondary CPUs - neither via hypercalls nor the INIT assert,
de-assert, plus Start-Up IPI messages.

Instead, the platform virtual firmware boots the secondary CPUs and
puts them in a state to transfer control to the kernel. This mechanism uses
the wakeup mailbox described in the Multiprocessor Wakeup Structure of the
ACPI specification. The entry point to the kernel is trampoline_start64.

Allocate and setup the trampoline using the default x86_platform callbacks.

The platform firmware configures the secondary CPUs in long mode. It is no
longer necessary to locate the trampoline under 1MB memory. After handoff
from firmware, the trampoline code switches briefly to 32-bit addressing
mode, which has an addressing limit of 4GB. Set the upper bound of the
trampoline memory accordingly.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
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
 - Added a note regarding there is no need to check for a present
   paravisor.
 - Edited commit message for clarity.

Changes in v2:
 - Dropped the function hv_reserve_real_mode(). Instead, used the new
   members realmode_limit and reserve_bios members of x86_init to
   set the upper bound of the trampoline memory. (Thomas)
---
 arch/x86/hyperv/hv_vtl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index f74199e77133..752101544663 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -68,9 +68,14 @@ void __init hv_vtl_init_platform(void)
 	 */
 	pr_info("Linux runs in Hyper-V Virtual Trust Level %d\n", ms_hyperv.vtl);
 
-	x86_platform.realmode_reserve = x86_init_noop;
-	x86_platform.realmode_init = x86_init_noop;
-	real_mode_header = &hv_vtl_real_mode_header;
+	/* There is no paravisor present if we are here. */
+	if (hv_isolation_type_tdx()) {
+		x86_init.resources.realmode_limit = SZ_4G;
+	} else {
+		x86_platform.realmode_reserve = x86_init_noop;
+		x86_platform.realmode_init = x86_init_noop;
+		real_mode_header = &hv_vtl_real_mode_header;
+	}
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
 	x86_init.resources.probe_roms = x86_init_noop;

-- 
2.43.0


