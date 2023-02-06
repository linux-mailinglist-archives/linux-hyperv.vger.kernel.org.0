Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7CA68C541
	for <lists+linux-hyperv@lfdr.de>; Mon,  6 Feb 2023 18:54:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjBFRyf (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 6 Feb 2023 12:54:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230193AbjBFRyb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 6 Feb 2023 12:54:31 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2139D22A17;
        Mon,  6 Feb 2023 09:54:30 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id BD0B320C7E21;
        Mon,  6 Feb 2023 09:54:28 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com BD0B320C7E21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1675706068;
        bh=aAEQsXw93ASVLNaj7yldD7WcYztof31LvCytxSCKKmI=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=W8gN2mOjF3uwDunFwChQrdlECU8hWzhSk3cn7vJL4Mcv2FfwuHY0RVmN83MjQ/Vnj
         Xv+7cT1Zl1LyItpBfliNqE4UxBpSj4w8oisGhSbWK48IUHGHdEhEmgLlvX3tQOeu+o
         YLtk1IW+vetdfR4DY1wRaEVOyXMVWEghkteDnv5w=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        virtualization@lists.linux-foundation.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com, dphadke@linux.microsoft.com
Subject: [PATCH v3 5/6] dt-bindings: hypervisor: VMBus
Date:   Mon,  6 Feb 2023 09:54:19 -0800
Message-Id: <1675706060-22361-6-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1675706060-22361-1-git-send-email-ssengar@linux.microsoft.com>
References: <1675706060-22361-1-git-send-email-ssengar@linux.microsoft.com>
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
[V3]
- Removed "device tree bindings" from title and patch subject.
- Removed duplicate vendor prefix, used microsoft instead of msft.
- Drop hex notation and leading zeros from device tree cell properties.
- Use 'soc' in example of device tree documantation for parent node.

 .../bindings/hypervisor/microsoft,vmbus.yaml  | 48 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hypervisor/microsoft,vmbus.yaml

diff --git a/Documentation/devicetree/bindings/hypervisor/microsoft,vmbus.yaml b/Documentation/devicetree/bindings/hypervisor/microsoft,vmbus.yaml
new file mode 100644
index 000000000000..a9c43a626df4
--- /dev/null
+++ b/Documentation/devicetree/bindings/hypervisor/microsoft,vmbus.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/hypervisor/microsoft,vmbus.yaml#
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
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        vmbus@ff0000000 {
+            #address-cells = <2>;
+            #size-cells = <1>;
+            compatible = "microsoft,vmbus";
+            ranges = <0x0f 0xf0000000 0x0f 0xf0000000 0x10000000>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 27a5650a9ffd..669f1c147bcb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9490,6 +9490,7 @@ S:	Supported
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git
 F:	Documentation/ABI/stable/sysfs-bus-vmbus
 F:	Documentation/ABI/testing/debugfs-hyperv
+F:	Documentation/devicetree/bindings/hypervisor/microsoft,vmbus.yaml
 F:	Documentation/virt/hyperv
 F:	Documentation/networking/device_drivers/ethernet/microsoft/netvsc.rst
 F:	arch/arm64/hyperv
-- 
2.25.1

