Return-Path: <linux-hyperv+bounces-2833-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9983195D991
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 01:23:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA69C1C21ADF
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 23:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E48421C8FBB;
	Fri, 23 Aug 2024 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bKx4Tutx"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F119F181B83;
	Fri, 23 Aug 2024 23:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724455434; cv=none; b=M7WGlX7LL6ABg5tYF+zhGFoh8HuznzIoVyGGqFsybr7ngCFPwKzaaEQUIGVqdATH4xhAQ7ureZev0TK1QZa5JHNLqLj3/4MtWtVUFCTW7mv/DodSAhWSGQDIRvfIPEoBq+U3NOkfa/L1h1Q8Ukns7TkhxFaaslcN/sVYPdM5+qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724455434; c=relaxed/simple;
	bh=9HpR83En6WtmTmfEotsgcaen3QI0F1sI9d5zLCWGrLc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CvJvbDxQqCJtTh2qwVua3+f4xQXsJukPEV/K1UNszuAD/rC10SWUuWXURGWAErocJxpYeYbbb0GWg0Z5p4eHq3s3bSmpoqM/dKTLsh31FzkYqebC6yfKtGrp5gu9LpvdEG6zG6Vw5BLkW8bCtCTW3JFVRS8Yaar+xvSS5gKHDv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bKx4Tutx; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724455433; x=1755991433;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=9HpR83En6WtmTmfEotsgcaen3QI0F1sI9d5zLCWGrLc=;
  b=bKx4TutxQyRllacjHxVyUsDN3hR25LR+OwruQDMIP5VkMhyk5SbYUqN9
   P2Ly0qmI7542HznWBdl1fYd4lN6HUn2jLyKVPSIIy8iv4bvuNl4q0IGHF
   fNqmgE7S9Gnr7rUIojIEVNbBdkDQukPa7KiX6IUspwxoLTk/mRDCb3bcQ
   iRXHmdzL/HqWlgRpe6+myW/7j+v9s54xqAencj+ufK69spIU5n+cjOsYv
   jQf2IXI1hzKmXIvFwMsUwR2JTnrL9egBucP5yomGd8S0nz/lsFcFGCJgV
   brb/cyGNzqjQHbM/9eUeMS+chtRsgcRV2DBejXi7CuWNuMbvuvWrCaekT
   A==;
X-CSE-ConnectionGUID: VWHQJu/cRhqbimv+HfoKnw==
X-CSE-MsgGUID: hFOmczvKSjinBElXRtyPnw==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="33619269"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33619269"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 16:23:52 -0700
X-CSE-ConnectionGUID: nhTVYrs4SpWn43e1pDMJLA==
X-CSE-MsgGUID: kzfrsuTpQgWz1OxqneYT9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61640998"
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
Subject: [PATCH v2 0/9] x86/hyperv: Support wakeup mailbox for VTL2 TDX guest
Date: Fri, 23 Aug 2024 16:23:18 -0700
Message-Id: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set of patches add ACPI multiprocessor wakeup support to VTL2 TDX VMs
booting with device tree instead of ACPI.

Historically, x86 platforms have booted secondary processors (APs) using
INIT followed by the start up IPI (SIPI) messages. However, TDX VMs
can't use this protocol because this protocol requires assistance from
VMMs while VMMs are not trusted by TDX guest.

ACPI specification version 6.4 introduced a new wakeup mailbox model to
address this issue. A "Multiprocessor Wakeup Structure" has been added to
an existing ACPI table (MADT). This structure provides the physical of a
"Multiprocessor Wakeup Mailbox Structure". Message written to the mailbox
structure steers the APs to the boot code.

With this new wakeup model, TDX VMs with ACPI support boot the APs
securely. However, TDX VMs with the device tree, like VTL2 TDX hyperv
guests, have no ACPI support and still face the challenge.

To fix this challenge, either a new mechanism from scratch is
introduced, or the TDX VMs with device tree can utilize the ACPI wakeup
model.

By reusing the ACPI wakeup mailbox model, the Multiprocessor Wakeup Mailbox
Structure will be kept and the message mechanism will be the same as ACPI.
This will reduce maintenance effort in the long term.

The first patch moves the madt wakeup implementation to generic code.
The patches 2-3 add the wakeup mailbox support to the device tree.
The patches 4-5 add the wakeup mailbox support to the hyperv guest.
The patches 6-8 update the real mode memory reservation.
The last patch applies the wakeup mailbox support to the VTL2 TDX guest.

v2:
  - Fix the cover letter's summary phrase.
  - Fix the DT binding document to pass validation.
  - Change the DT binding document to be ACPI independent.
  - Move ACPI-only functions into the #ifdef CONFIG_ACPI.
  - Change dtb_parse_mp_wake() to return mailbox physical address.
  - Rework the hv_is_private_mmio_tdx().
  - Remove unrelated real mode change from the patch that marks mailbox
    page private.
  - Check hv_isolation_type_tdx() instead of wakeup_mailbox_addr in
    hv_vtl_init_platform() because wakeup_mailbox_addr is not parsed yet.
  - Add memory range support to reserve_real_mode.
  - Remove realmode_reserve callback and use the memory range.
  - Move setting the real_mode_header to hv_vtl_init_platform.
  - Update comments and commit messages.
  - Minor style changes.

Yunhong Jiang (9):
  x86/acpi: Move ACPI MADT wakeup to generic code
  dt-bindings: x86: Add a binding for x86 wakeup mailbox
  x86/dt: Support the ACPI multiprocessor wakeup for device tree
  x86/hyperv: Parse the ACPI wakeup mailbox
  x86/hyperv: Mark ACPI wakeup mailbox page as private
  x86/realmode: Add memory range support to reserve_real_mode
  x86/hyperv: Move setting the real_mode_header to hv_vtl_init_platform
  x86/hyperv: Set realmode_limit to 4G for VTL2 TDX guest
  x86/hyperv: Use wakeup mailbox for VTL2 guests if available

 .../devicetree/bindings/x86/wakeup.yaml       | 64 +++++++++++++++++++
 MAINTAINERS                                   |  3 +
 arch/x86/Kconfig                              |  2 +-
 arch/x86/hyperv/hv_vtl.c                      | 29 +++++++--
 arch/x86/include/asm/acpi.h                   |  1 -
 arch/x86/include/asm/madt_wakeup.h            | 16 +++++
 arch/x86/include/asm/mshyperv.h               |  3 +
 arch/x86/include/asm/x86_init.h               |  6 ++
 arch/x86/kernel/Makefile                      |  1 +
 arch/x86/kernel/acpi/Makefile                 |  1 -
 arch/x86/kernel/cpu/mshyperv.c                |  2 +
 arch/x86/kernel/{acpi => }/madt_playdead.S    |  0
 arch/x86/kernel/{acpi => }/madt_wakeup.c      | 38 +++++++++++
 arch/x86/kernel/x86_init.c                    |  3 +
 arch/x86/realmode/init.c                      | 14 ++--
 drivers/hv/hv_common.c                        |  8 +++
 16 files changed, 176 insertions(+), 15 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/x86/wakeup.yaml
 create mode 100644 arch/x86/include/asm/madt_wakeup.h
 rename arch/x86/kernel/{acpi => }/madt_playdead.S (100%)
 rename arch/x86/kernel/{acpi => }/madt_wakeup.c (90%)


base-commit: fedb9ddeb1445f85d8f691b20f3faaa6dab8dd3f
-- 
2.25.1


