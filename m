Return-Path: <linux-hyperv+bounces-1583-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D648F85EEF4
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Feb 2024 03:11:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A1BB224BB
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Feb 2024 02:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D523B1754E;
	Thu, 22 Feb 2024 02:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QreDpfsD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257DD14016;
	Thu, 22 Feb 2024 02:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567845; cv=none; b=AKRsZecWqv1X6eQIRKp3U5U9wQNjCCYW7n8w8GCaaJHTG5bB+AA8z21eykIETTI8HCpB1AJ6WZIxlA7MXag4bJZW1PDCsGSfznPch6tzHJXtrlcXEidmsbyQUlIFH+WrsDMVT+AIcvz4ZudyK9vighKGISeN5MtQqlV/m3a+OmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567845; c=relaxed/simple;
	bh=mjD62jwPXXL/iF50Sop2guy61uKievhhSBMu62CiiMY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aQw0937vKJNQgiFoM5hZoGivF7sORVDZbHcJJMoS4QR3iRPjXoj8gh2/yH3GihYQxUqoqmtFrUR7jBmRE0nVfuJx3sztRH37g0HThV+NT7h5l/agJkHeWsEGGq5XCIaTbPgTW3IXifVt2hFzdt8oAQck3YSdS8A1KPYtdrUtydc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QreDpfsD; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708567844; x=1740103844;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mjD62jwPXXL/iF50Sop2guy61uKievhhSBMu62CiiMY=;
  b=QreDpfsDU7aLykDX1qtFMC1mLz+YR0iu1wJNDpw6aBeQp8x9MyqiBHBI
   vSttIIJMrPgBJ3xVJ9ldh2kWSBN5HrevIIcu39tU4+eJqxNwHwo70LyN2
   ETRapGt0MuGBvew3u0W3XFz+fZI8ck8xXnfpnqjHuS/wmYw8Tp2fLW2f3
   r+3ot0eJmzBxUVF+ZJpDHBETyzj+S9kzZ55BIag98j7ntRR7x4Mbj+A3i
   9WoFQ9cE1rMXA0RKz3sqsr6xKf5i6UsAMKRLR60IwxRzwZ1IdYSqWUIWM
   uaWnv5r5lMVum1xNPACzpN9QMnSe8AXbT0b4/Pkr8M6Ryt4VEOPUDb1En
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="2641015"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="2641015"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 18:10:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="5226886"
Received: from nlokaya-mobl1.amr.corp.intel.com (HELO rpedgeco-desk4.intel.com) ([10.209.62.65])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 18:10:41 -0800
From: Rick Edgecombe <rick.p.edgecombe@intel.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	mhklinux@outlook.com,
	linux-hyperv@vger.kernel.org,
	gregkh@linuxfoundation.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	kirill.shutemov@linux.intel.com,
	dave.hansen@linux.intel.com,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	elena.reshetova@intel.com,
	rick.p.edgecombe@intel.com
Subject: [RFC RFT PATCH 1/4] hv: Leak pages if set_memory_encrypted() fails
Date: Wed, 21 Feb 2024 18:10:03 -0800
Message-Id: <20240222021006.2279329-2-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
References: <20240222021006.2279329-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On TDX it is possible for the untrusted host to cause
set_memory_encrypted() or set_memory_decrypted() to fail such that an
error is returned and the resulting memory is shared. Callers need to take
care to handle these errors to avoid returning decrypted (shared) memory to
the page allocator, which could lead to functional or security issues.

Hyperv could free decrypted/shared pages if set_memory_encrypted() fails.
Leak the pages if this happens.

Only compile tested.

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 drivers/hv/connection.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index 3cabeeabb1ca..e39493421bbb 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -315,6 +315,7 @@ int vmbus_connect(void)
 
 void vmbus_disconnect(void)
 {
+	int ret;
 	/*
 	 * First send the unload request to the host.
 	 */
@@ -337,11 +338,13 @@ void vmbus_disconnect(void)
 		vmbus_connection.int_page = NULL;
 	}
 
-	set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[0], 1);
-	set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[1], 1);
+	ret = set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[0], 1);
+	ret |= set_memory_encrypted((unsigned long)vmbus_connection.monitor_pages[1], 1);
 
-	hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
-	hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
+	if (!ret) {
+		hv_free_hyperv_page(vmbus_connection.monitor_pages[0]);
+		hv_free_hyperv_page(vmbus_connection.monitor_pages[1]);
+	}
 	vmbus_connection.monitor_pages[0] = NULL;
 	vmbus_connection.monitor_pages[1] = NULL;
 }
-- 
2.34.1


