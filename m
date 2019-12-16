Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD9B111FC0C
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Dec 2019 01:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfLPATi (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Dec 2019 19:19:38 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34289 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726537AbfLPATh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Dec 2019 19:19:37 -0500
Received: by mail-qt1-f196.google.com with SMTP id 5so4428950qtz.1;
        Sun, 15 Dec 2019 16:19:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/LWpy3sT0NojI+6lHGq8dZmjGNhrVEiL5TtdHICIZc4=;
        b=YWwtUpgdB4C7Q4X0xMgmsDhu8K2YcKTpSy81xtryD588YUY101myAfwdgspbcp++85
         6rUIKyZFgNjmsF4vh3aNwsJ/DIr5fJmGbJgJRAG4m5DMAcJVWbNmgUvu85ZRr82QbH7N
         SjPcnTI82np5u2GBasGGK7q0ufep07XQTVE2LKC4dmpRPeGgmVk+Vbvn5SP5P+2/c0d+
         PW4xPb5dY7sVukOSE6AtRQFyG1c3wP0wyFooKOHxnXx9A2gSO+syfVPBz/XUSPLqmuEH
         O7l6gAeT6p4sbwV22GMICMLrj6hUwnTvwhKBHrhQNO6Z1EXh996On8A3IZd8QASa4dLh
         Jl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/LWpy3sT0NojI+6lHGq8dZmjGNhrVEiL5TtdHICIZc4=;
        b=NwGBw1DlmbzaIdM/lQ6xFOvhvfg2Wk03NRDTp3bHF7MoYi7mNLvoVNiylQoJA8yCFs
         PgQULmxMNh3jtTcZH7wN5LswuMIZwoo17FpV7a2816X2PKR+MbLskReTP0HbIAbZ3AsG
         vcp9OBBAq2yCj/XdgPvXMJWmvMB3T7thuyTvYlwGUXOMS3AJbEnXiZutmHDM2a42N9me
         0hSeUaIjzo6CpPYWecEMcDxDDsoGxbQipmeasDRFglIbp9/NhnK18Q7gLthgvMGnAXAz
         z1JOlCs0jNa4J9FN03jXry2rmgAzjAYt4rL6GrLxvHNsT5FCKcrp+pXtShz0iK27JSoJ
         9yfg==
X-Gm-Message-State: APjAAAXdB3HzzMn1qqmhjvs0ng3URaifwLcbD6sciKbuMz8kBOi81hB5
        Bhi+Q0s0RFrp5PPw8+m+/TM=
X-Google-Smtp-Source: APXvYqyhIIjZfzlpUFVMB/tiV3ydzxJugA4tfdYzQ1/oDFfstC6D6w9VTmT3ruQGJ7EWghnBfRjF2Q==
X-Received: by 2002:aed:2bc2:: with SMTP id e60mr22652718qtd.115.1576455576496;
        Sun, 15 Dec 2019 16:19:36 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v125sm5409912qka.47.2019.12.15.16.19.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 16:19:36 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 77F3122434;
        Sun, 15 Dec 2019 19:19:35 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 15 Dec 2019 19:19:35 -0500
X-ME-Sender: <xms:l832XfZQSIBODTOKHYP4OiihyxvNi_m-U8HmMcdMAJwD7fT-DlWZ1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvffufffkofgjfhgggfes
    tdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnh
    hgsehgmhgrihhlrdgtohhmqeenucfkphephedvrdduheehrdduuddurdejudenucfrrghr
    rghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrg
    hlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeep
    ghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:l832XfDsMu_b4P7cjdMpjiVhjWGLh_COxGdpGHu1Ng78W0-PKoIj6g>
    <xmx:l832XdFRYH1QxOB5aK2Pny-EtgZguMv0iUEYiIAbwvBhn9J-hOp8hw>
    <xmx:l832XaOm27CluqGyM6I7GBn5R-49iEMEdkx-rmXJKicVKLx1SwzaCw>
    <xmx:l832XZNG7-vMXq9oqX4_jGmE5UiJ3XjAVM63umg-Sj4VkYZ4Dks7cHrGOzE>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id A59FA80059;
        Sun, 15 Dec 2019 19:19:34 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-hyperv@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        xen-devel@lists.xenproject.org,
        Stefano Stabellini <sstabellini@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Matteo Croce <mcroce@redhat.com>
Subject: [RFC 2/6] arm64: vdso: Add support for multiple vDSO data pages
Date:   Mon, 16 Dec 2019 08:19:18 +0800
Message-Id: <20191216001922.23008-3-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216001922.23008-1-boqun.feng@gmail.com>
References: <20191216001922.23008-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Split __vdso_abi::vdso_pages into nr_vdso_{data,code}_pages, so that
__setup_additional_pages() could work with multiple vDSO data pages with
the setup from __vdso_init().

Multiple vDSO data pages are required when running in a virtualized
environment, where the cycles read from cntvct at userspace need to
be adjusted with some data from a page maintained by the hypervisor. For
example, the TSC page in Hyper-V.

This is a prerequisite for vDSO support in ARM64 on Hyper-V.

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
---
 arch/arm64/kernel/vdso.c | 43 ++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index 354b11e27c07..b9b5ec7a3084 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -50,7 +50,8 @@ struct __vdso_abi {
 	const char *name;
 	const char *vdso_code_start;
 	const char *vdso_code_end;
-	unsigned long vdso_pages;
+	unsigned long nr_vdso_data_pages;
+	unsigned long nr_vdso_code_pages;
 	/* Data Mapping */
 	struct vm_special_mapping *dm;
 	/* Code Mapping */
@@ -101,6 +102,8 @@ static int __vdso_init(enum arch_vdso_type arch_index)
 {
 	int i;
 	struct page **vdso_pagelist;
+	struct page **vdso_code_pagelist;
+	unsigned long nr_vdso_pages;
 	unsigned long pfn;
 
 	if (memcmp(vdso_lookup[arch_index].vdso_code_start, "\177ELF", 4)) {
@@ -108,14 +111,18 @@ static int __vdso_init(enum arch_vdso_type arch_index)
 		return -EINVAL;
 	}
 
-	vdso_lookup[arch_index].vdso_pages = (
+	vdso_lookup[arch_index].nr_vdso_data_pages = 1;
+
+	vdso_lookup[arch_index].nr_vdso_code_pages = (
 			vdso_lookup[arch_index].vdso_code_end -
 			vdso_lookup[arch_index].vdso_code_start) >>
 			PAGE_SHIFT;
 
-	/* Allocate the vDSO pagelist, plus a page for the data. */
-	vdso_pagelist = kcalloc(vdso_lookup[arch_index].vdso_pages + 1,
-				sizeof(struct page *),
+	nr_vdso_pages = vdso_lookup[arch_index].nr_vdso_data_pages +
+			vdso_lookup[arch_index].nr_vdso_code_pages;
+
+	/* Allocate the vDSO pagelist. */
+	vdso_pagelist = kcalloc(nr_vdso_pages, sizeof(struct page *),
 				GFP_KERNEL);
 	if (vdso_pagelist == NULL)
 		return -ENOMEM;
@@ -123,15 +130,17 @@ static int __vdso_init(enum arch_vdso_type arch_index)
 	/* Grab the vDSO data page. */
 	vdso_pagelist[0] = phys_to_page(__pa_symbol(vdso_data));
 
-
 	/* Grab the vDSO code pages. */
 	pfn = sym_to_pfn(vdso_lookup[arch_index].vdso_code_start);
 
-	for (i = 0; i < vdso_lookup[arch_index].vdso_pages; i++)
-		vdso_pagelist[i + 1] = pfn_to_page(pfn + i);
+	vdso_code_pagelist = vdso_pagelist +
+			     vdso_lookup[arch_index].nr_vdso_data_pages;
+
+	for (i = 0; i < vdso_lookup[arch_index].nr_vdso_code_pages; i++)
+		vdso_code_pagelist[i] = pfn_to_page(pfn + i);
 
-	vdso_lookup[arch_index].dm->pages = &vdso_pagelist[0];
-	vdso_lookup[arch_index].cm->pages = &vdso_pagelist[1];
+	vdso_lookup[arch_index].dm->pages = vdso_pagelist;
+	vdso_lookup[arch_index].cm->pages = vdso_code_pagelist;
 
 	return 0;
 }
@@ -141,26 +150,26 @@ static int __setup_additional_pages(enum arch_vdso_type arch_index,
 				    struct linux_binprm *bprm,
 				    int uses_interp)
 {
-	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
+	unsigned long vdso_base, vdso_text_len, vdso_data_len;
 	void *ret;
 
-	vdso_text_len = vdso_lookup[arch_index].vdso_pages << PAGE_SHIFT;
-	/* Be sure to map the data page */
-	vdso_mapping_len = vdso_text_len + PAGE_SIZE;
+	vdso_data_len = vdso_lookup[arch_index].nr_vdso_data_pages << PAGE_SHIFT;
+	vdso_text_len = vdso_lookup[arch_index].nr_vdso_code_pages << PAGE_SHIFT;
 
-	vdso_base = get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
+	vdso_base = get_unmapped_area(NULL, 0,
+				      vdso_data_len + vdso_text_len, 0, 0);
 	if (IS_ERR_VALUE(vdso_base)) {
 		ret = ERR_PTR(vdso_base);
 		goto up_fail;
 	}
 
-	ret = _install_special_mapping(mm, vdso_base, PAGE_SIZE,
+	ret = _install_special_mapping(mm, vdso_base, vdso_data_len,
 				       VM_READ|VM_MAYREAD,
 				       vdso_lookup[arch_index].dm);
 	if (IS_ERR(ret))
 		goto up_fail;
 
-	vdso_base += PAGE_SIZE;
+	vdso_base += vdso_data_len;
 	mm->context.vdso = (void *)vdso_base;
 	ret = _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ|VM_EXEC|
-- 
2.24.0

