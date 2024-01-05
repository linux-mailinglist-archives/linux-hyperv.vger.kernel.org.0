Return-Path: <linux-hyperv+bounces-1379-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 036C4825A26
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jan 2024 19:31:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D94E1F2460B
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jan 2024 18:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0171C2CCDF;
	Fri,  5 Jan 2024 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gb0SdXyq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23C7358B1;
	Fri,  5 Jan 2024 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5ceb02e2a56so1110785a12.2;
        Fri, 05 Jan 2024 10:30:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704479441; x=1705084241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3sjtnuQv0aW8e3tX/O8I3CPvFIKJ9WnNTakGmnE/PQ4=;
        b=gb0SdXyqz7P9KT4ny2nvqvyk5Syf/8MrZPpBoXW00yZe85XcbMRZcVPpCrlEssR/4F
         XiJ/NO/52GfI/1oKbt1fu2xIyH88ZLT5fkKe9zXv+TEqTkMhDwH0v27wft8T1hsS7zwY
         cBpU4/bluZgtCj1ZnvBbMGtbTOAzwc8DH4+vF5LK27yZPijRhFAj2Bf1axvhhBoA7Bne
         A8i1ngKfHfJaVvkZTHrcX4qVkTwzTuJHhco+SdXrl27t1TYTNF0V6iS8HeX4fzLr8HhR
         rdhnV5J71ZtPVV9cOopb2teAf4ob+t8/j1ECRb2wxuQbekEr5/0fuoYldlnJosYMxJS8
         bgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704479441; x=1705084241;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3sjtnuQv0aW8e3tX/O8I3CPvFIKJ9WnNTakGmnE/PQ4=;
        b=pTiOQbJPDoNUiUliRnC++M7avdm4GhJ1Qo/e1qNlIQAP/5fuDpKDmlhUmsPabh6GNv
         hIA2YI6nkqZwD5wHKbUQU8PLmX0lc3lMO1vllnGxd3TAq5WEyceRWSYZfFAwWpqUK5q4
         Wn3t89is9yhX0ttTr42SyetaPLaZNKh/kOE2ViFcG9Tng8SWKxuLq6OkwDmGxYkP2AhX
         AEzPU7sQX2O45jHTlf9Ff+0mvVYdMADXw5GcGhNIWG9YdWnmRdakLHPjvNlZwrWxbmgX
         YLdga4EhpA9j1qgiLpCU8DmhKNFzFnigkJB1IJLlG99gu7SvGKtTBqyBpFq1dJKQ+fPn
         T45g==
X-Gm-Message-State: AOJu0YxlAk/qBEkp0yV4YYxPhT21yVahlqaFVkZ5vNj4PBVuZb3770ip
	ktFL3lasm+K7qlEy6X8A8Ss=
X-Google-Smtp-Source: AGHT+IGZaFoZdBTf7Hf3s9plZg+SJexjwJwB03dmWIM7+favexb3cAjsi05kOu2bP0EG5HtVpfK9Dg==
X-Received: by 2002:a17:90b:1d0d:b0:28c:4a67:eb7d with SMTP id on13-20020a17090b1d0d00b0028c4a67eb7dmr2069534pjb.48.1704479440839;
        Fri, 05 Jan 2024 10:30:40 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id 23-20020a17090a195700b002868abc0e6dsm1687293pjh.11.2024.01.05.10.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jan 2024 10:30:40 -0800 (PST)
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
Subject: [PATCH v3 1/3] x86/hyperv: Use slow_virt_to_phys() in page transition hypervisor callback
Date: Fri,  5 Jan 2024 10:30:23 -0800
Message-Id: <20240105183025.225972-2-mhklinux@outlook.com>
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

In preparation for temporarily marking pages not present during a
transition between encrypted and decrypted, use slow_virt_to_phys()
in the hypervisor callback. As long as the PFN is correct,
slow_virt_to_phys() works even if the leaf PTE is not present.
The existing functions that depend on vmalloc_to_page() all
require that the leaf PTE be marked present, so they don't work.

Update the comments for slow_virt_to_phys() to note this broader usage
and the requirement to work even if the PTE is not marked present.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/hyperv/ivm.c        |  9 ++++++++-
 arch/x86/mm/pat/set_memory.c | 13 +++++++++----
 2 files changed, 17 insertions(+), 5 deletions(-)

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


