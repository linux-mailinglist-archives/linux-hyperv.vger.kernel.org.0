Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C034A49BABE
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Jan 2022 18:58:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240599AbiAYR4k (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 25 Jan 2022 12:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385185AbiAYRyu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 25 Jan 2022 12:54:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2364C06175E;
        Tue, 25 Jan 2022 09:54:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7F05CB819DC;
        Tue, 25 Jan 2022 17:54:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BE27C340E0;
        Tue, 25 Jan 2022 17:54:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643133286;
        bh=e8RIDdHaka7BpYFM9Quoh+WQnHQ0tbZzk2YChopEt5k=;
        h=Date:From:To:Cc:Subject:From;
        b=kfe3v9vI/NVHnoFrPeCBhSyVHjQQDrMtFRj2FLGHhtonu4oVamFx2uaUDoex/ZPwl
         zAnO3bCTPb9q619jkKtp8C1pKJs+BkuizxhpCxMKjeiPV8PutwIkovgwe8m+mrFAMM
         2HEC5/bm4WyeaEShCLHujXX1zoGLyVfDlZOEvGB6zvoypSLpPLnlheC948/vEtMNsN
         /fdY4pHAsSdnn3fHTGfUNrB0XxeSV1ybgzkbB/ohctVLAxpjqfQ05uUhAiSMJhSLRq
         3rYxH/SCyAD0/K0KLdZnAVPnfzcfa4kBNlSjiA/QDbNGNDJwFRub/mtBKmXwTelMft
         NwUAu3eCvQhBQ==
Date:   Tue, 25 Jan 2022 12:01:31 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-hardening@vger.kernel.org
Subject: [PATCH][next] Drivers: hv: vmbus: Use struct_size() helper in
 kmalloc()
Message-ID: <20220125180131.GA67746@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows that,
in the worst scenario, could lead to heap overflows.

Also, address the following sparse warnings:
drivers/hv/vmbus_drv.c:1132:31: warning: using sizeof on a flexible structure

Link: https://github.com/KSPP/linux/issues/174
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 17bf55fe3169..cd193456cd84 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1129,7 +1129,7 @@ void vmbus_on_msg_dpc(unsigned long data)
 	}
 
 	if (entry->handler_type	== VMHT_BLOCKING) {
-		ctx = kmalloc(sizeof(*ctx) + payload_size, GFP_ATOMIC);
+		ctx = kmalloc(struct_size(ctx, msg.payload, payload_size), GFP_ATOMIC);
 		if (ctx == NULL)
 			return;
 
-- 
2.27.0

