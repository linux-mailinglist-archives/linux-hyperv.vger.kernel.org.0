Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF09B687F87
	for <lists+linux-hyperv@lfdr.de>; Thu,  2 Feb 2023 15:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229666AbjBBOJ1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 2 Feb 2023 09:09:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjBBOJ0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 2 Feb 2023 09:09:26 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57BD087161;
        Thu,  2 Feb 2023 06:09:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 467DD61B66;
        Thu,  2 Feb 2023 14:09:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F10DCC4339B;
        Thu,  2 Feb 2023 14:09:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675346962;
        bh=fcXByrYMeAYU0QEawUizJluIVGp45lsSXGtpusnK5H4=;
        h=From:To:Cc:Subject:Date:From;
        b=qkCf7n/jq3U7En6Zb8foWGxOWszxPIiv35R1TFMs5MQfNxsXsR8aGMXrHMEW3sTIg
         e2DlqdnjIcGct5PnHihqUIUrI5quCDkkE5KkIxWOCxiezGsKZqmABHg/zOY8vfEMhU
         RJpXWxYqKYD77OH9VGce4I3KSri2GhRh65I7N3e4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-hyperv@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] HV: hv_balloon: fix memory leak with using debugfs_lookup()
Date:   Thu,  2 Feb 2023 15:09:18 +0100
Message-Id: <20230202140918.2289522-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1073; i=gregkh@linuxfoundation.org; h=from:subject; bh=fcXByrYMeAYU0QEawUizJluIVGp45lsSXGtpusnK5H4=; b=owGbwMvMwCRo6H6F97bub03G02pJDMm3j/AwXnp9/q2R/p2bsi98QiwnsJbMM3LXV2q6Os2K48yE Lhe9jlgWBkEmBlkxRZYv23iO7q84pOhlaHsaZg4rE8gQBi5OAZiI/DWG+c6+Ni+rf1i6Lt3SfUxbdn NtwrGCKQzzs6MYGWq1bO/NY7mpek/urOjVZW3CAA==
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

When calling debugfs_lookup() the result must have dput() called on it,
otherwise the memory will leak over time.  To make things simpler, just
call debugfs_lookup_and_remove() instead which handles all of the logic
at once.

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hv/hv_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index cbe43e2567a7..64ac5bdee3a6 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1963,7 +1963,7 @@ static void  hv_balloon_debugfs_init(struct hv_dynmem_device *b)
 
 static void  hv_balloon_debugfs_exit(struct hv_dynmem_device *b)
 {
-	debugfs_remove(debugfs_lookup("hv-balloon", NULL));
+	debugfs_lookup_and_remove("hv-balloon", NULL);
 }
 
 #else
-- 
2.39.1

