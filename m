Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A024A619172
	for <lists+linux-hyperv@lfdr.de>; Fri,  4 Nov 2022 07:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbiKDGw7 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 4 Nov 2022 02:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiKDGw6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 4 Nov 2022 02:52:58 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0934D292;
        Thu,  3 Nov 2022 23:52:58 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1134)
        id C66D820C3338; Thu,  3 Nov 2022 23:52:57 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C66D820C3338
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1667544777;
        bh=jb6l497PPbm1hNScY6pLdfDwqz1lLgbCVQL62N7ST2w=;
        h=From:To:Cc:Subject:Date:From;
        b=dd4z5rhEOCCgbd/WRAVLY7yoA2m04/GkgGrMz0g7VLTsdLI2jW4JbrfTfVX/VRIFn
         sAkezacDQDGg+thfyg4jQcJI47Q9FqEVCDm+t8OKZF/d79jy/fB7sWeoNHtwUKkiHx
         asLthUl0vRztG7P2lAQjCmi74Kds2wUDXi4raaj8=
From:   Shradha Gupta <shradhagupta@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     Shradha Gupta <shradhagupta@linux.microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Long Li <longli@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH] hv_balloon: Fix committed value in post_status() if dynamic memory is disabled
Date:   Thu,  3 Nov 2022 23:52:50 -0700
Message-Id: <1667544770-31377-1-git-send-email-shradhagupta@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

If Dynamic memory is disabled for VM, the committed value reported by the
post_status() call by hv_balloon driver includes compute_balloon_floor().
This is not needed if balloon_up operations or hot_add operations were
never requested on the VM(or if Dynamic memory was disabled for the VM)

Signed-off-by: Shradha Gupta <shradhagupta@linux.microsoft.com>
---
 drivers/hv/hv_balloon.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index fdf6decacf06..a6f5321d4a2e 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1129,11 +1129,23 @@ static unsigned long compute_balloon_floor(void)
 
 static unsigned long get_pages_committed(struct hv_dynmem_device *dm)
 {
-	return vm_memory_committed() +
-		dm->num_pages_ballooned +
-		(dm->num_pages_added > dm->num_pages_onlined ?
-		 dm->num_pages_added - dm->num_pages_onlined : 0) +
-		compute_balloon_floor();
+	unsigned long pages_committed;
+
+	pages_committed = vm_memory_committed();
+
+	/*
+	 * If no balloon_up or hot_add operation was performed do not add
+	 * num_pages_ballooned, number of pages offline or
+	 * compute_balloon_floor() to the pages_committed value
+	 */
+	if (dm->num_pages_ballooned || dm->num_pages_added) {
+		pages_committed += dm->num_pages_ballooned +
+			(dm->num_pages_added > dm->num_pages_onlined ?
+			 dm->num_pages_added - dm->num_pages_onlined : 0) +
+			 compute_balloon_floor();
+	}
+
+	return pages_committed;
 }
 
 /*
-- 
2.37.2

