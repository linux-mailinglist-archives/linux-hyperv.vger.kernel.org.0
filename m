Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C697CFCBC5
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Nov 2019 18:27:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725976AbfKNR11 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 14 Nov 2019 12:27:27 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:44707 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbfKNR10 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Nov 2019 12:27:26 -0500
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1iVItt-0003AZ-5S; Thu, 14 Nov 2019 17:27:21 +0000
From:   Colin King <colin.king@canonical.com>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] video: hyperv: hyperv_fb: fix indentation issue
Date:   Thu, 14 Nov 2019 17:27:20 +0000
Message-Id: <20191114172720.322023-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

There is a block of statements that are indented
too deeply, remove the extraneous tabs.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/video/fbdev/hyperv_fb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/video/fbdev/hyperv_fb.c b/drivers/video/fbdev/hyperv_fb.c
index 4cd27e5172a1..5fcf4bdf85ab 100644
--- a/drivers/video/fbdev/hyperv_fb.c
+++ b/drivers/video/fbdev/hyperv_fb.c
@@ -582,8 +582,8 @@ static int synthvid_get_supported_resolution(struct hv_device *hdev)
 	t = wait_for_completion_timeout(&par->wait, VSP_TIMEOUT);
 	if (!t) {
 		pr_err("Time out on waiting resolution response\n");
-			ret = -ETIMEDOUT;
-			goto out;
+		ret = -ETIMEDOUT;
+		goto out;
 	}
 
 	if (msg->resolution_resp.resolution_count == 0) {
-- 
2.20.1

