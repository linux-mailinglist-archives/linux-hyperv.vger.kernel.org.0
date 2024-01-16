Return-Path: <linux-hyperv+bounces-1439-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9415882E7E5
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 03:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F034E280EB4
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 02:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 687A4848E;
	Tue, 16 Jan 2024 02:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZCykdmhL"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ACA529AD;
	Tue, 16 Jan 2024 02:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d5dfda4319so2686595ad.0;
        Mon, 15 Jan 2024 18:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705371630; x=1705976430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WMHKxJ/T5Ct44oYlSE+LYrzOvXToXwBp+RoVB/ApQnM=;
        b=ZCykdmhLScgfeqb281iOMeUrZMW4PUe2S+xqz/V10DHHmGI+QWxsmEY6eHMIErddtC
         SquMAIRSHz9auI0PWAOyfZ9g2GqO2TtBDhE06EvyEU0+mbCZj7QwVxRWXVAks91dN41b
         5dElEkitgj1l5QFdfB8VsT/173ACtlBN2PnP3v0Gb0KL7dBO2GLDhrxiqlwlV30tjjjn
         G+BjUgKIlEeXNb34BHZO/dyjjmCoWoDjfdyR6Wf2ipQnjfI8mmob8vtvhu0oaNrPxD6H
         xnt/iUg9uFHBvC6I0+IptHhEMMFep73VdkmRNlVVGaulGjbnyEPaKL/xwAehdiAbAXNq
         eByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705371630; x=1705976430;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WMHKxJ/T5Ct44oYlSE+LYrzOvXToXwBp+RoVB/ApQnM=;
        b=sNAvadX+4ztSUX1+veRcMetXfB6jkVy1nTouuHODuLMiVCD/bBTopPm2827YwQWxif
         QlU5gx7M6eJhKHot5qKFannoXAdackSW95Zdolqf+q2eatsHciiRcacwUmGZjkqIndB+
         cx6D63l0HUi8N4OYbhlNhGHkS3Q/KFVup0N2E7xENvy6E91Gewj+5FfIU+af+oXVsZ8O
         H9h/oresRuzjO6IGj9v9YrKGZyiwWxw0IIV2B6I41nTeW7ZqfC5nGbnzuzZ08HtopJpF
         cWxIpS3SV8ruzefBIJImfX1Lfo2duu5rhAEezl1vPVlvyqFO7DnGX2m3k9AhdkUdmhUi
         kefQ==
X-Gm-Message-State: AOJu0YyfRLiZuKgE1bGkwbDtI2arpyMPwxreQpLR8KRtxWwJq3DDQb13
	sL12w/VGCR1kBR3oCWTWUBg=
X-Google-Smtp-Source: AGHT+IGKhIpxJK9risAw80iB9x8SFXIfFEzqHrHFHgbziciGN/6OZbZls+x7EV8Jy+UwtVv+JbHLlQ==
X-Received: by 2002:a17:903:2808:b0:1d4:75c6:9560 with SMTP id kp8-20020a170903280800b001d475c69560mr2742635plb.59.1705371630377;
        Mon, 15 Jan 2024 18:20:30 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id kn14-20020a170903078e00b001d1d1ef8be5sm8193379plb.173.2024.01.15.18.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 18:20:30 -0800 (PST)
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
Subject: [PATCH v4 1/3] x86/hyperv: Use slow_virt_to_phys() in page transition hypervisor callback
Date: Mon, 15 Jan 2024 18:20:06 -0800
Message-Id: <20240116022008.1023398-2-mhklinux@outlook.com>
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
 arch/x86/hyperv/ivm.c        | 12 +++++++++++-
 arch/x86/mm/pat/set_memory.c | 12 ++++++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/arch/x86/hyperv/ivm.c b/arch/x86/hyperv/ivm.c
index 02e55237d919..851107c77f4d 100644
--- a/arch/x86/hyperv/ivm.c
+++ b/arch/x86/hyperv/ivm.c
@@ -515,6 +515,8 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 	enum hv_mem_host_visibility visibility = enc ?
 			VMBUS_PAGE_NOT_VISIBLE : VMBUS_PAGE_VISIBLE_READ_WRITE;
 	u64 *pfn_array;
+	phys_addr_t paddr;
+	void *vaddr;
 	int ret = 0;
 	bool result = true;
 	int i, pfn;
@@ -524,7 +526,15 @@ static bool hv_vtom_set_host_visibility(unsigned long kbuffer, int pagecount, bo
 		return false;
 
 	for (i = 0, pfn = 0; i < pagecount; i++) {
-		pfn_array[pfn] = virt_to_hvpfn((void *)kbuffer + i * HV_HYP_PAGE_SIZE);
+		/*
+		 * Use slow_virt_to_phys() because the PRESENT bit has been
+		 * temporarily cleared in the PTEs.  slow_virt_to_phys() works
+		 * without the PRESENT bit while virt_to_hvpfn() or similar
+		 * does not.
+		 */
+		vaddr = (void *)kbuffer + (i * HV_HYP_PAGE_SIZE);
+		paddr = slow_virt_to_phys(vaddr);
+		pfn_array[pfn] = paddr >> HV_HYP_PAGE_SHIFT;
 		pfn++;
 
 		if (pfn == HV_MAX_MODIFY_GPA_REP_COUNT || i == pagecount - 1) {
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index bda9f129835e..e76ac64b516e 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -755,10 +755,14 @@ pmd_t *lookup_pmd_address(unsigned long address)
  * areas on 32-bit NUMA systems.  The percpu areas can
  * end up in this kind of memory, for instance.
  *
- * This could be optimized, but it is only intended to be
- * used at initialization time, and keeping it
- * unoptimized should increase the testing coverage for
- * the more obscure platforms.
+ * Note that as long as the PTEs are well-formed with correct PFNs, this
+ * works without checking the PRESENT bit in the leaf PTE.  This is unlike
+ * the similar vmalloc_to_page() and derivatives.  Callers may depend on
+ * this behavior.
+ *
+ * This could be optimized, but it is only used in paths that are not perf
+ * sensitive, and keeping it unoptimized should increase the testing coverage
+ * for the more obscure platforms.
  */
 phys_addr_t slow_virt_to_phys(void *__virt_addr)
 {
-- 
2.25.1


