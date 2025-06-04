Return-Path: <linux-hyperv+bounces-5730-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC84EACD085
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 02:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E68B3A6624
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 00:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1959B9444;
	Wed,  4 Jun 2025 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OjQ+g6WJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54E842C3251;
	Wed,  4 Jun 2025 00:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748996284; cv=none; b=C+M0H+dVTqzDNOJAwUamUQ+LHs7F/q6nf9A8Kn9RswU3uXro5zQGGBh10cZLqFImGGcL6lRggx8eOuZS42jQKqQbz+SW6xUTMc5spXuJr1r44XTWSz2W9iBss4P7Y3/VbGm9Ja4WiqkNclOAaO6EV6fdoT+4nrqqsFqugqtbGgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748996284; c=relaxed/simple;
	bh=WlIPLmc/FFq62iCagksYCp6qUw2SVgS1XlRC8UQ86RY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sKyuxoiVc1gPnhbA8BF8hsxsawgHMc4wfZ6/G+bv6GkG9XpyiCAMj/SLpnqzZkkiiT5Y627bcaNqhof24piPDVWPsLgaDxLVEOsxyqVq6pa6f8eWgfFJ4M0o0gENgubwvY+6Cj7nK+e9vgPuyOlQoiuifuuwGB9FLfJ+gy0qlmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OjQ+g6WJ; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748996283; x=1780532283;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=WlIPLmc/FFq62iCagksYCp6qUw2SVgS1XlRC8UQ86RY=;
  b=OjQ+g6WJBQCa9ERHE2/SiWMwYo2BG1zBVjbmzVCp0b+BMe++NJxY4mlv
   smFnycGz/oGGX2Fvnz8CeCStZ2zPIiagZEVeR93dNNChm/up74ns85Vi8
   5Aqqw/dhWh3tRokmUj/2Wgc11PeHarBjf9I6abl37EIlGth1x4xR3yjX2
   f/S8H3mfJybjjjNZt2AG10qrxvIQQ+OgtCxvbn8BTc0ZNVkA0/dcTg4kU
   u76Dro0JYD2AQj9TFf3T8a/opJnxFf6oluXM2y5v7U0v/jGMxCdkhO0cz
   p0h1uce0rQBeNE8GLhPGi3xkMMG8IPH1MOUnY57Ua+Jsnz0aBx5ko67lq
   A==;
X-CSE-ConnectionGUID: plUX8MMAQ4a6KsMt258sew==
X-CSE-MsgGUID: E6Q0aKIMRa2EgP7VvPWeqw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62112927"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="62112927"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:18:01 -0700
X-CSE-ConnectionGUID: Zq9LiRrKR3O6C1R9Li/Tcw==
X-CSE-MsgGUID: bFGiFZfiSz6RUM6oQ5bwdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="149904451"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:18:00 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Tue, 03 Jun 2025 17:15:13 -0700
Subject: [PATCH v4 01/10] x86/acpi: Add a helper functions to setup and
 access the wakeup mailbox
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-rneri-wakeup-mailbox-v4-1-d533272b7232@linux.intel.com>
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
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748996287; l=3940;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=WlIPLmc/FFq62iCagksYCp6qUw2SVgS1XlRC8UQ86RY=;
 b=OSOBVCV+0Em4QTXbhjXb/J+EoNF3QP2p8VNGT+Z1LJIjU5aqld4VELjoZBgn0IIhZe3X1dnhU
 RLgOMPg89OeB0PxRnPZNQq4Rn4RhHYRc1rNAB9P0ffvz9luLB5rKlNx
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

In preparation to move the functionality to wake secondary CPUs up out of
the ACPI code, add two helper functions.

The function acpi_setup_mp_wakeup_mailbox() stores the physical address of
the mailbox and updates the wakeup_secondary_cpu_64() APIC callback.

There is a slight change in behavior: now the APIC callback is updated
before configuring CPU hotplug offline behavior. This is fine as the APIC
callback continues to be updated unconditionally, regardless of the
restriction on CPU offlining.

The function acpi_madt_multiproc_wakeup_mailbox() returns a pointer to the
mailbox. Use this helper function only in the portions of the code for
which the variable acpi_mp_wake_mailbox will be out of scope once it is
relocated out of the ACPI directory.

The wakeup mailbox is only supported for CONFIG_X86_64 and needed only with
CONFIG_SMP=y.

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 - Squashed the two first patches of the series into one, both introduce
   helper functions. (Rafael)
 - Renamed setup_mp_wakeup_mailbox() as acpi_setup_mp_wakeup_mailbox().
   (Rafael)
 - Dropped the function prototype for !CONFIG_X86_64. (Rafael)

Changes since v2:
 - Introduced this patch.

Changes since v1:
 - N/A
---
 arch/x86/include/asm/smp.h         |  3 +++
 arch/x86/kernel/acpi/madt_wakeup.c | 20 +++++++++++++++-----
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 0c1c68039d6f..77dce560a70a 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -146,6 +146,9 @@ static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
 	return per_cpu(cpu_l2c_shared_map, cpu);
 }
 
+void acpi_setup_mp_wakeup_mailbox(u64 addr);
+struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void);
+
 #else /* !CONFIG_SMP */
 #define wbinvd_on_cpu(cpu)     wbinvd()
 static inline int wbinvd_on_all_cpus(void)
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index f36f28405dcc..4033c804307a 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -37,6 +37,7 @@ static void acpi_mp_play_dead(void)
 
 static void acpi_mp_cpu_die(unsigned int cpu)
 {
+	struct acpi_madt_multiproc_wakeup_mailbox *mailbox = acpi_get_mp_wakeup_mailbox();
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
@@ -227,7 +228,7 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	acpi_table_print_madt_entry(&header->common);
 
-	acpi_mp_wake_mailbox_paddr = mp_wake->mailbox_address;
+	acpi_setup_mp_wakeup_mailbox(mp_wake->mailbox_address);
 
 	if (mp_wake->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1 &&
 	    mp_wake->header.length >= ACPI_MADT_MP_WAKEUP_SIZE_V1) {
@@ -243,7 +244,16 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 		acpi_mp_disable_offlining(mp_wake);
 	}
 
+	return 0;
+}
+
+void __init acpi_setup_mp_wakeup_mailbox(u64 mailbox_paddr)
+{
+	acpi_mp_wake_mailbox_paddr = mailbox_paddr;
 	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
+}
 
-	return 0;
+struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void)
+{
+	return acpi_mp_wake_mailbox;
 }

-- 
2.43.0


