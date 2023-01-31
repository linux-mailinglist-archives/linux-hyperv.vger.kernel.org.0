Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5FC26834D6
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Jan 2023 19:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbjAaSKW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 Jan 2023 13:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbjAaSKT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 Jan 2023 13:10:19 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C90FA25E27;
        Tue, 31 Jan 2023 10:10:17 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 82A9F20DE349;
        Tue, 31 Jan 2023 10:10:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 82A9F20DE349
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675188617;
        bh=Bo1Cw+VywhyDQcgWGZuK7oyHRAyzlfuMCm8VaFb4YAM=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=pg9+FQh770ejizrOiZ/X53MWdAvo2ADyCRyNiHS2YoLW1kSxbRI9Dd5fgzAPndBsh
         HoGzsaePEIpbTHoV+2gPjAd1hvHPaKa3UJs3E1e9D2b6ZfSKAg/+m0rx0gVexLpi5V
         pDZnBqn+CeZisrcIV2Uzk8Knv0Jg4iDYJsqu5E28=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: [PATCH v2 4/6] dt-bindings: hypervisor: Rename virtio to hypervisor
Date:   Tue, 31 Jan 2023 10:10:07 -0800
Message-Id: <1675188609-20913-5-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
References: <1675188609-20913-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Rename virtio folder to more generic hypervisor, so that this can
accommodate more devices of similar type.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 .../devicetree/bindings/{virtio => hypervisor}/mmio.yaml        | 2 +-
 .../devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml   | 2 +-
 .../bindings/{virtio => hypervisor}/virtio-device.yaml          | 2 +-
 MAINTAINERS                                                     | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename Documentation/devicetree/bindings/{virtio => hypervisor}/mmio.yaml (95%)
 rename Documentation/devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml (98%)
 rename Documentation/devicetree/bindings/{virtio => hypervisor}/virtio-device.yaml (93%)

diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/hypervisor/mmio.yaml
similarity index 95%
rename from Documentation/devicetree/bindings/virtio/mmio.yaml
rename to Documentation/devicetree/bindings/hypervisor/mmio.yaml
index 0aa8433f0a5e..8492c9b4fec9 100644
--- a/Documentation/devicetree/bindings/virtio/mmio.yaml
+++ b/Documentation/devicetree/bindings/hypervisor/mmio.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/virtio/mmio.yaml#
+$id: http://devicetree.org/schemas/hypervisor/mmio.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: virtio memory mapped devices
diff --git a/Documentation/devicetree/bindings/virtio/pci-iommu.yaml b/Documentation/devicetree/bindings/hypervisor/pci-iommu.yaml
similarity index 98%
rename from Documentation/devicetree/bindings/virtio/pci-iommu.yaml
rename to Documentation/devicetree/bindings/hypervisor/pci-iommu.yaml
index 972a785a42de..52de535fd4ef 100644
--- a/Documentation/devicetree/bindings/virtio/pci-iommu.yaml
+++ b/Documentation/devicetree/bindings/hypervisor/pci-iommu.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/virtio/pci-iommu.yaml#
+$id: http://devicetree.org/schemas/hypervisor/pci-iommu.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: virtio-iommu device using the virtio-pci transport
diff --git a/Documentation/devicetree/bindings/virtio/virtio-device.yaml b/Documentation/devicetree/bindings/hypervisor/virtio-device.yaml
similarity index 93%
rename from Documentation/devicetree/bindings/virtio/virtio-device.yaml
rename to Documentation/devicetree/bindings/hypervisor/virtio-device.yaml
index 8c6919ba9497..7b8d93b06237 100644
--- a/Documentation/devicetree/bindings/virtio/virtio-device.yaml
+++ b/Documentation/devicetree/bindings/hypervisor/virtio-device.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/virtio/virtio-device.yaml#
+$id: http://devicetree.org/schemas/hypervisor/virtio-device.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Virtio device
diff --git a/MAINTAINERS b/MAINTAINERS
index 263d37a129b1..9bc5b88b723a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21967,7 +21967,7 @@ L:	virtualization@lists.linux-foundation.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-vdpa
 F:	Documentation/ABI/testing/sysfs-class-vduse
-F:	Documentation/devicetree/bindings/virtio/
+F:	Documentation/devicetree/bindings/hypervisor/
 F:	Documentation/driver-api/virtio/
 F:	drivers/block/virtio_blk.c
 F:	drivers/crypto/virtio/
-- 
2.25.1

