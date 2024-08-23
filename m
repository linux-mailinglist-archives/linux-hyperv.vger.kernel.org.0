Return-Path: <linux-hyperv+bounces-2841-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A91495D9B1
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 01:25:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 132D4B234CE
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 23:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40A641D04AE;
	Fri, 23 Aug 2024 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YYqGIcD1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70BD01CE6E8;
	Fri, 23 Aug 2024 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724455440; cv=none; b=B9wOen7kUewCGB4kPLdiuTN8FNypev0QPychQyEy5yqayM53yIM8oiRx1zy/91F6uVKzIlnYmU6yqY1s+hcT1VZbnAPEuukLJVlH8Zxj73UAXbxCzmr7R9RVpYWAixO9mIO3rXxobtrVv18P/vvqDuddMKBjqH4/ThDVPnAHZdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724455440; c=relaxed/simple;
	bh=x595JM1qMa7hWjcDHZCj/akxq3UF/CzHO34iSh2LbhU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZJUE3IZ+bQ083CxJt7HKMCOoM8TYVm3ikvtY0/PNBc6oBhcEiWwBtC0zOG/HQ4jkCS9IOeuzW6ltObUC5RmRRYK8847QQ+rRGG3XeG4vzaamVbISA+Zp8GNz75Sd6dIqB0VHu3HkwNhuslZ5YJ7UJIqSIqfm6l6OyrKACFMrtlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YYqGIcD1; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724455439; x=1755991439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=x595JM1qMa7hWjcDHZCj/akxq3UF/CzHO34iSh2LbhU=;
  b=YYqGIcD1zw7PstSGOLFwnoJPUQHH2PEy6AmcMOSTiO62y2do0Fhwt+7W
   JJRyEnboevFZk1PDifTf+F4AP528AKAvEVr0foY3WcvR6dv02vf8uh2Ob
   sYymaH2S2aCyJpl18s99n9A2JXSSDRiYtN217ScF+5bEf4D01FCPzxhvP
   4JUdqltGzA+M0+GgcmHzZ6AW/MCYtKBH3nBx699qxt4sPOcjV+YjeRUsM
   HVY3Fn7JZhXn4TJlGqjT3ZYdM7ncU/hDquvvI39nOLyK/RrKuyeT3PrZI
   OdtRoUN05mnPRdApH/7HhN2N+JqWKxh/pHQx36bvKndrx+X8DrdEFYf5J
   w==;
X-CSE-ConnectionGUID: iHW8xetmRaO/u6ZNkUzc/g==
X-CSE-MsgGUID: tDXS6VnPTOen5DzY/y9yTw==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="33619326"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33619326"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 16:23:55 -0700
X-CSE-ConnectionGUID: 27Tc/XVzRsOcWxDsNEhyBg==
X-CSE-MsgGUID: EJXCXD/1QCy+08AaNLg9kQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61641019"
Received: from yjiang5-dev1.sc.intel.com ([172.25.103.134])
  by fmviesa007.fm.intel.com with ESMTP; 23 Aug 2024 16:23:54 -0700
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
Subject: [PATCH v2 8/9] x86/hyperv: Set realmode_limit to 4G for VTL2 TDX guest
Date: Fri, 23 Aug 2024 16:23:26 -0700
Message-Id: <20240823232327.2408869-9-yunhong.jiang@linux.intel.com>
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

The VTL2 TDX guest may have no sub-1M memory available, but it needs to
invoke trampoline_start64 to wake up the APs through the wakeup mailbox
mechanism. Set realmode_limit to 4G for the VTL2 TDX guest, so that
reserve_real_mode allocae memory under 4G.

Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
---
 arch/x86/hyperv/hv_vtl.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index e5aa2688cdd0..5829aac74f80 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -40,11 +40,15 @@ void __init hv_vtl_init_platform(void)
 {
 	pr_info("Linux runs in Hyper-V Virtual Trust Level\n");
 
-	if (hv_isolation_type_tdx())
+	if (hv_isolation_type_tdx()) {
 		x86_platform.hyper.is_private_mmio = hv_is_private_mmio_tdx;
-	x86_platform.realmode_reserve = x86_init_noop;
-	x86_platform.realmode_init = x86_init_noop;
-	real_mode_header = &hv_vtl_real_mode_header;
+		x86_init.resources.realmode_limit = SZ_4G;
+		x86_init.resources.reserve_bios = 0;
+	} else {
+		x86_platform.realmode_reserve = x86_init_noop;
+		x86_platform.realmode_init = x86_init_noop;
+		real_mode_header = &hv_vtl_real_mode_header;
+	}
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
 
-- 
2.25.1


