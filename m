Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4052EC51D
	for <lists+linux-hyperv@lfdr.de>; Wed,  6 Jan 2021 21:35:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727334AbhAFUej (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 6 Jan 2021 15:34:39 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:55151 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727287AbhAFUei (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 6 Jan 2021 15:34:38 -0500
Received: by mail-wm1-f51.google.com with SMTP id c133so3433402wme.4;
        Wed, 06 Jan 2021 12:34:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mEBt6kadL06yrWP6jkRQ6hKHgAZ+ACyWHQVmdjiqpDc=;
        b=FnJEJ9HlZIOm13mLClJEQpxGA9+l5M9hc2j1CJBu8BJBQrkqcPfi7Az/otJbl2kgp5
         6igK8MvvzlR/+b5rA4RSj4c3PBCj/KbZH4cFOzMYiEH1Q3WUp1flr2z49Aex13/xEeiI
         ysWnt/5YSpLb4cjj9Bxrd73xXtzQXAX3Wy8Z5tdvSkI3b2npvsn03Z2Q42URm9w2FnGa
         +wVicu/yFRhd03BfjZXZ8gdQDnzWahZJI90bCOz8V/fQYiViLRIt7QjUJHlAXyvJwaka
         xHyJGIZJprZtNCgBKXPUpXDH+1e7lvqbwbwgeyYMQzSGUbOlfAJSH7lOp8ZS6ziPcrHZ
         rxXA==
X-Gm-Message-State: AOAM532xlIKUmbAAYfue2PRlYVFrbkGePwywdVdoq6pCoLhutmlrFi+D
        ei2M0D0Sc/BkMk+yLzvvnAuGFlBEJKE=
X-Google-Smtp-Source: ABdhPJywkep2yhD2SXTrIOLI/AJ3IeYO8EdXx5STTEDda+gBvjTvkOZc+5XEMSXwtwC/wQGFPrlDSg==
X-Received: by 2002:a05:600c:208:: with SMTP id 8mr5304096wmi.146.1609965236642;
        Wed, 06 Jan 2021 12:33:56 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id u9sm4499456wmb.32.2021.01.06.12.33.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 12:33:56 -0800 (PST)
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>
Subject: [PATCH v4 03/17] Drivers: hv: vmbus: skip VMBus initialization if Linux is root
Date:   Wed,  6 Jan 2021 20:33:36 +0000
Message-Id: <20210106203350.14568-4-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210106203350.14568-1-wei.liu@kernel.org>
References: <20210106203350.14568-1-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

There is no VMBus and the other infrastructures initialized in
hv_acpi_init when Linux is running as the root partition.

Signed-off-by: Wei Liu <wei.liu@kernel.org>
---
v3: Return 0 instead of -ENODEV.
---
 drivers/hv/vmbus_drv.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 502f8cd95f6d..ee27b3670a51 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2620,6 +2620,9 @@ static int __init hv_acpi_init(void)
 	if (!hv_is_hyperv_initialized())
 		return -ENODEV;
 
+	if (hv_root_partition)
+		return 0;
+
 	init_completion(&probe_event);
 
 	/*
-- 
2.20.1

