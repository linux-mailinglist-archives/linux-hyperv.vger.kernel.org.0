Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89A751EE4EF
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Jun 2020 15:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726003AbgFDNEQ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Jun 2020 09:04:16 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45752 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725926AbgFDNEQ (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Jun 2020 09:04:16 -0400
Received: by mail-lf1-f66.google.com with SMTP id d7so3529461lfi.12;
        Thu, 04 Jun 2020 06:04:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=urAgIqbBzqYwYgj9xnwgXf8/6DMJC8c4LD5osGdOhLY=;
        b=jvDyhezTeyAmzAK5lCkTlrCy7erWTXtpWKTbpo/Cy9ZKxGjRsWEanXZkG3fH9o6Vhi
         sIL2nGJfjQVhiYWVDLnISzWSNNbUVJ1sg/a3xFyHxRfOVlTxWZFPKuHCJAObleiWDSbs
         fy1pYykh2NmSx5BI7VMmgDToz+x5HgusEKE9gxyjiX0jWGDAJM3yew4zLIG0TYSdySo0
         iw/JpemDtQo/8S1euYgaOVYnRkPSX3KH47qhrI+qtcXsuBZvZcG6fuTdd166uq1DhVpm
         JgtA9zWr11JgXGGzSocBww8Thml+VkuMG9vp9LSkHswZzmQU6yfrDyRgMWjUfFjIMnNA
         lP+g==
X-Gm-Message-State: AOAM530428NUfkW+Yh/MG7S2mlMcjLz+cAim2fV5I3xV/AFciHLE27nk
        jhVrabIrQyjP51614z3WfdI=
X-Google-Smtp-Source: ABdhPJzS9kADwtRgaXZHbRJYWBULIzX77aZRmv+Bae/lnf6GOmmkrg7UmLzqiqJoxJPKCK8UP1vo9w==
X-Received: by 2002:a19:4854:: with SMTP id v81mr2467234lfa.189.1591275854710;
        Thu, 04 Jun 2020 06:04:14 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id h13sm1181611ljc.129.2020.06.04.06.04.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 06:04:14 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>
Cc:     Denis Efremov <efremov@linux.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: storvsc: Use kzfree() in storvsc_suspend()
Date:   Thu,  4 Jun 2020 16:04:06 +0300
Message-Id: <20200604130406.108940-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Use kzfree() instead of memset() with 0 followed by kfree().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/scsi/storvsc_drv.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 072ed8728657..e5a19cd8a450 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -2035,10 +2035,7 @@ static int storvsc_suspend(struct hv_device *hv_dev)
 
 	vmbus_close(hv_dev->channel);
 
-	memset(stor_device->stor_chns, 0,
-	       num_possible_cpus() * sizeof(void *));
-
-	kfree(stor_device->stor_chns);
+	kzfree(stor_device->stor_chns);
 	stor_device->stor_chns = NULL;
 
 	cpumask_clear(&stor_device->alloced_cpus);
-- 
2.26.2

