Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F634665A26
	for <lists+linux-hyperv@lfdr.de>; Wed, 11 Jan 2023 12:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjAKLbD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 11 Jan 2023 06:31:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232316AbjAKLaj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 11 Jan 2023 06:30:39 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4D5B95B3;
        Wed, 11 Jan 2023 03:30:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8E7E9B81B8D;
        Wed, 11 Jan 2023 11:30:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D55ADC433EF;
        Wed, 11 Jan 2023 11:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1673436635;
        bh=n8OnoHXUKt8/vexOA9DOw2P/znFEmBc1dMUhPM/P1nE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2sy49pouXHeFMASqr063ewfQj/lTX3SXAOjasByVHYZhWJtGQf+RQpeHziZY54PeY
         JXq+p19tkWKhMMWJx/E/kp6W25ZORCcL6ZjLRYaGln7pPm8n61zZDJYS4UjHnpI6PH
         Zz4N6jXJRlr1PtNp9rX+/FZOhZkDRoyUJupRvbEM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org
Subject: [PATCH v2 10/16] drivers: hv: move device_to_hv_device to use container_of_const()
Date:   Wed, 11 Jan 2023 12:30:12 +0100
Message-Id: <20230111113018.459199-11-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111113018.459199-1-gregkh@linuxfoundation.org>
References: <20230111113018.459199-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1177; i=gregkh@linuxfoundation.org; h=from:subject; bh=n8OnoHXUKt8/vexOA9DOw2P/znFEmBc1dMUhPM/P1nE=; b=owGbwMvMwCRo6H6F97bub03G02pJDMn75p68dtJ97m/PZ6YrTvN9j4tZYrzO51pEfViqqM8V7m6l c1nnO2JZGASZGGTFFFm+bOM5ur/ikKKXoe1pmDmsTCBDGLg4BWAiN+4zzHd07zprkHDlNOMpv//hrd tW83MGBTEs2BxmsuBRzpwd6/jnMYrpL0sXlnjlCAA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The driver core is changing to pass some pointers as const, so move
device_to_hv_device() to use container_of_const() to handle this change.

device_to_hv_device() now properly keeps the const-ness of the pointer
passed into it, while as before it could be lost.

Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/hyperv.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index 85f7c5a63aa6..8430e27f3c3f 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1309,10 +1309,7 @@ struct hv_device {
 };
 
 
-static inline struct hv_device *device_to_hv_device(struct device *d)
-{
-	return container_of(d, struct hv_device, device);
-}
+#define device_to_hv_device(d)	container_of_const(d, struct hv_device, device)
 
 static inline struct hv_driver *drv_to_hv_drv(struct device_driver *d)
 {
-- 
2.39.0

