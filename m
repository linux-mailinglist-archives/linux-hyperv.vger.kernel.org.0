Return-Path: <linux-hyperv+bounces-1381-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3AE825A2A
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jan 2024 19:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1CFB11C232C8
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jan 2024 18:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B83F5360B1;
	Fri,  5 Jan 2024 18:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EhLZPDeS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EC7935F17;
	Fri,  5 Jan 2024 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d3dee5f534so5684925ad.1;
        Fri, 05 Jan 2024 10:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704479443; x=1705084243; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DDBxixv8I/6JBD0uZ/FnCePGFgbAZpyF75SjVpOH3s=;
        b=EhLZPDeS27NBrNX01wbyiFm7RHs21Zx1a9df5gzlaX+kejjrCP3gZ3gZmDkS/I0fJ1
         XfzVoyUaJyO8u3y9IybugJShFLDLKSQB1ToYZEknidZrQI6lfZ9lu5c85vXWPs1e/7ov
         wjK8Pnr0KEGH2t+GyMs4HTjFEWcH8/sEyWooHCBKVc22kdoL3ujE5OfoE3tqTZdjx9NA
         Nq0wMpYlyyUIi2OuUZKvhEVbbc4qV9Lu+WzXL5q5bvGd4upKI8wF8CaBLTKGhCK7zHE0
         GHIxAf2kRyu1/bd+C7C0yTcbG9+IiHKNPb9CMDBG8d6UkRhqFCm8YYJGBCejtTKfyoDv
         o0FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704479443; x=1705084243;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/DDBxixv8I/6JBD0uZ/FnCePGFgbAZpyF75SjVpOH3s=;
        b=C9rS+NbN1fWUDNym6jQ3uCRFoYaIDzyOpCEBua6tHkX51nzDu65wCLQNESu6aoP2hw
         3WHncNq7uPz8uEV1ZJ9JCnXlk2e6z/PhEH685yAm5EgKOE2cMd9OlG18dYBfBJqs0cL4
         YbS81oAcHzxjJP3W/jsPViwb9KIB22OpZsXOYopIm5b7QhEp4UZMAe8V44XStqBk3JF1
         J2rDvE22a4UxDIVMDHa5TImW+ssxmZi1YGDbSdQ63A9F6zPAVhXWCwRb95kBdHxBxWig
         zsmeVL9CcP8zaDEt3rkZ6wDKzhPLyliNdL0FpkGrFrw4OWrvrTaugzRKpZiWSkolr2CZ
         weug==
X-Gm-Message-State: AOJu0Yzd+iaoFCC9SYTV2SkfxWZKDihhyYQQ0AmC5iemyubdgRSdIxdt
	C1OBwz6uZQmowqZOGMJDZfI=
X-Google-Smtp-Source: AGHT+IHZB8hxoZEO9XFseOS+q+ucI/+i6AVwNZFHhru24uO3VXpK5t8sRYDrNHcHS8sHO6AGVonlVw==
X-Received: by 2002:a17:90a:de11:b0:28c:3620:b5ee with SMTP id m17-20020a17090ade1100b0028c3620b5eemr3251196pjv.28.1704479443490;
        Fri, 05 Jan 2024 10:30:43 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a195700b002868abc0e6dsm1687293pjh.11.2024.01.05.10.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 10:30:43 -0800 (PST)
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
Subject: [PATCH v3 3/3] x86/hyperv: Make encrypted/decrypted changes safe for load_unaligned_zeropad()
Date: Fri,  5 Jan 2024 10:30:25 -0800
Message-Id: <20240105183025.225972-4-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240105183025.225972-1-mhklinux@outlook.com>
References: <20240105183025.225972-1-mhklinux@outlook.com>
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
---
 arch/x86/hyperv/ivm.c | 49 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 8ba18635e338..5ad39256a5d2 100644
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
@@ -521,7 +547,7 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 
 	pfn_array = kmalloc(HV_HYP_PAGE_SIZE, GFP_KERNEL);
 	if (!pfn_array)
-		return false;
+		goto err_set_memory_p;
 
 	for (i = 0, pfn = 0; i < pagecount; i++) {
 		/*
@@ -545,14 +571,30 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
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
@@ -615,6 +657,7 @@ void __init hv_vtom_init(void)
 	x86_platform.hyper.is_private_mmio = hv_is_private_mmio;
 	x86_platform.guest.enc_cache_flush_required = hv_vtom_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required = hv_vtom_tlb_flush_required;
+	x86_platform.guest.enc_status_change_prepare = hv_vtom_clear_present;
 	x86_platform.guest.enc_status_change_finish = hv_vtom_set_host_visibility;
 
 	/* Set WB as the default cache mode. */
-- 
2.25.1


