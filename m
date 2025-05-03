Return-Path: <linux-hyperv+bounces-5339-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C19AA8245
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 21:12:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 377D91B6232C
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 19:12:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ACEF281538;
	Sat,  3 May 2025 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZO5uDaW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A887280CE7;
	Sat,  3 May 2025 19:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299422; cv=none; b=XnDtHqvsDjKRFXxXRK8wL7h5LHMwN3LCDQUJrp5aMdh1tmwBrpfooZqHGPTiSeQNnbiIOMfzsD8gt2jtVBkuhww3hE9iKdQ4WccV4S/wPkiiRDPr/wcfaZMzB9yX8k9Obcn/etsdz3gj0JT1wdU8hUljMBaKipvmEayFjJ+hC9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299422; c=relaxed/simple;
	bh=ETQow3I3jVQQbfoDkbZ6LD9Df4riH/sjwHO2fajMiE0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=LKIehVKFQZ53rhzP9rGhvJAnpPewrsW39L8UXTuz/hqHcEEn7/VUnOrn7eIxrrEmb+q2AfrrckLuEGg5U4p4lg7ZdfUdwIdCtHsh8OVzqAQ2DSfEuVo/PwEUODe2gc/NqrRDkPND+Amr6rBWOrOl5yb8BUUEpbfFyZCctscMgEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZO5uDaW; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746299420; x=1777835420;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=ETQow3I3jVQQbfoDkbZ6LD9Df4riH/sjwHO2fajMiE0=;
  b=aZO5uDaWGvdggdlPNJFlXva1la+oZ+B1/6k3mpn3mrlzNG/Rv4yd6OVX
   CRHu5wF2mDlYDu1vlVKK7ptgxOEEtxHuyqUbMUtLRXiTSWyiuruEnM534
   nkI09cQFtVJpFtBSLr0FS919g8orUgJH0FPlwMl2eemyZxoFJoXgVS1PR
   UxZHw7+kAJjThbO0kyFMbThP1J3i6QxNBrrc00PcyscxWfzzQupPErY+y
   DYxtT+h1Q5KR/PaF6jPY0GSZib39GJVo4lsKFb2rGddzKEK5G4Qgjrhsk
   REHZCWjuTFGWyUNVGdR0f9rQWQVCu4eMWRymC196DPqjfhUwZCSVHYUeF
   A==;
X-CSE-ConnectionGUID: J4F2she8Tf+h4phYEaiVcQ==
X-CSE-MsgGUID: 9MM4zJbWSNCN2ORaTZ8iMQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="48095666"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="48095666"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:10:17 -0700
X-CSE-ConnectionGUID: Cg2HYCxrS3K8KM6RbaS3ew==
X-CSE-MsgGUID: AOkYwIMJRhiXoovjmJrE9g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="140046125"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP; 03 May 2025 12:10:16 -0700
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
Subject: [PATCH v3 13/13] x86/hyperv/vtl: Use the wakeup mailbox to boot secondary CPUs
Date: Sat,  3 May 2025 12:15:15 -0700
Message-Id: <20250503191515.24041-14-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

The hypervisor is an untrusted entity for TDX guests. It cannot be used
to boot secondary CPUs. The function hv_vtl_wakeup_secondary_cpu() cannot
be used.

Instead, the virtual firmware boots the secondary CPUs and places them in
a state to transfer control to the kernel using the wakeup mailbox.

The kernel updates the APIC callback wakeup_secondary_cpu_64() to use
the mailbox if detected early during boot (enumerated via either an ACPI
table or a DeviceTree node).

Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 - Unconditionally use the wakeup mailbox in a TDX confidential VM.
   (Michael).
 - Edited the commit message for clarity.

Changes since v1:
 - None
---
 arch/x86/hyperv/hv_vtl.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index cd48bedd21f0..30a5a0c156c1 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -299,7 +299,15 @@ int __init hv_vtl_early_init(void)
 		panic("XSAVE has to be disabled as it is not supported by this module.\n"
 			  "Please add 'noxsave' to the kernel command line.\n");
 
-	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
+	/*
+	 * TDX confidential VMs do not trust the hypervisor and cannot use it to
+	 * boot secondary CPUs. Instead, they will be booted using the wakeup
+	 * mailbox if detected during boot. See setup_arch().
+	 *
+	 * There is no paravisor present if we are here.
+	 */
+	if (!hv_isolation_type_tdx())
+		apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
 
 	return 0;
 }
-- 
2.43.0


