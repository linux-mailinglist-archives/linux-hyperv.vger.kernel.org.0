Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8A35E533D
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Sep 2022 20:39:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiIUSjI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 21 Sep 2022 14:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiIUSjH (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 21 Sep 2022 14:39:07 -0400
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC6EAA0316;
        Wed, 21 Sep 2022 11:39:06 -0700 (PDT)
Received: from skinsburskii-cloud-desktop.internal.cloudapp.net (unknown [20.14.88.254])
        by linux.microsoft.com (Postfix) with ESMTPSA id 3B448205D10E;
        Wed, 21 Sep 2022 11:39:06 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3B448205D10E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1663785546;
        bh=nmCc3UD/Zke6v9UtckBzTcZfSDMVeN9H7aJMP3kVrF8=;
        h=Subject:From:To:Cc:Date:From;
        b=qcpxKcNRxybVStd/mmCLR+4fP87jT9BEYYNTL0o8ij7x9lw9101q2HZvrFIi9CpWB
         GFSkKgrI9jOVn/+PasebnRhwcwSJJD5kNvDqmUSNLHDXOLHnHz8gjR8OjJ7WGF9Xv7
         eHTW/7GNXAXK9KMOuhMjVml1F9Tp13GJmLTh3zJw=
Subject: [PATCH] Drivers: hv: vmbus: Don't wait for the ACPI device upon
 initialization
From:   Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
To:     skinsburskii@microsoft.com
Cc:     Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 21 Sep 2022 18:39:05 +0000
Message-ID: <166378554568.581670.1124852716698789244.stgit@skinsburskii-cloud-desktop.internal.cloudapp.net>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>

Waiting to 5 seconds in case of missing VMBUS ACPI device is redundant as the
device is either present already or won't be available at all.
This patch enforces synchronous probing to make sure the bus traversal,
happening upon driver registering will either find the device (if present) or
not spend any additional time if device is absent.

Signed-off-by: Stanislav Kinsburskiy <stanislav.kinsburskiy@gmail.com>
CC: "K. Y. Srinivasan" <kys@microsoft.com>
CC: Haiyang Zhang <haiyangz@microsoft.com>
CC: Stephen Hemminger <sthemmin@microsoft.com>
CC: Wei Liu <wei.liu@kernel.org>
CC: Dexuan Cui <decui@microsoft.com>
CC: linux-hyperv@vger.kernel.org
CC: linux-kernel@vger.kernel.org
---
 drivers/hv/vmbus_drv.c |   13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 7b9f3fc3adf7..32d0009631a6 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -46,8 +46,6 @@ struct vmbus_dynid {
 
 static struct acpi_device  *hv_acpi_dev;
 
-static struct completion probe_event;
-
 static int hyperv_cpuhp_online;
 
 static void *hv_panic_page;
@@ -2468,7 +2466,6 @@ static int vmbus_acpi_add(struct acpi_device *device)
 	ret_val = 0;
 
 acpi_walk_err:
-	complete(&probe_event);
 	if (ret_val)
 		vmbus_acpi_remove(device);
 	return ret_val;
@@ -2647,6 +2644,7 @@ static struct acpi_driver vmbus_acpi_driver = {
 		.remove = vmbus_acpi_remove,
 	},
 	.drv.pm = &vmbus_bus_pm,
+	.drv.probe_type = PROBE_FORCE_SYNCHRONOUS,
 };
 
 static void hv_kexec_handler(void)
@@ -2719,7 +2717,7 @@ static struct syscore_ops hv_synic_syscore_ops = {
 
 static int __init hv_acpi_init(void)
 {
-	int ret, t;
+	int ret;
 
 	if (!hv_is_hyperv_initialized())
 		return -ENODEV;
@@ -2727,8 +2725,6 @@ static int __init hv_acpi_init(void)
 	if (hv_root_partition)
 		return 0;
 
-	init_completion(&probe_event);
-
 	/*
 	 * Get ACPI resources first.
 	 */
@@ -2737,9 +2733,8 @@ static int __init hv_acpi_init(void)
 	if (ret)
 		return ret;
 
-	t = wait_for_completion_timeout(&probe_event, 5*HZ);
-	if (t == 0) {
-		ret = -ETIMEDOUT;
+	if (!hv_acpi_dev) {
+		ret = -ENODEV;
 		goto cleanup;
 	}
 


