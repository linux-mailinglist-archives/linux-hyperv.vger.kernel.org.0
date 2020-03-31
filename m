Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 11778198D22
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Mar 2020 09:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726528AbgCaHiu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 Mar 2020 03:38:50 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35430 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgCaHiu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 Mar 2020 03:38:50 -0400
Received: by mail-pf1-f196.google.com with SMTP id u68so9955026pfb.2;
        Tue, 31 Mar 2020 00:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=clEoM1P33ahnu51wVt18VYbNSvCb4pxLGx0VQ1g+QU0=;
        b=pRCkdy9DweqMPvvEEk43IP8ZmbYGUUIqCEfMRIdUbthVHHA9bdtowzHwyFGfBxtLNP
         IDJpl5RONrulwcrwj7K49EC35SZDg8qZ/elPFdxdz84Hz4/RTDEFPyva1VFC/p6T2jSs
         X8oNWrC0YNuYSqYDC5F9eeTEYa/HUdg9+xgtBfFdGjKETd2Q4Yp0sePcZgPwSXAN6wSs
         u+JpmJcrXf9m/EPCt81lWdSm2vMW2EkLpF4EJNwuA+AUFvd6oAgR3EfM7W1qxwYTwMXg
         NH1DJLYXn7yua5hxm70FO9lUEuDEjYtw3VWx5b7CN4ZCh8QjwQ0WVcXk505P+dd+y41U
         X7/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=clEoM1P33ahnu51wVt18VYbNSvCb4pxLGx0VQ1g+QU0=;
        b=kHHhvPd4yG2zJjyvUBxHYH3kt5EmfyXlowb1fUc5I7We7RWpzKacwNiuqBIicOjwJa
         EGDvV9togH6933f8p5Nl7MZ+8wXerqF5iRzayZsmZWfHHySz5tN8/z42EQP34m8hsIkD
         za4A+NxwMQnoPnbwuZL2gCyXL6Kv3ihkSaKv195AQ1jXtxRby5SIW8fN0weXfV7u+z1P
         MDp0ZCd9A6kZJMQXH2ZPWDmR0HI/JXuP13ZJPkj19iQAqKZsDv5XgpxfZvaPZxy9GrF5
         TsQXuPQfGeEIY017TcKCIm09Y6uvGv97WkTVVwARdMbcIuD+OGJXuVqu+FYLy1+29ZCW
         f1kg==
X-Gm-Message-State: ANhLgQ22l/faUpRABYVHe+Ag60MZEE0B4Gnqat1c7Ra4tHW/71pVF85V
        mstZgbuJPMIrdck2TS+moCU=
X-Google-Smtp-Source: ADFU+vuhhva7xOwu7yBEwCmP/xzU/kqUaZ8k0h4Bh/gTzbtxJDk0jInPIVmzOVXc6R7o4XzoUi4Gdw==
X-Received: by 2002:a62:2c87:: with SMTP id s129mr17384827pfs.263.1585640329211;
        Tue, 31 Mar 2020 00:38:49 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([131.107.147.210])
        by smtp.googlemail.com with ESMTPSA id q80sm9203632pfc.17.2020.03.31.00.38.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 31 Mar 2020 00:38:48 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V4 6/6] x86/Hyper-V: Report crash data in die() when panic_on_oops is set
Date:   Tue, 31 Mar 2020 00:38:32 -0700
Message-Id: <20200331073832.12204-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200324075720.9462-7-Tianyu.Lan@microsoft.com>
References: <20200324075720.9462-7-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

When oops happens with panic_on_oops unset, the oops
thread is killed by die() and system continues to run.
In such case, guest should not report crash register
data to host since system still runs. Fix it.

Reviewed-by: Michael Kelley <mikelley@microsoft.com>
Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
Change since v3:
	Fix compile error
---
 drivers/hv/vmbus_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 172ceae69abb..4bc02aea2098 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -31,6 +31,7 @@
 #include <linux/kdebug.h>
 #include <linux/efi.h>
 #include <linux/random.h>
+#include <linux/kernel.h>
 #include <linux/syscore_ops.h>
 #include <clocksource/hyperv_timer.h>
 #include "hyperv_vmbus.h"
@@ -91,7 +92,7 @@ static int hyperv_die_event(struct notifier_block *nb, unsigned long val,
 	 * doing hyperv_report_panic_msg() later with kmsg data, don't do
 	 * the notification here.
 	 */
-	if (hyperv_report_reg())
+	if (hyperv_report_reg() && panic_on_oops)
 		hyperv_report_panic(regs, val);
 	return NOTIFY_DONE;
 }
-- 
2.14.5

