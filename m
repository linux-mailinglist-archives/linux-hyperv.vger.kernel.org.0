Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45B1C3067FA
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Jan 2021 00:35:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbhA0Xcq (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 27 Jan 2021 18:32:46 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:49592 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231453AbhA0XcX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 27 Jan 2021 18:32:23 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1l4uHh-00019P-Uz; Wed, 27 Jan 2021 23:31:38 +0000
From:   Colin King <colin.king@canonical.com>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] hv_utils: Fix spelling mistake "Hearbeat" -> "Heartbeat"
Date:   Wed, 27 Jan 2021 23:31:36 +0000
Message-Id: <20210127233136.623465-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in an error message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hv/hv_util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index 34f3e789cc9a..e4aefeb330da 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -507,7 +507,7 @@ static void heartbeat_onchannelcallback(void *context)
 
 		/* Ensure recvlen is big enough to read header data */
 		if (recvlen < ICMSG_HDR) {
-			pr_err_ratelimited("Hearbeat request received. Packet length too small: %d\n",
+			pr_err_ratelimited("Heartbeat request received. Packet length too small: %d\n",
 					   recvlen);
 			break;
 		}
-- 
2.29.2

