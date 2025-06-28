Return-Path: <linux-hyperv+bounces-6042-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD46FAEC49E
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 05:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 647FF3B69C1
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 03:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3524122171D;
	Sat, 28 Jun 2025 03:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="lkgCWFAC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B45221FF42;
	Sat, 28 Jun 2025 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751081727; cv=none; b=oi3TE6zsmKB3qzuJk/99lASlWdMYQbhJVStKflS38PxXLpVTDNhCqhp3jX6/Nqv0WHyXzGrtimUHW/IkjlgD1FEFFarbwPJ9XEJXKVD6V08+YhnXqLjR0eNR+Ksjl14Z2h3pb6znWuR1kaGXcxUZIjrMmXspNDh95m0kQAvjYKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751081727; c=relaxed/simple;
	bh=N2fJS0od4PztBQXpKokHlCgKokIm3lqpe/O3tOSfUV4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y3zB4bytZhYFfu6vT96xNblXKvTeKcYiWsojb87U8XHyC2kHdgmo/CACeoUG+JeJOlxHmxXwRALo41gAMcB1sAQcSTUG1sUFaraCNn9kh55BctMVV65ejrlf9Q1HTUNoxHFDWCkVZ6hGkHlDiCM1uDPt+r9QG8UKtFEN+Xu3DFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=lkgCWFAC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751081726; x=1782617726;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=N2fJS0od4PztBQXpKokHlCgKokIm3lqpe/O3tOSfUV4=;
  b=lkgCWFACbjGSxamGhQRx8JGJaPAGPQtezfAM6Jk4uUQVo6j27qbvOYJK
   +tH7QljxpUVmclIBQIVelsESplXWBkaS+1xL2Pyf94dHcPo1bgjFqE+MH
   odNHBPe9H8KSXx8Eh+Lb++qTZSUqkbnaCtpUEuI1fX/Vskmao0PP+8Xi/
   1JbYRMiU/ReRn0FLLeeZMYCPo4VuByGMfdcxU9zo1xXsq1JWkMxl1cluh
   RXIP5VCm81uuvb8PbXGXKrDsCvSQcu1zaGqxI0ntnKDsDwhJrXfMcl7NA
   AQtpHjdGZserB2DcvUJuIe+DiY35X3JROxJJmJILhscQf3QIZfag9D5GB
   Q==;
X-CSE-ConnectionGUID: HgrSb0tZTCS3ElW+ZJnFXA==
X-CSE-MsgGUID: G9qbBnFUQ5eJweLdaFgUjg==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53335355"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="53335355"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:22 -0700
X-CSE-ConnectionGUID: kfyg3/E6SeqynujUeDj2WQ==
X-CSE-MsgGUID: wbA/7BLHQu2SYB/oZkgZ3Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="153141952"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:21 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Fri, 27 Jun 2025 20:35:14 -0700
Subject: [PATCH v5 08/10] x86/smpwakeup: Add a helper get the address of
 the wakeup mailbox
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-rneri-wakeup-mailbox-v5-8-df547b1d196e@linux.intel.com>
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
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751081737; l=1696;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=N2fJS0od4PztBQXpKokHlCgKokIm3lqpe/O3tOSfUV4=;
 b=e6+Ki4qiU6OhUu5Q188/7DKWvc0LchICJK/SMkRzZEEvu594NtkYFUduWsG7XSzROV7T1F9as
 uuS03V24zd4A4A54Li7xDbxKVFrS/zwy5PnKAkqGF9obemIJcRY/p6i
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

A Hyper-V VTL level 2 guest on a TDX environment needs to map the
physical page of the ACPI Multiprocessor Wakeup Structure as private
(encrypted). It needs to know the physical address of this structure.
Add a helper function.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
 - None

Changes since v3:
 - Renamed function to acpi_get_mp_wakeup_mailbox_paddr().
 - Added Reviewed-by tag from Michael. Thanks!

Changes since v2:
 - Introduced this patch

Changes since v1:
 - N/A
---
 arch/x86/include/asm/smp.h  | 1 +
 arch/x86/kernel/smpwakeup.c | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 77dce560a70a..158e8979342e 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -148,6 +148,7 @@ static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
 
 void acpi_setup_mp_wakeup_mailbox(u64 addr);
 struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void);
+u64 acpi_get_mp_wakeup_mailbox_paddr(void);
 
 #else /* !CONFIG_SMP */
 #define wbinvd_on_cpu(cpu)     wbinvd()
diff --git a/arch/x86/kernel/smpwakeup.c b/arch/x86/kernel/smpwakeup.c
index 5089bcda615d..f730a66b6fc8 100644
--- a/arch/x86/kernel/smpwakeup.c
+++ b/arch/x86/kernel/smpwakeup.c
@@ -81,3 +81,8 @@ struct acpi_madt_multiproc_wakeup_mailbox *acpi_get_mp_wakeup_mailbox(void)
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


