Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B17D768D0DE
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Feb 2023 08:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjBGHuI (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Feb 2023 02:50:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbjBGHuF (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Feb 2023 02:50:05 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D8CF1E5D2;
        Mon,  6 Feb 2023 23:50:03 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 2734720C7E2F;
        Mon,  6 Feb 2023 23:50:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2734720C7E2F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675756203;
        bh=mKpNmSIgrjwnpdItA6SeJ/oovZZXYlrfih5kK51feog=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=R0SNKSjcaz3wSPXL2zVGuCdBX1jPSIPMYo2+sMKaCaKtvv7Xb0HwbpJcvrdOokItX
         tBSS8HoQT13yq4tDZTdC8A/AZnEb9kFCPJFx33qyr2IEREn89LkIxBbFBHslZKvf3f
         Z4U1/eDnHX9whprI4g6RpF4S95C0qnw9T1WW9s2s=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com, dphadke@linux.microsoft.com
Subject: [PATCH v4 4/6] dt-bindings: hypervisor: Rename virtio to hypervisor
Date:   Mon,  6 Feb 2023 23:49:57 -0800
Message-Id: <1675756199-5917-5-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675756199-5917-1-git-send-email-ssengar@linux.microsoft.com>
References: <1675756199-5917-1-git-send-email-ssengar@linux.microsoft.com>
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
 Documentation/devicetree/bindings/gpio/gpio-virtio.yaml               | 4 ++--
 Documentation/devicetree/bindings/{virtio => hypervisor}/mmio.yaml    | 2 +-
 .../devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml         | 2 +-
 .../devicetree/bindings/{virtio => hypervisor}/virtio-device.yaml     | 2 +-
 Documentation/devicetree/bindings/i2c/i2c-virtio.yaml                 | 4 ++--
 MAINTAINERS                                                           | 2 +-
 6 files changed, 8 insertions(+), 8 deletions(-)
 rename Documentation/devicetree/bindings/{virtio => hypervisor}/mmio.yaml (95%)
 rename Documentation/devicetree/bindings/{virtio => hypervisor}/pci-iommu.yaml (98%)
 rename Documentation/devicetree/bindings/{virtio => hypervisor}/virtio-device.yaml (93%)

diff --git a/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml b/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
index 601d857..e08ed2a 100644
--- a/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
+++ b/Documentation/devicetree/bindings/gpio/gpio-virtio.yaml
@@ -10,10 +10,10 @@ maintainers:
   - Viresh Kumar <viresh.kumar@linaro.org>
 
 allOf:
-  - $ref: /schemas/virtio/virtio-device.yaml#
+  - $ref: /schemas/hypervisor/virtio-device.yaml#
 
 description:
-  Virtio GPIO controller, see /schemas/virtio/virtio-device.yaml for more
+  Virtio GPIO controller, see /schemas/hypervisor/virtio-device.yaml for more
   details.
 
 properties:
diff --git a/Documentation/devicetree/bindings/virtio/mmio.yaml b/Documentation/devicetree/bindings/hypervisor/mmio.yaml
similarity index 95%
rename from Documentation/devicetree/bindings/virtio/mmio.yaml
rename to Documentation/devicetree/bindings/hypervisor/mmio.yaml
index 0aa8433..8492c9b 100644
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
index 972a785..52de535 100644
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
index 8c6919b..7b8d93b 100644
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
diff --git a/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml b/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
index 7d87ed8..99a0ce2 100644
--- a/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
+++ b/Documentation/devicetree/bindings/i2c/i2c-virtio.yaml
@@ -11,10 +11,10 @@ maintainers:
 
 allOf:
   - $ref: /schemas/i2c/i2c-controller.yaml#
-  - $ref: /schemas/virtio/virtio-device.yaml#
+  - $ref: /schemas/hypervisor/virtio-device.yaml#
 
 description:
-  Virtio I2C device, see /schemas/virtio/virtio-device.yaml for more details.
+  Virtio I2C device, see /schemas/hypervisor/virtio-device.yaml for more details.
 
 properties:
   $nodename:
diff --git a/MAINTAINERS b/MAINTAINERS
index f76ca28..27a5650 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21977,7 +21977,7 @@ L:	virtualization@lists.linux-foundation.org
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-vdpa
 F:	Documentation/ABI/testing/sysfs-class-vduse
-F:	Documentation/devicetree/bindings/virtio/
+F:	Documentation/devicetree/bindings/hypervisor/
 F:	Documentation/driver-api/virtio/
 F:	drivers/block/virtio_blk.c
 F:	drivers/crypto/virtio/
-- 
1.8.3.1

