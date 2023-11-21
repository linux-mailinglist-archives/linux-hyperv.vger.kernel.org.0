Return-Path: <linux-hyperv+bounces-1011-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2E9E7F3824
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 22:20:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD471C20E11
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 21:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33381584D1;
	Tue, 21 Nov 2023 21:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9Amo8b7"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6BF1AA;
	Tue, 21 Nov 2023 13:20:37 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1cf6a67e290so15795685ad.1;
        Tue, 21 Nov 2023 13:20:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700601636; x=1701206436; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WDCKZynU08jauQ6ld+7iiO8G5I0+Mgx4PpyHnd5gkcg=;
        b=b9Amo8b7XxRrje7EUu9nqxEMj5X/MN99pjuobtb5My8i4YpxIfBimz7rMorbQniKtG
         9CyDxgo/E0h6mF6YtFz0BAy8uCysyM79R+VrgisZowvmo8vbZVnfRdNJNyt7e9zsOBBn
         2U9dNBeq6lHtzMgT+BSYs9lQjdq2dUx616zxAWISM6Np6v4YI+stMSZ3ovUqiBB91eAr
         zOpfopn0Ier4F8dHEH13GHLGcZ2hwbYM1x5iqrkoStaDkcW64JT4nwZ/LWiAO7AhpL9u
         ihkrSDoU7Q0wNIiT6VzH4y4ykbW5EszQ3Ge19KLD1WTmuNLzPjmeTRNOqStPCtn4bVhN
         +tKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700601636; x=1701206436;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WDCKZynU08jauQ6ld+7iiO8G5I0+Mgx4PpyHnd5gkcg=;
        b=FDh7lGUD0uGtXXDx5zbOcIyDd4dwZHdfSI1r6XHP8iSbN40aSQSFmC3QX3OpVJPamD
         MnjmPWdORvuNSpkYuTr6V9gKQnTgycKQb+8d0ZKUNzFOY2zn8jVrg5HnvFmQuWzcFspU
         JnOml40trUUEwEiQVcn60G6s4hC+sN9E4frAZm4AGDdLWy4qRqpjU1YPruKuI68ocNBk
         LX0g8Lr8Xye2nMCKi3H31s+eBCdqtOZhXkZpENrLDiFgn+HtORo3+bVGpHxFj8hAV2QM
         nfJQZd9IHp3UcxsRBp9rFcjY1Y8m7aiwScjpNaRCqBmciYgBeT/oPsGANiB70iAfma5c
         tgtQ==
X-Gm-Message-State: AOJu0YxRAVmI7ZaISQO4PZHOrJA9jbiJycnbe3i56BQN7qbLzJxEYnyf
	Bb6HcVX6ruBKang+M4YZjYc=
X-Google-Smtp-Source: AGHT+IHGih5jJrhH0e5Fitw1xqGZ2tbx4HII00I2SufuwbFYeK8kmL25D5zlL+pZpN85Iq/vTDPqHw==
X-Received: by 2002:a17:902:ec84:b0:1c9:faef:5765 with SMTP id x4-20020a170902ec8400b001c9faef5765mr603101plg.5.1700601636565;
        Tue, 21 Nov 2023 13:20:36 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b001bf52834696sm8281924pll.207.2023.11.21.13.20.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:20:36 -0800 (PST)
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
Subject: [PATCH v2 3/8] x86/mm: Remove "static" from vmap_pages_range()
Date: Tue, 21 Nov 2023 13:20:11 -0800
Message-Id: <20231121212016.1154303-4-mhklinux@outlook.com>
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

The mm subsystem currently provides no mechanism to map memory pages
to a specified virtual address range.  A virtual address range can be
allocated using get_vm_area(), but the only function available for
mapping memory pages to a caller-specified address in that range is
ioremap_page_range(), which is inappropriate for system memory.

Fix this by allowing vmap_pages_range() to be used by callers outside
of vmalloc.c.

Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 include/linux/vmalloc.h | 2 ++
 mm/vmalloc.c            | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index c720be70c8dd..ee12f5226a45 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -233,6 +233,8 @@ static inline bool is_vm_area_hugepages(const void *addr)
 
 #ifdef CONFIG_MMU
 void vunmap_range(unsigned long addr, unsigned long end);
+int vmap_pages_range(unsigned long addr, unsigned long end, pgprot_t prot,
+			struct page **pages, unsigned int page_shift);
 static inline void set_vm_flush_reset_perms(void *addr)
 {
 	struct vm_struct *vm = find_vm_area(addr);
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index d12a17fc0c17..b2a72bd317c6 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -625,7 +625,7 @@ int vmap_pages_range_noflush(unsigned long addr, unsigned long end,
  * RETURNS:
  * 0 on success, -errno on failure.
  */
-static int vmap_pages_range(unsigned long addr, unsigned long end,
+int vmap_pages_range(unsigned long addr, unsigned long end,
 		pgprot_t prot, struct page **pages, unsigned int page_shift)
 {
 	int err;
-- 
2.25.1


