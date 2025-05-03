Return-Path: <linux-hyperv+bounces-5334-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E5CFAA8233
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 21:11:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE5487AFFBB
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 19:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB5F828033C;
	Sat,  3 May 2025 19:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XHa8jKLZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28AD227FD4D;
	Sat,  3 May 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299418; cv=none; b=AMQfeaXmv8/hZi2ubaGeUaFV12jvIOhSvK0YWS0EyEK+zCXBKZpRtOM0eg+XTD4zXIOiJr6qq3iIl6fV3yZQSoghk/J+NZzddbziQeMwDmViFvS71MHvn2Uq+ORqiWx3jko+B7y1aPFulEIPP5J7+xhGaJBPJ8EwMcU/QesWk+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299418; c=relaxed/simple;
	bh=j/9mIAvlEOOCsyHjMviwOwVmvkwhQtG1H2/lP07dXF0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=bGpxhAEICoX51qY9sElJgdnEhuGYpjsiykkYEYyKCvVt6R++RUUC3QnuHmHDZTXWK8BW7dZmGNzB9MKaa1Iuva7vpSOo450Ipr15jrj//9q1eZoZ/30yFgs5hrYPuI7md8vsll4ak/aecM+Wtof3I50+JVZXkbDchhk9yVDRL2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XHa8jKLZ; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746299417; x=1777835417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=j/9mIAvlEOOCsyHjMviwOwVmvkwhQtG1H2/lP07dXF0=;
  b=XHa8jKLZlcpVJpS1wZYp/hPEyTawZ3An9zreYHqD6F/eC/fb6SGhUqWY
   lML8eK4AcjGIB/nkuqW9UhaveX24c2V7Nlgw7JHBQ7caGGoUZEbp2Rwwy
   FeZsWS7LW3bu2VqhPO+CKcDiciBGWuBXwrrFMJD1H1T8x0C5ESyzEy5lR
   ceNkAwhLkRxVhAE/pXy+Pxoitue1TMk7VYilkJjXdg1zTPQX+DQU6f9l/
   EgrWMYLvswkl4NrYWnybBVvTIq6zq/+OevCFqck6ADmVmiyf4wCaZccYH
   VS9ujQmIujlvaqnFq7DoSE2aQMu0ibrDLoH9k5YQWNE6i8pUrlI4XygqS
   g==;
X-CSE-ConnectionGUID: uR+7PFPxRgKSZ6rxs8i89A==
X-CSE-MsgGUID: scyx+9hOTyuqkyz7LxSpsA==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="48095640"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="48095640"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:10:14 -0700
X-CSE-ConnectionGUID: sR3gkVVvQJiLJ2mmXdxwKw==
X-CSE-MsgGUID: 2jkfZr56T7uFDQMdwCZpaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="140046107"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP; 03 May 2025 12:10:13 -0700
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
Subject: [PATCH v3 08/13] x86/hyperv/vtl: Set real_mode_header in hv_vtl_init_platform()
Date: Sat,  3 May 2025 12:15:10 -0700
Message-Id: <20250503191515.24041-9-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

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

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v2:
 - Edited the commit message for clarity.

Changes since v1:
 - Introduced this patch.
---
 arch/x86/hyperv/hv_vtl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index 4580936dcb03..6bd183ee484f 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -60,6 +60,7 @@ void __init hv_vtl_init_platform(void)
 
 	x86_platform.realmode_reserve = x86_init_noop;
 	x86_platform.realmode_init = x86_init_noop;
+	real_mode_header = &hv_vtl_real_mode_header;
 	x86_init.irqs.pre_vector_init = x86_init_noop;
 	x86_init.timers.timer_init = x86_init_noop;
 	x86_init.resources.probe_roms = x86_init_noop;
@@ -279,7 +280,6 @@ int __init hv_vtl_early_init(void)
 		panic("XSAVE has to be disabled as it is not supported by this module.\n"
 			  "Please add 'noxsave' to the kernel command line.\n");
 
-	real_mode_header = &hv_vtl_real_mode_header;
 	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
 
 	return 0;
-- 
2.43.0


