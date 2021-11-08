Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 955E2447D58
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Nov 2021 11:12:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237807AbhKHKPC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 8 Nov 2021 05:15:02 -0500
Received: from mail.skyhub.de ([5.9.137.197]:38254 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237746AbhKHKO7 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 8 Nov 2021 05:14:59 -0500
Received: from zn.tnic (p200300ec2f33110088892b77bd117736.dip0.t-ipconnect.de [IPv6:2003:ec:2f33:1100:8889:2b77:bd11:7736])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8DF0C1EC04DF;
        Mon,  8 Nov 2021 11:12:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1636366334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1iair6BWPYTb3fn2g/N3YxlgrdOuwpEEIcBJ21kHgLU=;
        b=YmYK5pWTuxMInILmWGuCaPPl5eN7NW8dSeDuDBpplcWi/gm6eS8Yba7OjFJkqwQSkGh3pr
        uzMQSNbwlKauDhee2yXt551kKgZq6L1lcrWQVUPNShKdhMusvu2up8w4nCrfMk9rFZ03Vk
        a/H86JSpIpv6ji/a8yN4Qve69hx4AiM=
From:   Borislav Petkov <bp@alien8.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-hyperv@vger.kernel.org
Subject: [PATCH v0 08/42] Drivers: hv: vmbus: Check notifier registration return value
Date:   Mon,  8 Nov 2021 11:11:23 +0100
Message-Id: <20211108101157.15189-9-bp@alien8.de>
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
Cc: linux-hyperv@vger.kernel.org
---
 drivers/hv/vmbus_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 392c1ac4f819..370afd108d2d 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1574,8 +1574,8 @@ static int vmbus_bus_init(void)
 	 * the VMbus channel connection to prevent any VMbus
 	 * activity after the VM panics.
 	 */
-	atomic_notifier_chain_register(&panic_notifier_list,
-			       &hyperv_panic_block);
+	if (atomic_notifier_chain_register(&panic_notifier_list, &hyperv_panic_block))
+		pr_warn("VMBus panic notifier already registered\n");
 
 	vmbus_request_offers();
 
-- 
2.29.2

