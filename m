Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390B473ED3A
	for <lists+linux-hyperv@lfdr.de>; Mon, 26 Jun 2023 23:51:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjFZVuj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 26 Jun 2023 17:50:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjFZVua (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 26 Jun 2023 17:50:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8C72117;
        Mon, 26 Jun 2023 14:50:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A75C60F7E;
        Mon, 26 Jun 2023 21:50:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA557C43391;
        Mon, 26 Jun 2023 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687816216;
        bh=7OIVpCvo0zS8ygaRSX0KMQHDK2Hn6ZWdVevir0Umxkc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UPXurdMVC5g62BGi0D3SwidTmslpsM3UF8iyMmsK52lC/7Zhldnz9Cgc6LmRTI5u0
         vZlWRgCkhzGqcA0ElmTwr9svUE2W2yBxKHY9iGXOmcIWZFwoMVr2/bVBavCEv1gpmh
         /lBl7ZAkF6D4I++5gvHdHnFSLAzCrV5cQdm7R4ZriwntyPSKHMMA0uy0kZ755DF7dW
         aOEwheuJjyOkULqjY235xXNTEeTeAs1iVWPLv19n/gmVpeHX5hNurZZirzzG6Ti52K
         uYSz20ptjWyNPyYToG1Ng2Y1NnIQ8uiQJT49L8tOMxdpDVe2Xn5cx1IqLmwa1TBdyT
         Qp/rTHtxb5x4w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 6.3 11/16] scsi: storvsc: Always set no_report_opcodes
Date:   Mon, 26 Jun 2023 17:49:51 -0400
Message-Id: <20230626214956.178942-11-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230626214956.178942-1-sashal@kernel.org>
References: <20230626214956.178942-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.3.9
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Michael Kelley <mikelley@microsoft.com>

[ Upstream commit 31d16e712bdcaee769de4780f72ff8d6cd3f0589 ]

Hyper-V synthetic SCSI devices do not support the MAINTENANCE_IN SCSI
command, so scsi_report_opcode() always fails, resulting in messages like
this:

hv_storvsc <guid>: tag#205 cmd 0xa3 status: scsi 0x2 srb 0x86 hv 0xc0000001

The recently added support for command duration limits calls
scsi_report_opcode() four times as each device comes online, which
significantly increases the number of messages logged in a system with many
disks.

Fix the problem by always marking Hyper-V synthetic SCSI devices as not
supporting scsi_report_opcode(). With this setting, the MAINTENANCE_IN SCSI
command is not issued and no messages are logged.

Signed-off-by: Michael Kelley <mikelley@microsoft.com>
Link: https://lore.kernel.org/r/1686343101-18930-1-git-send-email-mikelley@microsoft.com
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/scsi/storvsc_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/storvsc_drv.c b/drivers/scsi/storvsc_drv.c
index e6bc622954cfa..659196a2f63ad 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1567,6 +1567,8 @@ static int storvsc_device_configure(struct scsi_device *sdevice)
 {
 	blk_queue_rq_timeout(sdevice->request_queue, (storvsc_timeout * HZ));
 
+	/* storvsc devices don't support MAINTENANCE_IN SCSI cmd */
+	sdevice->no_report_opcodes = 1;
 	sdevice->no_write_same = 1;
 
 	/*
-- 
2.39.2

