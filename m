Return-Path: <linux-hyperv+bounces-1438-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 844BD82E7E1
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 03:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5251F23898
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 02:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3683749F;
	Tue, 16 Jan 2024 02:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RFmxPSlS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2D46FD0;
	Tue, 16 Jan 2024 02:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-5c65ca2e1eeso4180740a12.2;
        Mon, 15 Jan 2024 18:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705371633; x=1705976433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bse0/qXZQoiuVJq8kHe7VoVGITL3RsI555OnNeb2YB0=;
        b=RFmxPSlSwG2En+JVP0XLnnym7mG+pfWo7SJThANNtXQmp/HnQiBMu7uUQU3DbHMCMD
         1FebT01evkMFwSLUGhUM7kB4gNMIZ214f2ErDwD5DAaNQYsL4m/nPsM1hgPY3nLcn6KO
         oeg8agVfNoSCcekXX4VzZRKWFIz8xfmbvHVZAKYncGQL26CXV+IGdivwSfpHspeefyoL
         GbxDK+XcDm5aRM0foW9m1poD/hycKUJsH0h3rHcOo7PLESluQWGr3mAZz7onYmXz2eLi
         uBFFPNeo0wuRaQRYhzEcSapWCND8bXkwxbjYtbilc30YKC964rFAFVRGHWcw/ZR0cOYP
         9RIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705371633; x=1705976433;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bse0/qXZQoiuVJq8kHe7VoVGITL3RsI555OnNeb2YB0=;
        b=G0aYv5jZCkRUnBXi4s3jxLKWTp7wHQg97rWL9yoLQHUDCj0krzRWsG2xGPt9Abvg4I
         cXDOzRikOj54cQSPH0G1hvguNHbVszfWIHAiTDKDeOgKFstiAXj+UbQRa+kZnBMRytnE
         vJ3cfuqvKCQVjwy7Vxv2XYRRIo15lANSvFCxkVI5CpH7/wmzMvygGXiDtE3/Tsz3+pBv
         TZE+EiLMaV41viHqF9jcpveNVc310056fX/kdqTSWDVlPV2uxT4kbXLPUIAnRgwJ9Ab2
         xx/m7d7SGO0Tkjdu+NtuXV8qgidcI+2kQGksM0qIs0U5VW6YTvNomFtDgv5lFjq2hv++
         y85g==
X-Gm-Message-State: AOJu0Yz87pxOEnnVcu/zX2u5iTSwa98yUdZnN0k04dCWm/KHm1VJwdBK
	RS554n4ITHhGQRz35/xYh+o=
X-Google-Smtp-Source: AGHT+IEr2+CDYGS0V8/X7I1MGszR2ZNlclrOwLdx0/MeFP/gOuYxw/HddIq+C+XRl375qrBivD1cYQ==
X-Received: by 2002:a05:6a20:e618:b0:19b:1da3:bafc with SMTP id my24-20020a056a20e61800b0019b1da3bafcmr760682pzb.4.1705371632710;
        Mon, 15 Jan 2024 18:20:32 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id kn14-20020a170903078e00b001d1d1ef8be5sm8193379plb.173.2024.01.15.18.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 18:20:32 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kirill.shutemov@linux.intel.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	luto@kernel.org,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	lstoakes@gmail.com,
	thomas.lendacky@amd.com,
	ardb@kernel.org,
	jroedel@suse.de,
	seanjc@google.com,
	rick.p.edgecombe@intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev,
	linux-hyperv@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v4 3/3] x86/hyperv: Make encrypted/decrypted changes safe for load_unaligned_zeropad()
Date: Mon, 15 Jan 2024 18:20:08 -0800
Message-Id: <20240116022008.1023398-4-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240116022008.1023398-1-mhklinux@outlook.com>
References: <20240116022008.1023398-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

In a CoCo VM, when transitioning memory from encrypted to decrypted, or
vice versa, the caller of set_memory_encrypted() or set_memory_decrypted()
is responsible for ensuring the memory isn't in use and isn't referenced
while the transition is in progress.  The transition has multiple steps,
and the memory is in an inconsistent state until all steps are complete.
A reference while the state is inconsistent could result in an exception
that can't be cleanly fixed up.

