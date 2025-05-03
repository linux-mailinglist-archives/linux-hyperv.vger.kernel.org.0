Return-Path: <linux-hyperv+bounces-5328-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABD8AA821B
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 21:10:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 621793BEDD9
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 19:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF6A27EC89;
	Sat,  3 May 2025 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fYzesCcE"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E86227E7D0;
	Sat,  3 May 2025 19:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299415; cv=none; b=kwixLKr8LGM8Lv5aH1WH7UCHXKwm2XPqqTdxxPgw3qWyfCT7SP2vJGmT4V8xaIjt1I8r/Q6KT9HQ7GlomxmPhfnp7CpDwksc+6WWj0P/QQ7VO8UF77/xF1JPo1WYWqMlqnjI1yfkv1i91GrK4LRnOGrlYrUWuoSF3yFh1R7igGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299415; c=relaxed/simple;
	bh=CcBd5muWd0bFU2n4MW9K/uESkZokPGbZ1FllJgz4DJ0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=X5yP6o/IaFicr8ZaWdStZtVUcj86U+54h8CvdwBmrv/BaZCYyHdAGN7WbsdDQRnVXjs8ZsEEvryz7EZ1Yiqsji9De4msDTEoY2f37nlRmJAPA76lLIubTVgLCJ2nFpJQWdV8C6VF5bza5LMI5fr1fw4LqZDQk3uulseWF+zQoVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fYzesCcE; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746299414; x=1777835414;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=CcBd5muWd0bFU2n4MW9K/uESkZokPGbZ1FllJgz4DJ0=;
  b=fYzesCcE85FUZbbuVzHz0ytJdR6q3gRI9CwYalH2Rew3Elp1F0+44tpE
   vD2OES/yexIz29icJXLtpouAhiJtnCMNf1MCUkkRT+o63S0E3R76sCqGv
   BtQlhwXCJwADynx4SC1/ZX8DPRF/O/TmK3fDMQ+X4XK7XqoKO28v5V+hK
   k52xE4Y6Jn8hGVdw5u5+4dc0/zh7iK0KQnwVvYdHQD9GzCHWT4OX/i3fs
   LmDJyIXFzpEfrqZqS5cvXnw578dLyzuRFHMHDhwFh2hiYCqe3dJxA4ONf
   dFVgMjHDbKvZN+pgi9zwv9T8W/TIDpIcjMHs2w1QJTTuFBbgbRtHng8xI
   w==;
X-CSE-ConnectionGUID: 5vef0Qw9ThKAzsAHj0QS7A==
X-CSE-MsgGUID: I1v86+cuRamqr/zc71yADg==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="48095609"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="48095609"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:10:11 -0700
X-CSE-ConnectionGUID: uVKts7upQuqc3OwM7RW0Eg==
X-CSE-MsgGUID: zRLZuPgTRkOjwmEz5GV2qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="140046085"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP; 03 May 2025 12:10:10 -0700
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
Subject: [PATCH v3 02/13] x86/acpi: Add a helper function to get a pointer to the wakeup mailbox
Date: Sat,  3 May 2025 12:15:04 -0700
Message-Id: <20250503191515.24041-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

In preparation to move the functionality to wake secondary CPUs up out
of the ACPI code, add a helper function to get a pointer to the mailbox.

Use this helper function only in the portions of the code for which the
variable acpi_mp_wake_mailbox will be out of scope once it is relocated
out of the ACPI directory.

The wakeup mailbox is only supported for CONFIG_X86_64 and needed only
with CONFIG_SMP.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 - Introduced this patch.

Changes since v1:
 - N/A
---
 arch/x86/include/asm/smp.h         |  1 +
 arch/x86/kernel/acpi/madt_wakeup.c | 12 +++++++++---
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 3622951d2ee0..97bfbd0d24d4 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -148,6 +148,7 @@ static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
 
 #ifdef CONFIG_X86_64
 void setup_mp_wakeup_mailbox(u64 addr);
+struct acpi_madt_multiproc_wakeup_mailbox *get_mp_wakeup_mailbox(void);
 #endif
 
 #else /* !CONFIG_SMP */
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 04de3db307de..6b9e41a24574 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -37,6 +37,7 @@ static void acpi_mp_play_dead(void)
 
 static void acpi_mp_cpu_die(unsigned int cpu)
 {
+	struct acpi_madt_multiproc_wakeup_mailbox *mailbox = get_mp_wakeup_mailbox();
 	u32 apicid = per_cpu(x86_cpu_to_apicid, cpu);
 	unsigned long timeout;
 
@@ -46,13 +47,13 @@ static void acpi_mp_cpu_die(unsigned int cpu)
 	 *
 	 * BIOS has to clear 'command' field of the mailbox.
 	 */
-	acpi_mp_wake_mailbox->apic_id = apicid;
-	smp_store_release(&acpi_mp_wake_mailbox->command,
+	mailbox->apic_id = apicid;
+	smp_store_release(&mailbox->command,
 			  ACPI_MP_WAKE_COMMAND_TEST);
 
 	/* Don't wait longer than a second. */
 	timeout = USEC_PER_SEC;
-	while (READ_ONCE(acpi_mp_wake_mailbox->command) && --timeout)
+	while (READ_ONCE(mailbox->command) && --timeout)
 		udelay(1);
 
 	if (!timeout)
@@ -251,3 +252,8 @@ void __init setup_mp_wakeup_mailbox(u64 mailbox_paddr)
 	acpi_mp_wake_mailbox_paddr = mailbox_paddr;
 	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
 }
+
+struct acpi_madt_multiproc_wakeup_mailbox *get_mp_wakeup_mailbox(void)
+{
+	return acpi_mp_wake_mailbox;
+}
-- 
2.43.0


