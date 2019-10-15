Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089C2D757A
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Oct 2019 13:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726251AbfJOLr2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Oct 2019 07:47:28 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45048 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729481AbfJOLr1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Oct 2019 07:47:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id z9so23453701wrl.11;
        Tue, 15 Oct 2019 04:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ulsuWsmw6ywU37e9HkaAdJcm6nrsJHw0aJd0sjrTDpg=;
        b=etwkzRt382aFYCF9p0y+RlbPcJwDiADZape6hsbFYpfFkGYZzpuQdMhY02YM2yYKJ/
         jb1mCI+HoT0QSy8L/MDHaIgi9n0Bv7I+5L7aNudoQ59Z35gAI8ZG+dqNFW54PHlTcWtF
         JKyxJjoqBQR/8y+frdOmiPTSH7kUcp41WAZtTNu91uljdvnupB83/sqVWG5iGiTRtCa7
         oSY7cZTFodDiQ83bc5nehZ2InQMslMJJQbwpsP3mCnmky9nxX1A2HubOMC1qTsnnXBHQ
         ostqP2GJlH4Wj6NiWOQjGCSi4j2LTdBUA/PSSiNS7VanhD/89Wx++Gx2Q30SlqHhBb6t
         J4vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ulsuWsmw6ywU37e9HkaAdJcm6nrsJHw0aJd0sjrTDpg=;
        b=TFm/ahci/zbx5eGkdcBMEiIH48/bGzmZWNrQhZP+dHMLnUMRdigdSmEa3yskuaTAh7
         a92+QADoCfQXt8Zgejd3LM5StPu+ifLgz173CAQR7V/lKcS/eNjYH5qhpY3WuL+ghWJ+
         0Lp5PphEsdj54+AD38FdT530wWrGrLf1m0+1G+77zcHic7zzfROWQnvOiUjvoGXLHQAp
         KrTmae9KDdrEBrjd50/QvNcvfbSrXcqVFYUcs5swLj7zDJI6nPNrCt+gBpzenHgNj1jo
         y1WwQGfoab4XXVyKdG18euVWu5iqpEjZPGkrRSXph2kIGJdKz8TbcqGnh/VrGHXCRRR4
         XCCQ==
X-Gm-Message-State: APjAAAWi3Sag/1Me3812i8QikER8RyBJORoGcZB4VuVih/lwoaKGDcLB
        g+sX/ILPNdITxW5C01SCvUrqzJF2eexWmA==
X-Google-Smtp-Source: APXvYqzDFx/Jn+FF3XP9lfJUfdUNjQ2QHplgf/Xs3th4bCzywAppyk8BSnmo7qsZ03A6IQpXxgHHGg==
X-Received: by 2002:adf:f441:: with SMTP id f1mr32187954wrp.340.1571140044294;
        Tue, 15 Oct 2019 04:47:24 -0700 (PDT)
Received: from andrea.corp.microsoft.com ([2a01:110:8012:1010:8d42:cc61:bfff:65c2])
        by smtp.gmail.com with ESMTPSA id u11sm20237307wmd.32.2019.10.15.04.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2019 04:47:23 -0700 (PDT)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v3 3/3] Drivers: hv: vmbus: Add module parameter to cap the VMBus version
Date:   Tue, 15 Oct 2019 13:46:46 +0200
Message-Id: <20191015114646.15354-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191015114646.15354-1-parri.andrea@gmail.com>
References: <20191015114646.15354-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently, Linux guests negotiate the VMBus version with Hyper-V
and use the highest available VMBus version they can connect to.
This has some drawbacks: by using the highest available version,
certain code paths are never executed and can not be tested when
the guest runs on the newest host.

Add the module parameter "max_version", to upper-bound the VMBus
versions guests can negotiate.

Suggested-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
---
 drivers/hv/connection.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/hv/connection.c b/drivers/hv/connection.c
index cadfb34b38d80..0475be4356dd7 100644
--- a/drivers/hv/connection.c
+++ b/drivers/hv/connection.c
@@ -14,6 +14,7 @@
 #include <linux/wait.h>
 #include <linux/delay.h>
 #include <linux/mm.h>
+#include <linux/module.h>
 #include <linux/slab.h>
 #include <linux/vmalloc.h>
 #include <linux/hyperv.h>
@@ -55,6 +56,16 @@ static __u32 vmbus_versions[] = {
 	VERSION_WS2008
 };
 
+/*
+ * Maximal VMBus protocol version guests can negotiate.  Useful to cap the
+ * VMBus version for testing and debugging purpose.
+ */
+static uint max_version = VERSION_WIN10_V5_2;
+
+module_param(max_version, uint, S_IRUGO);
+MODULE_PARM_DESC(max_version,
+		 "Maximal VMBus protocol version which can be negotiated");
+
 int vmbus_negotiate_version(struct vmbus_channel_msginfo *msginfo, u32 version)
 {
 	int ret = 0;
@@ -240,6 +251,8 @@ int vmbus_connect(void)
 			goto cleanup;
 
 		version = vmbus_versions[i];
+		if (version > max_version)
+			continue;
 
 		ret = vmbus_negotiate_version(msginfo, version);
 		if (ret == -ETIMEDOUT)
-- 
2.23.0

