Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1980E11FC12
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Dec 2019 01:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbfLPAT6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Dec 2019 19:19:58 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:42723 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfLPAT6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Dec 2019 19:19:58 -0500
Received: by mail-qk1-f193.google.com with SMTP id z14so3876246qkg.9;
        Sun, 15 Dec 2019 16:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qJHTf9gLZO0OmW0oKiFiaoMPD31UWwBIv/AQO8x022Q=;
        b=UCmY/B2PlCGXERTqtwgVAtc2JqLgwUuUJuM66myj3BI4trxbjf3g0TnSG6nt58tAr5
         b6wmX04u6YUR9eii5m+YXMa0EHZfMbtFJz9VgI+Ygal0hewZUXXIVCeMfWObhUfyF884
         ccoID02pgYC30wQuv/zvjzzmDqkBrJJHen+E411WY7HJgXTj6Wx6U3NKulvnMa5Govq9
         DZ478mLox8WXtHb8Ijf7WIhQI4NskICyGfTV78MMNlQTmCghtj1RoL0rAINJT9xwhXHE
         TFSowtCHOCjZF2GfjW67JnBz9elQipCHK+6FWG2DnYry+jvTyvmUDGnSXckYfxC8F5D2
         F7yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qJHTf9gLZO0OmW0oKiFiaoMPD31UWwBIv/AQO8x022Q=;
        b=OrQSpBHQHMqW4Z4yQXfvxvgM9XgKb7xxn28hzafjlrQw63K1fean5kzFIq3dlibOnt
         Kk9ApjWCeoF7aSP+git7BlXnX8aIHvMQJ5zpxxdnnPN5L7/j4UgzRde99/aDTSmtbrcj
         9NduU/SllrASeWLS6wfp5RKoK7cFmksdmyaJGMW3vJE+CC5WgoabmV6mHYhnVORag5y/
         qLvxqUGpcTUobbkESKqMu2BsybfosEMdsfV+ire/H9X/NxMP6FiPCagaaTsTeyC9J4XN
         IdniaisTCEQipNoYf8lZA8x10IgslA78GBDJPuyaQyjw2si5tFw1HrTdXGT6cQwRzyi3
         +3Ng==
X-Gm-Message-State: APjAAAVrkVgyrzoIgswuw8h8hu5SvhN3PvLHmk8xoS1bPAdaWWj/sdJB
        aOY5ggf4vsLhZTznGCy/gqc=
X-Google-Smtp-Source: APXvYqziDt2MJepPF60CYkhXmMwNyU7utpHzVQ8iPImbF+lXkZE5ubq26nEL7jVGpgS+wAWhxEIl4A==
X-Received: by 2002:a37:a70b:: with SMTP id q11mr24215846qke.393.1576455596683;
        Sun, 15 Dec 2019 16:19:56 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id i28sm6346240qtc.57.2019.12.15.16.19.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 16:19:56 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id AC2A822434;
        Sun, 15 Dec 2019 19:19:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Sun, 15 Dec 2019 19:19:55 -0500
X-ME-Sender: <xms:q832XWJ0BhXQcTrYcjk1bHKva8UP7EuqtVW4y1Ee6GAf1WjhXaMBjA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvffufffkofgjfhgggfes
    tdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnh
    hgsehgmhgrihhlrdgtohhmqeenucffohhmrghinheplhgushdrshgsnecukfhppeehvddr
    udehhedrudduuddrjedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvg
    hsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheeh
    hedvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
    enucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:q832XVNfTCZ3v6Kv4pI60WtD8isXG21O9hss97uye1E18hH8M8o9Ww>
    <xmx:q832Xa_Z41VClRCH52woC1AnmwXQ_d6yDhF5xYPbLu89-tOq4nGZrg>
    <xmx:q832XeLFb0c_FEbHERaQ81gytweMZOLjCeZvlG8JEE1w307tDWYTyA>
    <xmx:q832XbGdsmzDJ6ZAgBmhTbg-OS0cKYnSXKrIkKdBlIb_jlstk1yAcB_QM4Y>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id EB795306012F;
        Sun, 15 Dec 2019 19:19:54 -0500 (EST)
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
        Matteo Croce <mcroce@redhat.com>,
        Allison Randal <allison@lohutok.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexios Zavras <alexios.zavras@intel.com>
