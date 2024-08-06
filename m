Return-Path: <linux-hyperv+bounces-2732-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D0B949B07
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 00:13:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 696251C21B64
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 22:13:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E4AA173347;
	Tue,  6 Aug 2024 22:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N8OhLlYj"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64242172BAE;
	Tue,  6 Aug 2024 22:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982382; cv=none; b=Ra/dYh6+KoxQ+EYvuD8OPiUOBzacDJaZKhImPy8alOlUrHoMlFJ4vC/H56nXVqfhhXxgj1ZkZaogSNVFTcd3abhpHlv0qVilWTXh+l6iE1ttYT+ATHF0EgRkAg5rax+60q4St6rZj8i0iHvUQaVqO0oOPSSvXm0Ww8dSumXbmMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982382; c=relaxed/simple;
	bh=eMfTwuERrN+nNbChcSkoO5cgQetqoZ0j/xiy1nJlAp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hoovj2R14BpCS/wInwz3eTP4NOujjxwx3QAP0WtcocS2bd4xKTa8FLjAyaEhTOwjr1ujZa2jD51/mkAFm8qn0JmsDzZBCpxmgniYtwzXR+1E2AQQXNwLXSHQvebdUX15Qj23l3xFJ4nNfQQOh3vm969/0gy8vDFaIP1UOpS7Xt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N8OhLlYj; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722982381; x=1754518381;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=eMfTwuERrN+nNbChcSkoO5cgQetqoZ0j/xiy1nJlAp4=;
  b=N8OhLlYjVsoNhVKNI0LMSsP4BDN4XASjjkvbIQv9F43cXHoTIoclr74T
   MEsfvuNIaYF8Uwy8pvw6LWo6A1Gfj13gGTPqy1MwZjhaH9rJpIaeKAh6m
   F4gxGPCt6NKynUpYa8R9UEmSHrrWGBNxoBkaDgA5A1l+BzlvFSorWHhq7
   dttaritPOP2nynW+O1APmP/IBceJ1Zq0ieNOwcT72qDh4ijvXHxS1g4fG
   1rcd9n1wQ156Mymwj/TzrwZGe2VsyA8usWFqZ4V8eDNcu2oAcC7hg0MTW
   1Uhw7MB4NhcdaSXN+2rmJ/X2E2xbdCmVCWl2yNwj7faz9utwq+zwxlXaw
   g==;
X-CSE-ConnectionGUID: C2sAS/ogTSWYZ6hotc33vg==
X-CSE-MsgGUID: 6qMAiggeQaW06gYR9F69mA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38534349"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38534349"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 15:13:00 -0700
X-CSE-ConnectionGUID: 21E0rOI9RbmLk7d1OXS1gQ==
X-CSE-MsgGUID: 5Uaa+pBPQIu50xZSqL7CNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61465620"
Received: from yjiang5-dev1.sc.intel.com ([172.25.103.134])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2024 15:12:58 -0700
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
Subject: [PATCH 0/7] x86/acpi: Move ACPI MADT wakeup to generic code
Date: Tue,  6 Aug 2024 15:12:30 -0700
Message-Id: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This set of patches add ACPI multiprocessor wakeup support to TDX VMs
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
securely. However, TDX VMs with the device tree have no ACPI support and
still face the challenge.

To fix this challenge, either a new mechanism from scratch is
introduced, or the TDX VMs with device tree can utilize the ACPI wakeup
model.

By reusing the ACPI wakeup mailbox model, the Multiprocessor Wakeup Mailbox
Structure will be kept and the message mechanism will be the same as ACPI.
This will reduce maintenance effort in the long term.

The first patch moves the madt wakeup implementation to generic code.

The second/third patches add the mailbox support to the device tree.

The last four patches apply the mailbox support to the hyper-v TDX VMs
with device tree.

Yunhong Jiang (7):
  x86/acpi: Move ACPI MADT wakeup to generic code
  dt-bindings: x86: Add ACPI wakeup mailbox
  x86/dt: Support the ACPI multiprocessor wakeup for device tree
  x86/hyperv: Parse the ACPI wakeup mailbox
  x86/hyperv: Mark ACPI wakeup mailbox page as private
  x86/hyperv: Reserve real mode when ACPI wakeup mailbox is available
  x86/hyperv: Use the ACPI wakeup mailbox for VTL2 guests when available

 .../devicetree/bindings/x86/wakeup.yaml       | 41 ++++++++++++++++
 MAINTAINERS                                   |  3 ++
 arch/x86/Kconfig                              |  2 +-
 arch/x86/hyperv/hv_vtl.c                      | 43 +++++++++++++++--
 arch/x86/include/asm/acpi.h                   |  1 -
 arch/x86/include/asm/madt_wakeup.h            | 16 +++++++
 arch/x86/include/asm/mshyperv.h               |  3 ++
 arch/x86/kernel/Makefile                      |  1 +
 arch/x86/kernel/acpi/Makefile                 |  1 -
 arch/x86/kernel/cpu/mshyperv.c                |  2 +
 arch/x86/kernel/{acpi => }/madt_playdead.S    |  0
 arch/x86/kernel/{acpi => }/madt_wakeup.c      | 47 ++++++++++++++++++-
 drivers/hv/hv_common.c                        |  8 ++++
 13 files changed, 159 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/x86/wakeup.yaml
 create mode 100644 arch/x86/include/asm/madt_wakeup.h
 rename arch/x86/kernel/{acpi => }/madt_playdead.S (100%)
 rename arch/x86/kernel/{acpi => }/madt_wakeup.c (87%)


base-commit: 9ebdc7589cbb5c976e6c8807cbe13f263d70d32c
-- 
2.25.1


