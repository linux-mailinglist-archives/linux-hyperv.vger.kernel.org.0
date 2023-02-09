Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3913690878
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Feb 2023 13:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbjBIMQx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Feb 2023 07:16:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjBIMQt (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Feb 2023 07:16:49 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8A90AEC4E;
        Thu,  9 Feb 2023 04:16:31 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id E4FE920C8AF3;
        Thu,  9 Feb 2023 04:15:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E4FE920C8AF3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675944943;
        bh=GI+VPyEx6h0BVnPPC0y/WHoLYEEOuv2EPkQqu7kzKDg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kdcwjwtuBNrI9HXY8HpmZ86VRzQT04nEkutIfXghfnZ1egmYQyBv6QzCgW87g8pIZ
         Bie+eLn0pLynu0InPJfJKYsivuRT9+p0Q1863BS11VH+rdKymsRg5JttbSgPtexoKu
         L7wTP/kJd5cyjimX5NHW9GT78f/B8Pz0RsohdP7k=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@linux.microsoft.com, dphadke@linux.microsoft.com
Subject: [PATCH v5 4/5] dt-bindings: hypervisor: VMBus
Date:   Thu,  9 Feb 2023 04:15:38 -0800
Message-Id: <1675944939-22631-5-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675944939-22631-1-git-send-email-ssengar@linux.microsoft.com>
References: <1675944939-22631-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Add dt-bindings for Hyper-V VMBus.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
[V5]
- moved dt documantation to bus folder
- update the dt node to have 'bus' as parent node instead of 'soc'. Also
  added compatible and ranges property for parent node.
- Made sure dt_binding_check have no error/varnings for microsoft,vmbus.yaml file

 .../bindings/bus/microsoft,vmbus.yaml         | 50 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml

diff --git a/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
new file mode 100644
index 000000000000..40daefc37615
--- /dev/null
+++ b/Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/bus/microsoft,vmbus.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microsoft Hyper-V VMBus
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
+    const: microsoft,vmbus
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
+    bus@ff0000000 {
+        compatible = "simple-bus";
+        #address-cells = <2>;
+        #size-cells = <1>;
+        ranges = <0x0 0xf 0xf0000000 0x10000000>;
+
+        vmbus@ff0000000 {
+            compatible = "microsoft,vmbus";
+            #address-cells = <2>;
+            #size-cells = <1>;
+            ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index df202a1e4b96..67ddecd1a383 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9490,6 +9490,7 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 F:	Documentation/ABI/stable/sysfs-bus-vmbus
 F:	Documentation/ABI/testing/debugfs-hyperv
+F:	Documentation/devicetree/bindings/bus/microsoft,vmbus.yaml
 F:	Documentation/virt/hyperv
 F:	Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
 F:	arch/arm64/hyperv
-- 
2.34.1

