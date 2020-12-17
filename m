Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB1CF2DDA28
	for <lists+linux-hyperv@lfdr.de>; Thu, 17 Dec 2020 21:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731601AbgLQUeg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 17 Dec 2020 15:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731595AbgLQUef (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 17 Dec 2020 15:34:35 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 484DFC06138C;
        Thu, 17 Dec 2020 12:33:55 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id r4so163543wmh.5;
        Thu, 17 Dec 2020 12:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=gQGWPM/sf8+J1RLMjv3ZaWA/7DvHetdsTdc1DOQtFJQ=;
        b=qQikXu51Qi9p3EQTAoWNtLzcEEHx9Kz0wZB/60aM5LTsJCBfmY6s87JDfUxpYcF5Cm
         U1sIg7LPP64Rn1Ox2oOwk8xsX4H47lWqfM9K95gsaz96Onhi/hWiRDXiCNqP3AoWBNZm
         XeZnXJMbAy/tkoIpb7DcKMJnIjSkz54Rvm19/BdeTj5HW6fflJf05Yt5CcN+811CS2x6
         1N1KQo9awFYDJvAqDDIjJmbAaqZ3VaYg3cnzGfTQDFGKblBXTl0qAU0TQpbJAI+4Wf54
         wtx94CGODvCKpaY9PJWPZeYaz/42GwxhSIaGI/HoLkinsD4rvyJx6tIiMvIXJaAekrpr
         k+kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gQGWPM/sf8+J1RLMjv3ZaWA/7DvHetdsTdc1DOQtFJQ=;
        b=GQnSiu5jwwEXsx794a4EYLK1R9wq9qdL7JimL3GxKi+jt8mqLmsKf/G+UuMieBUXRx
         IZJu16rqxqXObpt3jsQMNTbpSDTQVwH+1PSetctNTbYGZvdepn9aSnh+BFFuGuJbOAoJ
         jS5R/30k8x9Q8iY3g2F/GzznJjxBlo9iKLQPGCcZF48i3njhhHNVIN3ab95hvMu28MBd
         OL9P5CptlJWQrPGU8MTF9WdSKcAACtVCcx0vtyCezKz1uHuL8JSVQgQR7HuF3PTr4EhS
         Bd0cXA5tvCWTydTEnD9nnq4NkcYpDWuZxqGQdkA2r/hR+bvYbJbku91KyiZ0Mg0PeHkq
         1d8Q==
X-Gm-Message-State: AOAM531Qet9EQSFA+ReI+4/9yXqM15/YMbrpljnxNEqTGp8N1FDflRGh
        23CQH6SDlXZjD6FwRr3TOfWIEqvOrtYbvd79
X-Google-Smtp-Source: ABdhPJzHhkG60AUjmunNTz3OqiaOhMWdwUPpzrmUPPmz9Ttw2uRDJTCtpDLdFCTPRlwZsVlESFHdVw==
X-Received: by 2002:a1c:770d:: with SMTP id t13mr1036395wmi.153.1608237233745;
        Thu, 17 Dec 2020 12:33:53 -0800 (PST)
Received: from localhost.localdomain (host-95-239-64-30.retail.telecomitalia.it. [95.239.64.30])
        by smtp.gmail.com with ESMTPSA id a62sm11729128wmh.40.2020.12.17.12.33.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 12:33:53 -0800 (PST)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>,
        Saruhan Karademir <skarade@microsoft.com>,
        Juan Vazquez <juvazq@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: [PATCH 3/3] scsi: storvsc: Validate length of incoming packet in storvsc_on_channel_callback()
Date:   Thu, 17 Dec 2020 21:33:21 +0100
Message-Id: <20201217203321.4539-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201217203321.4539-1-parri.andrea@gmail.com>
References: <20201217203321.4539-1-parri.andrea@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Check that the packet is of the expected size at least, don't copy data
past the packet.

Reported-by: Saruhan Karademir <skarade@microsoft.com>
Signed-off-by: Andrea Parri (Microsoft) <parri.andrea@gmail.com>
Cc: "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
---
 drivers/scsi/storvsc_drv.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 8714355cb63e7..4b8bde2750fac 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1250,6 +1250,12 @@ static void storvsc_on_channel_callback(void *context)
 		request = (struct storvsc_cmd_request *)
 			((unsigned long)desc->trans_id);
 
+		if (hv_pkt_datalen(desc) < sizeof(struct vstor_packet) -
+				stor_device->vmscsi_size_delta) {
+			dev_err(&device->device, "Invalid packet len\n");
+			continue;
+		}
+
 		if (request == &stor_device->init_request ||
 		    request == &stor_device->reset_request) {
 			memcpy(&request->vstor_packet, packet,
-- 
2.25.1

