Return-Path: <linux-hyperv+bounces-1015-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B56B67F382B
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 22:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E68C91C20D6B
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Nov 2023 21:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30D9584C7;
	Tue, 21 Nov 2023 21:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EQvFRD4x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B81C7D76;
	Tue, 21 Nov 2023 13:20:43 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc5b705769so53531915ad.0;
        Tue, 21 Nov 2023 13:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700601643; x=1701206443; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8UP31zz2tzNyQ1XI1JgNxsSlBbVYVcKRejtDKCckFA=;
        b=EQvFRD4xS0Od02YOZ89FSXUma5aS1JF8NLEsj3EHY2PokkTlrckc/oaQGvN+T+GqIz
         oUbBAQmU9m9bdG5GULvBeGmc6ddF8O+8dhT9wiUOrikXEd6vGDCk5Z6qT+oXzonIeOBj
         sOmUMfxnplAyO80Wlrx/LVHjJBNH+ab2kZSmll2Qo3gIlRYBFdNnnbh1yfLiC2JxDgE5
         dE7UpZ5X9IOf/ISlPzN8MthizhHvgM+MZMeAYGzmJ0eg/dDcgtwBh7hLmO4CHcW7Ads0
         sSYWh9MgW/CnXlhPB03cNXdABx5fmbDglcPoD1p6zruaw3ieE38hwDQLGPopCnWxHose
         QMTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700601643; x=1701206443;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:to:from:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=r8UP31zz2tzNyQ1XI1JgNxsSlBbVYVcKRejtDKCckFA=;
        b=stjgxx6USQfk8Ap7GZ8JXFAId15KpZAxbEGFul8xgAbgGYyERhrq1DfeHB8smYJrKR
         s48wbyhlm2yr4tuOlAwVyX9l2A7Jj7DhKOYdKSpZSTb5HmjNyyyAfe/5ntNHhvNQtApA
         WRQRn4YysUeFuzhc9hCV3h1Az9H93LYAnsDkewEkglwdoTaBpCOdKG6wMAPhTR7nohhQ
         bw94a7c1ym2kI98sOw7q0oYFvFCIR1tWla4SzoaRN2j8Et2yQ+GjKWKCbIxrGWeEiI5v
         3TcwmZf7tqtY3QRRqe3QLvEzgkL/OgSYjJXySmL6VsS9PBxlDBAbdXmLek+zaMUlpL4K
         Vfng==
X-Gm-Message-State: AOJu0Yxvf3FnvzfvVXeqj6uecIVACvPFi75j4wNyPMFkU+yXHyqi7BKp
	a/QEEzMKydsIH6ohs4Z2zLc=
X-Google-Smtp-Source: AGHT+IGw2VRIF1KG5D53DbB1/O4g2GnYpBfD7Y44LMA28ENuVB/Zgq+24fLWa4HnCMkuyOoJyBsYkg==
X-Received: by 2002:a17:903:1107:b0:1cf:73ff:b196 with SMTP id n7-20020a170903110700b001cf73ffb196mr470013plh.8.1700601643193;
        Tue, 21 Nov 2023 13:20:43 -0800 (PST)
Received: from localhost.localdomain (c-73-254-87-52.hsd1.wa.comcast.net. [73.254.87.52])
        by smtp.gmail.com with ESMTPSA id j2-20020a170902758200b001bf52834696sm8281924pll.207.2023.11.21.13.20.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 13:20:42 -0800 (PST)
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
Subject: [PATCH v2 8/8] x86/mm: Add comments about errors in set_memory_decrypted()/encrypted()
Date: Tue, 21 Nov 2023 13:20:16 -0800
Message-Id: <20231121212016.1154303-9-mhklinux@outlook.com>
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

The functions set_memory_decrypted()/encrypted() may leave the input
memory range in an inconsistent state if an error occurs.  Add comments
describing the situation and what callers must be aware of.  Also add
comments in __set_memory_enc_dec() with more details on the issues and
why further investment in error handling is not likely to be useful.

No functional change.

Suggested-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Michael Kelley <mhklinux@outlook.com>
---
 arch/x86/mm/pat/set_memory.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 7365c86a7ff0..f519e5ca543b 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2133,6 +2133,24 @@ int set_memory_global(unsigned long addr, int numpages)
 /*
  * __set_memory_enc_dec() is used for the hypervisors that get
  * informed about "encryption" status via page tables.
+ *
+ * If an error occurs in making the transition between encrypted and
+ * decrypted, the transitioned memory is left in an indeterminate state.
+ * The encryption status in the guest page tables may not match the
+ * hypervisor's view of the encryption status, making the memory unusable.
+ * If the memory consists of multiple pages, different pages may be in
+ * different indeterminate states.
+ *
+ * It is difficult to recover from errors such that we can ensure
+ * consistency between the page tables and hypervisor view of the encryption
+ * state. It may not be possible to back out of changes, particularly if the
+ * failure occurs in communicating with the hypervisor. Given this limitation,
+ * further work on the error handling is not likely to meaningfully improve
+ * the reliablity or usability of the system.
+ *
+ * Any errors are likely to soon render the VM inoperable, but we return
+ * an error rather than panic'ing so that the caller can decide how best
+ * to shutdown cleanly.
  */
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
@@ -2203,6 +2221,14 @@ static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 	return set_memory_p(&addr, numpages);
 }
 
+/*
+ * If set_memory_encrypted()/decrypted() returns an error, the input memory
+ * range is left in an indeterminate state.  The encryption status of pages
+ * may be inconsistent, so the memory is unusable.  The caller should not try
+ * to do further operations on the memory, or return it to the free list.
+ * The memory must be leaked, and the caller should take steps to shutdown
+ * the system as cleanly as possible as something is seriously wrong.
+ */
 int set_memory_encrypted(unsigned long addr, int numpages)
 {
 	return __set_memory_enc_dec(addr, numpages, true);
-- 
2.25.1


