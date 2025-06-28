Return-Path: <linux-hyperv+bounces-6044-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CEDAEC4A2
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 05:37:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FA994A85D8
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 03:37:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3EDD2222D6;
	Sat, 28 Jun 2025 03:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AnE3GvH7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBEE7221286;
	Sat, 28 Jun 2025 03:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751081728; cv=none; b=KxFhxDF9ymrJjfW9l6KerbSMQ9pZafCBTszkTpugHh8YBeneMwwO+M3WwKjkTeqypPXlIGqnXroGCXQEMn3yMuVrVRqfF1+bRz/vo71EblOgcXJBqXm5EfL3Q0/bRRfNh4igD4tRPl9BuAsGs2RKkKbBIUpM7gyxCvFzVgV7dCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751081728; c=relaxed/simple;
	bh=T9YueJiAj+n6P/e5GV63Kzix4CrmOOaujBI5JnNGJTE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=usYf28VQ9fkkwqh4y6J/vnGtvegvV5NVYo12DjAHVIIq/u70EraERwEEYnxccTa0id/wTjE8zqLseWwelJMnPCRiVpG3P/aQyDgO++G0jTeSzOXjXpPl15cn3UFDJ24ni8nAYRr6AS03YaQR+vJYvNLCZgG1qMyStvyXP1J031A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AnE3GvH7; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751081727; x=1782617727;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=T9YueJiAj+n6P/e5GV63Kzix4CrmOOaujBI5JnNGJTE=;
  b=AnE3GvH7ccKSJm2EzdnNy2g+yJK/+INoY3Z7WcaLhKHt6TAMi9PPYA2N
   meQNzdrlUCKtzWvYWciyhxUxk3+Q8swPH7vN1zlznOUPusoFyoFAe2ZOY
   2RyiNZrtxPfpL+cczSQIJLnmTiQIrhLXKaJ1qTzhWqVztulrdbDEAJpk/
   3fA3BYlmGyxyTQJLj5prH5ZotW58ekTVMtQkDkmJL7hTTHjngEhnT6F/W
   XEY7LOURfIl8g6+S9/T0I15e5DsJqtviiss8IhjrQsB00C94DZkEbj2o/
   9mnEedDHMHBf/nOv7w0VjHEAML/gT1RrolwvgIYcb15OAhtbMbzDgJh6u
   w==;
X-CSE-ConnectionGUID: B5MojksGT+WaUwvVrD5EaQ==
X-CSE-MsgGUID: Ns8rktOYReKuyNLBhoksyg==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53335367"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="53335367"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:23 -0700
X-CSE-ConnectionGUID: WWKhVj/bQHuwpsuztdkwSg==
X-CSE-MsgGUID: uwDk4xcSTDKSAvIAx5g4Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="153141960"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:22 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Fri, 27 Jun 2025 20:35:16 -0700
Subject: [PATCH v5 10/10] x86/hyperv/vtl: Use the wakeup mailbox to boot
 secondary CPUs
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-rneri-wakeup-mailbox-v5-10-df547b1d196e@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751081737; l=1858;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=T9YueJiAj+n6P/e5GV63Kzix4CrmOOaujBI5JnNGJTE=;
 b=o+h3qNZaK9P6IrPcq4aIXzZ9PfkETm0kElx9WkN8z3CpUP1kRiZ5h2gAds/e7BEHwhMHHQ6l7
 Jj1F9ZMKI8wBRh50Iq+y0zkbQeXAhu1jAWQ8fbvjxpehhno3Ct/4q+o
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
Changes since v4:
 - None

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
index ed633a7e05b4..d82e040d9d9a 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -264,7 +264,15 @@ int __init hv_vtl_early_init(void)
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


