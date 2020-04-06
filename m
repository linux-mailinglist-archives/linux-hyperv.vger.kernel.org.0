Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC59619F3BA
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Apr 2020 12:43:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726885AbgDFKnY (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Apr 2020 06:43:24 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33754 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726918AbgDFKnX (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Apr 2020 06:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586169802;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SnzvWDxT51ceWkFoDXIfz8ULidaqB4F/U3oJiWp4gvU=;
        b=HgK/lAMSzfijUqkvZDZYzidsfEYYHxUdsvwVqyWilGLdGOKPTv02nf5NIAQJn8k7tZ96Q8
        F3nkqsfs/9CCbI/GwfTRK/Ai21OvjESvCcXxEjqmLfk/I4UN0Ask9bazwO/th2kv2EIYH6
        NDW1iLiQ92eQGSSZqm9PFD/2ajv7Qo4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-SDq-NofkNq-3GrxDTGPsLw-1; Mon, 06 Apr 2020 06:43:21 -0400
X-MC-Unique: SDq-NofkNq-3GrxDTGPsLw-1
Received: by mail-wm1-f71.google.com with SMTP id n127so720610wme.4
        for <linux-hyperv@vger.kernel.org>; Mon, 06 Apr 2020 03:43:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SnzvWDxT51ceWkFoDXIfz8ULidaqB4F/U3oJiWp4gvU=;
        b=lT6og0T9ALZ7ZCYHO9EVNaWvuZNMw3maO9WYbT0TVV9ZYnC2n+b76Li/3NLRYQXvpL
         6wnJHv2l8E/66gsHhSxXDeZvr4tSdRLHS0vcBAl4cxCAKnqc1n2plwryNpFbeOxSJpOx
         rklF16C2j0pcg6AEsfbV7zVt8nXLCecRy0RU4HqP6ELaYB9TS+qtKNPONMb7tyG7+Gkr
         SSayE1kboeRdx5WwZGfr/HjTJAb3L1Ve2ojDlPbELCvRlxW3AQh8OIaMqMtfioe7GCS3
         Vkj6ve7+bmj7meiUiS6qNxU6alEoLvevZIybNS1tN3azeizvmFa95qynY06Q3R3c+Nic
         Uv1A==
X-Gm-Message-State: AGi0Pubhi8uyngm4Tqc6J+uUOKgukTVrbyCxa7zawV1IiHvzYROKEjNh
        IXnNosyKA7BQPodFzkfWg39DZk9/HWiBh42f8H76oYgyZm2H418noh13uxnFd9+QjHyNE7+5T0h
        CtpoE4m/FitspN3RQsjgjPBSU
X-Received: by 2002:a5d:4bc5:: with SMTP id l5mr9114540wrt.164.1586169798977;
        Mon, 06 Apr 2020 03:43:18 -0700 (PDT)
X-Google-Smtp-Source: APiQypJ8yCoOfXBrw2hnivxr3dtp1W/vg3CXlZhUIMMwsfC1gV7Nw0Lbed9ft/EvbBu2UXPFMNgSvg==
X-Received: by 2002:a5d:4bc5:: with SMTP id l5mr9114520wrt.164.1586169798735;
        Mon, 06 Apr 2020 03:43:18 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id g2sm25442781wrs.42.2020.04.06.03.43.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 03:43:18 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     linux-hyperv@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Wei Liu <wei.liu@kernel.org>,
        Tianyu Lan <Tianyu.Lan@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH v2 4/5] Drivers: hv: make sure that 'struct vmbus_channel_message_header' compiles correctly
Date:   Mon,  6 Apr 2020 12:43:15 +0200
Message-Id: <20200406104316.45303-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200406104154.45010-1-vkuznets@redhat.com>
References: <20200406104154.45010-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Strictly speaking, compiler is free to use something different from 'u32'
for 'enum vmbus_channel_message_type' (e.g. char) but it doesn't happen in
real life, just add a BUILD_BUG_ON() guardian.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 4ab2f1511dcb..94c02433827d 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -1023,6 +1023,13 @@ void vmbus_on_msg_dpc(unsigned long data)
 	struct onmessage_work_context *ctx;
 	u32 message_type = msg->header.message_type;
 
+	/*
+	 * 'enum vmbus_channel_message_type' is supposed to always be 'u32' as
+	 * it is being used in 'struct vmbus_channel_message_header' definition
+	 * which is supposed to match hypervisor ABI.
+	 */
+	BUILD_BUG_ON(sizeof(enum vmbus_channel_message_type) != sizeof(u32));
+
 	if (message_type == HVMSG_NONE)
 		/* no msg */
 		return;
-- 
2.25.1

