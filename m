Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D25997767D2
	for <lists+linux-hyperv@lfdr.de>; Wed,  9 Aug 2023 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbjHITCc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 9 Aug 2023 15:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjHITCb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 9 Aug 2023 15:02:31 -0400
X-Greylist: delayed 1319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Aug 2023 12:02:29 PDT
Received: from vps-vb.mhejs.net (vps-vb.mhejs.net [37.28.154.113])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A56BE71;
        Wed,  9 Aug 2023 12:02:28 -0700 (PDT)
Received: from MUA
        by vps-vb.mhejs.net with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mail@maciej.szmigiero.name>)
        id 1qTo6a-0004tp-11; Wed, 09 Aug 2023 20:40:24 +0200
From:   "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
To:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>
Cc:     Jake Oshins <jakeo@microsoft.com>, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] Drivers: hv: vmbus: Don't dereference ACPI root object handle
Date:   Wed,  9 Aug 2023 20:40:18 +0200
Message-ID: <fd8e64ceeecfd1d95ff49021080cf699e88dbbde.1691606267.git.maciej.szmigiero@oracle.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>

Since the commit referenced in the Fixes: tag below the VMBus client driver
is walking the ACPI namespace up from the VMBus ACPI device to the ACPI
namespace root object trying to find Hyper-V MMIO ranges.

However, if it is not able to find them it ends trying to walk resources of
the ACPI namespace root object itself.
This object has all-ones handle, which causes a NULL pointer dereference
in the ACPI code (from dereferencing this pointer with an offset).

This in turn causes an oops on boot with VMBus host implementations that do
not provide Hyper-V MMIO ranges in their VMBus ACPI device or its
ancestors.
The QEMU VMBus implementation is an example of such implementation.

I guess providing these ranges is optional, since all tested Windows
versions seem to be able to use VMBus devices without them.

Fix this by explicitly terminating the lookup at the ACPI namespace root
object.

Note that Linux guests under KVM/QEMU do not use the Hyper-V PV interface
by default - they only do so if the KVM PV interface is missing or
disabled.

Example stack trace of such oops:
[ 3.710827] ? __die+0x1f/0x60
[ 3.715030] ? page_fault_oops+0x159/0x460
[ 3.716008] ? exc_page_fault+0x73/0x170
[ 3.716959] ? asm_exc_page_fault+0x22/0x30
[ 3.717957] ? acpi_ns_lookup+0x7a/0x4b0
[ 3.718898] ? acpi_ns_internalize_name+0x79/0xc0
[ 3.720018] acpi_ns_get_node_unlocked+0xb5/0xe0
[ 3.721120] ? acpi_ns_check_object_type+0xfe/0x200
[ 3.722285] ? acpi_rs_convert_aml_to_resource+0x37/0x6e0
[ 3.723559] ? down_timeout+0x3a/0x60
[ 3.724455] ? acpi_ns_get_node+0x3a/0x60
[ 3.725412] acpi_ns_get_node+0x3a/0x60
[ 3.726335] acpi_ns_evaluate+0x1c3/0x2c0
[ 3.727295] acpi_ut_evaluate_object+0x64/0x1b0
[ 3.728400] acpi_rs_get_method_data+0x2b/0x70
[ 3.729476] ? vmbus_platform_driver_probe+0x1d0/0x1d0 [hv_vmbus]
[ 3.730940] ? vmbus_platform_driver_probe+0x1d0/0x1d0 [hv_vmbus]
[ 3.732411] acpi_walk_resources+0x78/0xd0
[ 3.733398] vmbus_platform_driver_probe+0x9f/0x1d0 [hv_vmbus]
[ 3.734802] platform_probe+0x3d/0x90
[ 3.735684] really_probe+0x19b/0x400
[ 3.736570] ? __device_attach_driver+0x100/0x100
[ 3.737697] __driver_probe_device+0x78/0x160
[ 3.738746] driver_probe_device+0x1f/0x90
[ 3.739743] __driver_attach+0xc2/0x1b0
[ 3.740671] bus_for_each_dev+0x70/0xc0
[ 3.741601] bus_add_driver+0x10e/0x210
[ 3.742527] driver_register+0x55/0xf0
[ 3.744412] ? 0xffffffffc039a000
[ 3.745207] hv_acpi_init+0x3c/0x1000 [hv_vmbus]

Fixes: 7f163a6fd957 ("drivers:hv: Modify hv_vmbus to search for all MMIO ranges available.")
Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
---
 drivers/hv/vmbus_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 67f95a29aeca..edbb38f6956b 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -2287,7 +2287,8 @@ static int vmbus_acpi_add(struct platform_device *pdev)
 	 * Some ancestor of the vmbus acpi device (Gen1 or Gen2
 	 * firmware) is the VMOD that has the mmio ranges. Get that.
 	 */
-	for (ancestor = acpi_dev_parent(device); ancestor;
+	for (ancestor = acpi_dev_parent(device);
+	     ancestor && ancestor->handle != ACPI_ROOT_OBJECT;
 	     ancestor = acpi_dev_parent(ancestor)) {
 		result = acpi_walk_resources(ancestor->handle, METHOD_NAME__CRS,
 					     vmbus_walk_resources, NULL);
