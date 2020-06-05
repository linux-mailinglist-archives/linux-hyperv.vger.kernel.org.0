Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B341EF297
	for <lists+linux-hyperv@lfdr.de>; Fri,  5 Jun 2020 09:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbgFEH7j (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 5 Jun 2020 03:59:39 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:41101 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgFEH7j (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 5 Jun 2020 03:59:39 -0400
Received: by mail-lj1-f196.google.com with SMTP id 9so10561206ljc.8;
        Fri, 05 Jun 2020 00:59:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=76On/DuswXUwHpVdv2b9W5T6CYfTi3YXauiy+oGqoso=;
        b=Y59MDwtkCib2cL96VDY0ByOXDqheBH1JDba8EfUM/1nQ+nlGr+FE0VpaWt3O8fXNxz
         YtlKlDMS2kXca67cH9lQ6gztSmgOGUj8NIi4VXiElqaLG6MBulrN/HiPtdpdXBJyYAXE
         FZ8e7+0OEa8hVwmOJe6fc2UDrqhQfiV3+psmtjRQfJlQlmyEgsFro5DIKRrP6lPDdcS2
         yyCOXTulyrrdtdKJ1kQdSl9uTVnKfvf09FrAc2DICw8reH3ioKnMLAeDxJYWLehDN9hy
         NnefwMEuRoNQLv42Y0BtvX+LSadiTdJRD+bRfuqbaeHjshn8sY5tuVTa6WcDO2oMB1ks
         zF5g==
X-Gm-Message-State: AOAM530adVKNFxsPC6AoVen4JDcZblsYd7Lm9TfxK/ptAShsfpGfavE7
        zQKATxH3Nx3jEkOYpbriueU=
X-Google-Smtp-Source: ABdhPJwxjtMPEmi+T8tjORT90RaXxDqZwyQKhkCEYCkc3UeboYOaiTVen5x2zFPzdNERz+tJDwYQMA==
X-Received: by 2002:a2e:b5ca:: with SMTP id g10mr4357629ljn.370.1591343977025;
        Fri, 05 Jun 2020 00:59:37 -0700 (PDT)
Received: from localhost.localdomain (broadband-37-110-38-130.ip.moscow.rt.ru. [37.110.38.130])
        by smtp.googlemail.com with ESMTPSA id a9sm230697ljk.116.2020.06.05.00.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 00:59:36 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Dexuan Cui <decui@microsoft.com>,
        Michael Kelley <mikelley@microsoft.com>
Cc:     Denis Efremov <efremov@linux.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-hyperv@vger.kernel.org,
        Linux SCSI List <linux-scsi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] scsi: storvsc: Remove memset before memory freeing in storvsc_suspend()
Date:   Fri,  5 Jun 2020 10:59:34 +0300
Message-Id: <20200605075934.8403-1-efremov@linux.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <CAA42JLat6Ern5_mztmoBX9-ONtmz=gZE3YUphY+njTa+A=efVw@mail.gmail.com>
References: <CAA42JLat6Ern5_mztmoBX9-ONtmz=gZE3YUphY+njTa+A=efVw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Remove memset with 0 for stor_device->stor_chns in storvsc_suspend()
before the call to kfree() as the memory contains no sensitive information.

Fixes: 56fb10585934 ("scsi: storvsc: Add the support of hibernation")
Suggested-by: Dexuan Cui <decui@microsoft.com>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/scsi/storvsc_drv.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 072ed8728657..2d90cddd8ac2 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -2035,9 +2035,6 @@ static int storvsc_suspend(struct hv_device *hv_dev)
 
 	vmbus_close(hv_dev->channel);
 
-	memset(stor_device->stor_chns, 0,
-	       num_possible_cpus() * sizeof(void *));
-
 	kfree(stor_device->stor_chns);
 	stor_device->stor_chns = NULL;
 
-- 
2.26.2

