Return-Path: <linux-hyperv+bounces-424-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE7B7B6127
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 08:54:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 14E0A1C20506
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 06:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEA7CA77;
	Tue,  3 Oct 2023 06:54:48 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE476D263
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Oct 2023 06:54:45 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B51F3DD;
	Mon,  2 Oct 2023 23:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696316083; x=1727852083;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i5VPM7WJy8QX3AfDJPn+y86GzsjxiQoeNBcvUeRwUoQ=;
  b=OwLVC44mlD5Q1qhL+d8Y/7ROid0I25+bOxRoDRoYqNLWsX4i5CWCn9ML
   /2mkwuBYUSH6TxanccwTrKcCNLJ6f1mysaaIQP7CPO376WixYASU0uUvX
   7/4sFzuliY1d332HHpgRYSvwVPq3DayKfMvg5U3J8m+F0J7leENrUs8zJ
   I66xV4eIreZ+MLntiGc84ehOTmWvvqYSG+FMy7D75NqDBWt8GSp6aPmPW
   jynoYsf7Z4fD6vJanSCqwEd0DNGrz4xmADBVFFwo3ESsjEqZx2eiwDFYN
   ybxt/wQG3vX1Lv1psarS/D+OsTwVm+cdwEr4AjsSvWVGt/qtGLTwVLabs
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="367858027"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="367858027"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 23:54:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1081900928"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="1081900928"
Received: from unknown (HELO fred..) ([172.25.112.68])
  by fmsmga005.fm.intel.com with ESMTP; 02 Oct 2023 23:54:40 -0700
From: Xin Li <xin3.li@intel.com>
To: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-edac@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	kvm@vger.kernel.org,
	xen-devel@lists.xenproject.org
Cc: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	luto@kernel.org,
	pbonzini@redhat.com,
	seanjc@google.com,
	peterz@infradead.org,
	jgross@suse.com,
	ravi.v.shankar@intel.com,
	mhiramat@kernel.org,
	andrew.cooper3@citrix.com,
	jiangshanlai@gmail.com,
	nik.borisov@suse.com
Subject: [PATCH v12 11/37] x86/opcode: Add ERET[US] instructions to the x86 opcode map
Date: Mon,  2 Oct 2023 23:24:32 -0700
Message-Id: <20231003062458.23552-12-xin3.li@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231003062458.23552-1-xin3.li@intel.com>
References: <20231003062458.23552-1-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: "H. Peter Anvin (Intel)" <hpa@zytor.com>

ERETU returns from an event handler while making a transition to ring 3,
and ERETS returns from an event handler while staying in ring 0.

Add instruction opcodes used by ERET[US] to the x86 opcode map; opcode
numbers are per FRED spec v5.0.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Tested-by: Shan Kang <shan.kang@intel.com>
Signed-off-by: Xin Li <xin3.li@intel.com>
Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 arch/x86/lib/x86-opcode-map.txt       | 2 +-
 tools/arch/x86/lib/x86-opcode-map.txt | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/lib/x86-opcode-map.txt b/arch/x86/lib/x86-opcode-map.txt
index 1efe1d9bf5ce..12af572201a2 100644
--- a/arch/x86/lib/x86-opcode-map.txt
+++ b/arch/x86/lib/x86-opcode-map.txt
@@ -1052,7 +1052,7 @@ EndTable
 
 GrpTable: Grp7
 0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B)
-1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
+1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B) | ERETU (F3),(010),(11B) | ERETS (F2),(010),(11B)
 2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
 4: SMSW Mw/Rv
diff --git a/tools/arch/x86/lib/x86-opcode-map.txt b/tools/arch/x86/lib/x86-opcode-map.txt
index 1efe1d9bf5ce..12af572201a2 100644
--- a/tools/arch/x86/lib/x86-opcode-map.txt
+++ b/tools/arch/x86/lib/x86-opcode-map.txt
@@ -1052,7 +1052,7 @@ EndTable
 
 GrpTable: Grp7
 0: SGDT Ms | VMCALL (001),(11B) | VMLAUNCH (010),(11B) | VMRESUME (011),(11B) | VMXOFF (100),(11B) | PCONFIG (101),(11B) | ENCLV (000),(11B) | WRMSRNS (110),(11B)
-1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B)
+1: SIDT Ms | MONITOR (000),(11B) | MWAIT (001),(11B) | CLAC (010),(11B) | STAC (011),(11B) | ENCLS (111),(11B) | ERETU (F3),(010),(11B) | ERETS (F2),(010),(11B)
 2: LGDT Ms | XGETBV (000),(11B) | XSETBV (001),(11B) | VMFUNC (100),(11B) | XEND (101)(11B) | XTEST (110)(11B) | ENCLU (111),(11B)
 3: LIDT Ms
 4: SMSW Mw/Rv
-- 
2.34.1


