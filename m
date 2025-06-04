Return-Path: <linux-hyperv+bounces-5739-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43153ACD0A7
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 02:19:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31C42176F1F
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 00:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 735C815687D;
	Wed,  4 Jun 2025 00:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="S1tWAsgK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B622286338;
	Wed,  4 Jun 2025 00:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748996289; cv=none; b=l5r7TdfU5KN8AIFK2CUIDmcaWseazSxnxl6WBzOLV1E7343aXRMqUp0mgFi22gy77CsrbAq7ozBZoQ+pHQUxwr/LZSohqYkDJWlRdqFXKXhh7qW9avkT4ww2FfOkoRcXD356U1dYSt8nExe6cCbbyBIwibJeNiHu+pWXCaI9y1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748996289; c=relaxed/simple;
	bh=YMzG5+AadCckxPwzHaVnWjL9Y7atDKDPkNrr/M1BYpQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U+STvnulgPklDf0F4mLzwBPpeD8iMsqPQP+c/FIY0wW2XKiAWQnUdGuuSoxZZ/IPPheAVr0xPvwDgx/c9/XzTKyGxnFEq2eD6nmNELGmyjo7jZL4+HcCiFi0lD+rGolqH2c1u3UPsstReLWvGVtZ2URV80/+W0eMvbXPeArdgy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=S1tWAsgK; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748996288; x=1780532288;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=YMzG5+AadCckxPwzHaVnWjL9Y7atDKDPkNrr/M1BYpQ=;
  b=S1tWAsgK04q3WWG6yx5I1kaI3yDrnO7/+YD7NrdtdtWKfwwnJLfHHG8V
   +kAwecBz3Cb3e05Eaz8Mau4q8culDiIFbVAsR4atsGvlglOopNiWdWOJo
   6p+F1uieCj0TP926b1lSPEut5bQQlrLXne9EwG3ZziR5f9XChk4olDGng
   Vc06WV6drC5tQq0SMxY9LEeEQ1bIomL+4/ai9orK1JjGopRciVK3uSbJO
   mvA/JtI0L7Lm0HpmvGs/nas4KzVc36qb7i3JdlIxNZ3wnHj/wiwQHBSXl
   qKUhJfIWnxm/vpUTF9oSjgrnmrW9/O7TiJu+6YU/0hlqlJFbvBtVTNa6H
   g==;
X-CSE-ConnectionGUID: tyX2Q5dWRwaaWZ0o+zE6kQ==
X-CSE-MsgGUID: e8/VatTDSzyHRMJ24k8qEw==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62112974"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="62112974"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:18:02 -0700
X-CSE-ConnectionGUID: +0ZBoGqeTXaj2BQXnK6DtQ==
X-CSE-MsgGUID: A4Uf1QcFSAm91jlrxnwHeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="149904486"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:18:01 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Tue, 03 Jun 2025 17:15:22 -0700
Subject: [PATCH v4 10/10] x86/hyperv/vtl: Use the wakeup mailbox to boot
 secondary CPUs
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-rneri-wakeup-mailbox-v4-10-d533272b7232@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748996287; l=1828;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=YMzG5+AadCckxPwzHaVnWjL9Y7atDKDPkNrr/M1BYpQ=;
 b=AQX0mRFsZ9dxNlLT540Y7TjjN7bcbmpsiw30cxH6/zwuFQYEkgAnS0GiAk8Dh5iKMQ9me49xK
 sZKwsKJ+V7rDO57ChwsHvsuwtp/BntEe8NCaEPcH4LfK3UiIp3PYsuZ
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

The hypervisor is an untrusted entity for TDX guests. It cannot be used
to boot secondary CPUs. The function hv_vtl_wakeup_secondary_cpu() cannot
be used.

Instead, the virtual firmware boots the secondary CPUs and places them in
a state to transfer control to the kernel using the wakeup mailbox.

The kernel updates the APIC callback wakeup_secondary_cpu_64() to use
the mailbox if detected early during boot (enumerated via either an ACPI
table or a DeviceTree node).

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v3:
 - Added Reviewed-by tag from Michael. Thanks!

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
index 995d1de7a9be..f3d4f06d1f17 100644
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


