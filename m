Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 621712D2ED5
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Dec 2020 16:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729985AbgLHP4f (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 8 Dec 2020 10:56:35 -0500
Received: from mail-m972.mail.163.com ([123.126.97.2]:39542 "EHLO
        mail-m972.mail.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730004AbgLHP4e (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 8 Dec 2020 10:56:34 -0500
X-Greylist: delayed 8340 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Dec 2020 10:56:33 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id; bh=t2VJOPJlWsz8l5wsja
        RBlQoKQE79rv25LpyRWLQ/ba0=; b=b2aJ7/dSbQG7CMDbVNBHIkBCvL2U6vyJ2b
        vExmabzSzvEr357wuq/GFDu28Qr3KxTqY1GYhZhj/wEo6glJkzf40WlsAhvoVewk
        X4AyUx0724fXwl5kISaoLyWBAOolkXoUPNTtr9C7hBxEik7MHy4uIe6dtURBmEr+
        OGQ8qSzLw=
Received: from localhost.localdomain (unknown [202.112.113.212])
        by smtp2 (Coremail) with SMTP id GtxpCgC3z3pYfc9fHjmbEQ--.13268S4;
        Tue, 08 Dec 2020 21:19:26 +0800 (CST)
From:   Xiaohui Zhang <ruc_zhangxiaohui@163.com>
To:     Xiaohui Zhang <ruc_zhangxiaohui@163.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-hyperv@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] scsi: Fix possible buffer overflows in storvsc_queuecommand
Date:   Tue,  8 Dec 2020 21:19:18 +0800
Message-Id: <20201208131918.31534-1-ruc_zhangxiaohui@163.com>
X-Mailer: git-send-email 2.17.1
X-CM-TRANSID: GtxpCgC3z3pYfc9fHjmbEQ--.13268S4
X-Coremail-Antispam: 1Uf129KBjvdXoWrtF4xZF4rAw4fXF4xJry7ZFb_yoWDAFbE9w
        4rKr97Wry5Arn7Xr1DGFy3ua4avr4UWr1rua12v39xArWjywsav34vqrs0vr48trWUuayD
        A3Z5Xr1Fy3W0kjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR9mRUUUUUU==
X-Originating-IP: [202.112.113.212]
X-CM-SenderInfo: puxfs6pkdqw5xldrx3rl6rljoofrz/1tbipR70MFUMbDH2ZAAAsp
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Zhang Xiaohui <ruc_zhangxiaohui@163.com>

storvsc_queuecommand() calls memcpy() without checking
the destination size may trigger a buffer overflower,
which a local user could use to cause denial of service
or the execution of arbitrary code.
Fix it by putting the length check before calling memcpy().

Signed-off-by: Zhang Xiaohui <ruc_zhangxiaohui@163.com>
---
 drivers/scsi/storvsc_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index 0c65fbd41..09b60a4c0 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1729,6 +1729,8 @@ static int storvsc_queuecommand(struct Scsi_Host *host, struct scsi_cmnd *scmnd)
 
 	vm_srb->cdb_length = scmnd->cmd_len;
 
+	if (vm_srb->cdb_length > STORVSC_MAX_CMD_LEN)
+		vm_srb->cdb_length = STORVSC_MAX_CMD_LEN;
 	memcpy(vm_srb->cdb, scmnd->cmnd, vm_srb->cdb_length);
 
 	sgl = (struct scatterlist *)scsi_sglist(scmnd);
-- 
2.17.1

