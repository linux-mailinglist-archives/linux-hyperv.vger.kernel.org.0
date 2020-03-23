Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2BF6418F54F
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Mar 2020 14:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728414AbgCWNJr (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Mar 2020 09:09:47 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:46236 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728424AbgCWNJo (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Mar 2020 09:09:44 -0400
Received: by mail-pf1-f195.google.com with SMTP id q3so2930130pff.13;
        Mon, 23 Mar 2020 06:09:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=3NXnWBLRV4+ycqR57F21x0zLKmiRfwhohWhxRGGsA4g=;
        b=FnkfqQvTCECL2JvXl4WJWyBq7XGHSZgx1NXO/su3aXyZG5KzFpuQJdNeWnLsDd1ClP
         MMqYbHeOyorc/+1VDTnmBPtF5ycHnfOXFbaPi7mwcJxQYdFT/69hruMw4Qo1bvg6qiPN
         Dzww9vKnHrCK/lnzMyM/MbdU2PfWd+7WIaxQVQxT1qRN0t8v0I5CtZzqGQawLyXOvDAV
         1oPJ79BGbKuxlumunCcrO0DMZM81bau+a32XopER1S8npoONrVrS4Plhr7HPDAzSv9XY
         Nha1d0+cZwBNR53wRZWzYmFMglfzQNmAgDr/hLJnpBZcyuk36V7FI5uJRlZcomwLF0Lw
         vasA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=3NXnWBLRV4+ycqR57F21x0zLKmiRfwhohWhxRGGsA4g=;
        b=dnqrssPqkReI2bqmmWQQIQp4dRqCtAwLeShlXSpyReDJtYaYxX5w+feDpUioLL6j4t
         pxf2OY9cxvRglklianZEUPAaDeSEr4RSeE09y+pkcWpJuPXNGWQbqgYcnSXJCFQ4ZijL
         u+gP6tX6RY2sdBwR4oW5VGKpFbs7JJPgLySXQ/MzDn1Gh+nrMMYfoE0krEGbhbcpDBNQ
         3+y8A/xidUGL26ZnExLr7f9IaH/3kbfD9D60Q6lkefunZNJXA0gpXW2h22CXJCv759Y3
         ntTHNKvYDmbNs2HVCSkHUfGryXH7D7WW5NYNI94KZbEpugPyosnEP1JcaXQAlFyoo2fa
         jQPw==
X-Gm-Message-State: ANhLgQ2TM6j8z/KY/NOUudC+QmsetCvschn48ohCvv+5wy86u5ntIswI
        MCIiqeyWVttMw6aiR3JTWNY=
X-Google-Smtp-Source: ADFU+vuETYWvD07Qi6t5j/sbo0Ptqbzr6/4g3CV3KeEKSsRdb9/kzUl8wETafouEUSs9zFRv6ENvrw==
X-Received: by 2002:a63:3083:: with SMTP id w125mr745553pgw.282.1584968983155;
        Mon, 23 Mar 2020 06:09:43 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([131.107.147.210])
        by smtp.googlemail.com with ESMTPSA id u14sm12262034pgg.67.2020.03.23.06.09.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 23 Mar 2020 06:09:42 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V2 6/6] x86/Hyper-V: Report crash data in die() when panic_on_oops is set
Date:   Mon, 23 Mar 2020 06:09:24 -0700
Message-Id: <20200323130924.2968-7-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200323130924.2968-1-Tianyu.Lan@microsoft.com>
References: <20200323130924.2968-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When oops happens with panic_on_oops unset, the oops
thread is killed by die() and system continues to run.
In such case, guest should not report crash register
data to host since system still runs. Fix it.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 00447175c040..ecdb64db0e4a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -89,7 +89,7 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
 	 * Crash notify only can be triggered once. If crash notify
 	 * message is available, just report kmsg to crash buffer.
 	 */
-	if (hyperv_report_reg())
+	if (hyperv_report_reg() && panic_on_oops)
 		hyperv_report_panic(regs, val);
 	return NOTIFY_DONE;
 }
-- 
2.14.5

