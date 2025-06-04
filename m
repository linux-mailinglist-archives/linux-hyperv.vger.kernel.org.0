Return-Path: <linux-hyperv+bounces-5736-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A25AACD09D
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 02:19:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4819717652F
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 00:19:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3BD786328;
	Wed,  4 Jun 2025 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I7D8XiPy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8963595A;
	Wed,  4 Jun 2025 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748996287; cv=none; b=FIUWqdbXCTkwceqnsUIBtASsO+rW926ycFYsV8yrrIJV2Rs8iO97xESMixvuoNNDNL8v+3wb7jh8at0gcu5KWt2NWCQLlWBgaEAKn1IbC7lIljAzM/fg0csmjqgra2iZWi3Du8tUBYSC1jTSjCoM0k8s+hNy9RtOtYBNAXIegoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748996287; c=relaxed/simple;
	bh=KV3C22xeOFoKXBk/U+nLRQtAIIYTiSgcSALyUOXxLKU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ji0U10D4myCAVQz0PNt/2U+yTTCg0IMlZWIlLusLjw2e+fj4CM8HgP1K/J8F/MnrmLOOuJOPNins6QcDrO34VItsS0HPrjEzFy2LWQQp7hwMsu4GSMEjfKkXf0kNU4GXURgWne97Zgdp19XY8uirAtntO7eSt4Kb3ppP+saLD+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I7D8XiPy; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748996286; x=1780532286;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=KV3C22xeOFoKXBk/U+nLRQtAIIYTiSgcSALyUOXxLKU=;
  b=I7D8XiPyb8e38Akfwqk3anTDmcDpBo2mJ6/QXiaa6vnyTzQbX+mmDk2k
   d4NPxscX5ftciO1zYqF8DEoxQfcTMzRORjSMYb6TU2R3UWUgpN+yoFcAm
   Bd3BrZjrKtUi36z1QocdLf1jclgAP2dD1E12fGATZ8AARVW+bz86glAGI
   pdzA9oodcGjLWV9KgDP3dWK3QzBuPmaZ7lTpUIx0kBl4eRjIAFjW/HsZu
   mHiL6awKc4X5VFCELjNpd5kOX1bWEQTSf2fXWY038WQ1EZeThT2OCTe56
   CACOYQVQg4M6aX5BveIQPPnHBFZALt5gZvyLdhFbG5akgu5M5bYEljHRy
   A==;
X-CSE-ConnectionGUID: dz7r1JGgTUOchLNDkLXeCg==
X-CSE-MsgGUID: edjBSBV9Sp6MwDlnrZedFQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62112963"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="62112963"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:18:02 -0700
X-CSE-ConnectionGUID: zTf4k3h6TjGu+vnS7EEd9Q==
X-CSE-MsgGUID: /63SA10USl2JM0T6K3F+qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="149904476"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:18:01 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Tue, 03 Jun 2025 17:15:19 -0700
Subject: [PATCH v4 07/10] x86/hyperv/vtl: Setup the 64-bit trampoline for
 TDX guests
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-rneri-wakeup-mailbox-v4-7-d533272b7232@linux.intel.com>
References: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com>
In-Reply-To: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com>
To: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Chris Oo <cho@microsoft.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, 
 Ricardo Neri <ricardo.neri@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748996287; l=2512;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=cwjzbQJMuckUfYrMyGEivmvlDqF1G7Qp0Q7oqGDvum0=;
 b=iOiCh0sBp1vME5V7EgWP7K/SYZ9V0T2RvZgXULmi9oV7K8jmbntaWo8lLvDgOrtCv3sOa+yWr
 nsbZSp7iGfsBGOw+pVcZaxYYEU9YnmTOvTqfQptW1b2p2y4fLhUb57i
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

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

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 - Added Reviewed-by tag from Michael. Thanks!

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


