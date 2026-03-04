Return-Path: <linux-hyperv+bounces-9139-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHr0G4nDqGk0xAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9139-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:43:05 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC902090A8
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:43:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF9E63055832
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 23:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC29391518;
	Wed,  4 Mar 2026 23:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P+p2arDU"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49415371D18;
	Wed,  4 Mar 2026 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667752; cv=none; b=NbFnCIaNWpVazCoTiPJS51pFI8sqgg8Yxycm7QU9IKZvDlXRHGYDfv+KBul3Tyq0eCkPAq9op4dpGwA7ljUevb0XcryEA+1fIsBEdUdrzrURXhFVew3nox9YnSSMuM3CH8JA7nMdtvW8jGNDCUknlcb7gyQ0sh5miS7ZNtQ4tHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667752; c=relaxed/simple;
	bh=sW69dOJpj+Zvcx0LGtVJv5/bm8HwObqT3wbBW18B9RQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HpWO9mK11KgujzBi0QL+NtoP24pBU7xOTAOPVEmJfwBXnxOh1JZf+JfUJuVHje4cdpjTU87m6wyH/i/nwYxsf0KLa+X/0QuVS1KNaiNMwQOuUhn6Rug5NoHxUiZ29RkstQ1AWfCQYlz9/ur7R+5f9esRvsVvi6vg8koigz3OexM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P+p2arDU; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772667752; x=1804203752;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=sW69dOJpj+Zvcx0LGtVJv5/bm8HwObqT3wbBW18B9RQ=;
  b=P+p2arDUcQa4+hTVTGPnwlX+X67lK3ulRSNQCwmMwImFSV7y6M7Sl6T0
   aj9kdOyn8G76Krr4WenQrOpeTOhi6TpYY55lcYzYG/Py8pE9xkGFndcTl
   ovuc7B6OjnVEN+ewxzDI8tP2rLgHRQHUDqEnYxwLB689rZpqpIJVDukz2
   +Ba0JuiNrCGybg8UXAuiyLQdN1ydKotHWZ8a//UxcC1cl0n3Sl1bWgCej
   S5qNOCiRTldoFTOYQUtMy/QOvl0udh4CDe8BmoqF+xQhvOJPszht215YN
   9vNnxSjdGg+ZKnjviEkrcpIyHc7k06eui29feAzzblpj3ZS9eolSEPjRy
   Q==;
X-CSE-ConnectionGUID: Ph/JkUX9TteqnAEDu5RvAg==
X-CSE-MsgGUID: 5Y+zhKyXRgeJwM1/EvlntA==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="96359369"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="96359369"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:29 -0800
X-CSE-ConnectionGUID: Z5gypgjcTGSg75UTsjnwTw==
X-CSE-MsgGUID: QaW84QqxRpSVUkbqab9p5g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="215376896"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:28 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 04 Mar 2026 15:41:13 -0800
Subject: [PATCH v9 02/10] x86/acpi: Add functions to setup and access the
 wakeup mailbox
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260304-rneri-wakeup-mailbox-v9-2-a5c6845e6251@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772667694; l=3190;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=sW69dOJpj+Zvcx0LGtVJv5/bm8HwObqT3wbBW18B9RQ=;
 b=PcyOuEtArfUqX0eO1T9nxSxRHpSmRhQyWPkxT5Ilxwz8XNktxvA5O3ur5EgLsERHPzoOWh5Ef
 mG4JkPPoW6ZArNKqic8WorwPQttGws2kwl0OiW3LsPpg4kq5C6Jf7RH
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=
X-Rspamd-Queue-Id: 1AC902090A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9139-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,microsoft.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ricardo.neri-calderon@linux.intel.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.intel.com:mid,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email]
X-Rspamd-Action: no action

Systems that describe hardware using DeviceTree graphs may enumerate and
implement the wakeup mailbox as defined in the ACPI specification but do
not otherwise depend on ACPI. Expose functions to setup and access the
location of the wakeup mailbox from outside ACPI code.

The function acpi_setup_mp_wakeup_mailbox() stores the physical address of
the mailbox and updates the wakeup_secondary_cpu_64() APIC callback.

The function acpi_madt_multiproc_wakeup_mailbox() returns a pointer to the
mailbox.

Acked-by: Rafael J. Wysocki (Intel) <rafael@kernel.org>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes in v9:
 - None

Changes in v8:
 - Added Acked-by tag from Rafael. Thanks!

Changes in v7:
 - Moved function declarations to arch/x86/include/asm/acpi.h
 - Added stubs for !CONFIG_ACPI.
 - Do not use these new functions in madt_wakeup.c.
 - Dropped Acked-by and Reviewed-by tags from Rafael and Dexuan as this
   patch changed.

Changes in v6:
 - Fixed grammar error in the subject of the patch. (Rafael)
 - Added Acked-by tag from Rafael. Thanks!
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes in v5:
 - None

Changes in v4:
 - Squashed the two first patches of the series into one, both introduce
   helper functions. (Rafael)
 - Renamed setup_mp_wakeup_mailbox() as acpi_setup_mp_wakeup_mailbox().
   (Rafael)
 - Dropped the function prototype for !CONFIG_X86_64. (Rafael)

Changes in v3:
 - Introduced this patch.

Changes in v2:
 - N/A
---
 arch/x86/include/asm/acpi.h        | 10 ++++++++++
 arch/x86/kernel/acpi/madt_wakeup.c | 11 +++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index a03aa6f999d1..820df375df79 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -182,6 +182,9 @@ void __iomem *x86_acpi_os_ioremap(acpi_physical_address phys, acpi_size size);
 #define acpi_os_ioremap acpi_os_ioremap
 #endif
 
+void acpi_setup_mp_wakeup_mailbox(u64 addr);
+struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void);
+
 #else /* !CONFIG_ACPI */
 
 #define acpi_lapic 0
@@ -200,6 +203,13 @@ static inline u64 x86_default_get_root_pointer(void)
 	return 0;
 }
 
+static inline void acpi_setup_mp_wakeup_mailbox(u64 addr) { }
+
+static inline struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void)
+{
+	return NULL;
+}
+
 #endif /* !CONFIG_ACPI */
 
 #define ARCH_HAS_POWER_INIT	1
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/acpi/madt_wakeup.c
index 6d7603511f52..82caf44b45e3 100644
--- a/arch/x86/kernel/acpi/madt_wakeup.c
+++ b/arch/x86/kernel/acpi/madt_wakeup.c
@@ -247,3 +247,14 @@ int __init acpi_parse_mp_wake(union acpi_subtable_headers *header,
 
 	return 0;
 }
+
+void __init acpi_setup_mp_wakeup_mailbox(u64 mailbox_paddr)
+{
+	acpi_mp_wake_mailbox_paddr = mailbox_paddr;
+	apic_update_callback(wakeup_secondary_cpu_64, acpi_wakeup_cpu);
+}
+
+struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void)
+{
+	return acpi_mp_wake_mailbox;
+}

-- 
2.43.0


