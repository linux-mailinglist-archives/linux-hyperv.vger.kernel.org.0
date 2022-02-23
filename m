Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62F244C1E2D
	for <lists+linux-hyperv@lfdr.de>; Wed, 23 Feb 2022 23:05:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243363AbiBWWGD (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 23 Feb 2022 17:06:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243271AbiBWWF5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 23 Feb 2022 17:05:57 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63684DF62;
        Wed, 23 Feb 2022 14:05:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 82E5161922;
        Wed, 23 Feb 2022 22:05:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 869DCC340E7;
        Wed, 23 Feb 2022 22:05:25 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="bT1dqqnJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645653924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a89/Lm75y4Z0GZ9X8KfFu1CUr1fh3dhCCiCALwHdE1I=;
        b=bT1dqqnJZ0Fe9h5jPfLuxQFCLCzQRHrtr6PotmddfrA9rxzPtLPBsSC06Z9X6w970kXDcj
        XqDx1UgjwEwt9yJo3LgvBQsD2UdVO62j09jEj20Rq1uMZPfz6A/B6YbLhMBirSL6sOteBx
        vS7ybKBwp8Ek2YRenF9O8nJfkw4+7uI=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 0f07b509 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Wed, 23 Feb 2022 22:05:23 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-hyperv@vger.kernel.org, kvm@vger.kernel.org,
        linux-crypto@vger.kernel.org, qemu-devel@nongnu.org,
        linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, adrian@parity.io,
        dwmw@amazon.co.uk, graf@amazon.com, colmmacc@amazon.com,
        raduweis@amazon.com, imammedo@redhat.com, ehabkost@redhat.com,
        ben@skyportsystems.com, mst@redhat.com, kys@microsoft.com,
        haiyangz@microsoft.com, sthemmin@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, linux@dominikbrodowski.net, ardb@kernel.org,
        jannh@google.com, gregkh@linuxfoundation.org, tytso@mit.edu
Subject: [PATCH v2 2/2] virt: vmgenid: introduce driver for reinitializing RNG on VM fork
Date:   Wed, 23 Feb 2022 23:04:56 +0100
Message-Id: <20220223220456.666193-3-Jason@zx2c4.com>
In-Reply-To: <20220223220456.666193-1-Jason@zx2c4.com>
References: <20220223220456.666193-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

VM Generation ID is a feature from Microsoft, described at
<https://go.microsoft.com/fwlink/?LinkId=260709>, and supported by
Hyper-V and QEMU. Its usage is described in Microsoft's RNG whitepaper,
<https://aka.ms/win10rng>, as:

    If the OS is running in a VM, there is a problem that most
    hypervisors can snapshot the state of the machine and later rewind
    the VM state to the saved state. This results in the machine running
    a second time with the exact same RNG state, which leads to serious
    security problems.  To reduce the window of vulnerability, Windows
    10 on a Hyper-V VM will detect when the VM state is reset, retrieve
    a unique (not random) value from the hypervisor, and reseed the root
    RNG with that unique value.  This does not eliminate the
    vulnerability, but it greatly reduces the time during which the RNG
    system will produce the same outputs as it did during a previous
    instantiation of the same VM state.

Linux has the same issue, and given that vmgenid is supported already by
multiple hypervisors, we can implement more or less the same solution.
So this commit wires up the vmgenid ACPI notification to the RNG's newly
added add_vmfork_randomness() function.

It can be used from qemu via the `-device vmgenid,guid=auto` parameter.
After setting that, use `savevm` in the monitor to save the VM state,
then quit QEMU, start it again, and use `loadvm`. That will trigger this
driver's notify function, which hands the new UUID to the RNG.

This driver builds on prior work from Adrian Catangiu at Amazon, and it
is my hope that that team can resume maintenance of this driver.

Cc: Adrian Catangiu <adrian@parity.io>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/virt/Kconfig   |   9 ++++
 drivers/virt/Makefile  |   1 +
 drivers/virt/vmgenid.c | 120 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 130 insertions(+)
 create mode 100644 drivers/virt/vmgenid.c

diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
index 8061e8ef449f..d3276dc2095c 100644
--- a/drivers/virt/Kconfig
+++ b/drivers/virt/Kconfig
@@ -13,6 +13,15 @@ menuconfig VIRT_DRIVERS
 
 if VIRT_DRIVERS
 
+config VMGENID
+	tristate "Virtual Machine Generation ID driver"
+	default y
+	depends on ACPI
+	help
+	  Say Y here to use the hypervisor-provided Virtual Machine Generation ID
+	  to reseed the RNG when the VM is cloned. This is highly recommended if
+	  you intend to do any rollback / cloning / snapshotting of VMs.
+
 config FSL_HV_MANAGER
 	tristate "Freescale hypervisor management driver"
 	depends on FSL_SOC
diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
index 3e272ea60cd9..108d0ffcc9aa 100644
--- a/drivers/virt/Makefile
+++ b/drivers/virt/Makefile
@@ -4,6 +4,7 @@
 #
 
 obj-$(CONFIG_FSL_HV_MANAGER)	+= fsl_hypervisor.o
+obj-$(CONFIG_VMGENID)		+= vmgenid.o
 obj-y				+= vboxguest/
 
 obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
diff --git a/drivers/virt/vmgenid.c b/drivers/virt/vmgenid.c
new file mode 100644
index 000000000000..c2255ea6be59
--- /dev/null
+++ b/drivers/virt/vmgenid.c
@@ -0,0 +1,120 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Virtual Machine Generation ID driver
+ *
+ * Copyright (C) 2022 Jason A. Donenfeld <Jason@zx2c4.com>. All Rights Reserved.
+ * Copyright (C) 2020 Amazon. All rights reserved.
+ * Copyright (C) 2018 Red Hat Inc. All rights reserved.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/acpi.h>
+#include <linux/random.h>
+#include <linux/uuid.h>
+
+ACPI_MODULE_NAME("vmgenid");
+
+static struct {
+	uuid_t this_uuid;
+	uuid_t *next_uuid;
+} state;
+
+static int vmgenid_acpi_add(struct acpi_device *device)
+{
+	struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER };
+	union acpi_object *pss;
+	phys_addr_t phys_addr;
+	acpi_status status;
+	int ret = 0;
+
+	if (!device)
+		return -EINVAL;
+
+	status = acpi_evaluate_object(device->handle, "ADDR", NULL, &buffer);
+	if (ACPI_FAILURE(status)) {
+		ACPI_EXCEPTION((AE_INFO, status, "Evaluating ADDR"));
+		return -ENODEV;
+	}
+	pss = buffer.pointer;
+	if (!pss || pss->type != ACPI_TYPE_PACKAGE || pss->package.count != 2 ||
+	    pss->package.elements[0].type != ACPI_TYPE_INTEGER ||
+	    pss->package.elements[1].type != ACPI_TYPE_INTEGER) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	phys_addr = (pss->package.elements[0].integer.value << 0) |
+		    (pss->package.elements[1].integer.value << 32);
+	state.next_uuid = acpi_os_map_memory(phys_addr, sizeof(*state.next_uuid));
+	if (!state.next_uuid) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	state.this_uuid = *state.next_uuid;
+	device->driver_data = &state;
+	add_device_randomness(&state.this_uuid, sizeof(state.this_uuid));
+
+out:
+	ACPI_FREE(buffer.pointer);
+	return ret;
+}
+
+static int vmgenid_acpi_remove(struct acpi_device *device)
+{
+	if (!device || acpi_driver_data(device) != &state)
+		return -EINVAL;
+	device->driver_data = NULL;
+	if (state.next_uuid)
+		acpi_os_unmap_memory(state.next_uuid, sizeof(*state.next_uuid));
+	state.next_uuid = NULL;
+	return 0;
+}
+
+static void vmgenid_acpi_notify(struct acpi_device *device, u32 event)
+{
+	uuid_t old_uuid;
+
+	if (!device || acpi_driver_data(device) != &state)
+		return;
+	old_uuid = state.this_uuid;
+	state.this_uuid = *state.next_uuid;
+	if (!memcmp(&old_uuid, &state.this_uuid, sizeof(state.this_uuid)))
+		return;
+	add_vmfork_randomness(&state.this_uuid, sizeof(state.this_uuid));
+}
+
+static const struct acpi_device_id vmgenid_ids[] = {
+	{"VMGENID", 0},
+	{"QEMUVGID", 0},
+	{ },
+};
+
+static struct acpi_driver acpi_driver = {
+	.name = "vm_generation_id",
+	.ids = vmgenid_ids,
+	.owner = THIS_MODULE,
+	.ops = {
+		.add = vmgenid_acpi_add,
+		.remove = vmgenid_acpi_remove,
+		.notify = vmgenid_acpi_notify,
+	}
+};
+
+static int __init vmgenid_init(void)
+{
+	return acpi_bus_register_driver(&acpi_driver);
+}
+
+static void __exit vmgenid_exit(void)
+{
+	acpi_bus_unregister_driver(&acpi_driver);
+}
+
+module_init(vmgenid_init);
+module_exit(vmgenid_exit);
+
+MODULE_DEVICE_TABLE(acpi, vmgenid_ids);
+MODULE_DESCRIPTION("Virtual Machine Generation ID");
+MODULE_LICENSE("GPL v2");
-- 
2.35.1

