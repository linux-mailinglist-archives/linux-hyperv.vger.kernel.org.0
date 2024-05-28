Return-Path: <linux-hyperv+bounces-2237-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 051AC8D17CA
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 11:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 988911F24E90
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 May 2024 09:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E972816B734;
	Tue, 28 May 2024 09:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MxqgJFHn"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB7D16D9C8;
	Tue, 28 May 2024 09:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716890156; cv=none; b=h+uZWPfWL0ap3YxOu++br/ZzS79HgV4qc42ajkSMUkUIbtkVnPFYDyivUeBBvjcrGDDWNK++m0AyacryMEsyIFElDWRPfEYcP+xDRf2VH9rSTD99OlsQAfMnYrjW6391TLTQm8EDuQJsTxGMrZfD2K8kDGktQGzCCWg1O9aTbxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716890156; c=relaxed/simple;
	bh=ggOF5UziCfkAXFWyu9AjZBbe749R0vOnMDQfmgr6Dec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=osAY1S9zuKJcycRtRjaV16c/d9RltTIQSlyUTpSEraIPKmvdDIe+b87mjXjR/PxWpUZiz+Pem+8+kR6Mdn78WBDbRqQ2ssdJ4gn481xYgO54rA1d9TS10a/5KmpJVCoV9VvwQeGZQVoKkeLAOac2qGDvAeHUyJ3lF+PN5jcbSPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.helo=mgamail.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MxqgJFHn; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mgamail.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716890156; x=1748426156;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ggOF5UziCfkAXFWyu9AjZBbe749R0vOnMDQfmgr6Dec=;
  b=MxqgJFHnLtBBREofd9QtLC4uJL4QWYz/YH142ejkWEhLDHKOVnZG4vE1
   BmUbJaDlzBgiJMIdBoHLlNvqBSDeylM+FHpQOF8SwNanmQn+Hbtq8US73
   fnwdshO0Vqy7sIORqi+j2BPwBoPWPa+Rx4lAmWZph5xAPghtZAvA7OxO7
   cUWMAtgHNwkqtOuBE1SZb2ZJJAVHXU6qPeBLmDObSVM4RG4z0YlxAotgj
   GWCGux3+8AqulQYb1kzwU2R8dVjJiGIg3DPYrlbUD+pB1XVBrrft13u1f
   H1onWvrQ/MV67O0dByaBnVDTXwb+BISRVXt3aS/edu/7Gj7R+hZjocP/g
   w==;
X-CSE-ConnectionGUID: 9DFki978SnqCXMdo8TLCwA==
X-CSE-MsgGUID: Rm2i719qQtWVkxc5eNH+TA==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13172186"
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="13172186"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 02:55:41 -0700
X-CSE-ConnectionGUID: J1NSLEg5Q4us7sdnT0LpJA==
X-CSE-MsgGUID: lwOD5fg7R4aE5sJChWCTtw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,194,1712646000"; 
   d="scan'208";a="39984750"
Received: from black.fi.intel.com ([10.237.72.28])
  by orviesa004.jf.intel.com with ESMTP; 28 May 2024 02:55:34 -0700
Received: by black.fi.intel.com (Postfix, from userid 1000)
	id AA54977C; Tue, 28 May 2024 12:55:26 +0300 (EEST)
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
	Tao Liu <ltao@redhat.com>
Subject: [PATCHv11 09/19] x86/tdx: Account shared memory
Date: Tue, 28 May 2024 12:55:12 +0300
Message-ID: <20240528095522.509667-10-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
References: <20240528095522.509667-1-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel will convert all shared memory back to private during kexec.
The direct mapping page tables will provide information on which memory
is shared.

It is extremely important to convert all shared memory. If a page is
missed, it will cause the second kernel to crash when it accesses it.

Keep track of the number of shared pages. This will allow for
cross-checking against the shared information in the direct mapping and
reporting if the shared bit is lost.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
---
 arch/x86/coco/tdx/tdx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 26fa47db5782..979891e97d83 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -38,6 +38,8 @@
 
 #define TDREPORT_SUBTYPE_0	0
 
+static atomic_long_t nr_shared;
+
 /* Called from __tdx_hypercall() for unrecoverable failure */
 noinstr void __noreturn __tdx_hypercall_failed(void)
 {
@@ -821,6 +823,11 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	if (!enc && !tdx_enc_status_changed(vaddr, numpages, enc))
 		return -EIO;
 
+	if (enc)
+		atomic_long_sub(numpages, &nr_shared);
+	else
+		atomic_long_add(numpages, &nr_shared);
+
 	return 0;
 }
 
-- 
2.43.0


