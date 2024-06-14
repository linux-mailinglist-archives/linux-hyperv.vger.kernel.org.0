Return-Path: <linux-hyperv+bounces-2432-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2A8908920
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 12:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D12B01C26B5D
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Jun 2024 10:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3DCB19DF77;
	Fri, 14 Jun 2024 09:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="n+uArnss"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397FC19D080;
	Fri, 14 Jun 2024 09:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718359172; cv=none; b=oUZKekVRoBXiKgCdLMxjp0HWNXoUUQtzpwudXfJSx2piHB/8JWb54JS7pfENUmsphp0S2EDOXVnSj+nPXhu988fDWXIGAO9wdiB4Dt03NHQS5bLEnVOOV65dffC4jRcrMaVSJunm74V0e1bB1w7EwbTlzDcX/SpX/DVRgBo7p04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718359172; c=relaxed/simple;
	bh=HwN3E9+jHttKTDhoTNFYma+HMbcshBlbCm33137SzQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cpmgS6ZRmBKYLl2d/N7aHGE1WN+KFiVZ94uuZ/Ht05/XEpLgzvPUS5L4oLbtiSGP0GaoWvRvHWryfPJKgEs5M3y1BZVPCHAQof6+yHuUA4FiBPEu5AVVUcZONBpo01PcuVueylcW62pRhX3Wx09UhDkaDceoD/ZD2lIM19+5RoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=n+uArnss; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718359171; x=1749895171;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HwN3E9+jHttKTDhoTNFYma+HMbcshBlbCm33137SzQU=;
  b=n+uArnss9Xb+m1gpuTuJQ8iXyE+KkfLO4b55FhiQ2+lxjpyA6JZfX5ff
   0nN+OJVxx8mDtsMEg53dtWj4R20lwzU8SBZgqxmwalNcMpzaSK8E5JvCl
   tE1EuXqzQYBwj7qE2JhfHkxGGegechPm6n1hP5+bGHDUhheHNFR02kq/D
   n6+hH63hohLUuOSszRnFevnDC0JTJoivL7w+32VYUjRcs/YdIQ9SXIIyR
   H26ynL+pOY+f63bZiIsrxsq+Hw2U4xcxCaFjrZhifupXz9yd3TmniXuMT
   10PabNJn63Rd+fhGuwrIIsEqMYKYC6R95/UdutJdQNGx370Mwi7BA22G1
   Q==;
X-CSE-ConnectionGUID: xbF/O9lUR+OEmg6RHzAYJQ==
X-CSE-MsgGUID: M9jtv8AiRbWZ98b2kQdTbw==
X-IronPort-AV: E=McAfee;i="6700,10204,11102"; a="12072493"
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="12072493"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2024 02:59:29 -0700
X-CSE-ConnectionGUID: G+tz7pLBTY6yGEWRFRf04w==
X-CSE-MsgGUID: NwlEkHzrRIKqL4DT6nmJSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,237,1712646000"; 
   d="scan'208";a="44995910"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmviesa004.fm.intel.com with ESMTP; 14 Jun 2024 02:59:23 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id 71DC62B69; Fri, 14 Jun 2024 12:59:09 +0300 (EEST)
From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To: Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Elena Reshetova <elena.reshetova@intel.com>,
	Jun Nakajima <jun.nakajima@intel.com>,
	Rick Edgecombe  <rick.p.edgecombe@intel.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	"Kalra, Ashish" <ashish.kalra@amd.com>,
	Sean Christopherson <seanjc@google.com>,
	"Huang, Kai" <kai.huang@intel.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Baoquan He <bhe@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	kexec@lists.infradead.org,
	linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Tao Liu <ltao@redhat.com>
Subject: [PATCHv12 19/19] ACPI: tables: Print MULTIPROC_WAKEUP when MADT is parsed
Date: Fri, 14 Jun 2024 12:59:04 +0300
Message-ID: <20240614095904.1345461-20-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When MADT is parsed, print MULTIPROC_WAKEUP information:

ACPI: MP Wakeup (version[1], mailbox[0x7fffd000], reset[0x7fffe068])

This debug information will be very helpful during bring up.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Acked-by: Kai Huang <kai.huang@intel.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
---
 drivers/acpi/tables.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index b976e5fc3fbc..9e1b01c35070 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -198,6 +198,20 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
 		}
 		break;
 
+	case ACPI_MADT_TYPE_MULTIPROC_WAKEUP:
+		{
+			struct acpi_madt_multiproc_wakeup *p =
+				(struct acpi_madt_multiproc_wakeup *)header;
+			u64 reset_vector = 0;
+
+			if (p->version >= ACPI_MADT_MP_WAKEUP_VERSION_V1)
+				reset_vector = p->reset_vector;
+
+			pr_debug("MP Wakeup (version[%d], mailbox[%#llx], reset[%#llx])\n",
+				 p->version, p->mailbox_address, reset_vector);
+		}
+		break;
+
 	case ACPI_MADT_TYPE_CORE_PIC:
 		{
 			struct acpi_madt_core_pic *p = (struct acpi_madt_core_pic *)header;
-- 
2.43.0


