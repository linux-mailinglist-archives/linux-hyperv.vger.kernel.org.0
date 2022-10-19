Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A476046CE
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Oct 2022 15:21:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbiJSNV1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Oct 2022 09:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230134AbiJSNUx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Oct 2022 09:20:53 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.67.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BA3A194FBB;
        Wed, 19 Oct 2022 06:06:30 -0700 (PDT)
X-QQ-mid: bizesmtp87t1666184172tv3azqre
Received: from localhost.localdomain ( [182.148.15.91])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 19 Oct 2022 20:56:10 +0800 (CST)
X-QQ-SSF: 01000000008000F0I000B00A0000000
X-QQ-FEAT: +bXiSo2NuBfBrSAf1PlD8ynDcF31d48ieGDuIUccW62rCEVnCrXgKMrvZpb9W
        DTJd+R5sevR9OWkabCezI/7wtnTrmT6a0j+Os7IWIU+uBlpJeyxE4Dh6+N1uW85NoL1tb0O
        EwU3t3AOysDk6mnSnlLczFII2qHkYJZZiS3XtT6gKxtk2TiCLumVNohAUN1xEHFQ9TS9+QI
        Y9bwsVsaBF4jWjATWmaby8aqra24aSHRP7iSZXd0Ehasc1HSRFtVCe4lPrEJSTBlqewjJXA
        qXL4QPQSePh6Fe4BlV5eGgCtNREFeOhWJVDgRhxoAH9EzDRVpdv52JZEURpO1bpcNWOsb6x
        qJtYRvLZX6/jVpdlOiA4BcjiqPh6alYqkJ62rgWkMVwar+wuqAgcgp1zvF07JP0qZy2XG8q
X-QQ-GoodBg: 0
From:   Jilin Yuan <yuanjilin@cdjrlc.com>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jilin Yuan <yuanjilin@cdjrlc.com>
Subject: [PATCH] Drivers: hv: fix repeated words in comments
Date:   Wed, 19 Oct 2022 20:56:04 +0800
Message-Id: <20221019125604.52999-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Delete the redundant word 'of'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/hv/hv_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_balloon.c b/drivers/hv/hv_balloon.c
index fdf6decacf06..6c127f061f06 100644
--- a/drivers/hv/hv_balloon.c
+++ b/drivers/hv/hv_balloon.c
@@ -905,7 +905,7 @@ static unsigned long handle_pg_range(unsigned long pg_start,
 			 * We have some residual hot add range
 			 * that needs to be hot added; hot add
 			 * it now. Hot add a multiple of
-			 * of HA_CHUNK that fully covers the pages
+			 * HA_CHUNK that fully covers the pages
 			 * we have.
 			 */
 			size = (has->end_pfn - has->ha_end_pfn);
-- 
2.36.1

