Return-Path: <linux-hyperv+bounces-7240-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40207BE6275
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 04:50:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2879F5E162F
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 02:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08CA5283FC5;
	Fri, 17 Oct 2025 02:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GOXd/PhW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E964726FDBF;
	Fri, 17 Oct 2025 02:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760669336; cv=none; b=hubuNCREpAHg4pGAcH8Eq2wA+FPgmaGj18Qg8GF/OIfJ//SUodtDumq11pIfMwP4S6oEBntgX2+tYM+MjyKExJ7XjVud6NBZ977DJbNZWN8SI6W/ihA3AOewUoQiZrNfPOe/eaLMDY6q46zcyH7+4sNyNmKcZA19JiOKtCaUyb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760669336; c=relaxed/simple;
	bh=K/5U2Qk8R/cIAFnRILyVEin1gfN+/w6yMlS9Y9x1rfw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=icrclZMOJ4BqWFlJWCBbO/D0h2glU7ue/fII+BQe3FDUmJgcgkV+tYHWyOHKLJHCn8KN1N1Q7ywEx8DYolSuV1Lf0rjU+a2A6MbbNLpJ91StWCeZsu9rbwuHvI8wX7oKJCbA53lsYec6QLRmmKUnaYicrQzT+hcbbbsBJfiLhPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GOXd/PhW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760669335; x=1792205335;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=K/5U2Qk8R/cIAFnRILyVEin1gfN+/w6yMlS9Y9x1rfw=;
  b=GOXd/PhWAC3srKPUFKVECJGxTVAye7QP3v6fsqjHALIcrAbJWdQWiOXU
   gqKo+CGDiD8Zd0JXB8Zp4gFZXsDVoc5RbtIgLILah8TDaSK2CaDAh/ugu
   Rv/KNayk8njQvrNXshCbEi/d3xKLvi9N0vylCjQ7SmmPnbctJNDZxXIAi
   +pWQrz7YfYtb/DfPg5IVns2qOdI9t6QE0JmAYDweAg4QXNXI6+piJZw3T
   jJh6RdQZ0SPLfQtx/eTXPgZhJsK2eEGqbAIehnuOvKr191jO3eSpCXSwm
   1g5U735t/KTjVmaA7ZLXEoOihsxP+8yCDdcC9JqbTNWO9kzWfLno1BIa/
   w==;
X-CSE-ConnectionGUID: WnIfTquTTDSHCXGGG4LpMA==
X-CSE-MsgGUID: QXw8e+C5S/+OaEXJYdyR5Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="80321932"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="80321932"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:51 -0700
X-CSE-ConnectionGUID: 7qWtohq3T8K7TA5tHC14hA==
X-CSE-MsgGUID: jkpZZNQ9TCaZdtJdtnseKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="219776575"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:50 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 16 Oct 2025 19:57:30 -0700
Subject: [PATCH v6 08/10] x86/smpwakeup: Add a helper get the address of
 the wakeup mailbox
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-rneri-wakeup-mailbox-v6-8-40435fb9305e@linux.intel.com>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
In-Reply-To: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760669902; l=1835;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=K/5U2Qk8R/cIAFnRILyVEin1gfN+/w6yMlS9Y9x1rfw=;
 b=JeXwHHzKBw2NIblS/o5uV7qNHOeHVrmvG2V4Lp2RQoYAProTTAbanpIgZWA7Gko05pahnUmrx
 AtaJGjTHQhHDfI4A3tapBgPCxYUMpOjK4/jn7mPpzn0Yw4F+UG+feYc
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

A Hyper-V VTL level 2 guest in a TDX environment needs to map the physical
page of the ACPI Multiprocessor Wakeup Structure as private (encrypted). It
needs to know the physical address of this structure. Add a helper function
to retrieve the address.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 - Added Reviewed-by tag from Dexuan. Thanks!

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
index 47ac4381a805..71de1963f984 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -151,6 +151,7 @@ static inline struct cpumask *cpu_l2c_shared_mask(int cpu)
 
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


