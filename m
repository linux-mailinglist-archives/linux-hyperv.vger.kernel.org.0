Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47C6C744A7
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jul 2019 07:04:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390321AbfGYFDx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 25 Jul 2019 01:03:53 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36753 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390312AbfGYFDx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 Jul 2019 01:03:53 -0400
Received: by mail-qt1-f196.google.com with SMTP id z4so47912509qtc.3;
        Wed, 24 Jul 2019 22:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=H39b2ploFjN9pdMuxlSa6UUk4s9UZsZu6j1GUYRP990=;
        b=mejtluFbzw8MkFwo5+Q7yt6ewsH00E2O/E73K+KPZYIM6WxeG6s9dhcT3dgam8ju9f
         0nLjITGV4dVI7Ji2FQj76lBR8yLRCqBg6abc/oQnoh07HQc1Y14ymVQaVxWxSyyEnP6L
         Dd2a5iy41AQJuJLUETGtKWzK+00KDGaWbqXIOr7XoDwWUyWFcLD0UK7vr6EJbHcJ91Ot
         fAIK0IENS1dlRqZkMrPwzd94rhGgqLNmlb1dPWYraor0izhlj8U9K8lYNqm+spwbSSCp
         z9Ba8jNxNTISd4pvEABWBFFT+28/LDqhBDugsjtKE2R+sqQNunHnG8p+dcY3oaSzrqWe
         qLbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=H39b2ploFjN9pdMuxlSa6UUk4s9UZsZu6j1GUYRP990=;
        b=MWd17BmNA+2Mc9ufN2Gvw7HrfnxQmqKTA/Ds/ZHiH6ssQZE+GVa025h2ZO0KJsgiLF
         Co1aLmFVyTFkMXpa/q5LdQLHCPFTz1ZZXj9piR10ywH6SGsTbK2NJErpCDQflmxnMww0
         D3MH4ZLOU9WttVSHRw5Y1ifDpo1KLbXyCET4Z86dgtv8WxtIBRKYcpQPC71Gjn0HoDEp
         ol8mbv8RaGbFqFV8mMLVFk9zBlK05zUqOeg2oKdj4yavxgQ6sVGhIrYEfaTv7wLnV0Q5
         vyIkMjoLd8Yy46SUuMol6JHSsA+6Y7mCTZCR8zOO2EuruFHVF6x5Nwaf6YmcYrKM0tX3
         iesw==
X-Gm-Message-State: APjAAAUQBmns8BBqOGz/Oi0pKfVf8LMebj6p9+wVeJ9yI4KtPDUymi+g
        ic7p1kL+4xVrKC4rqOEWK14YLAfcLSI=
X-Google-Smtp-Source: APXvYqwPQS+miESjpP0rTLP6Xw+JLCm1fufuc0BZ1YcvC86luE5wXiZLTIIycjGRG9NSymofoSof0A==
X-Received: by 2002:ac8:7349:: with SMTP id q9mr60305499qtp.151.1564031031591;
        Wed, 24 Jul 2019 22:03:51 -0700 (PDT)
Received: from AzureHyper-V.3xjlci4r0w3u5g13o212qxlisd.bx.internal.cloudapp.net ([13.68.195.119])
        by smtp.gmail.com with ESMTPSA id y2sm21835328qkj.8.2019.07.24.22.03.50
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 22:03:51 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
X-Google-Original-From: Himadri Pandya <himadri18.07@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Himadri Pandya <himadri18.07@gmail.com>
Subject: [PATCH 1/2] Drivers: hv: Specify receive buffer size using Hyper-V page size
Date:   Thu, 25 Jul 2019 05:03:14 +0000
Message-Id: <20190725050315.6935-2-himadri18.07@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725050315.6935-1-himadri18.07@gmail.com>
References: <20190725050315.6935-1-himadri18.07@gmail.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The recv_buffer is used to retrieve data from the VMbus ring buffer.
VMbus ring buffers are sized based on the guest page size which
Hyper-V assumes to be 4KB. But it may be different on some
architectures. So use the Hyper-V page size to allocate the
recv_buffer and set the maximum size to receive.

Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
---
 drivers/hv/hv_fcopy.c    | 3 ++-
 drivers/hv/hv_kvp.c      | 3 ++-
 drivers/hv/hv_snapshot.c | 3 ++-
 drivers/hv/hv_util.c     | 8 ++++----
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/drivers/hv/hv_fcopy.c b/drivers/hv/hv_fcopy.c
index 7e30ae0635cc..08fa4a5de644 100644
--- a/drivers/hv/hv_fcopy.c
+++ b/drivers/hv/hv_fcopy.c
@@ -13,6 +13,7 @@
 #include <linux/workqueue.h>
 #include <linux/hyperv.h>
 #include <linux/sched.h>
