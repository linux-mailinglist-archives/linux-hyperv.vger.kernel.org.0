Return-Path: <linux-hyperv+bounces-5336-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0679FAA823B
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 21:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606001894A48
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 19:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21D0A280CE3;
	Sat,  3 May 2025 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKqfC3Rp"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1C9280309;
	Sat,  3 May 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299420; cv=none; b=cRuFw+ooLyxagH80uje+oDUM1H1IJpRBm6JJ4q9Gh/d8s95pqUKmtI9QDWoSNQuFWkGmvp7M4RBG4vr/ho8mZgNYtMFAoCw0VfMk3KXgP7SOQVrqJc/i9TEmE3qGOBiWLO4UYXgX+61gKL8rshOmgIqvBFFIihW9RNmNFGd+uaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299420; c=relaxed/simple;
	bh=ESLZ9uhO1N2lJ6bZhCVExA9DKJ2OV1MWa4rUf2Woug4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=WuX6ZErTeCL0To+03/kny/s+/h46QYEYVLcnPLFmyQGP3iI3XCnEtjgwII8wVvU1qH+OWVb7Q+PYXyCvdSS2hu/cMEAIYnOZbn7/ShdZJM+x3IRsqyDoiQXjTUrgQzX3DDgxeTmnh/3fBwiabYfCnCOJDfS/Sv9xUIH5HQxQybE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKqfC3Rp; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746299418; x=1777835418;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ESLZ9uhO1N2lJ6bZhCVExA9DKJ2OV1MWa4rUf2Woug4=;
  b=NKqfC3RpirS7yCCpVLmOyfuQGIJ0CLGcZ3LxJdCjCN9qSIoaGxE+Xdtz
   TbruKsKDP/3AG/BUHrIzkEStbjqaJ59aetEOFe/onl9w7AD/cQQQGW87C
   5ToA/prBYNglN3MwHpX9fcUSuf80BCSdH0FausK1V7he6eOCkM+lgsUtz
   F04ySS6uas/dnoiJqThESzYDybz62h/4DY8DKkMlYv2vTIkRHDRi+WmvB
   Qm7aCE1cdcdCQuAuwNoezKLAkthHw0ru1THhpKfEnaU79FskPdQxL6hyx
   Ahb9p8B9Dv/SZcLSA2kLwtFs7+W2wOTyQJSQA/E9O30ZU7y5eSnbxO/O1
   A==;
X-CSE-ConnectionGUID: dW6GpWRhR6a54qsZ3kHyFw==
X-CSE-MsgGUID: Q4u+d8xUSlG873fxKiSTmA==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="48095651"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="48095651"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:10:15 -0700
X-CSE-ConnectionGUID: 3BIjFLjoRcy2YFC8rrVosQ==
X-CSE-MsgGUID: MjcGbIRPTVCmjnr/bIX9kA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="140046114"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP; 03 May 2025 12:10:14 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: x86@kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: devicetree@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-acpi@vger.kernel.org ,
	linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH v3 10/13] x86/hyperv/vtl: Setup the 64-bit trampoline for TDX guests
Date: Sat,  3 May 2025 12:15:12 -0700
Message-Id: <20250503191515.24041-11-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

From: Yunhong Jiang <yunhong.jiang@linux.intel.com>

The hypervisor is an untrusted entity for TDX guests. It cannot be used
to boot secondary CPUs - neither via hypercalls not the INIT assert,
de-assert plus Start-Up IPI messages.

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

Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 - Added a note regarding there is no need to check for a present
   paravisor.
 - Edited commit message for clarity.

Changes since v1:
 - Dropped the function hv_reserve_real_mode(). Instead, used the new
   members realmode_limit and reserve_bios members of x86_init to
   set the upper bound of the trampoline memory. (Thomas)
---
 arch/x86/hyperv/hv_vtl.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 6bd183ee484f..8b497c8292d3 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -58,9 +58,14 @@ void __init hv_vtl_init_platform(void)
 {
 	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
 
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


