Return-Path: <linux-hyperv+bounces-2739-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DD88949B25
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 00:14:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E90E7B25317
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 Aug 2024 22:14:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B0D17921D;
	Tue,  6 Aug 2024 22:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cieWg0aI"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0629D178381;
	Tue,  6 Aug 2024 22:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722982390; cv=none; b=hNpkc36GrkBHfjd/ZdWFEsJYLBX6yYARNFjeSapwc8XvimUb2+L70/MDI3x10WUgfUTSVzIDa0ftiCFDb9YUSHQtXMT3mr9M3Hbonrh3Qwd1EyBfaw6EWQ7682MoCxyb22yU/u0DD+JxWUwCva2WDYeRnrH+aWUD7oYIoqt/Ke8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722982390; c=relaxed/simple;
	bh=cLcQPUSyW6zpKPEpULWnl+A4X3BrwKfXFamHYe2uC7A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KDTJeJ8WpvSLMKMoHoLUzkhL23BfsU24vDsMiq+FtFZHseP9CcjtA4OEKJA85mYBU8g1jAxVJNpVbUWmcwxwTywyv8RmdhJDw5lmp0XaZfirBO04GaW0GcCOkrzoz5zKXEzfuvtVbIZ7ZysmorBEb1AjtjNfEWrcXwDOpU8Fk8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cieWg0aI; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722982389; x=1754518389;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cLcQPUSyW6zpKPEpULWnl+A4X3BrwKfXFamHYe2uC7A=;
  b=cieWg0aIzjMLk01YEz4u7NnV7RbuG0oHNxH7WCVAygwFRpVJw0fBXxDL
   +Hho9D6Z7mDAp9uCOY1fZPDMFEixrzhvaCmBQ0YBlDGBkEGnPptsbSy06
   QD7m/FxAUi0HXlkOEnEZCp6URAn86Zk/Lrc4bsOYQaYKhyRtTMla/d/ht
   LnHn+ivHAphkR/CPRC2L2BhkVEEOXjT9tH0XTgS64igvfLIPfUsBjz+Us
   DYYgw+UD2cqx82SI7WGWmiZWm9C+wU9UR5K3WhHIlk5CDqKXiZ4yoGK3J
   kpLqyRZTnDMXaOgQQb0h+Cu6P7NZx1FEjCp7SdinQRUL5hSAav1WbHKNp
   w==;
X-CSE-ConnectionGUID: taUgbzgBSwqZCxDgDeVV+Q==
X-CSE-MsgGUID: cLQs4eK3QIOMv8R3ZZzdFA==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38534422"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38534422"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 15:13:09 -0700
X-CSE-ConnectionGUID: 1ddOgj/xQqe50JmXrzya0Q==
X-CSE-MsgGUID: jVbftUq8SVq6ntpXp5x24g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="61465671"
Received: from yjiang5-dev1.sc.intel.com ([172.25.103.134])
  by orviesa003.jf.intel.com with ESMTP; 06 Aug 2024 15:13:08 -0700
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
Subject: [PATCH 7/7] x86/hyperv: Use the ACPI wakeup mailbox for VTL2 guests when available
Date: Tue,  6 Aug 2024 15:12:37 -0700
Message-Id: <20240806221237.1634126-8-yunhong.jiang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
References: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The VTL2 in a TDX guest can boot utilizing the device tree instead of
ACPI tables. When the ACPI wakeup mailbox is present in device tree,
don't overwrite wakeup_secondary_cpu_64 so that the acpi_wakeup_cpu will
be used to bring up the APs.

Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
---
 arch/x86/hyperv/hv_vtl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/hyperv/hv_vtl.c b/arch/x86/hyperv/hv_vtl.c
index a1eb5548bd4d..132d05fd9136 100644
--- a/arch/x86/hyperv/hv_vtl.c
+++ b/arch/x86/hyperv/hv_vtl.c
@@ -276,9 +276,10 @@ int __init hv_vtl_early_init(void)
 		panic("XSAVE has to be disabled as it is not supported by this module.\n"
 			  "Please add 'noxsave' to the kernel command line.\n");
 
-	if (!wakeup_mailbox_addr)
+	if (!wakeup_mailbox_addr) {
 		real_mode_header = &hv_vtl_real_mode_header;
-	apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
+		apic_update_callback(wakeup_secondary_cpu_64, hv_vtl_wakeup_secondary_cpu);
+	}
 
 	return 0;
 }
-- 
2.25.1