+#include <asm/hyperv-tlfs.h>
 
 #include "hyperv_vmbus.h"
 #include "hv_utils_transport.h"
@@ -234,7 +235,7 @@ void hv_fcopy_onchannelcallback(void *context)
 	if (fcopy_transaction.state > HVUTIL_READY)
 		return;
 
-	vmbus_recvpacket(channel, recv_buffer, PAGE_SIZE * 2, &recvlen,
+	vmbus_recvpacket(channel, recv_buffer, HV_HYP_PAGE_SIZE * 2, &recvlen,
 			 &requestid);
 	if (recvlen <= 0)
 		return;
diff --git a/drivers/hv/hv_kvp.c b/drivers/hv/hv_kvp.c
index 5054d1105236..ae7c028dc5a8 100644
--- a/drivers/hv/hv_kvp.c
+++ b/drivers/hv/hv_kvp.c
@@ -27,6 +27,7 @@
 #include <linux/connector.h>
 #include <linux/workqueue.h>
 #include <linux/hyperv.h>
+#include <asm/hyperv-tlfs.h>
 
 #include "hyperv_vmbus.h"
 #include "hv_utils_transport.h"
@@ -661,7 +662,7 @@ void hv_kvp_onchannelcallback(void *context)
 	if (kvp_transaction.state > HVUTIL_READY)
 		return;
 
-	vmbus_recvpacket(channel, recv_buffer, PAGE_SIZE * 4, &recvlen,
+	vmbus_recvpacket(channel, recv_buffer, HV_HYP_PAGE_SIZE * 4, &recvlen,
 			 &requestid);
 
 	if (recvlen > 0) {
diff --git a/drivers/hv/hv_snapshot.c b/drivers/hv/hv_snapshot.c
index 20ba95b75a94..03b6454268b3 100644
--- a/drivers/hv/hv_snapshot.c
+++ b/drivers/hv/hv_snapshot.c
@@ -12,6 +12,7 @@
 #include <linux/connector.h>
 #include <linux/workqueue.h>
 #include <linux/hyperv.h>
+#include <asm/hyperv-tlfs.h>
 
 #include "hyperv_vmbus.h"
 #include "hv_utils_transport.h"
@@ -297,7 +298,7 @@ void hv_vss_onchannelcallback(void *context)
 	if (vss_transaction.state > HVUTIL_READY)
 		return;
 
-	vmbus_recvpacket(channel, recv_buffer, PAGE_SIZE * 2, &recvlen,
+	vmbus_recvpacket(channel, recv_buffer, HV_HYP_PAGE_SIZE * 2, &recvlen,
 			 &requestid);
 
 	if (recvlen > 0) {
diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index e32681ee7b9f..c2c08f26bd5f 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -136,7 +136,7 @@ static void shutdown_onchannelcallback(void *context)
 	struct icmsg_hdr *icmsghdrp;
 
 	vmbus_recvpacket(channel, shut_txf_buf,
-			 PAGE_SIZE, &recvlen, &requestid);
+			 HV_HYP_PAGE_SIZE, &recvlen, &requestid);
 
 	if (recvlen > 0) {
 		icmsghdrp = (struct icmsg_hdr *)&shut_txf_buf[
@@ -284,7 +284,7 @@ static void timesync_onchannelcallback(void *context)
 	u8 *time_txf_buf = util_timesynch.recv_buffer;
 
 	vmbus_recvpacket(channel, time_txf_buf,
-			 PAGE_SIZE, &recvlen, &requestid);
+			 HV_HYP_PAGE_SIZE, &recvlen, &requestid);
 
 	if (recvlen > 0) {
 		icmsghdrp = (struct icmsg_hdr *)&time_txf_buf[
@@ -346,7 +346,7 @@ static void heartbeat_onchannelcallback(void *context)
 	while (1) {
 
 		vmbus_recvpacket(channel, hbeat_txf_buf,
-				 PAGE_SIZE, &recvlen, &requestid);
+				 HV_HYP_PAGE_SIZE, &recvlen, &requestid);
 
 		if (!recvlen)
 			break;
@@ -390,7 +390,7 @@ static int util_probe(struct hv_device *dev,
 		(struct hv_util_service *)dev_id->driver_data;
 	int ret;
 
-	srv->recv_buffer = kmalloc(PAGE_SIZE * 4, GFP_KERNEL);
+	srv->recv_buffer = kmalloc(HV_HYP_PAGE_SIZE * 4, GFP_KERNEL);
 	if (!srv->recv_buffer)
 		return -ENOMEM;
 	srv->channel = dev->channel;
-- 
2.17.1

