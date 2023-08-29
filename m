Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB10F78C5EC
	for <lists+linux-hyperv@lfdr.de>; Tue, 29 Aug 2023 15:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234410AbjH2Net (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 29 Aug 2023 09:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236268AbjH2Nd6 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 29 Aug 2023 09:33:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA73CDB;
        Tue, 29 Aug 2023 06:33:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9B59A657A4;
        Tue, 29 Aug 2023 13:33:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1DC9C433CA;
        Tue, 29 Aug 2023 13:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693316030;
        bh=zjCyClAbSddK0G/BsujVzB6NcEfzr6b4xukEH0rpEhg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pPP+a8PjayANZ9nOo7drcW0lStOzlatWV/ilPhjOaKvKehamQ+ii4uLqbOAP637as
         NQDENekLR5Jivegd6PSe5cZaQ7Xt5jqxZasHhEXQRBm4/ea3ozNgGs7Lrc2o/S3qtd
         sEla08r8z46aKunL11MJoof1lbBVU7jvVo/wmeaQGU4Wvk0+9eIE6Wi8FihzoKBxzY
         +1l0EDRSfAagzd4nMJZbg6/ir3gkcVvF7wLrJyoSokdaMubaCQNe1j3eP94/wP+pha
         tNNFazptMqcJLf0eLjWOTQysy30IJfhtgpfHM8dHIafa55QcPGeaJs/H3QnKTaR00g
         BFd/YUMfqJzGw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sasha Levin <sashal@kernel.org>, kys@microsoft.com,
        haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com,
        jejb@linux.ibm.com, linux-hyperv@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 6/7] scsi: storvsc: Always set no_report_opcodes
Date:   Tue, 29 Aug 2023 09:33:35 -0400
Message-Id: <20230829133336.520573-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230829133336.520573-1-sashal@kernel.org>
References: <20230829133336.520573-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.192
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
index 70b4868fe2f7d..17efb6c9e21f4 100644
--- a/drivers/scsi/storvsc_drv.c
+++ b/drivers/scsi/storvsc_drv.c
@@ -1537,6 +1537,8 @@ static int storvsc_device_configure(struct scsi_device *sdevice)
 {
 	blk_queue_rq_timeout(sdevice->request_queue, (storvsc_timeout * HZ));
 
+	/* storvsc devices don't support MAINTENANCE_IN SCSI cmd */
+	sdevice->no_report_opcodes = 1;
 	sdevice->no_write_same = 1;
 
 	/*
-- 
2.40.1

