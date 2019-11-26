Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE7261097C4
	for <lists+linux-hyperv@lfdr.de>; Tue, 26 Nov 2019 03:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726926AbfKZCRt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 25 Nov 2019 21:17:49 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:37611 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfKZCRt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 25 Nov 2019 21:17:49 -0500
Received: by mail-qk1-f193.google.com with SMTP id e187so14810072qkf.4;
        Mon, 25 Nov 2019 18:17:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lum5yvTwyxlmtQGtde1ND4PsuRW3bzOGy1CfGppZ++Y=;
        b=ijh+tzmrex64seYZum553uDwhyi58v45cTa6vQE8qsQubHFn3IhgU0Pa9JDSwwE2GK
         dPZHLjo+37eyOaFKepsFjIhKy8pBNRSqqFOOrtyBnaSRbTIlNjqQThRoaGVJT3IS2YDK
         InQO385PaBlMTynVqRcq28Uf/MC32cDyaU4z0AgEMEMBVK0FVo5T62HLIhU1Hjj04Yao
         btPRjLJJCxd1FixCd903VqsGZj+NTvOQZmQNAB42obmLj0fLIpITlGq2fIen/6nnks4C
         FOIpWzaMRixzaFeXYsYlxu7V/S7lqD2m2VVgxOwfxR/yKy+vDcygXOuQ40FNVDNx2084
         IPCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=lum5yvTwyxlmtQGtde1ND4PsuRW3bzOGy1CfGppZ++Y=;
        b=hljxiIkQPBRXT6UwlDz9U0DZqvKuWgw195M+knwDykBTviT+raDyAwnmg02C3o1GMB
         hit8CNpURHrUr4AUDf5rhsMIoeo84lqgQOEEu0mD9wO4s8KqSGjoe8CIpcMT8mn0AfKF
         VvBkmNjRsYcjA12N1Lq0+twttKTx4XyNL3cwr5DnekqG2Yv7D/mlkyWCrI3thWMSuaxW
         Ja/u3npP8pEfbHdOXBloxw4Pc+kFkRfBY/Tot6tODGyClesb/TnIm2O03UeP+I1DrDeF
         rYG5esE/x1FUE7Au95OLa3+RTwdurSnHSHlTDhZx/gQkrVIYt0+Ll/TPTc8EhhgFaXic
         126A==
X-Gm-Message-State: APjAAAWdQBWUMHAaw9H9qrq8Ywj4PqjFVcZdClbXkaiRNGK2zrwi72+f
        urcci0QjSXZtbwhd627DYWFUefPr
X-Google-Smtp-Source: APXvYqyDmXCLYu7zkSEIYa48Hku6Ktklg4NWhTrGPK3SpkZ3qC8Ugb+b/bgmX5rZf/c/qzzeSL86zw==
X-Received: by 2002:a37:4d89:: with SMTP id a131mr19040147qkb.241.1574734666699;
        Mon, 25 Nov 2019 18:17:46 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id v65sm4406930qkh.7.2019.11.25.18.17.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Nov 2019 18:17:45 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9AEF3226FC;
        Mon, 25 Nov 2019 21:17:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 25 Nov 2019 21:17:44 -0500
X-ME-Sender: <xms:SIvcXVjqX8ZqBlc9-SYhoB01Y2hlUYMPj08uw47KYUnzsp4_9q5lKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrudeivddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecukfhppeehvddrud
    ehhedrudduuddrjedunecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghs
    mhhtphgruhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhe
    dvqdgsohhquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvgen
    ucevlhhushhtvghrufhiiigvpedt
X-ME-Proxy: <xmx:SIvcXY_crJDuNoe1E7pXLISd1o7jcgfCLlgcUL_MxVsSxJL0W9v8jg>
    <xmx:SIvcXRLWQHHU18cdPMdCo0GOEcK7c4NTaZFihj-dexW8R4FdAUy-lA>
    <xmx:SIvcXdzBas5aRYEnaFVp3xfTxmykQ0cuFBik3srFGt3_FMbgTCytxg>
    <xmx:SIvcXYQS3-BGxQxB4BqxZVHkS11RT7hnNK8_vDK9crm-Qxzfdfd17LW20QQ>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id BEF61306005F;
        Mon, 25 Nov 2019 21:17:43 -0500 (EST)
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-hyperv@vger.kernel.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] clocksource: hyperv: Reserve PAGE_SIZE space for tsc page
Date:   Tue, 26 Nov 2019 10:17:20 +0800
Message-Id: <20191126021723.4710-1-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently, the reserved size for a tsc page is 4K, which is enough for
communicating with hypervisor. However, in the case where we want to
export the tsc page to userspace (e.g. for vDSO to read the
clocksource), the tsc page should be at least PAGE_SIZE, otherwise, when
PAGE_SIZE is larger than 4K, extra kernel data will be mapped into
userspace, which means leaking kernel information.

Therefore reserve PAGE_SIZE space for tsc_pg as a preparation for the
vDSO support of ARM64 in the future. Also, while at it, replace all
reference to tsc_pg with hv_get_tsc_page() since it should be the only
interface to access tsc page.

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
Cc: linux-hyperv@vger.kernel.org
---
 drivers/clocksource/hyperv_timer.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
index 2317d4e3daaf..bcac936fa62b 100644
--- a/drivers/clocksource/hyperv_timer.c
+++ b/drivers/clocksource/hyperv_timer.c
@@ -213,17 +213,20 @@ EXPORT_SYMBOL_GPL(hv_stimer_global_cleanup);
 struct clocksource *hyperv_cs;
 EXPORT_SYMBOL_GPL(hyperv_cs);
 
-static struct ms_hyperv_tsc_page tsc_pg __aligned(PAGE_SIZE);
+static union {
+	struct ms_hyperv_tsc_page page;
+	u8 reserved[PAGE_SIZE];
+} tsc_pg __aligned(PAGE_SIZE);
 
 struct ms_hyperv_tsc_page *hv_get_tsc_page(void)
 {
-	return &tsc_pg;
+	return &tsc_pg.page;
 }
 EXPORT_SYMBOL_GPL(hv_get_tsc_page);
 
 static u64 notrace read_hv_clock_tsc(struct clocksource *arg)
 {
-	u64 current_tick = hv_read_tsc_page(&tsc_pg);
+	u64 current_tick = hv_read_tsc_page(hv_get_tsc_page());
 
 	if (current_tick == U64_MAX)
 		hv_get_time_ref_count(current_tick);
@@ -278,7 +281,7 @@ static bool __init hv_init_tsc_clocksource(void)
 		return false;
 
 	hyperv_cs = &hyperv_cs_tsc;
-	phys_addr = virt_to_phys(&tsc_pg);
+	phys_addr = virt_to_phys(hv_get_tsc_page());
 
 	/*
 	 * The Hyper-V TLFS specifies to preserve the value of reserved
-- 
2.24.0

