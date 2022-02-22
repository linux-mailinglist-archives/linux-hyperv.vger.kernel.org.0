Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D71814BFACC
	for <lists+linux-hyperv@lfdr.de>; Tue, 22 Feb 2022 15:21:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232665AbiBVOWW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 22 Feb 2022 09:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiBVOWV (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 22 Feb 2022 09:22:21 -0500
X-Greylist: delayed 445 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 22 Feb 2022 06:21:56 PST
Received: from mail.bitwise.fi (mail.bitwise.fi [109.204.228.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 895FDA278F;
        Tue, 22 Feb 2022 06:21:56 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by mail.bitwise.fi (Postfix) with ESMTP id 0E72D46001C;
        Tue, 22 Feb 2022 16:14:30 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at 
Received: from mail.bitwise.fi ([127.0.0.1])
        by localhost (mustetatti.dmz.bitwise.fi [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6HK8W964f5TN; Tue, 22 Feb 2022 16:14:24 +0200 (EET)
Received: from localhost.net (fw1.dmz.bitwise.fi [192.168.69.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: anssiha)
        by mail.bitwise.fi (Postfix) with ESMTPSA id C51B546000C;
        Tue, 22 Feb 2022 16:14:24 +0200 (EET)
From:   Anssi Hannula <anssi.hannula@bitwise.fi>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] hv_balloon: rate-limit "Unhandled message" warning
Date:   Tue, 22 Feb 2022 16:14:00 +0200
Message-Id: <20220222141400.98160-1-anssi.hannula@bitwise.fi>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

For a couple of times I have encountered a situation where

  hv_balloon: Unhandled message: type: 12447

is being flooded over 1 million times per second with various values,
filling the log and consuming cycles, making debugging difficult.

Add rate limiting to the message.

Most other Hyper-V drivers already have similar rate limiting in their
message callbacks.

The cause of the floods in my case was probably fixed by 96d9d1fa5cd5
("Drivers: hv: balloon: account for vmbus packet header in
max_pkt_size").

Fixes: 9aa8b50b2b3d ("Drivers: hv: Add Hyper-V balloon driver")
Signed-off-by: Anssi Hannula <anssi.hannula@bitwise.fi>
---
 drivers/hv/hv_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index f2d05bff4245..439f99b8b5de 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -1563,7 +1563,7 @@ static void balloon_onchannelcallback(void *context)
 			break;
 
 		default:
-			pr_warn("Unhandled message: type: %d\n", dm_hdr->type);
+			pr_warn_ratelimited("Unhandled message: type: %d\n", dm_hdr->type);
 
 		}
 	}
-- 
2.34.1

