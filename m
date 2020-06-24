Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15780207500
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Jun 2020 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389484AbgFXN4K (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 24 Jun 2020 09:56:10 -0400
Received: from smtp.asem.it ([151.1.184.197]:55480 "EHLO smtp.asem.it"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391188AbgFXN4J (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 24 Jun 2020 09:56:09 -0400
Received: from webmail.asem.it
        by asem.it (smtp.asem.it)
        (SecurityGateway 6.5.2)
        with ESMTP id SG000339068.MSG 
        for <linux-hyperv@vger.kernel.org>; Wed, 24 Jun 2020 15:56:03 +0200S
Received: from ASAS044.asem.intra (172.16.16.44) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Wed, 24
 Jun 2020 15:56:01 +0200
Received: from flavio-x.asem.intra (172.16.17.208) by ASAS044.asem.intra
 (172.16.16.44) with Microsoft SMTP Server id 15.1.1979.3 via Frontend
 Transport; Wed, 24 Jun 2020 15:56:01 +0200
From:   Flavio Suligoi <f.suligoi@asem.it>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
CC:     <linux-hyperv@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 1/1] scsi: storvsc: fix spelling mistake
Date:   Wed, 24 Jun 2020 15:56:00 +0200
Message-ID: <20200624135600.14274-1-f.suligoi@asem.it>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-SGHeloLookup-Result: pass smtp.helo=webmail.asem.it (ip=172.16.16.44)
X-SGSPF-Result: none (smtp.asem.it)
X-SGOP-RefID: str=0001.0A09020D.5EF35B71.0086,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0 (_st=1 _vt=0 _iwf=0)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Fix typo: "trigerred" --> "triggered"

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/scsi/storvsc_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 624467e2590a..3040696c20dd 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1038,7 +1038,7 @@ static void storvsc_handle_error(struct vmscsi_request *vm_srb,
 			do_work = true;
 			process_err_fn = storvsc_device_scan;
 			/*
-			 * Retry the I/O that trigerred this.
+			 * Retry the I/O that triggered this.
 			 */
 			set_host_byte(scmnd, DID_REQUEUE);
 		}
-- 
2.17.1

