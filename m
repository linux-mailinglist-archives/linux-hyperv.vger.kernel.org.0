Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD5BB1C9492
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 May 2020 17:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbgEGPNx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 7 May 2020 11:13:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727778AbgEGPNw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 7 May 2020 11:13:52 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C59C05BD43;
        Thu,  7 May 2020 08:13:52 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 18so3133509pfv.8;
        Thu, 07 May 2020 08:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wCNfAcxLHirtWhA7szQNX73G2LCH8rXx5QD9p4rA8Dk=;
        b=fnItiLadgw6gVujkCLGxeMWnUOu819/tIkaEKowyFt2g/Nn5mUHkALPznXH/TNOJ79
         yWdwyURQZlI5T5wZROAv2M29GKPJTD4oUIlR9Ok5e0xh2scXtpiqYk2ZZOlgncX/KnCF
         a66SYwlNiFizvPuObtEK4h/OXk1dGLhnzVd8zIrpbccuHyqFthc9h3dcasHhv2Jkhphi
         VgOJXrMFGryLIG39lrJIdtXZf42cY/GDJgUYxFN+VUTWPgBdTBg0ge0Izm2wQvq2Hb5R
         mPAzY+dbzTO5NnUosx31byzGn1LXlAiN8iDlwoUX0injGUVcIUHfU+XrPHvV3Lk+ucmu
         JIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wCNfAcxLHirtWhA7szQNX73G2LCH8rXx5QD9p4rA8Dk=;
        b=ZbuVrk0lfx11DkBQaBnNQILnO8NJEMZEqfDKgPGHlppZtWjt1eiLuHQUxE+5YxUUbj
         wZM885am+YdcFVvmNyQ4YCGk2K6S0aXnq/Q28mR2oXpk0MYiNYnRmeyRaqduk4Ubrr1w
         jmsc4Yf4UHBvyxPTLVREloQUUma5vTLcSQ/tLfgtf4PUcwqZMM/h1R1bhBFcmBARGojt
         u147TsgMD7Q8z3UwjSE9N97Tfv8RJlp0qyCbYwzWR+feNZS8UE97D3+zQWbTBqU2ivjA
         rwoV8PfHowLxxYaFg9lmof20RtphNJTOQ0f/NfyYCxKMgpDgumqiETdT1FQUY0l7ZcsF
         rmlA==
X-Gm-Message-State: AGi0PuZJIoiHxSYYRDk1G8F75UFHb+Z6OB6YijlJTcOONKv6ojWCqeju
        o4gTAohAsA1Bk8SfqEzYLD0=
X-Google-Smtp-Source: APiQypLmdj5NF5BayTeEdUuJYPAeEE4bIXkpQXtR0s8noMzSOLGduyoeZyIGB9WwRTgPXAz0lr3XjA==
X-Received: by 2002:aa7:8f26:: with SMTP id y6mr14474231pfr.36.1588864432467;
        Thu, 07 May 2020 08:13:52 -0700 (PDT)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id d2sm5118326pfa.164.2020.05.07.08.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 08:13:51 -0700 (PDT)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH] uio_hv_generic: add missed sysfs_remove_bin_file
Date:   Thu,  7 May 2020 23:13:43 +0800
Message-Id: <20200507151343.792816-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This driver calls sysfs_create_bin_file() in probe, but forgets to
call sysfs_remove_bin_file() in remove.
Add the missed call to fix it.

Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 drivers/uio/uio_hv_generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 3c5169eb23f5..4dae2320b103 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -361,6 +361,7 @@ hv_uio_remove(struct hv_device *dev)
 	if (!pdata)
 		return 0;
 
+	sysfs_remove_bin_file(&dev->channel->kobj, &ring_buffer_bin_attr);
 	uio_unregister_device(&pdata->info);
 	hv_uio_cleanup(dev, pdata);
 	hv_set_drvdata(dev, NULL);
-- 
2.26.2

