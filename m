Return-Path: <linux-hyperv+bounces-6041-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 803EFAEC497
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 05:36:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02C584A7F22
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 03:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1D26221278;
	Sat, 28 Jun 2025 03:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OzXRcD5H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6621E087;
	Sat, 28 Jun 2025 03:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751081726; cv=none; b=B+chpztGGoh15siI3HMvw8xdVVeVR5dKbQ/8dD+adR6UhTBlPV0Jwnmbw3WSfl4lsYTRxNGUXWICVhHNCT4oWfKIErRR04lP0ZnUhcfVTFhbmc2j/MlIHfuKbz3i0QVOrPz1vMnNO4dhYsKlZph6fAxXQtoefR9rC6kYhPbEOso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751081726; c=relaxed/simple;
	bh=7u3jzQOHQC8e8nYlBmPy/cvDiVVJG6dcIK9qVAeDnaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eB/N3Cw7aafYgfipKw7/GHARBFTdE+GGGy3Kt1Rrk8F6tHMnpuRduhJITw7rqYNahvsuompnkepwslpfJAc9HKey3Nbw/3cllmGeLP6efNLcWp8lUGSQkn0QZIWl/mPc44Y1WXJ8VEFBH/uSmfojDMvYdddcMuTCpZFfDROxUHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OzXRcD5H; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751081725; x=1782617725;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=7u3jzQOHQC8e8nYlBmPy/cvDiVVJG6dcIK9qVAeDnaI=;
  b=OzXRcD5HNimeUgSSUJ5aq6VDL/6D+5FE0EnnEzsZcVxsvOtwk3abA3gt
   4IiXXsEydeDauFtod2+RKDOpPv/0QNckI5OvYeN46KF/d1uvdszg6WkrX
   qU2vsWjdc7CPf8zEQRsVIUWMPSNtRkuWc4bfeb9nm+V9lFlRLWzwCMYLT
   OkK5xLktUOWDh6MWsoKKB5IDfo9/eS2qpYCDZQCmRNfWFkFdxC/yirvsi
   RIm5Fs2SsH9ht9nSSkK8ph4edtVorOgb+vcxhK1fv8WEwYeeXMhplyXv7
   +l2eCoTXPDThFTj6WpxdMVgsIVCOiJBBUvO4Q4DnipNrUbeFNqwRJaIqF
   g==;
X-CSE-ConnectionGUID: R5Wewn+GTO2eG6+tQyM5bQ==
X-CSE-MsgGUID: QOxpC7wYQaCEWjpBN8Hl6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53335348"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="53335348"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:21 -0700
X-CSE-ConnectionGUID: Jyf+GzUgSm2Ojz2uycDGuw==
X-CSE-MsgGUID: Wa+jJ2d7TPqOAff3hoVhKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="153141947"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:21 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Fri, 27 Jun 2025 20:35:13 -0700
Subject: [PATCH v5 07/10] x86/hyperv/vtl: Setup the 64-bit trampoline for
 TDX guests
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-rneri-wakeup-mailbox-v5-7-df547b1d196e@linux.intel.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
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
 Ricardo Neri <ricardo.neri@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751081737; l=2563;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=v53YIEDb5wEecGCYiRI9pSAZEMooPBl6C6+NHy1rJw4=;
 b=dsGZ9Lm5tU4WnkSGeayXzXSkr5L4Gn5pyBmPg9HRIhUWFgMBBDqh/CSXzfIxAI/PALl+wN/Cq
 tlxEXHw+QLaCwEtJZyKnFqkqmaX0MDWwXcmJUN4WOQXZgJLOwRwxw6W
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
Changes since v4:
 - None

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
index e10b63b7a49f..ca0d23206e67 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -63,9 +63,14 @@ void __init hv_vtl_init_platform(void)
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


