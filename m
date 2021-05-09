Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902943775BD
	for <lists+linux-hyperv@lfdr.de>; Sun,  9 May 2021 09:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229631AbhEIHOQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 9 May 2021 03:14:16 -0400
Received: from smtp06.smtpout.orange.fr ([80.12.242.128]:60769 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbhEIHOQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 9 May 2021 03:14:16 -0400
Received: from localhost.localdomain ([86.243.172.93])
        by mwinf5d86 with ME
        id 2XD52500321Fzsu03XD5xo; Sun, 09 May 2021 09:13:06 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 09 May 2021 09:13:06 +0200
X-ME-IP: 86.243.172.93
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        wei.liu@kernel.org, decui@microsoft.com, gregkh@linuxfoundation.org
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH 1/2] uio_hv_generic: Fix a memory leak in error handling paths
Date:   Sun,  9 May 2021 09:13:03 +0200
Message-Id: <4fdaff557deef6f0475d02ba7922ddbaa1ab08a6.1620544055.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

If 'vmbus_establish_gpadl()' fails, the (recv|send)_gpadl will not be
updated and 'hv_uio_cleanup()' in the error handling path will not be
able to free the corresponding buffer.

In such a case, we need to free the buffer explicitly.

Fixes: cdfa835c6e5e ("uio_hv_generic: defer opening vmbus until first use")
Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Before commit cdfa835c6e5e, the 'vfree' were done unconditionally
in 'hv_uio_cleanup()'.
So, another way for fixing the potential leak is to modify
'hv_uio_cleanup()' and revert to the previous behavior.

I don't know the underlying reason for this change so I don't know which is
the best way to fix this error handling path. Unless there is a specific
reason, changing 'hv_uio_cleanup()' could be better because it would keep
the error handling path of the probe cleaner, IMHO.
---
 drivers/uio/uio_hv_generic.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 0330ba99730e..eebc399f2cc7 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -296,8 +296,10 @@ hv_uio_probe(struct hv_device *dev,
 
 	ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
 				    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
-	if (ret)
+	if (ret) {
+		vfree(pdata->recv_buf);
 		goto fail_close;
+	}
 
 	/* put Global Physical Address Label in name */
 	snprintf(pdata->recv_name, sizeof(pdata->recv_name),
@@ -316,8 +318,10 @@ hv_uio_probe(struct hv_device *dev,
 
 	ret = vmbus_establish_gpadl(channel, pdata->send_buf,
 				    SEND_BUFFER_SIZE, &pdata->send_gpadl);
-	if (ret)
+	if (ret) {
+		vfree(pdata->send_buf);
 		goto fail_close;
+	}
 
 	snprintf(pdata->send_name, sizeof(pdata->send_name),
 		 "send:%u", pdata->send_gpadl);
-- 
2.30.2

