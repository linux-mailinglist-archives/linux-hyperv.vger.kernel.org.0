Return-Path: <linux-hyperv+bounces-9143-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oK7iCo7DqGk0xAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9143-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:43:10 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D28712090B7
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:43:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 880E5304F5EC
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 23:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98ED39FCC9;
	Wed,  4 Mar 2026 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XIJbNVsK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E1D73976BB;
	Wed,  4 Mar 2026 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667754; cv=none; b=jUSkKQefwlumlG9i/Q9Ys2QD6V5FMIyUClwRan9Jh0OFplOq2QIfgBHHettmOMeaTSQlmBZqEkh39eNv9E0/CqayNSJYN+YqczYd3C4TZDcHnhaHJIIje8TqbH3YeGHiDqz4hiuaRaGJZK4miqI0WBeiRFcN2rUmFZmEK76/WC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667754; c=relaxed/simple;
	bh=L8Ru1Y1TQTL3fMh3bls020gKDtFIM4GJX2W6RnGN4oA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YzVcubs7a2DaL1zs6IpPhSggdh6j0DoFOvYCnFEMXYjA5TiOb8QCMZf29UJfkl6YNLyXNFhZ/YVNzVLmID79HJ08rQOtIR1eq4kKTimLrGbRF94lfYX9xI2+8GWlS0M07hfJXEpYyCZpTb+6eBT5lBr93dkdXVb5NMP5nhvLpUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XIJbNVsK; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772667753; x=1804203753;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=L8Ru1Y1TQTL3fMh3bls020gKDtFIM4GJX2W6RnGN4oA=;
  b=XIJbNVsKJ5sqN7Y3Ve0xOZWZAM9+D56WodO3cqvj6yWOOFsU3orXPmbf
   wvuuOGNbFnirPI/vttRXvi1S4AMMHqerGvLrauKrI8NUgnEIWam4VxijA
   41Wi2TjH/Lk0ZUcq7FCbc7n1TFNOl66c+9Q6E3yb1CHXzOSVonT0bpmH+
   YOj/AVmrfBqwSf/KoYxvxhMYzOcD3HajhrEsbGrnCdFJBjELYEJGFiIcC
   2ij9OqTgqvxyAnaMXIo5dgiZ4sAjH/H7M2co6H0IG5zicn/tWDPjJ1+A4
   BldN6N3ZKZ9G81RhWDzrj7zNrG+Dg4CD0rDBdj4IlabZxNtKjs1Xs8dew
   A==;
X-CSE-ConnectionGUID: oBOMegsvRKKurdpgz0JlYg==
X-CSE-MsgGUID: uq8zzZIKRRO0Z80ddFkdXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="96359396"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="96359396"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:30 -0800
X-CSE-ConnectionGUID: 6xn8DzpJTkeJXjN2O9UDPw==
X-CSE-MsgGUID: BhDGoJiYTtm1bJ0ThOlNGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="215376913"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:29 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 04 Mar 2026 15:41:18 -0800
Subject: [PATCH v9 07/10] x86/hyperv/vtl: Setup the 64-bit trampoline for
 TDX guests
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-rneri-wakeup-mailbox-v9-7-a5c6845e6251@linux.intel.com>
References: <20260304-rneri-wakeup-mailbox-v9-0-a5c6845e6251@linux.intel.com>
In-Reply-To: <20260304-rneri-wakeup-mailbox-v9-0-a5c6845e6251@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772667694; l=2745;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=gZ53l7WuF1Dvxd82tcmGZ1N9jujHl1P/hFTFjsVZFn0=;
 b=s1yOtexGbHwKfPQMvOJrkBmnW+al2MUn7C1xWVdDG+35/vJ1TBIZ9CaDoAYn3jFrxa/oRikSJ
 Mu7cwdf5u+RBkdioq9WAAcbMPC3XO0PJmUneRoo7zE2d4Ipr2MnMZyw
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=
X-Rspamd-Queue-Id: D28712090B7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9143-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,microsoft.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ricardo.neri-calderon@linux.intel.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,outlook.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,intel.com:dkim,intel.com:email]
X-Rspamd-Action: no action

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
Changes in v9:
 - None

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
index e045bf3a2c59..b94fffa67312 100644
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


