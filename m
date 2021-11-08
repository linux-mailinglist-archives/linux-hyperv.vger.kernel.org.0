Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C737447D62
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Nov 2021 11:13:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238635AbhKHKPh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Nov 2021 05:15:37 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38270 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238553AbhKHKPG (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Nov 2021 05:15:06 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C02C91EC04F9;
        Mon,  8 Nov 2021 11:12:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366341;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=p1nGyibGvf59NpOAO7wV/X/d026fwSGAncC/X46u+GM=;
        b=IEjLECFemLU74CeuCcRAAH5o95ocxRSblNeMwXhBkZjbDSkeylQ+q7YiDqhK0jce01s3LB
        kieX6N8MKvfw8MUw40jJ4VapsnCs2eU9TwFIk+HF/JYtDjeP/24kFB0NFi9Xp1sqDbxBt+
        SiPIHeSWSBhGjHwbDF4m6wldCiAex1c=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-fbdev@vger.kernel.org, linux-hyperv@vger.kernel.org
Subject: [PATCH v0 17/42] drivers: video: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:32 +0100
Message-Id: <20211108101157.15189-18-bp@alien8.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20211108101157.15189-1-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Avoid homegrown notifier registration checks.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-fbdev@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
---
 drivers/video/console/dummycon.c | 3 ++-
 drivers/video/fbdev/hyperv_fb.c  | 5 +++--
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/video/console/dummycon.c b/drivers/video/console/dummycon.c
index f1711b2f9ff0..2d0cdd76dfde 100644
--- a/drivers/video/console/dummycon.c
+++ b/drivers/video/console/dummycon.c
@@ -36,7 +36,8 @@ void dummycon_register_output_notifier(struct notifier_block *nb)
 {
 	WARN_CONSOLE_UNLOCKED();
 
-	raw_notifier_chain_register(&dummycon_output_nh, nb);
+	if (raw_notifier_chain_register(&dummycon_output_nh, nb))
+		pr_warn("dummycon output notifier already registered\n");
 
 	if (dummycon_putc_called)
 		nb->notifier_call(nb, 0, NULL);
diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 23999df52739..183bd459e5c2 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -1255,8 +1255,9 @@ static int hvfb_probe(struct hv_device *hdev,
 
 	par->synchronous_fb = false;
 	par->hvfb_panic_nb.notifier_call = hvfb_on_panic;
-	atomic_notifier_chain_register(&panic_notifier_list,
-				       &par->hvfb_panic_nb);
+
+	if (atomic_notifier_chain_register(&panic_notifier_list, &par->hvfb_panic_nb))
+		pr_warn("Hyper-V FB panic notifier already registered\n");
 
 	return 0;
 
-- 
2.29.2

