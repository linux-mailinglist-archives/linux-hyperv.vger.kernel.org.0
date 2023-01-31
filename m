Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE2B6834CA
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Jan 2023 19:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjAaSKT (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 Jan 2023 13:10:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbjAaSKS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 Jan 2023 13:10:18 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7504A19F1A;
        Tue, 31 Jan 2023 10:10:17 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2029820B3712;
        Tue, 31 Jan 2023 10:10:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2029820B3712
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675188617;
        bh=Njh2hRh/Sz5JeDXwWgVBU7GskswtLNmWD2gVdeP5sDo=;
        h=From:To:Subject:Date:From;
        b=KoKMr9fUhL6pfBllkuhz7ca/wt7QrhqkgvwDTJ3y/hc1hPnSDn/36xEv2L48bOKgE
         BOhapBtyOuL6reBYAhNFadtV15LvStvquTEaB4FDSKwlACe0xS9pm9zipIU+mtZpS7
         QdoW2Ap/o5Og2yDI0a4EbSJ4+IKj4Q0WCAbV41xc=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: [PATCH v2 0/6] Device tree support for Hyper-V VMBus driver
Date:   Tue, 31 Jan 2023 10:10:03 -0800
Message-Id: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
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
support.

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

[v2]
- Convert VMBus acpi device to platform device, and added device tree support
  in separate patch. This enables using same driver structure for both the flows.
- In Device tree documentation, changed virtio folder to hypervisor and moved
  VMBus documentation there.
- Moved bindings before Device tree patch.
- Removed stale ".data" and ".name" field from of_device match table.
- Removed debug print.
- Fix "make DT_CHECKER_FLAGS=-m dt_binding_check" warnings.

Saurabh Sengar (6):
  drivers/clocksource/hyper-v: non ACPI support in hyperv clock
  Drivers: hv: allow non ACPI compilation for
    hv_is_hibernation_supported
  Drivers: hv: vmbus: Convert acpi_device to platform_device
  dt-bindings: hypervisor: Rename virtio to hypervisor
  dt-bindings: hypervisor: Add dt-bindings for VMBus
  Driver: VMBus: Add device tree support

 .../bindings/{virtio => hypervisor}/mmio.yaml |   2 +-
 .../bindings/hypervisor/msft,vmbus.yaml       |  50 ++++++
 .../{virtio => hypervisor}/pci-iommu.yaml     |   2 +-
 .../{virtio => hypervisor}/virtio-device.yaml |   2 +-
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   3 +-
 drivers/clocksource/hyperv_timer.c            |  15 +-
 drivers/hv/hv_common.c                        |   4 +
 drivers/hv/vmbus_drv.c                        | 153 ++++++++++++++----
 9 files changed, 193 insertions(+), 40 deletions(-)
 rename Documentation/devicetree/bindings/{virtio => hypervisor}/mmio.yaml (95%)
 create mode 100644 Documentation/devicetree/bindings/hypervisor/msft,vmbus.yaml
 rename Documentation/devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml (98%)
 rename Documentation/devicetree/bindings/{virtio => hypervisor}/virtio-device.yaml (93%)

-- 
2.25.1

