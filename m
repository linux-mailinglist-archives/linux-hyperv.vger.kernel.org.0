Return-Path: <linux-hyperv+bounces-1007-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2A307F3825
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 22:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11386B21BB0
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 21:20:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2531B584C7;
	Tue, 21 Nov 2023 21:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kbf9nbZ3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A28521BB;
	Tue, 21 Nov 2023 13:20:34 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1cf69f1163aso16218185ad.3;
        Tue, 21 Nov 2023 13:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700601634; x=1701206434; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rbfDwkGJGwxULqg8ltFjMn30Y46reH21KWF1N/yir7w=;
        b=Kbf9nbZ3UFE5JlKKhydyu3F2cjlZr7ZWSFeuGuCxxV48n7PIKyuWV6DmIr4eoYAOAs
         fWMRsU8pLNNUlw8yIfhC0goEsXrM1UD7kljZsFsYpuDNKdcy7CV85ZD3jsWsDnHDl9gN
         FJrw7BVJTpwrXXJRPs/G3VKvYujKPHJCwzXt7k77WlbK0moEMa9cTwsr+zEJaLmBU/Sq
         Y9oM8o0gVH8HSvo+pMzXxA7DlVXrsSJC/CTxfNYK17JG6Yukk4wOGoDJQYTizsiO1DQ7
         BQFor9iZsT4uvmO2jrWtOblXN01fKMR8jt0cH6IOSvBVE/VZ/jLC+W36e8MeDCMgwwft
         vcTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700601634; x=1701206434;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rbfDwkGJGwxULqg8ltFjMn30Y46reH21KWF1N/yir7w=;
        b=QsqUzi0FiB74jWuo9FZLBfZPMPkG0VnEM2zL/drsirpcKgTrGYWgwB0lkpg+WVwrgs
         4X5ZeDoo9dA7wN6kztw/c0ZZML5cUhPn6jwl+8S+zRREUS4aUhxwqzrTuP/grSMkAv+/
         ocHmngc54LguTGGaO1UJzXgbrN64W8u9sp55q78DhGlHWZTJ/VSRfd3kQalhUY8kf3ed
         ojJXYW5/3bEaGRxhjpFu8ZbvqP3B2X35+xucqOFcgt27esx2J0k8wI+r9YOOvfWUzRQD
         o9HYbvKfKa1MTAd1ujzoRnW1kLSXyJwOZrrGVxd5Qj48GAHkSFSwRk0CYbKrxaJ4YhjL
         094w==
X-Gm-Message-State: AOJu0YwYTDJKpt6o+IrK7GXe2jePMsWJge8aguJLkW77HZptDz+LlXQD
	SOMtz8rMgtEifs/E5sajXig=
X-Google-Smtp-Source: AGHT+IEOsjamSGHkOASGUCwZPWO7OmI3DBmh+Jjr7fpstRfuOke2KTseFR9lGErT7CmT9qeaxU040A==
X-Received: by 2002:a17:903:32c1:b0:1cf:6656:69cf with SMTP id i1-20020a17090332c100b001cf665669cfmr467098plr.21.1700601634054;
        Tue, 21 Nov 2023 13:20:34 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b001bf52834696sm8281924pll.207.2023.11.21.13.20.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:20:33 -0800 (PST)
From: mhkelley58@gmail.com
X-Google-Original-From: mhklinux@outlook.com
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	kirill.shutemov@linux.intel.com,
	kys@microsoft.com,
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
Subject: [PATCH v2 1/8] x86/coco: Use slow_virt_to_phys() in page transition hypervisor callbacks
Date: Tue, 21 Nov 2023 13:20:09 -0800
Message-Id: <20231121212016.1154303-2-mhklinux@outlook.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231121212016.1154303-1-mhklinux@outlook.com>
References: <20231121212016.1154303-1-mhklinux@outlook.com>
Reply-To: mhklinux@outlook.com
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Kelley <mhklinux@outlook.com>

In preparation for temporarily marking pages not present during a
transition between encrypted and decrypted, use slow_virt_to_phys()
in the hypervisor callbacks. As long as the PFN is correct,
slow_virt_to_phys() works even if the leaf PTE is not present.
The existing functions that depend on vmalloc_to_page() all
require that the leaf PTE be marked present, so they don't work.

Update the comments for slow_virt_to_phys() to note this broader usage
and the requirement to work even if the PTE is not marked present.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/hyperv/ivm.c        |  9 ++++++++-
 arch/x86/kernel/sev.c        |  8 +++++++-
 arch/x86/mm/pat/set_memory.c | 13 +++++++++----
 3 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 02e55237d919..8ba18635e338 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -524,7 +524,14 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 		return false;
 
 	for (i = 0, pfn = 0; i < pagecount; i++) {
-		pfn_array[pfn] = virt_to_hvpfn((void *)kbuffer + i * HV_HYP_PAGE_SIZE);
+		/*
+		 * Use slow_virt_to_phys() because the PRESENT bit has been
+		 * temporarily cleared in the PTEs.  slow_virt_to_phys() works
+		 * without the PRESENT bit while virt_to_hvpfn() or similar
+		 * does not.
+		 */
+		pfn_array[pfn] = slow_virt_to_phys((void *)kbuffer +
+					i * HV_HYP_PAGE_SIZE) >> HV_HYP_PAGE_SHIFT;
 		pfn++;
 
 		if (pfn == HV_MAX_MODIFY_GPA_REP_COUNT || i == pagecount - 1) {
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
index 70472eebe719..7eac92c07a58 100644
--- a/arch/x86/kernel/sev.c
+++ b/arch/x86/kernel/sev.c
@@ -811,7 +811,13 @@ static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long
 		hdr->end_entry = i;
 
 		if (is_vmalloc_addr((void *)vaddr)) {
-			pfn = vmalloc_to_pfn((void *)vaddr);
+			/*
+			 * Use slow_virt_to_phys() because the PRESENT bit has been
+			 * temporarily cleared in the PTEs.  slow_virt_to_phys() works
+			 * without the PRESENT bit while vmalloc_to_pfn() or similar
+			 * does not.
+			 */
+			pfn = slow_virt_to_phys((void *)vaddr) >> PAGE_SHIFT;
 			use_large_entry = false;
 		} else {
 			pfn = __pa(vaddr) >> PAGE_SHIFT;
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index bda9f129835e..8e19796e7ce5 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -755,10 +755,15 @@ pmd_t *lookup_pmd_address(unsigned long address)
  * areas on 32-bit NUMA systems.  The percpu areas can
  * end up in this kind of memory, for instance.
  *
- * This could be optimized, but it is only intended to be
- * used at initialization time, and keeping it
- * unoptimized should increase the testing coverage for
- * the more obscure platforms.
+ * It is also used in callbacks for CoCo VM page transitions between private
+ * and shared because it works when the PRESENT bit is not set in the leaf
+ * PTE. In such cases, the state of the PTEs, including the PFN, is otherwise
+ * known to be valid, so the returned physical address is correct. The similar
+ * function vmalloc_to_pfn() can't be used because it requires the PRESENT bit.
+ *
+ * This could be optimized, but it is only used in paths that are not perf
+ * sensitive, and keeping it unoptimized should increase the testing coverage
+ * for the more obscure platforms.
  */
 phys_addr_t slow_virt_to_phys(void *__virt_addr)
 {
-- 
2.25.1