However, the kernel load_unaligned_zeropad() mechanism could cause a stray
reference that can't be prevented by the caller of set_memory_encrypted()
or set_memory_decrypted(), so there's specific code to handle this case.
But a CoCo VM running on Hyper-V may be configured to run with a paravisor,
with the #VC or #VE exception routed to the paravisor. There's no
architectural way to forward the exceptions back to the guest kernel, and
in such a case, the load_unaligned_zeropad() specific code doesn't work.

To avoid this problem, mark pages as "not present" while a transition
is in progress. If load_unaligned_zeropad() causes a stray reference, a
normal page fault is generated instead of #VC or #VE, and the
page-fault-based fixup handlers for load_unaligned_zeropad() resolve the
reference. When the encrypted/decrypted transition is complete, mark the
pages as "present" again.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 arch/x86/hyperv/ivm.c | 53 +++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 851107c77f4d..95036feb95e7 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -15,6 +15,7 @@
 #include <asm/io.h>
 #include <asm/coco.h>
 #include <asm/mem_encrypt.h>
+#include <asm/set_memory.h>
 #include <asm/mshyperv.h>
 #include <asm/hypervisor.h>
 #include <asm/mtrr.h>
@@ -502,6 +503,31 @@ static int hv_mark_gpa_visibility(u16 count, const u64 pfn[],
 		return -EFAULT;
 }
 
+/*
+ * When transitioning memory between encrypted and decrypted, the caller
+ * of set_memory_encrypted() or set_memory_decrypted() is responsible for
+ * ensuring that the memory isn't in use and isn't referenced while the
+ * transition is in progress.  The transition has multiple steps, and the
+ * memory is in an inconsistent state until all steps are complete. A
+ * reference while the state is inconsistent could result in an exception
+ * that can't be cleanly fixed up.
+ *
+ * But the Linux kernel load_unaligned_zeropad() mechanism could cause a
+ * stray reference that can't be prevented by the caller, so Linux has
+ * specific code to handle this case. But when the #VC and #VE exceptions
+ * routed to a paravisor, the specific code doesn't work. To avoid this
+ * problem, mark the pages as "not present" while the transition is in
+ * progress. If load_unaligned_zeropad() causes a stray reference, a normal
+ * page fault is generated instead of #VC or #VE, and the page-fault-based
+ * handlers for load_unaligned_zeropad() resolve the reference.  When the
+ * transition is complete, hv_vtom_set_host_visibility() marks the pages
+ * as "present" again.
+ */
+static bool hv_vtom_clear_present(unsigned long kbuffer, int pagecount, bool enc)
+{
+	return !set_memory_np(kbuffer, pagecount);
+}
+
 /*
  * hv_vtom_set_host_visibility - Set specified memory visible to host.
  *
@@ -522,8 +548,10 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 	int i, pfn;
 
 	pfn_array = kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
-	if (!pfn_array)
-		return false;
+	if (!pfn_array) {
+		result = false;
+		goto err_set_memory_p;
+	}
 
 	for (i = 0, pfn = 0; i < pagecount; i++) {
 		/*
@@ -548,14 +576,30 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 		}
 	}
 
- err_free_pfn_array:
+err_free_pfn_array:
 	kfree(pfn_array);
+
+err_set_memory_p:
+	/*
+	 * Set the PTE PRESENT bits again to revert what hv_vtom_clear_present()
+	 * did. Do this even if there is an error earlier in this function in
+	 * order to avoid leaving the memory range in a "broken" state. Setting
+	 * the PRESENT bits shouldn't fail, but return an error if it does.
+	 */
+	if (set_memory_p(kbuffer, pagecount))
+		result = false;
+
 	return result;
 }
 
 static bool hv_vtom_tlb_flush_required(bool private)
 {
-	return true;
+	/*
+	 * Since hv_vtom_clear_present() marks the PTEs as "not present"
+	 * and flushes the TLB, they can't be in the TLB. That makes the
+	 * flush controlled by this function redundant, so return "false".
+	 */
+	return false;
 }
 
 static bool hv_vtom_cache_flush_required(void)
@@ -618,6 +662,7 @@ void __init hv_vtom_init(void)
 	x86_platform.hyper.is_private_mmio = hv_is_private_mmio;
 	x86_platform.guest.enc_cache_flush_required = hv_vtom_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required = hv_vtom_tlb_flush_required;
+	x86_platform.guest.enc_status_change_prepare = hv_vtom_clear_present;
 	x86_platform.guest.enc_status_change_finish = hv_vtom_set_host_visibility;
 
 	/* Set WB as the default cache mode. */
-- 
2.25.1


