Return-Path: <linux-hyperv+bounces-2733-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E0181949B0D
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 00:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C895B222A1
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 22:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFA6B174ED0;
	Tue,  6 Aug 2024 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cHNlcKMB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B08E170A02;
	Tue,  6 Aug 2024 22:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982382; cv=none; b=b64fNpSbi5bxxwgmSgf1ZegXgAp3GS+CZ69PpYtHibSXS+XWeWSXzaJVCZqQQAcxKTo1JXZav33J6RK+74ym1TmIUQSM2+KSyaXB6/ocf5JvGlvbL7Pqk4Y3Gcz0tbClarwl+cVzC3zEb/kh5Ys0JYW9Vxl1MNDsjEs+Yzvf1UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982382; c=relaxed/simple;
	bh=q6cecAe5n2ojTi6IvNZq7/UciZod0Y7dSn3+dmBOoek=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lksn3HR8z8J09l1nwMXhUxYGB4AqkGQhr6w9oncCesh1o1GCW621QR7qs/an23utKM/5044sbg+D/KQ1N0x659Y0PiNSxia8Ca0UTOAz9cB69bhCBHb5+eJyfY7bgfVapnexHqpp5HlhRfN6B2yKYFJj0zoiUfcqvSEhDl0avac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cHNlcKMB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722982381; x=1754518381;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=q6cecAe5n2ojTi6IvNZq7/UciZod0Y7dSn3+dmBOoek=;
  b=cHNlcKMBbh/tc7Dga60d3id6AeSeBfHjiJy2Sb1Y5slG0Ul74qE9n76p
   uYe5XrxWLNiKZETCdv4XqYBFJH3tlxNtccGfUnHcFEaI9+chkVnTon2me
   t1G0esghIa6EzXLGOH/HgLSFiCbRdJ4Xji4xE/o+wGpoNEXmrQ2UWLMsS
   gudOQwx5GUUh86z8cjUuuWNvozcxL+X5ymsqXciU5V/Mgd/lEJL7uUpZT
   aM+U+JibGfjWlOnoo0roEqCejlRCj/chcUhQXmQqmQOBM5edClO1rDjk3
   JiQPkC7HRb2byEWyZ7XXLI+BKjb8WbYHyqKAZAUq5EzNn7iyh6+BiLODr
   Q==;
X-CSE-ConnectionGUID: 23TdF8Q0TgW36eoie6Qh1A==
X-CSE-MsgGUID: 5PfFb55XTbawz2MWvTVEhg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38534359"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38534359"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 15:13:01 -0700
X-CSE-ConnectionGUID: BNXLwhFOSlmL58JeW1fA7w==
X-CSE-MsgGUID: d9ETNo7qT/Cc9esscxuzwA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61465621"
Received: from yjiang5-dev1.sc.intel.com ([172.25.103.134])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2024 15:13:00 -0700
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
	kirill.shutemov@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	yunhong.jiang@linux.intel.com
Subject: [PATCH 1/7] x86/acpi: Move ACPI MADT wakeup to generic code
Date: Tue,  6 Aug 2024 15:12:31 -0700
Message-Id: <20240806221237.1634126-2-yunhong.jiang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
References: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
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
index eebc4fa2ab9a..6cc6d5c367df 100644
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
index a847180836e4..b2de8a4698c3 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -155,4 +155,5 @@ ifeq ($(CONFIG_X86_64),y)
 
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


