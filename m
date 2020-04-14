Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F05E1A8296
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Apr 2020 17:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439458AbgDNPXu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Apr 2020 11:23:50 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53836 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439435AbgDNPXr (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Apr 2020 11:23:47 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <colin.king@canonical.com>)
        id 1jONPc-0005Mt-9D; Tue, 14 Apr 2020 15:23:44 +0000
From:   Colin King <colin.king@canonical.com>
To:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, linux-hyperv@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next] drivers: hv: remove redundant assignment to pointer primary_channel
Date:   Tue, 14 Apr 2020 16:23:43 +0100
Message-Id: <20200414152343.243166-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The pointer primary_channel is being assigned with a value that is never,
The assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/hv/channel_mgmt.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/hv/channel_mgmt.c b/drivers/hv/channel_mgmt.c
index ffd7fffa5f83..f7bbb8dc4b0f 100644
--- a/drivers/hv/channel_mgmt.c
+++ b/drivers/hv/channel_mgmt.c
@@ -425,8 +425,6 @@ void hv_process_channel_removal(struct vmbus_channel *channel)
 
 	if (channel->primary_channel == NULL) {
 		list_del(&channel->listentry);
-
-		primary_channel = channel;
 	} else {
 		primary_channel = channel->primary_channel;
 		spin_lock_irqsave(&primary_channel->lock, flags);
-- 
2.25.1

