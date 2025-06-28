Return-Path: <linux-hyperv+bounces-6039-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B155BAEC491
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 05:36:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A2854A43ED
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 03:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D19221FF46;
	Sat, 28 Jun 2025 03:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Lg6BSzgC"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1E821CA0D;
	Sat, 28 Jun 2025 03:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751081725; cv=none; b=sKCkqwwXyd4OoCk1+wlJGbeDBcrrApt1jOxXlfkBO6AgO8Rnew+MtfNJf/wbnBHfq0qdbo93yEJlnSBp9e5DuKV+RpS81LhIVtatv9wCe55xUl7uwoO8puc7HyJV8xQRPvo6x6sbJHeWW52fpTAmeP+5eFQFHjgUn7QeFISPnwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751081725; c=relaxed/simple;
	bh=/INFvW4Qi6kj0Usw93W5OwBiOHfJrQKbA2C20+QLwds=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ZXp8ATCHGW7J25TTA/6eVJee0V41AMfP7QLkn2d7u5R3epaZW7NXg6ry+NuuXbp1vDepjgEmL7y59ga37mDlUNNTbP3RRkDrZIWIUrK/UrpziXTKw0g+Y8oohFeStxsJCpWNUPTn9lwU+drdy6QN0DsiIiPIZBk4dGKtqSXiqI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Lg6BSzgC; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751081724; x=1782617724;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=/INFvW4Qi6kj0Usw93W5OwBiOHfJrQKbA2C20+QLwds=;
  b=Lg6BSzgCQPRPJwuNbGb8VQu5nliojT6j7PzjPjkFuotrzNjfn/tsqe9x
   lykbTHh5LhSVgbOvD/5Ef8xBX+A/yX4FMUyDVv6MGMatKt5iQGsF0QvpI
   HoJRC+OAobpmhg3dTRK036CLQwfJXwla2236aw8ccuJGgZKEN4NYwtgoS
   UrsjEgbRDALcqiRj+aJcfqe2q0ct4moCSZtefzVZ9N1RUJvUG98mVCtxY
   IQL1FaYyXY7srmQ2xNUJfnDKJuTSun8r6jlXYm8n9nIpVIKBPJfVBs/3K
   lr/VGf4PpLtRLm/MQuHwNc/eYUAldpd8XJoNorLaJra92gpxv6uYzDyvE
   g==;
X-CSE-ConnectionGUID: TttKtrDVTue9U94KJGgE2Q==
X-CSE-MsgGUID: OcD7/SchRz+/AC3jCQWnEw==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53335335"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="53335335"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:21 -0700
X-CSE-ConnectionGUID: 7QUh+mIGRPyi7zf2WSQ4LQ==
X-CSE-MsgGUID: Pu09oazjTrSJam+6hyybFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="153141938"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:20 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Fri, 27 Jun 2025 20:35:11 -0700
Subject: [PATCH v5 05/10] x86/hyperv/vtl: Set real_mode_header in
 hv_vtl_init_platform()
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-rneri-wakeup-mailbox-v5-5-df547b1d196e@linux.intel.com>
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
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Thomas Gleixner <tglx@linutronix.de>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751081737; l=2018;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=s/4d/L3MtI822NkMfDzjH/6F6iBEhiXrR7cqJZV+mls=;
 b=C7u4HhtenpEjBNMxz4L9ZCpzbnjUEXumSps9XJKGY6Cpe0b6CnNydI0qDTrcLz9t5bP4ZCUil
 fG1u5eYKJKdBxXWlgY+F2mbgftJVnmF5fQprHn353OP7y1aL818mnK6
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

From: Yunhong Jiang <yunhong.jiang@linux.intel.com>

Hyper-V VTL clears x86_platform.realmode_{init(), reserve()} in
hv_vtl_platform_init() whereas it sets real_mode_header later in
hv_vtl_early_init(). There is no need to deal with the real mode memory
in two places: x86_platform.realmode_init() is invoked much later via an
early_initcall.

Set real_mode_header in hv_vtl_init_platform() to keep all code dealing
with memory for the real mode trampoline in one place. Besides making the
code more readable, it prepares it for a subsequent changeset in which the
behavior needs to change to support Hyper-V VTL guests in TDX environment.

Reviewed-by: Michael Kelley <mhklinux@outlook.com>
Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v4:
 - None

Changes since v3:
 - Added Reviewed-by tag from Michael. Thanks!

Changes since v2:
 - Edited the commit message for clarity.

Changes since v1:
 - Introduced this patch.
---
 arch/x86/hyperv/hv_vtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 042e8712d8de..e10b63b7a49f 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -65,6 +65,7 @@ void __init hv_vtl_init_platform(void)
 
 	x86_platform.realmode_reserve = x86_init_noop;
 	x86_platform.realmode_init = x86_init_noop;
+	real_mode_header = &hv_vtl_real_mode_header;
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
 	x86_init.resources.probe_roms = x86_init_noop;
@@ -244,7 +245,6 @@ int __init hv_vtl_early_init(void)
 		panic("XSAVE has to be disabled as it is not supported by this module.\n"
 			  "Please add 'noxsave' to the kernel command line.\n");
 
-	real_mode_header = &hv_vtl_real_mode_header;
 	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
 
 	return 0;

-- 
2.43.0


