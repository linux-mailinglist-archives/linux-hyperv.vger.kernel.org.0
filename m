Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A6375AC51D
	for <lists+linux-hyperv@lfdr.de>; Sun,  4 Sep 2022 17:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234247AbiIDPs3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 4 Sep 2022 11:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDPs3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 4 Sep 2022 11:48:29 -0400
Received: from smtpbg.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 600883719C
        for <linux-hyperv@vger.kernel.org>; Sun,  4 Sep 2022 08:48:24 -0700 (PDT)
X-QQ-mid: bizesmtp87t1662306495th5ofvuz
Received: from localhost.localdomain ( [182.148.14.80])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 04 Sep 2022 23:48:09 +0800 (CST)
X-QQ-SSF: 01000000002000C0C000B00A0000000
X-QQ-FEAT: VNWd8gjdZNqmAsjqkP0E6dXZQHpeBd3fhcd/2H6f1wnMFlZGVCPgYwUIcfftc
        XZLmioHjkesacywsQoL2dfd5cl+DnyeXKl5G4cJzP1c+IhE/ilMcD+ssTtZDAQ4Ix42Oz9U
        1dBkrc0AnsRcKpmpeqVK8PsxSMcf/6KIRNuLf6JH6BR4OqqrlLXtI7GdtpG8t1Fh0ekKHOU
        xijPpB4Mek3z0WjfG4vM/igWnVladc8SD9lvRK55X2DOUVvvlY2hbnLv1OWI8G8R15qxuZZ
        0lF6vW4EWXD7pk5BKvulOJhzX3ZKiwCbEkyqgeE5+mu9jgkyYF2mwCDQwiuDogPVI+utt7J
        wHXTC72bb+gXD0crac0KLfbrAX0tFVDq2xAtEu5GnquVaHNp0naJEJvCAuj0g==
X-QQ-GoodBg: 0
From:   Shaomin Deng <dengshaomin@cdjrlc.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com,
        linux-hyperv@vger.kernel.org
Cc:     Shaomin Deng <dengshaomin@cdjrlc.com>
Subject: [PATCH] Drivers: hv: Fix double word in comments
Date:   Sun,  4 Sep 2022 11:48:08 -0400
Message-Id: <20220904154808.26022-1-dengshaomin@cdjrlc.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Delete the rebundant word "in" in comments.

Signed-off-by: Shaomin Deng <dengshaomin@cdjrlc.com>
---
 drivers/hv/hv_fcopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_fcopy.c b/drivers/hv/hv_fcopy.c
index 660036da7449..922d83eb7ddf 100644
--- a/drivers/hv/hv_fcopy.c
+++ b/drivers/hv/hv_fcopy.c
@@ -129,7 +129,7 @@ static void fcopy_send_data(struct work_struct *dummy)
 
 	/*
 	 * The  strings sent from the host are encoded in
-	 * in utf16; convert it to utf8 strings.
+	 * utf16; convert it to utf8 strings.
 	 * The host assures us that the utf16 strings will not exceed
 	 * the max lengths specified. We will however, reserve room
 	 * for the string terminating character - in the utf16s_utf8s()
-- 
2.35.1

