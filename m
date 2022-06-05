Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA0B53DAE9
	for <lists+linux-hyperv@lfdr.de>; Sun,  5 Jun 2022 10:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244963AbiFEIzt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 5 Jun 2022 04:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiFEIzs (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 5 Jun 2022 04:55:48 -0400
Received: from smtpbg.qq.com (smtpbg136.qq.com [106.55.201.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CE84504E;
        Sun,  5 Jun 2022 01:55:42 -0700 (PDT)
X-QQ-mid: bizesmtp91t1654419332t708ad00
Received: from localhost.localdomain ( [111.9.5.115])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 05 Jun 2022 16:55:25 +0800 (CST)
X-QQ-SSF: 01000000002000C0G000B00A0000000
X-QQ-FEAT: rCzLTtzQ0gf1BCNkKEop1dn2udIbXTrozZbiYciwJkOn2ym83SM09Qyzh0pIK
        Mj3fW6Py4jQfXzs+pNT26Rbn3GcaXhIHfutHvpRvPVr/Vn3sY1JUIVabrLwBkkrLyUoYcRP
        98nP4pyqQs6jqbPqbpwIw0bdZm32t5p3CKX3fQK9NyaljhmNrwXwNnPA5Jy8rkqy4hVddDK
        mhi89hJAeeVjDEw5o41VdTxku5damVIo0n+2quq8yPLwuO+E2/HPkEmf33zLc5hzBvfbDiW
        FVcWUaBhp02oTo5CWAYFJ/jYi/RPBqBX0CO4WtmgtanIuTN3JZF6AYREVOj79ll7GtI7tFe
        gjMFq28XXMj5KSbWKE=
X-QQ-GoodBg: 0
From:   Xiang wangx <wangxiang@cdjrlc.com>
To:     kys@microsoft.com
Cc:     haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiang wangx <wangxiang@cdjrlc.com>
Subject: [PATCH] Drivers: hv: Fix syntax errors in comments
Date:   Sun,  5 Jun 2022 16:55:24 +0800
Message-Id: <20220605085524.11289-1-wangxiang@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybgspam:qybgspam7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Delete the redundant word 'in'.

Signed-off-by: Xiang wangx <wangxiang@cdjrlc.com>
---
 drivers/hv/hv_kvp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index c698592b83e4..d35b60c06114 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -394,7 +394,7 @@ kvp_send_key(struct work_struct *dummy)
 	in_msg = kvp_transaction.kvp_msg;
 
 	/*
-	 * The key/value strings sent from the host are encoded in
+	 * The key/value strings sent from the host are encoded
 	 * in utf16; convert it to utf8 strings.
 	 * The host assures us that the utf16 strings will not exceed
 	 * the max lengths specified. We will however, reserve room
-- 
2.36.1

