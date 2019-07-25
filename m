Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B6EF744A8
	for <lists+linux-hyperv@lfdr.de>; Thu, 25 Jul 2019 07:04:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390316AbfGYFDx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 25 Jul 2019 01:03:53 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:41944 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390203AbfGYFDx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 25 Jul 2019 01:03:53 -0400
Received: by mail-qt1-f195.google.com with SMTP id d17so47782998qtj.8;
        Wed, 24 Jul 2019 22:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GuNGF4te9uGOqfh3/j24z/rr+ibi6UtsrswhQy3VB4M=;
        b=rkyHm/teCMVeDPLPYdgzviyhcPg6fFLtCxN9DNJdyuLIVAislbVk9PnC35UBLm1g01
         qXG4hNumissyXSQhhK2qpIGiq9yVLC+biBEShD68LJsDqoG9pUl7rSOZ5Cn7sM+p4l0W
         eSXG2qe/XO8Gqlx62dBOIusbkYOBYxJMGW24HBBSeYMPGEgK0V5zPNqBQwfpN005/TfP
         UKQkfXWnoyq1KA0a6aYIxL1UP6KSvhm2c9GtdQZML4tvnIO1+cwiDVLvlOkd4kYGaM9c
         FrqbPujJvqtiRBhVehZI2GJmhAgYtRlQb6roxjlLFCb5qztFNj9wcW/zgetAvsM8GKt4
         fijA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GuNGF4te9uGOqfh3/j24z/rr+ibi6UtsrswhQy3VB4M=;
        b=QL4s6R9O9f/XYXkqHueiyV3UwJaGwpGaXV10aK1FTELzXtF5qcESgHjF+CH2SYkE79
         et/+Je6nLyb5DQxz1wQ1I+TcREd+WHcY/MBcInmlwNjOseVgfSrtGsJ1gx+oQj03tnQv
         GmYZobb+d8S/QZ+rKl//xvO4WhNtOatdJIpbeXyQ9Ha9quluvkaZI4eQZ4zlLIxk9DoP
         5vKxsw7cYtrkMTVfw2xL56S9qsvGjAt5L+wgBf+LKfu2iCRsJo0C7kVjLgMgImcst5aQ
         pSXeN+CV/UOGFZcXrpyyfw3H33sTmhbaioptd8Vd5henbGM8DqMIYZdA3nOdUff/N3Di
         aboQ==
X-Gm-Message-State: APjAAAUdabMEk7SyK2qzcmRlaHYwciJsbjZM5u1DOyhgkVkxnW0s/oSA
        Y9Kp65Cn0Zk1y0WKGqxSZYY=
X-Google-Smtp-Source: APXvYqx+asM1BMq5QfFQpEKCdo1HGKVr0l2LQq92FA4tQV5C9VmRobv9SHastnuYEPowZIp/oBamqA==
X-Received: by 2002:a0c:d0ab:: with SMTP id z40mr62308786qvg.216.1564031032278;
        Wed, 24 Jul 2019 22:03:52 -0700 (PDT)
Received: from AzureHyper-V.3xjlci4r0w3u5g13o212qxlisd.bx.internal.cloudapp.net ([13.68.195.119])
        by smtp.gmail.com with ESMTPSA id y2sm21835328qkj.8.2019.07.24.22.03.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 24 Jul 2019 22:03:51 -0700 (PDT)
From:   Himadri Pandya <himadrispandya@gmail.com>
X-Google-Original-From: Himadri Pandya <himadri18.07@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Himadri Pandya <himadri18.07@gmail.com>
Subject: [PATCH 2/2] Drivers: hv: util: Specify ring buffer size using Hyper-V page size
Date:   Thu, 25 Jul 2019 05:03:15 +0000
Message-Id: <20190725050315.6935-3-himadri18.07@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190725050315.6935-1-himadri18.07@gmail.com>
References: <20190725050315.6935-1-himadri18.07@gmail.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

VMbus ring buffers are sized based on the 4K page size used by
Hyper-V. The Linux guest page size may not be 4K on all architectures
so use the Hyper-V page size to specify the ring buffer size.

Signed-off-by: Himadri Pandya <himadri18.07@gmail.com>
---
 drivers/hv/hv_util.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
index c2c08f26bd5f..766bd8457346 100644
--- a/drivers/hv/hv_util.c
+++ b/drivers/hv/hv_util.c
@@ -413,8 +413,9 @@ static int util_probe(struct hv_device *dev,
 
 	hv_set_drvdata(dev, srv);
 
-	ret = vmbus_open(dev->channel, 4 * PAGE_SIZE, 4 * PAGE_SIZE, NULL, 0,
-			srv->util_cb, dev->channel);
+	ret = vmbus_open(dev->channel, 4 * HV_HYP_PAGE_SIZE,
+			 4 * HV_HYP_PAGE_SIZE, NULL, 0, srv->util_cb,
+			 dev->channel);
 	if (ret)
 		goto error;
 
-- 
2.17.1

