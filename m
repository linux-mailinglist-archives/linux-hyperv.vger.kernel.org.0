Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5455018856F
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Mar 2020 14:25:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgCQNZd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 17 Mar 2020 09:25:33 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44473 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725872AbgCQNZc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 17 Mar 2020 09:25:32 -0400
Received: by mail-pf1-f193.google.com with SMTP id b72so11936630pfb.11;
        Tue, 17 Mar 2020 06:25:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=MrCO2qWyLt6GMelevFESZLUc05GAVUhiejhFIhGEowk=;
        b=risv9eC7+uHtXwh/CzDfDJH5WmA7Fn2ZJa99N5UwNHJv+lRrugy3ATRq24yk9loL1G
         aB3RevozFPsxX+0ww5fL3rPq40NGOWKYo72EjzR7Ipxv8gXjpR/EC6a70HdkfeuiqNNX
         Amsn2FU1Berl4UWfV/q/+BMY5BeSWWZrZBbw2+zQ3s7A3GyUrALdXfUOpfrizxlro2Dk
         f3e0qL1iKHOFl01LO57er970PXrt+bT1Ynp59XOYavbePqPb77cUkcbezAJpa02iJfGl
         bQtsDaJSi1aE8CD+W75fzEyXqa2gqGkxtmyeJb6Kc07ODWOLQ1ChZasqBpHDdlLGazRE
         9zJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=MrCO2qWyLt6GMelevFESZLUc05GAVUhiejhFIhGEowk=;
        b=eVIJbMrgF27d/Xr0s8QC7EDoM/rwASWMYdKXz+DVHBvtnl1IeTkKVC+xV6/mvy2bER
         rGNMLJUuhdlXxxPYAN35eWWMjQz2tmoESN+yixuWFt6TGAoHpdxoQVd1b8MdN+Y7ZTzE
         WNsnCgAlJOraZQZcKl4xw47uPUncy+dT0BAp3D0U2fq2cKMWaHo59YGRuD6Xl2fQz3qR
         Ojg1LdHZvH5F/wuTiu7ixa2d0P2noZtE9nevht6sgZwBEu7lgGXr4RDmIZY3I7/x0pM1
         tzg2AdVbTW65PxlplsXgcZBCEtde/gBuyf878nEJDOnaGNLtPAM5AmpPu09AYaaVEkS5
         NniA==
X-Gm-Message-State: ANhLgQ1z/UP4a+SM6ARze6DBPgFRiMiv/bMbh0ByeNKw+mFObIElth2m
        gSbUdC2S1aqjrZMwNh02c2Q=
X-Google-Smtp-Source: ADFU+vter7IHF9YQ0RfQDuJek1E+T8QCews5dM5EJv3wjPu1lFDxKWlNtZTm4MD1Az20y9UbmCtWpg==
X-Received: by 2002:a63:31c9:: with SMTP id x192mr5265390pgx.88.1584451531408;
        Tue, 17 Mar 2020 06:25:31 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.2.210])
        by smtp.googlemail.com with ESMTPSA id e30sm2910902pga.6.2020.03.17.06.25.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 17 Mar 2020 06:25:30 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH 2/4] x86/Hyper-V: Free hv_panic_page when fail to register kmsg dump
Date:   Tue, 17 Mar 2020 06:25:21 -0700
Message-Id: <20200317132523.1508-3-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
In-Reply-To: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
References: <20200317132523.1508-1-Tianyu.Lan@microsoft.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

If fail to register kmsg dump on Hyper-V platform, hv_panic_page
will not be used anywhere. So free and reset it.

Signed-off-by: Tianyu Lan <Tianyu.Lan@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index b56b9fb9bd90..b043efea092a 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1385,9 +1385,13 @@ static int vmbus_bus_init(void)
 			hv_panic_page = (void *)hv_alloc_hyperv_zeroed_page();
 			if (hv_panic_page) {
 				ret = kmsg_dump_register(&hv_kmsg_dumper);
-				if (ret)
+				if (ret) {
 					pr_err("Hyper-V: kmsg dump register "
 						"error 0x%x\n", ret);
+					hv_free_hyperv_page(
+					    (unsigned long)hv_panic_page);
+					hv_panic_page = NULL;
+				}
 			} else
 				pr_err("Hyper-V: panic message page memory "
 					"allocation failed");
-- 
2.14.5

