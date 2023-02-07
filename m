Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A1B68D0D3
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Feb 2023 08:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjBGHuF (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Feb 2023 02:50:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjBGHuE (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Feb 2023 02:50:04 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 54E3B12847;
        Mon,  6 Feb 2023 23:50:03 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id B822420C7E28;
        Mon,  6 Feb 2023 23:50:02 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B822420C7E28
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675756202;
        bh=mf6bBpSzSp5FvIZlbgZNiPFVdnfQ6pILfRC3PQopagc=;
        h=From:To:Subject:Date:From;
        b=MQWnrOafvpvN/YE8jA0A4/NMv0Ma8eqAj/Gv6A5D4Il2aBi9HAX2/wtRVlJ3inGes
         QWwt2icKXn8zhkmdfZjs+dSTr/zL+K8QTeWyXImorKt3jnqt0nRbw+Bf4VCd5dqTzk
         K8cCKOpP+k9kFX0fSKEgxICK1CNHuWJFiAXZsbfs=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com, dphadke@linux.microsoft.com
Subject: [PATCH v4 0/6] Device tree support for Hyper-V VMBus driver
Date:   Mon,  6 Feb 2023 23:49:53 -0800
Message-Id: <1675756199-5917-1-git-send-email-ssengar@linux.microsoft.com>
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
  virtio.
- Drop hex notation and leading zeros from device tree cell properties.
- Added missing full stop at the end of commit message.
- Typos fix: s/Initaly/Initially/ and s/hibernate/hibernation/.
- Replace to_acpi_device with ACPI_COMPANION which simplify the logic.
- Added more info in cover letter aboutsystem under test.

[v2]
- Convert VMBus acpi device to platform device, and added device tree support
  in separate patch. This enables using same driver structure for both the flows.
- In Device tree documentation, changed virtio folder to hypervisor and moved
  VMBus documentation there.
- Moved bindings before Device tree patch.
- Removed stale ".data" and ".name" field from of_device match table.
- Removed debug print.

Saurabh Sengar (6):
  drivers/clocksource/hyper-v: non ACPI support in hyperv clock
  Drivers: hv: allow non ACPI compilation for
    hv_is_hibernation_supported
  Drivers: hv: vmbus: Convert acpi_device to more generic
    platform_device
  dt-bindings: hypervisor: Rename virtio to hypervisor
  dt-bindings: hypervisor: VMBus
  Driver: VMBus: Add device tree support

 .../devicetree/bindings/gpio/gpio-virtio.yaml      |   4 +-
 .../bindings/hypervisor/microsoft,vmbus.yaml       |  48 +++++++++
 .../bindings/{virtio => hypervisor}/mmio.yaml      |   2 +-
 .../bindings/{virtio => hypervisor}/pci-iommu.yaml |   2 +-
 .../{virtio => hypervisor}/virtio-device.yaml      |   2 +-
 .../devicetree/bindings/i2c/i2c-virtio.yaml        |   4 +-
 MAINTAINERS                                        |   3 +-
 drivers/clocksource/hyperv_timer.c                 |  15 ++-
 drivers/hv/Kconfig                                 |   4 +-
 drivers/hv/hv_common.c                             |   4 +
 drivers/hv/vmbus_drv.c                             | 120 ++++++++++++++++-----
 11 files changed, 171 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hypervisor/microsoft,vmbus.yaml
 rename Documentation/devicetree/bindings/{virtio => hypervisor}/mmio.yaml (95%)
 rename Documentation/devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml (98%)
 rename Documentation/devicetree/bindings/{virtio => hypervisor}/virtio-device.yaml (93%)

-- 
1.8.3.1

