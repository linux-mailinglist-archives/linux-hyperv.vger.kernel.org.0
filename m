Return-Path: <linux-hyperv+bounces-2842-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17AA595D9B3
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 01:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0A331F2437F
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 23:25:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98BE91D172B;
	Fri, 23 Aug 2024 23:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bIql0v+T"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC8DE1CEAAF;
	Fri, 23 Aug 2024 23:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724455440; cv=none; b=anzgomAqzQmxCbv6s1ZXM5ezLxdSQqbQkMVKmK4VW9g4x9ox9i+4ksH6Kp+WsZYcdlX4Trl2ZhCNw0M/OsyeAPHiLEaJnrF0gwCaAWc3nhpw5nzlHW6TvkJeG2IbASuH8xY2PsREfO2MjkrqcixategGuENd0l5FcUdF1hzCNa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724455440; c=relaxed/simple;
	bh=aTUjSPlr92miH9hNP8IzSsf9aHifGfF00lLQKGCBga4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MiauqthRHV8/LEIuhTKoYg3Dh6tjdkLmXrJYju5CzLeqtQpoWxjC6ke3GHJpsTP1VWGH2sL6GaxY8Cct5G/EEeBHwfxdOLPxaFVSXpgwBP4tw4btwO0qKvHKeuYLwPjG6xESdd5TsamNfMOBWGxtqurjkk25EkgSFphNoM4Y6Sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bIql0v+T; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724455439; x=1755991439;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aTUjSPlr92miH9hNP8IzSsf9aHifGfF00lLQKGCBga4=;
  b=bIql0v+T3jTMT83Vm2a80WYNVWUmvtAGR5+o585GgsXpcmiIyeu7SLt+
   XjmV+Q/C7fsQs+SyzI4MYlSyh9sDL+tqmeNrtzrD/OxEW7xj4Mh7KGmFi
   NCnFHj2fgbP7WG0MVK2g0Mrz9N+aIhZXJ770Bp6OzE9PAfRub/pU8M3ve
   pxL1MkufCKuSq6mTmBWUPRuiwEFePX4WJpXRdu/Zrn6CMCp2/WCm7afbg
   Si5bJXk6hyfPEonHBG7OfGW9oq2vsaBnpOQiPY27AMeb/YYic4EHY3s+I
   ieHyWn8L1/J0Lhv40FdJ8Kfy4ck0NmUCZjWkX9zuKeK/AOeDiemSL9nmi
   Q==;
X-CSE-ConnectionGUID: 62DVpbivRvSI636M3eNHqQ==
X-CSE-MsgGUID: n63CMfyXQ4y9qRkOSxkMDA==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="33619333"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33619333"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 16:23:55 -0700
X-CSE-ConnectionGUID: qrmX1Uw4Spq3Z0u+YjRdCA==
X-CSE-MsgGUID: fZMgbovvQMmEl3hmHT6qxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61641020"
Received: from yjiang5-dev1.sc.intel.com ([172.25.103.134])
  by fmviesa007.fm.intel.com with ESMTP; 23 Aug 2024 16:23:55 -0700
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
Subject: [PATCH v2 9/9] x86/hyperv: Use wakeup mailbox for VTL2 guests if available
Date: Fri, 23 Aug 2024 16:23:27 -0700
Message-Id: <20240823232327.2408869-10-yunhong.jiang@linux.intel.com>
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

For VTL2 hyperv guest with wakeup mailbox in device tree, don't
overwrite wakeup_secondary_cpu_64 so that the acpi_wakeup_cpu will be
used to bring up the APs.

Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
---
 arch/x86/hyperv/hv_vtl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 5829aac74f80..09a7410200ba 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -264,7 +264,8 @@ int __init hv_vtl_early_init(void)
 		panic("XSAVE has to be disabled as it is not supported by this module.\n"
 			  "Please add 'noxsave' to the kernel command line.\n");
 
-	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
+	if (!wakeup_mailbox_addr)
+		apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
 
 	return 0;
 }
-- 
2.25.1


