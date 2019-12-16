Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18D7611FC0B
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Dec 2019 01:19:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726526AbfLPATg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 15 Dec 2019 19:19:36 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:34211 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726373AbfLPATe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 15 Dec 2019 19:19:34 -0500
Received: by mail-qk1-f193.google.com with SMTP id j9so2937446qkk.1;
        Sun, 15 Dec 2019 16:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UVpf63Qd4TX5I9v6qZSm1vjU4JS6/z/tTXxQbaf4TBY=;
        b=D3mlEWftH/mVQoC67x99bNXce+yDo9uBMNOqzw1fGt6PhXd+LwHuVyfikJEw19svXT
         ahktUA0bg5LNwRtDfUXFXJtgYcVcz+WvgYNgKN52gtMp51f/HAJu//uMElnRofK2Dy+9
         Ewadu7SGqcg12XJ5zZTRprJ3NaY1znutfpXRlG4jrG/SFwQGxLAzeNLLgox4fEnUWkQw
         +J5igAXDv+iyg+LeIsh1Zj443GBnRzKKPnfRFWGm4ewPAuxQE/ACSVBktckgGgyZgqCR
         6LqvzSPpBJdipjqwU1V6qSP+X4WGwMPO3iyNej07cCFd7D54L3xTElk/AZTKjMtaVZW1
         RD7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UVpf63Qd4TX5I9v6qZSm1vjU4JS6/z/tTXxQbaf4TBY=;
        b=PSuk6YmoOLr8LaPv303RctTphRguIYcr+8qFp8KcZ7ghYtNESQJF5zU66R/9bk6tXO
         iD0KOyq5sTkeEjPOnhk0YxBildhIyujZyOXiY4ldYuehjbgYEo/zZgB2NGkEu94DfY7C
         j2QEsXIeb2qoZrzISvH4X30OGtSHFdPy/sjuWAoTBhoOC2P7TfUG+QFyrn49dNHPYh1F
         JBEuYZ3Q7rqduaI3FlVecFHj1GyrwroT5AyQT9gfmp32tKC2SnUw52g7YfkxX4GZUfvp
         5olOBi4/SJFDjDHN0wGEQuHosko6J/NGf4AkvvgK6/hKJnTHUJ4ns+E7ccWtlS+g1GDE
         Y87g==
X-Gm-Message-State: APjAAAWbE98712iVTEhgg2K0mZZH9n5kzLsXEloDjx2zf7OL/dLGcDFv
        ZqYE+oNTGODrFsQq6G/huBA=
X-Google-Smtp-Source: APXvYqx3q9o5IJDrNl2qRBw2P9CxytUA2HNSYLBG2f5II++aBKtmeVfY050HNOiMvaqJ5iFUhF31NA==
X-Received: by 2002:a37:4047:: with SMTP id n68mr24901320qka.258.1576455573256;
        Sun, 15 Dec 2019 16:19:33 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id g16sm5431819qkk.61.2019.12.15.16.19.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Dec 2019 16:19:32 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 851932243F;
        Sun, 15 Dec 2019 19:19:31 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 15 Dec 2019 19:19:31 -0500
X-ME-Sender: <xms:k832XadXgrGcvhHXrQgixQfusVx3I2zgBe1vYGxMM1OBi1ia7pJkfQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrvddtgedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhorhhtvggutfgvtghiphdvucdlgedtmdenucfjughrpefhvffufffkofgjfhgggfes
    tdekredtredttdenucfhrhhomhepuehoqhhunhcuhfgvnhhguceosghoqhhunhdrfhgvnh
    hgsehgmhgrihhlrdgtohhmqeenucfkphephedvrdduheehrdduuddurdejudenucfrrghr
    rghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrg
    hlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeep
    ghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgvnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:k832XUi8fzGm26Bbd8FBjgs6V_X1Z6B77yd2PtlZUsUELS9iVEIaaA>
    <xmx:k832XW_7t8KIwsegj48VkjbCQyL995c-MkpH-jRx3rDzPL12KDDzDw>
    <xmx:k832XSbyuh6uVe5LGlV4GvbhPrxOw1t7oRzFp7J8wp3DS_UzsmDG0g>
    <xmx:k832XfcXy6BV60t5ZHB6ZgVtmayIz_Uvuf_yjzhevdi1WusdebQV2BB0RDQ>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id DF9058005C;
        Sun, 15 Dec 2019 19:19:30 -0500 (EST)
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
        Boqun Feng <boqun.feng@gmail.com>
Subject: [RFC 1/6] arm64: hyperv: Allow hv_get_raw_timer() definition to be overridden
Date:   Mon, 16 Dec 2019 08:19:17 +0800
Message-Id: <20191216001922.23008-2-boqun.feng@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191216001922.23008-1-boqun.feng@gmail.com>
References: <20191216001922.23008-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

In order to support vDSO, hv_read_tsc_page() should be able to be called
from userspace if tsc page mapped. As a result, hv_get_raw_timer(),
called by hv_read_tsc_page() requires to be called by both kernel and
vDSO. Currently, it's defined as arch_timer_read_counter(), which is a
function pointer initialized (using a kernel address) by the arch timer
driver, therefore not usable in vDSO.

Fix this by allowing a previous definition to override the default one,
so that in vDSO code, we can define it as a function callable in
userspace.

Signed-off-by: Boqun Feng (Microsoft) <boqun.feng@gmail.com>
---
 arch/arm64/include/asm/mshyperv.h | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/mshyperv.h b/arch/arm64/include/asm/mshyperv.h
index a8468a611912..9cc4aeddf2d0 100644
--- a/arch/arm64/include/asm/mshyperv.h
+++ b/arch/arm64/include/asm/mshyperv.h
@@ -97,8 +97,15 @@ extern void hv_get_vpreg_128(u32 reg, struct hv_get_vp_register_output *result);
 #define hv_disable_stimer0_percpu_irq(irq)	disable_percpu_irq(irq)
 #endif
 
-/* ARM64 specific code to read the hardware clock */
+/*
+ * ARM64 specific code to read the hardware clock.
+ *
+ * This could be used in both kernel space and userspace (vDSO), so make it
+ * possible for a previous definition to override the default one.
+ */
+#ifndef hv_get_raw_timer
 #define hv_get_raw_timer() arch_timer_read_counter()
+#endif
 
 #include <asm-generic/mshyperv.h>
 
-- 
2.24.0

