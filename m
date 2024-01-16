Return-Path: <linux-hyperv+bounces-1437-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69AD582E7E2
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 03:20:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B6C428251B
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Jan 2024 02:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE9537494;
	Tue, 16 Jan 2024 02:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k4uDZkcN"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D319567D;
	Tue, 16 Jan 2024 02:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1d3f2985425so44576845ad.3;
        Mon, 15 Jan 2024 18:20:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705371631; x=1705976431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4vfRMdoaViI6HxDtxXy2GwJGspyIYSCzcn+j2z7kh4=;
        b=k4uDZkcNwgelhv8HFf9nmioP4dIoTWC45t1pAGzvsA86QqktpEMy/9NuCURb1aVa8/
         /xCB41ND7GEQS6+nUf7LGkJHTVI38zj/Uw5PSpRD+tSJotap4UAVEuQ57CiQW5GzTkr/
         4uxlT7Fa1f0zG3pMe95oYcptBOeaVIpXwBfWuXs+4BVbzO7bht9HpF9Va9P+psKU4y7X
         3aRuSvdQX7tJr49cT+YTzg8wwq3ktGk2DEZYg2zUf1dni54HwAHSs9Zb8DOf+qdT6SuJ
         fLWhlqhq4EANvg4naXgm749CNKg0GMpXAVeonJNd2Zp4m/uBUriyF2okaWKujl6aKIkh
         dsEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705371631; x=1705976431;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c4vfRMdoaViI6HxDtxXy2GwJGspyIYSCzcn+j2z7kh4=;
        b=G/E76C2tHyt30lzTNBH0IIxfNRyaXxtmTIYajazC/TMZmgO/GC7izy2belKKynlPRh
         uXydUuuhQ1rkQwP5pIHGon9NETy+lAfr9xPDbyWoIo2y/ON8DF/85YLKlmRAIOVIZ8mD
         VON8rSLjv06P6mY7JQROdWTLxVbxoY3riuVLRJk80v1TC/vspi09Mu6uT63rQ8LanyV4
         ziwPPCLUhwlJE+23gIQOq0p51gHH4IDIOsLypDYFjBlFM4Omp5Yyaq2giBidtEQuamGE
         ItTUbgZ8ShEvquscjSq3Lqeu0cOpOlvHDES29tceQ1c8+XwmLKf1s+G/nup/Is1SM6hf
         tHHw==
X-Gm-Message-State: AOJu0YyX5nhevSBR0bmCXtluJqPhY4V3frs7GNt7bVsB0SteWlO0zBw+
	9AETX1ds/OpzWPE4aw91YQI=
X-Google-Smtp-Source: AGHT+IFRVMIEFLp+rPfL0OtTdnRiBOnM5nFlc0pFAGcjr3KeEtvte2JqdiXRGVdv5FquDNd/HY+qHQ==
X-Received: by 2002:a17:902:cec8:b0:1d5:c558:164d with SMTP id d8-20020a170902cec800b001d5c558164dmr1779308plg.74.1705371631546;
        Mon, 15 Jan 2024 18:20:31 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id kn14-20020a170903078e00b001d1d1ef8be5sm8193379plb.173.2024.01.15.18.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jan 2024 18:20:31 -0800 (PST)
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
Subject: [PATCH v4 2/3] x86/mm: Regularize set_memory_p() parameters and make non-static
Date: Mon, 15 Jan 2024 18:20:07 -0800
Message-Id: <20240116022008.1023398-3-mhklinux@outlook.com>
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

set_memory_p() is currently static.  It has parameters that don't
match set_memory_p() under arch/powerpc and that aren't congruent
with the other set_memory_* functions. There's no good reason for
the difference.

Fix this by making the parameters consistent, and update the one
existing call site.  Make the function non-static and add it to
include/asm/set_memory.h so that it is completely parallel to
set_memory_np() and is usable in other modules.

No functional change.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 arch/x86/include/asm/set_memory.h |  1 +
 arch/x86/mm/pat/set_memory.c      | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index a5e89641bd2d..9aee31862b4a 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -47,6 +47,7 @@ int set_memory_uc(unsigned long addr, int numpages);
 int set_memory_wc(unsigned long addr, int numpages);
 int set_memory_wb(unsigned long addr, int numpages);
 int set_memory_np(unsigned long addr, int numpages);
+int set_memory_p(unsigned long addr, int numpages);
 int set_memory_4k(unsigned long addr, int numpages);
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index e76ac64b516e..164d32029424 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2045,17 +2045,12 @@ int set_mce_nospec(unsigned long pfn)
 	return rc;
 }
 
-static int set_memory_p(unsigned long *addr, int numpages)
-{
-	return change_page_attr_set(addr, numpages, __pgprot(_PAGE_PRESENT), 0);
-}
-
 /* Restore full speculative operation to the pfn. */
 int clear_mce_nospec(unsigned long pfn)
 {
 	unsigned long addr = (unsigned long) pfn_to_kaddr(pfn);
 
-	return set_memory_p(&addr, 1);
+	return set_memory_p(addr, 1);
 }
 EXPORT_SYMBOL_GPL(clear_mce_nospec);
 #endif /* CONFIG_X86_64 */
@@ -2108,6 +2103,11 @@ int set_memory_np_noalias(unsigned long addr, int numpages)
 					CPA_NO_CHECK_ALIAS, NULL);
 }
 
+int set_memory_p(unsigned long addr, int numpages)
+{
+	return change_page_attr_set(&addr, numpages, __pgprot(_PAGE_PRESENT), 0);
+}
+
 int set_memory_4k(unsigned long addr, int numpages)
 {
 	return change_page_attr_set_clr(&addr, numpages, __pgprot(0),
-- 
2.25.1


