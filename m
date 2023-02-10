Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFDF3691B70
	for <lists+linux-hyperv@lfdr.de>; Fri, 10 Feb 2023 10:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231918AbjBJJeP (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 10 Feb 2023 04:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231851AbjBJJeN (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 10 Feb 2023 04:34:13 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A185F6E9AB;
        Fri, 10 Feb 2023 01:34:11 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id D826D20C8B01;
        Fri, 10 Feb 2023 01:34:10 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com D826D20C8B01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1676021650;
        bh=q4TutN4EfLOgEY2yzLVWA4JuUxxmC/QhFlypjJsNTPc=;
        h=From:To:Subject:Date:From;
        b=Z3KEXMSgtT5NE+H6YRL05MSjppB0VRIOeVKFKZZ9iXajCXJQ6oF4Qrcm5lq3KWqI5
         YqoCCpeGWAPu1OM0sO3VY48OI412rNhyveomdsMQLL95ddmcl0HNLkgN82aECN1TG+
         KvM12OxmladTiV5wHuHZF+F15VIN7+z0WCuXUJvw=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@linux.microsoft.com, dphadke@linux.microsoft.com,
        lenb@kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v6 0/5] Device tree support for Hyper-V VMBus driver
Date:   Fri, 10 Feb 2023 01:34:01 -0800
Message-Id: <1676021646-2619-1-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This set of patches expands the VMBus driver to include device tree
support. This feature allows for a kernel boot without the use of ACPI
tables, resulting in a smaller memory footprint and potentially faster
boot times. This is tested by enabling CONFIG_FLAT and OF_EARLY_FLATTREE
for x86.

The first two patches enable compilation of Hyper-V APIs in a non-ACPI
build.

The third patch converts the VMBus driver from acpi to more generic
platform driver.

Further to add device tree documentation for VMBus, it needs to club with
other virtualization driver's documentation. For this rename the virtio
folder to more generic hypervisor, so that all the hypervisor based
devices can co-exist in a single place in device tree documentation. The
fourth patch does this renaming.

The fifth patch introduces the device tree documentation for VMBus.

The sixth patch adds device tree support to the VMBus driver. Currently
this is tested only for x86 and it may not work for other archs.

[V6]
- define acpi_sleep_state_supported in acpi header for !ACPI,
  dropped the changes done in hv_common.c under #ifdef CONFIG_ACPI
- "Devicetree" instead of "device tree"
- Remove initialize of ret
- set "np = pdev->dev.of_node;" on declarartion
- remove one error print
- use bus_addr instead of pci_addr


[V5]
- Removed #else for device tree parsing code. This should help better
  test coverage.
- Fix macro '__maybe_unused' warning
- Added below options in Kconfig to enable device tree options for HYPERV
	select OF if !ACPI
	select OF_EARLY_FLATTREE if !ACPI
- moved dt documantation to bus folder
- update the dt node to have 'bus' as parent node instead of 'soc'. Also
  added compatible and ranges property for parent node.
- Made sure dt_binding_check have no error/varnings for microsoft,vmbus.yaml file
- Fix commit messages and add Reviwed-by from Michael for first 3 patches

[V4]
- rebased which fixed return type of 'vmbus_mmio_remove' from int to void
- used __maybe_unused for 'vmbus_of_match' and safeguard vmbus_acpi_device_ids
  under #ifdef

[V3]
- Changed the logic to use generic api (for_each_of_range) for parsing "ranges".
- Remove dependency of ACPI for HYPERV in case of x86.
- Removed "device tree bindings" from title and patch subject.
- Removed duplicate vendor prefix, used microsoft instead of msft.
- Use 'soc' in example of device tree documantation for parent node.
- Fixed compatible schemas error generated in other modules referring to

Saurabh Sengar (5):
  drivers/clocksource/hyper-v: non ACPI support in hyperv clock
  ACPI: bus: Add stub acpi_sleep_state_supported() in non-ACPI cases
  Drivers: hv: vmbus: Convert acpi_device to more generic
    platform_device
  dt-bindings: hypervisor: VMBus
  Driver: VMBus: Add Devicetree support

 .../bindings/bus/microsoft,vmbus.yaml         |  50 ++++++++
 MAINTAINERS                                   |   1 +
 drivers/clocksource/hyperv_timer.c            |  15 ++-
 drivers/hv/Kconfig                            |   6 +-
 drivers/hv/vmbus_drv.c                        | 115 ++++++++++++++----
 include/linux/acpi.h                          |   5 +
 6 files changed, 163 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml

-- 
2.34.1

