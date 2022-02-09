Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 123764AE835
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Feb 2022 05:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345782AbiBIEHu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Feb 2022 23:07:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346273AbiBIDXX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Feb 2022 22:23:23 -0500
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0257DC061576;
        Tue,  8 Feb 2022 19:23:23 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1644376998;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y8t74zSXdVdVEqvsmjbyK1jndX1+u445HuQ3KsiGyrE=;
        b=wK3CEApaLy3nGlQriQlv3vZpjrLb/IInbkvLnEqImOLPlX/zjErxQ0/vOW2nT2Ggv43Ray
        WwwgLOng4itLCuvHqrjq2h+FcuBigxX9xw0Pf2Ev49FOxFJoX1Sh4HnEihYBA31m/B1319
        DO9Gs92N/WudhHOaNiyiNblIMnQJC5E=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: hv: utils: Make use of the helper macro LIST_HEAD()
Date:   Wed,  9 Feb 2022 11:22:51 +0800
Message-Id: <20220209032251.37362-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,TO_EQ_FM_DIRECT_MX,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Replace "struct list_head head = LIST_HEAD_INIT(head)" with
"LIST_HEAD(head)" to simplify the code.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/hv/hv_utils_transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_utils_transport.c b/drivers/hv/hv_utils_transport.c
index eb2833d2b5d0..832885198643 100644
--- a/drivers/hv/hv_utils_transport.c
+++ b/drivers/hv/hv_utils_transport.c
@@ -13,7 +13,7 @@
 #include "hv_utils_transport.h"
 
 static DEFINE_SPINLOCK(hvt_list_lock);
-static struct list_head hvt_list = LIST_HEAD_INIT(hvt_list);
+static LIST_HEAD(hvt_list);
 
 static void hvt_reset(struct hvutil_transport *hvt)
 {
-- 
2.25.1

