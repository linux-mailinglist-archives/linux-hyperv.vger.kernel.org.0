Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464D95B1E06
	for <lists+linux-hyperv@lfdr.de>; Thu,  8 Sep 2022 15:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbiIHNI4 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 8 Sep 2022 09:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiIHNIt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 8 Sep 2022 09:08:49 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.221.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D1B9C59F1;
        Thu,  8 Sep 2022 06:08:41 -0700 (PDT)
X-QQ-mid: bizesmtp63t1662642492tnlj5i5r
Received: from localhost.localdomain ( [182.148.14.0])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 08 Sep 2022 21:08:11 +0800 (CST)
X-QQ-SSF: 01000000002000B0C000B00A0000000
X-QQ-FEAT: D6RqbDSxuq6+r8ef+kw6Z75XjCwsOgMcZO1hDR10kAbH3EtZRXkH37pYTsg8e
        YB4K+QwesppJix51TZbKg32k6cD33mP9sw92mbBLzAwYw2iyBEJifoJyMytA4M7eJSlO15z
        VXsF0OThAmCU8o5Ua69SmVI4TpioYTs7FjPQx7Jzf5GZwBozr/DQzvuSmvkxGca00oh+c5V
        Yfvr2gXyQS3iIYSCOY3HFZaE5/hzWIQkGgk0Nq4Vx5j90mhisjDQlm0aLbY4ISIigavCr5b
        +TeDG0XU1cHZ/sSuFwJj5IYVQHWNGxKeIygnJzEMUTIqdkzL3XCsSegcQd6mrIEM/fymGwD
        00XHHatPmjOWLcVvGlMcfD9fGI/1Izbh2+KBr4xFFuQxHNDKGkcH/7O8o0XhQ==
X-QQ-GoodBg: 0
From:   wangjianli <wangjianli@cdjrlc.com>
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangjianli <wangjianli@cdjrlc.com>
Subject: [PATCH] drivers/scsi: fix repeated words in comments
Date:   Thu,  8 Sep 2022 21:07:54 +0800
Message-Id: <20220908130754.34999-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Delete the redundant word 'to'.

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 drivers/scsi/storvsc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 573f89eade3b..9f7c71a8c80e 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -2059,7 +2059,7 @@ static int storvsc_probe(struct hv_device *device,
 err_out2:
 	/*
 	 * Once we have connected with the host, we would need to
-	 * to invoke storvsc_dev_remove() to rollback this state and
+	 * invoke storvsc_dev_remove() to rollback this state and
 	 * this call also frees up the stor_device; hence the jump around
 	 * err_out1 label.
 	 */
-- 
2.36.1

