Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D7802C2E01
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Nov 2020 18:09:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390579AbgKXRHw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Nov 2020 12:07:52 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:55035 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729093AbgKXRHw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Nov 2020 12:07:52 -0500
Received: by mail-wm1-f68.google.com with SMTP id d142so3036657wmd.4;
        Tue, 24 Nov 2020 09:07:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZKmhSPX4j4dhn/f/ifRtYGYc7hU6N0WJ35NAyU50tx8=;
        b=ubvJUyXZgExMGkDj9NyqODg9lcM1egAGNq5ivdxFOViKf0UjdT7qAM2/Y6b/8RVgE1
         iuSRDo3bpDWqF4N8xpkD0/XXHMvXqunCczfdKjJcxv7rfNtrxgwS7Ctfks7pYrC2Xgge
         Eu/EsU1q8wkokctDEVYuyfm4CUfZmjHA1JK50xBxf9nRGM8U877k4h9ItrhPxbAcj5dQ
         od4fT/CAUPR8zq7jZfOPApcYU6MJ+UNMNTRMxwYyvstz76FzSfuHUpvfVUIFYwlhUIgj
         IULJbGtOZvpK3QZ57P3KmMpgzQHi39JXP6DaqHxdSGfvd/u9ZvGuFRGK8swX/q/za1y2
         j66w==
X-Gm-Message-State: AOAM5327g5KfipNXj9TtIERLODylEEA9NQHCbOnM0aBdtKFEM86pNVTA
        uzBTHGOSbzSvCRFrQiHNOPmjlt++/bE=
X-Google-Smtp-Source: ABdhPJxgeO/vwhe8jhR8vwKdh8RzW01exk08yMcJFmii7SQwvSaZ0PYIjDOc7N8OLLeJm/NkdjIjkw==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr5368181wmi.131.1606237671003;
        Tue, 24 Nov 2020 09:07:51 -0800 (PST)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v20sm6419874wmh.44.2020.11.24.09.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Nov 2020 09:07:50 -0800 (PST)
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
Subject: [PATCH v3 03/17] Drivers: hv: vmbus: skip VMBus initialization if Linux is root
Date:   Tue, 24 Nov 2020 17:07:30 +0000
Message-Id: <20201124170744.112180-4-wei.liu@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201124170744.112180-1-wei.liu@kernel.org>
References: <20201124170744.112180-1-wei.liu@kernel.org>
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
index 4fad3e6745e5..23f5bce8f242 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2612,6 +2612,9 @@ static int __init hv_acpi_init(void)
 	if (!hv_is_hyperv_initialized())
 		return -ENODEV;
 
+	if (hv_root_partition)
+		return 0;
+
 	init_completion(&probe_event);
 
 	/*
-- 
2.20.1

