Return-Path: <linux-hyperv+bounces-9145-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPToIaLDqGk2xAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9145-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:43:30 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D1AF20910C
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:43:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4A50A3060CC4
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 23:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28523A5E84;
	Wed,  4 Mar 2026 23:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gfc6NnNB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D4739EF3B;
	Wed,  4 Mar 2026 23:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667755; cv=none; b=NEmQEQohomEwaDs2oNjiBqfPkRn2bYQ+PhxJbKOPUXPY+tTazVdQbfd2qJqwU+qw4OAP2P0PD/3/TsrUoW0Vw3I8vbUDeSW+bC2YdM8YrQPtiP8wahWLu2IkJh9qwPfnHyUns/Q360mn1/kduYFIFjb95shmoyhu0+HqYCRdR8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667755; c=relaxed/simple;
	bh=t5nYwO5pX4uVzM/aRglX5MIg6SjtwvRmK+6R7EwEGdY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VKmMEIrFXxwDbFnu5extRP2K1pva5DcV22eZqllXe0XE1uzYWHuPaNAMr9F/5V+TkyJrhd486L6HSL5cjvWo3ZLxS3PySunj/FPhAjQk5a/9Bqecm+Dbk9VoLSdm62MrvCZkt+ERjC1AQD7xhYh2XSO6JMe4rmE0qokhK4yJy5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gfc6NnNB; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772667755; x=1804203755;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=t5nYwO5pX4uVzM/aRglX5MIg6SjtwvRmK+6R7EwEGdY=;
  b=gfc6NnNB0URXYFYGp1jxY5nivbOIYhSl6kozNsT7YY0FMO6O1c7xQKGk
   bu2Ecy9yPet/mmxyrS6Bf2AUBJBoN7Vo58eKV5V8LnepZdvfs5dE82ImS
   e8bjnJCxHa2PdRfPnb1eNjvd8q86i1qfQ9Vl1P2SxOaWqpyjSmrDcI82k
   cTmMFV3w0RaLZ/6e/e4OiZ+OSi503vfI3jH/ZI2BLXRuiDL8kiXTqKkn1
   utjDy6jQv7IYEbT24MYPlBB4HZyueSKBpgGGJsWO+oHhd+cPAllIWj7U+
   ak59uE1kzab+8Zo4YyJtyQQYuw+tRAfjPscAV8HU3riZk67lh1ECM3PcV
   Q==;
X-CSE-ConnectionGUID: IqQbMGXaTVuuwTW1lEk8IQ==
X-CSE-MsgGUID: J81eRiySQ++HjI+ZvZYeLA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="96359399"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="96359399"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:30 -0800
X-CSE-ConnectionGUID: IafsOjuRRW6hlNz2GQ2EXA==
X-CSE-MsgGUID: mnrkwTZ4SVu1hi//fyd3qg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="215376918"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:29 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 04 Mar 2026 15:41:19 -0800
Subject: [PATCH v9 08/10] x86/acpi: Add a helper get the address of the
 wakeup mailbox
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-rneri-wakeup-mailbox-v9-8-a5c6845e6251@linux.intel.com>
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
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772667694; l=2340;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=t5nYwO5pX4uVzM/aRglX5MIg6SjtwvRmK+6R7EwEGdY=;
 b=5pVLVGPbhpxYRtEKJ6Cs/CU/TZic6fN/6+qFPl0AODwB5tpYIQQWoL9kB8Fgr3rMWpec3ljas
 K4OHyiZiPUPD6qGRFiM9mo1fiOH9aBMDuHOatV1IAqBBVXQrSkDPHPl
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=
X-Rspamd-Queue-Id: 3D1AF20910C
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
	TAGGED_FROM(0.00)[bounces-9145-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,microsoft.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
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

A Hyper-V VTL level 2 guest in a TDX environment needs to map the physical
page of the ACPI Multiprocessor Wakeup Structure as private (encrypted). It
needs to know the physical address of this structure. Add a helper function
to retrieve the address.

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes in v9:
 - None

Changes in v8:
 - Added Acked-by tag from Rafael. Thanks!

Changes in v7:
 - Moved the added function to arch/x86/kernel/acpi/madt_wakeup.c
 - Dropped Reviewed-by tags from Dexuan and Michael as this patch
   changed.

Changes in v6:
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes in v5:
 - None

Changes in v4:
 - Renamed function to acpi_get_mp_wakeup_mailbox_paddr().
 - Added Reviewed-by tag from Michael. Thanks!

Changes in v3:
 - Introduced this patch

Changes in v2:
 - N/A
---
 arch/x86/include/asm/acpi.h        | 6 ++++++
 arch/x86/kernel/acpi/madt_wakeup.c | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 820df375df79..c4e6459bd56b 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -184,6 +184,7 @@ void __iomem *x86_acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
 
 void acpi_setup_mp_wakeup_mailbox(u64 addr);
 struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void);
+u64 acpi_get_mp_wakeup_mailbox_paddr(void);
 
 #else /* !CONFIG_ACPI */
 
@@ -210,6 +211,11 @@ static inline struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mail
 	return NULL;
 }
 
+static inline u64 acpi_get_mp_wakeup_mailbox_paddr(void)
+{
+	return 0;
+}
+
 #endif /* !CONFIG_ACPI */
 
 #define ARCH_HAS_POWER_INIT	1
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 82caf44b45e3..48734e4a6e8f 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -258,3 +258,8 @@ struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void)
 {
 	return acpi_mp_wake_mailbox;
 }
+
+u64 acpi_get_mp_wakeup_mailbox_paddr(void)
+{
+	return acpi_mp_wake_mailbox_paddr;
+}

-- 
2.43.0


