Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F5F56834D2
	for <lists+linux-hyperv@lfdr.de>; Tue, 31 Jan 2023 19:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbjAaSKW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 31 Jan 2023 13:10:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231644AbjAaSKT (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 31 Jan 2023 13:10:19 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 47BBF2884D;
        Tue, 31 Jan 2023 10:10:18 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 9A96520DFDBF;
        Tue, 31 Jan 2023 10:10:17 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9A96520DFDBF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675188617;
        bh=aolDgf0ZKmA1dIvXP/OLbXrz+i5/r4RkpCnFJWskn6w=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=XhFYOZ5zsW06gmNDjCX8xlCrymk2F9BhPsEXvR9/xI2wHtfEIBQr1s3Bs3F3GJg6e
         vohocTceW2F4c2LX+iYT0AOi9q7dEutF/VcR4tV3wLpkAFX4noleRLV+9F0+goj98u
         QPBIkVVVrqWCpKTp7PovS5nSvRe43RO4V2jJl7o4=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: [PATCH v2 5/6] dt-bindings: hypervisor: Add dt-bindings for VMBus
Date:   Tue, 31 Jan 2023 10:10:08 -0800
Message-Id: <1675188609-20913-6-git-send-email-ssengar@linux.microsoft.com>
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

Add dt-bindings for Hyper-V VMBus

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 .../bindings/hypervisor/msft,vmbus.yaml       | 50 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  1 +
 3 files changed, 53 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hypervisor/msft,vmbus.yaml

diff --git a/Documentation/devicetree/bindings/hypervisor/msft,vmbus.yaml b/Documentation/devicetree/bindings/hypervisor/msft,vmbus.yaml
new file mode 100644
index 000000000000..8f50d6097c48
--- /dev/null
+++ b/Documentation/devicetree/bindings/hypervisor/msft,vmbus.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hypervisor/msft,vmbus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microsoft Hyper-V VMBus device tree bindings
+
+maintainers:
+  - Saurabh Sengar <ssengar@linux.microsoft.com>
+
+description:
+  VMBus is a software bus that implement the protocols for communication
+  between the root or host OS and guest OSs (virtual machines).
+
+properties:
+  compatible:
+    const: msft,vmbus
+
+  ranges: true
+
+  '#address-cells':
+    const: 2
+
+  '#size-cells':
+    const: 1
+
+required:
+  - compatible
+  - ranges
+  - '#address-cells'
+  - '#size-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    / {
+        compatible = "foo";
+        model = "foo";
+        #address-cells = <0x02>;
+        #size-cells = <0x02>;
+
+        vmbus@ff0000000 {
+            #address-cells = <0x02>;
+            #size-cells = <0x01>;
+            compatible = "msft,vmbus";
+            ranges = <0x00 0x00 0x0f 0xf0000000 0x10000000>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 1f7a519a936f..ab74ea97535f 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -876,6 +876,8 @@ patternProperties:
     deprecated: true
   "^mscc,.*":
     description: Microsemi Corporation
+  "^msft,.*":
+    description: Microsoft Corporation
   "^msi,.*":
     description: Micro-Star International Co. Ltd.
   "^mstar,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index 9bc5b88b723a..c749782b0cff 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9496,6 +9496,7 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 F:	Documentation/ABI/stable/sysfs-bus-vmbus
 F:	Documentation/ABI/testing/debugfs-hyperv
+F:	Documentation/devicetree/bindings/hypervisor/msft,vmbus.yaml
 F:	Documentation/virt/hyperv
 F:	Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
 F:	arch/arm64/hyperv
-- 
2.25.1

