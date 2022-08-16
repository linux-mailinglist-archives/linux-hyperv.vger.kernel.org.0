Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DAF596105
	for <lists+linux-hyperv@lfdr.de>; Tue, 16 Aug 2022 19:23:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230163AbiHPRXf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 16 Aug 2022 13:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbiHPRXe (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 16 Aug 2022 13:23:34 -0400
Received: from bg5.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1A36390;
        Tue, 16 Aug 2022 10:23:31 -0700 (PDT)
X-QQ-mid: bizesmtp67t1660670602t07ismjf
Received: from harry-jrlc.. ( [182.148.12.144])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 17 Aug 2022 01:23:11 +0800 (CST)
X-QQ-SSF: 0100000000200060D000B00A0000020
X-QQ-FEAT: 7L1V3dHhUFOfrXcLe5fWClKG+8D1dNxLwt1NI5KRaUqLUr7x0f7ef9UW0l2/8
        dXJin9wACu/JKd1EY4RoPJXQg7WNzCi+uQPl3JkyG6I1mfHi9gQBsxj0u+Sq+1UL9ZqmndH
        lZNMLYVaL6YOPGGgXTuF1gzYJqv6QXC74rR9CONOZUkvnMk2rGH1fKGi4uOc+ShWDjlHGH1
        FBZR2p9yD6LGbexuSUV9W0FgnIT1v/ELCeRk5fPVG//i8l40YdAEKy53BLZ9BFnbdL413yR
        /YKoG4+iq9kjLX9VXgriHyXn7v9KSbKLF0fAuiOZydTrtaLI/4/KvL92AwEgUJggEWVJZjP
        sk2DfPFopAsTxMznZY2vCxxQS33O/L7EbmQcmh/7Iv5GfOdmONHD5ymLclu1A==
X-QQ-GoodBg: 0
From:   Xin Gao <gaoxin@cdjrlc.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Xin Gao <gaoxin@cdjrlc.com>
Subject: [PATCH] tools: hv: Fix comment typo
Date:   Wed, 17 Aug 2022 01:23:09 +0800
Message-Id: <20220816172309.7072-1-gaoxin@cdjrlc.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr6
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The double `the' is duplicated in the comment, remove one.

Signed-off-by: Xin Gao <gaoxin@cdjrlc.com>
---
 tools/hv/hv_kvp_daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/hv/hv_kvp_daemon.c b/tools/hv/hv_kvp_daemon.c
index 1e6fd6ca513b..d5ddab830b6b 100644
--- a/tools/hv/hv_kvp_daemon.c
+++ b/tools/hv/hv_kvp_daemon.c
@@ -43,7 +43,7 @@
 #include <getopt.h>
 
 /*
- * KVP protocol: The user mode component first registers with the
+ * KVP protocol: The user mode component first registers with
  * the kernel component. Subsequently, the kernel component requests, data
  * for the specified keys. In response to this message the user mode component
  * fills in the value corresponding to the specified key. We overload the
-- 
2.30.2

