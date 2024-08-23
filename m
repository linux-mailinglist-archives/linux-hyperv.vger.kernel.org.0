Return-Path: <linux-hyperv+bounces-2834-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3158C95D994
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 01:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 623991C21F9D
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 23:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F4A1C9458;
	Fri, 23 Aug 2024 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nXDaBW89"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DC8E1C6F77;
	Fri, 23 Aug 2024 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724455436; cv=none; b=SL1c/eeFI5pWC4sNeb09nNfcKWRq96ENDuP0rljUy9M0km9AYLoXDsBAyr1p8D3HIJ5qNIbhMvxHCTc8L5m8q++QAC7yoBMvWNBZhCnmu1EvnbW5QQxCrOXVdz1Q0eFr9CuV00tGM/TLIqIs6vMGKSxhlMrQUMjxTjg0XwA3eCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724455436; c=relaxed/simple;
	bh=xLRdtJ64kQ24k5untrIAz54KexJSdvR2FAmQANoccMo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RZWilwJovyHnaoLNHsoN6wPHYO8Pw+hO8yKcreDgbVYWE0GPdNplBnCx5LVXdptvSJScA3vfeQLuYBs2rl+mdoDa07xTLZcGkeVVpr00EEAtmXyHglFQzKmYGjEDnblRlsBJNcvCBFOhtfrvujC4xxfm2veA+WS5kjaQ4DPjUAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nXDaBW89; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724455435; x=1755991435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=xLRdtJ64kQ24k5untrIAz54KexJSdvR2FAmQANoccMo=;
  b=nXDaBW89P1mdCVg9owO1QvANbhbhk7fc0VX9B3NC2I6MGJWXQAJlO0CJ
   QqV/VVwsbXJBzdt/A3PKBIxb6+gozVCyEc6QbX4BpGVARldj1DRiIt2Jr
   Gs+glwrAmKieplMn2FPo4FIvVkUO+PoFGjOwStUH2TnfovGNQAmk6UKnC
   pEnh5nVgvTm+QnkAuTDvsTtEZQHt4PhjLESVHml3beAGCHXAPzF3tBlwv
   M1ILJTtqeTPfU+BYmpn6FmlLGPALEbIlhft0tqgm1PoDdjGZ0uCAHC1Ig
   FSiguQqBiadiGzwtSUW8+G1RXCQt9+K8lYezyDeIqk9nv/FimlN3ZA+2w
   w==;
X-CSE-ConnectionGUID: y/KaeimPRRGW8yDROCUNOw==
X-CSE-MsgGUID: S7NqGuUOR1eB+9sCFZMyug==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="33619277"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33619277"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 16:23:52 -0700
X-CSE-ConnectionGUID: XHJC5UBwQz6mZb/8EWTeWg==
X-CSE-MsgGUID: nXWzuEMZTquSbbXwR/czRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61641000"
Received: from yjiang5-dev1.sc.intel.com ([172.25.103.134])
  by fmviesa007.fm.intel.com with ESMTP; 23 Aug 2024 16:23:52 -0700
From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	rafael@kernel.org,
	lenb@kernel.org,
	kirill.shutemov@linux.intel.com,
	yunhong.jiang@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 1/9] x86/acpi: Move ACPI MADT wakeup to generic code
Date: Fri, 23 Aug 2024 16:23:19 -0700
Message-Id: <20240823232327.2408869-2-yunhong.jiang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In order to support the ACPI mailbox wakeup in device tree, move the MADT
wakeup code out of the acpi directory, so that both ACPI and device tree
can use it.

Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
---
 MAINTAINERS                                | 2 ++
 arch/x86/kernel/Makefile                   | 1 +
 arch/x86/kernel/acpi/Makefile              | 1 -
 arch/x86/kernel/{acpi => }/madt_playdead.S | 0
 arch/x86/kernel/{acpi => }/madt_wakeup.c   | 0
 5 files changed, 3 insertions(+), 1 deletion(-)
 rename arch/x86/kernel/{acpi => }/madt_playdead.S (100%)
 rename arch/x86/kernel/{acpi => }/madt_wakeup.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 969eb9c6e759..5555a3bbac5f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -289,6 +289,8 @@ F:	Documentation/ABI/testing/configfs-acpi
 F:	Documentation/ABI/testing/sysfs-bus-acpi
 F:	Documentation/firmware-guide/acpi/
 F:	arch/x86/kernel/acpi/
+F:	arch/x86/kernel/madt_playdead.S
+F:	arch/x86/kernel/madt_wakeup.c
 F:	arch/x86/pci/acpi.c
 F:	drivers/acpi/
 F:	drivers/pci/*/*acpi*
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index f7918980667a..0823e5ba3aea 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -163,4 +163,5 @@ ifeq ($(CONFIG_X86_64),y)
 
 	obj-$(CONFIG_MMCONF_FAM10H)	+= mmconf-fam10h_64.o
 	obj-y				+= vsmp_64.o
+	obj-$(CONFIG_ACPI_MADT_WAKEUP)	+= madt_wakeup.o madt_playdead.o
 endif
diff --git a/arch/x86/kernel/acpi/Makefile b/arch/x86/kernel/acpi/Makefile
index 842a5f449404..fc17b3f136fe 100644
--- a/arch/x86/kernel/acpi/Makefile
+++ b/arch/x86/kernel/acpi/Makefile
@@ -4,7 +4,6 @@ obj-$(CONFIG_ACPI)		+= boot.o
 obj-$(CONFIG_ACPI_SLEEP)	+= sleep.o wakeup_$(BITS).o
 obj-$(CONFIG_ACPI_APEI)		+= apei.o
 obj-$(CONFIG_ACPI_CPPC_LIB)	+= cppc.o
-obj-$(CONFIG_ACPI_MADT_WAKEUP)	+= madt_wakeup.o madt_playdead.o
 
 ifneq ($(CONFIG_ACPI_PROCESSOR),)
 obj-y				+= cstate.o
diff --git a/arch/x86/kernel/acpi/madt_playdead.S b/arch/x86/kernel/madt_playdead.S
similarity index 100%
rename from arch/x86/kernel/acpi/madt_playdead.S
rename to arch/x86/kernel/madt_playdead.S
diff --git a/arch/x86/kernel/acpi/madt_wakeup.c b/arch/x86/kernel/madt_wakeup.c
similarity index 100%
rename from arch/x86/kernel/acpi/madt_wakeup.c
rename to arch/x86/kernel/madt_wakeup.c
-- 
2.25.1


