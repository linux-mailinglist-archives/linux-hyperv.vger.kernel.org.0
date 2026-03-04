Return-Path: <linux-hyperv+bounces-9144-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uEkGIJDDqGk2xAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9144-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:43:12 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 345692090CE
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2EDA1305BB88
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 23:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5A53A1CE7;
	Wed,  4 Mar 2026 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GNNM6kbV"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E05F3750BE;
	Wed,  4 Mar 2026 23:42:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667754; cv=none; b=iOBSqaaJIy3vFC9vVUpkOEI7vNM6r8105orBxW8ML5pj2jLHVTiV2KbPjOyEm+lY+Nm20FaCd+I7w3ckmqaQCV9jS1xXHCxkdpF3sy4p7ncpyXbd66pvFM3RdkzdzZANIlW4XTY94Ga5rii5q4b7oChRydFHbPHd4LRVZN3UMZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667754; c=relaxed/simple;
	bh=GN6daPpQzOfVGd6Nv2NhuT5UdbbWKvTexhWrt0VUkRI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pbjHKDsAQ1yM64TP483lsqUO1kmzW8kcGlGxFZoRdxdqsOdq78OuptsU8wPvs0AN7hgLHLi0WoS+07/fzBgawFKE7XyY9eR7/MuyDR35xx4Hb0kdQZ7H/yZT33dN295rAMUsgQIm/ZdgWvJ5+g5+j8xGHFZ2GV5Z8/MpzRR5Sr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GNNM6kbV; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772667753; x=1804203753;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=GN6daPpQzOfVGd6Nv2NhuT5UdbbWKvTexhWrt0VUkRI=;
  b=GNNM6kbVItW3YhUI+7FRfmA666E8kmhtdi4jm/HxIj0r9AVSHgV4DXIH
   axw/wsX4nBPX9EZfdWuwIk/q0aeoU1Bf8q829Kt4BESbXvAj49mEcPPiP
   XlTel+oGonXAffDHQw/NiF3rhik6+QOobhgQZPoGVEmN0X3JQmrcOO5t2
   QNyU/QYF7He4tzKshYHVX2uuPg9rciMG8mazA9k33XP8lDd8GAHr6JWGu
   YN8NbDQu/uBJ64/VrSieEuoFJ2epi9aa1EoscbLw+ca7qSGWk1y1bSI/A
   p5wOig5z+sr12bzCAxsoLv06IUoS44gvwZhfGEEd8XAKXIi3c8tc4KAlU
   Q==;
X-CSE-ConnectionGUID: XdKg2nDzR0WYMoue+i5GJQ==
X-CSE-MsgGUID: oUso5Ej1RwmnI/jOPc9mug==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="96359391"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="96359391"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:30 -0800
X-CSE-ConnectionGUID: e2I0jXvjQxm9lPjvTkcAXg==
X-CSE-MsgGUID: lZ3PCYpASWKqh7qQUVaAcA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="215376910"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:29 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 04 Mar 2026 15:41:17 -0800
Subject: [PATCH v9 06/10] x86/realmode: Make the location of the trampoline
 configurable
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-rneri-wakeup-mailbox-v9-6-a5c6845e6251@linux.intel.com>
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
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>, 
 Thomas Gleixner <tglx@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772667694; l=4020;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=mpGPF3jR6AORmhK8ZGU375OgdCDiSrS2mYiIBTZ7o8s=;
 b=CdqfIDTgrn7FZ78H7swP/gIDIt/LMostWKRS8hxdEcko9yKqjNhwfuvw3/G3emClYG5DGCvgu
 MlPjmoH7ewNBn9W/xuaCVevSuHLoR/UUK+/NJlV7kkd6T3RWsXvX9UZ
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=
X-Rspamd-Queue-Id: 345692090CE
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9144-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,microsoft.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[21];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ricardo.neri-calderon@linux.intel.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[linux-hyperv,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,intel.com:dkim,intel.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,outlook.com:email]
X-Rspamd-Action: no action

From: Yunhong Jiang <yunhong.jiang@linux.intel.com>

x86 CPUs boot in real mode. This mode uses a 1MB address space. The
trampoline must reside below this 1MB memory boundary.

There are platforms in which the firmware boots the secondary CPUs,
switches them to long mode and transfers control to the kernel. An example
of such a mechanism is the ACPI Multiprocessor Wakeup Structure.

In this scenario there is no restriction on locating the trampoline under
1MB memory. Moreover, certain platforms (for example, Hyper-V VTL guests)
may not have memory available for allocation below 1MB.

Add a new member to struct x86_init_resources to specify the upper bound
for the location of the trampoline memory. Preserve the default upper bound
of 1MB to conserve the current behavior.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Originally-by: Thomas Gleixner <tglx@linutronix.de>
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
 - Edited the commit message for clarity.
 - Minor tweaks to comments.
 - Removed the option to not reserve the first 1MB of memory as it is
   not needed.

Changes in v2:
 - Added this patch using code that Thomas suggested:
   https://lore.kernel.org/lkml/87a5ho2q6x.ffs@tglx/
---
 arch/x86/include/asm/x86_init.h | 3 +++
 arch/x86/kernel/x86_init.c      | 3 +++
 arch/x86/realmode/init.c        | 7 +++----
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index 6c8a6ead84f6..953d3199408a 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -31,12 +31,15 @@ struct x86_init_mpparse {
  *				platform
  * @memory_setup:		platform specific memory setup
  * @dmi_setup:			platform specific DMI setup
+ * @realmode_limit:		platform specific address limit for the real mode trampoline
+ *				(default 1M)
  */
 struct x86_init_resources {
 	void (*probe_roms)(void);
 	void (*reserve_resources)(void);
 	char *(*memory_setup)(void);
 	void (*dmi_setup)(void);
+	unsigned long realmode_limit;
 };
 
 /**
diff --git a/arch/x86/kernel/x86_init.c b/arch/x86/kernel/x86_init.c
index ebefb77c37bb..252c5827d063 100644
--- a/arch/x86/kernel/x86_init.c
+++ b/arch/x86/kernel/x86_init.c
@@ -9,6 +9,7 @@
 #include <linux/export.h>
 #include <linux/pci.h>
 #include <linux/acpi.h>
+#include <linux/sizes.h>
 
 #include <asm/acpi.h>
 #include <asm/bios_ebda.h>
@@ -69,6 +70,8 @@ struct x86_init_ops x86_init __initdata = {
 		.reserve_resources	= reserve_standard_io_resources,
 		.memory_setup		= e820__memory_setup_default,
 		.dmi_setup		= dmi_setup,
+		/* Has to be under 1M so we can execute real-mode AP code. */
+		.realmode_limit		= SZ_1M,
 	},
 
 	.mpparse = {
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 88be32026768..694d80a5c68e 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -46,7 +46,7 @@ void load_trampoline_pgtable(void)
 
 void __init reserve_real_mode(void)
 {
-	phys_addr_t mem;
+	phys_addr_t mem, limit = x86_init.resources.realmode_limit;
 	size_t size = real_mode_size_needed();
 
 	if (!size)
@@ -54,10 +54,9 @@ void __init reserve_real_mode(void)
 
 	WARN_ON(slab_is_available());
 
-	/* Has to be under 1M so we can execute real-mode AP code. */
-	mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, 1<<20);
+	mem = memblock_phys_alloc_range(size, PAGE_SIZE, 0, limit);
 	if (!mem)
-		pr_info("No sub-1M memory is available for the trampoline\n");
+		pr_info("No memory below %pa for the real-mode trampoline\n", &limit);
 	else
 		set_real_mode_mem(mem);
 

-- 
2.43.0