Subject: [RFC 4/6] arm64: vdso: hyperv: Map tsc page into vDSO if enabled
Date:   Mon, 16 Dec 2019 08:19:20 +0800
Message-Id: <20191216001922.23008-5-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216001922.23008-1-boqun.feng@gmail.com>
References: <20191216001922.23008-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Hyper-V, a tsc page has the data for adjusting cntvct numbers to
clocksource cycles, and that's how Hyper-V guest kernel reads the
clocksource. In order to allow userspace to read the same clocksource
directly, the tsc page has to been mapped into userspace via vDSO.

Use the framework for vDSO set-up in __vdso_init() to do this.

Note: if HYPERV_TIMER=y but the kernel is using other clocksource or
doesn't have the hyperv timer clocksource, tsc page will still be mapped
into userspace.

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
---
 arch/arm64/kernel/vdso.c          | 12 ++++++++++++
 arch/arm64/kernel/vdso/vdso.lds.S | 12 +++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index b9b5ec7a3084..18a634987bdc 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -9,6 +9,7 @@
 
 #include <linux/cache.h>
 #include <linux/clocksource.h>
+#include <clocksource/hyperv_timer.h>
 #include <linux/elf.h>
 #include <linux/err.h>
 #include <linux/errno.h>
@@ -105,14 +106,22 @@ static int __vdso_init(enum arch_vdso_type arch_index)
 	struct page **vdso_code_pagelist;
 	unsigned long nr_vdso_pages;
 	unsigned long pfn;
+	struct ms_hyperv_tsc_page *tsc_page;
+	int tsc_page_idx;
 
 	if (memcmp(vdso_lookup[arch_index].vdso_code_start, "\177ELF", 4)) {
 		pr_err("vDSO is not a valid ELF object!\n");
 		return -EINVAL;
 	}
 
+	/* One vDSO data page */
 	vdso_lookup[arch_index].nr_vdso_data_pages = 1;
 
+	/* Grab the Hyper-V tsc page, if enabled, add one more page */
+	tsc_page = hv_get_tsc_page();
+	if (tsc_page)
+		tsc_page_idx = vdso_lookup[arch_index].nr_vdso_data_pages++;
+
 	vdso_lookup[arch_index].nr_vdso_code_pages = (
 			vdso_lookup[arch_index].vdso_code_end -
 			vdso_lookup[arch_index].vdso_code_start) >>
@@ -130,6 +139,9 @@ static int __vdso_init(enum arch_vdso_type arch_index)
 	/* Grab the vDSO data page. */
 	vdso_pagelist[0] = phys_to_page(__pa_symbol(vdso_data));
 
+	if (tsc_page)
+		vdso_pagelist[tsc_page_idx] = phys_to_page(__pa(tsc_page));
+
 	/* Grab the vDSO code pages. */
 	pfn = sym_to_pfn(vdso_lookup[arch_index].vdso_code_start);
 
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.lds.S
index 7ad2d3a0cd48..e40a1f5a6d30 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -17,7 +17,17 @@ OUTPUT_ARCH(aarch64)
 
 SECTIONS
 {
-	PROVIDE(_vdso_data = . - PAGE_SIZE);
+	/*
+	 * vdso data pages:
+	 *   vdso data (1 page)
+	 *   hv tsc page (1 page if enabled)
+	 */
+	PROVIDE(_vdso_data = _hvclock_page - PAGE_SIZE);
+#ifdef CONFIG_HYPERV_TIMER
+	PROVIDE(_hvclock_page = . - PAGE_SIZE);
+#else
+	PROVIDE(_hvclock_page = .);
+#endif
 	. = VDSO_LBASE + SIZEOF_HEADERS;
 
 	.hash		: { *(.hash) }			:text
-- 
2.24.0

