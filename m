Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64BC56A075C
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Feb 2023 12:29:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbjBWL3N (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 23 Feb 2023 06:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233932AbjBWL3L (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 23 Feb 2023 06:29:11 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 480AA1A4B4;
        Thu, 23 Feb 2023 03:29:10 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 8572620B9C3D;
        Thu, 23 Feb 2023 03:29:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 8572620B9C3D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1677151749;
        bh=9LzfJ2wDDgDGa4AhSo7ZfFDPw3dQwLl7YS8zCxwU1VI=;
        h=From:To:Subject:Date:From;
        b=sQabikqTf96urJJwh8zc9/NnNs6bMQ9A9IoOdQkLRb5tztGfwdlxaZAA2ODrdOxL0
         OdMoWOb9LJAj8dh5pBf4cKfB74OkBf+uW9d3fZacxPnwVqBx4m25EhRnGCiyRXgKQw
         DYznzRJfhrcMXQU6BcpAoGQWTdsuMC4HAsbfoby8=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        lenb@kernel.org, rafael@kernel.org, linux-acpi@vger.kernel.org
Subject: [PATCH v7 0/5] Device tree support for Hyper-V VMBus driver
Date:   Thu, 23 Feb 2023 03:29:00 -0800
Message-Id: <1677151745-16521-1-git-send-email-ssengar@linux.microsoft.com>
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

The fourth patch introduces the device tree documentation for VMBus.

The fifth patch adds device tree support to the VMBus driver. Currently
this is tested only for x86 and it may not work for other archs.

[V7]
- Use cpu_addr instead of bus_addr.
- Updated Documentation accordingly.

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

Saurabh Sengar (5):
  drivers/clocksource/hyper-v: non ACPI support in hyperv clock
  ACPI: bus: Add stub acpi_sleep_state_supported() in non-ACPI cases
  Drivers: hv: vmbus: Convert acpi_device to more generic
    platform_device
  dt-bindings: bus: VMBus
  Driver: VMBus: Add Devicetree support

 .../bindings/bus/microsoft,vmbus.yaml         |  54 ++++++++
 MAINTAINERS                                   |   1 +
 drivers/clocksource/hyperv_timer.c            |  15 ++-
 drivers/hv/Kconfig                            |   6 +-
 drivers/hv/vmbus_drv.c                        | 115 ++++++++++++++----
 include/linux/acpi.h                          |   5 +
 6 files changed, 167 insertions(+), 29 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml

-- 
2.34.1

