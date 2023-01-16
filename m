Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28FAE66CAD7
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Jan 2023 18:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbjAPRIJ (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Jan 2023 12:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233970AbjAPRHn (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Jan 2023 12:07:43 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 29823442FC;
        Mon, 16 Jan 2023 08:48:14 -0800 (PST)
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4440B20DFE7B;
        Mon, 16 Jan 2023 08:48:13 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4440B20DFE7B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1673887693;
        bh=8WJ4zN5MuJ/C11+0ipegAO1si9SMvqeWNRylUa8fNzc=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=SjlDDfFhL9lfRd/aAv5hJ1HJ4R9srUQcXj9teGHm7+UGQLoLW1dy6/XPfY07mR9Ra
         DEKKMNkKJvFKNbdBLAoKIa5nt3aDtEyKsM+wZm50Hz7rHu/8FO3BKNEzpDP566/I9I
         QZPbBRsm8wDewAHHWkZxzmZQpq2ZxomBKn5QF3G4=
From:   Saurabh Sengar <ssengar@linux.microsoft.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, mikelley@microsoft.com,
        ssengar@microsoft.com
Subject: [PATCH 4/4] dt-bindings: hv: Add dt-bindings for VMBus
Date:   Mon, 16 Jan 2023 08:48:08 -0800
Message-Id: <1673887688-19151-5-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
References: <1673887688-19151-1-git-send-email-ssengar@linux.microsoft.com>
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
 .../devicetree/bindings/hv/msft,vmbus.yaml         | 34 ++++++++++++++++++++++
 1 file changed, 34 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hv/msft,vmbus.yaml

diff --git a/Documentation/devicetree/bindings/hv/msft,vmbus.yaml b/Documentation/devicetree/bindings/hv/msft,vmbus.yaml
new file mode 100644
index 0000000..66cb426
--- /dev/null
+++ b/Documentation/devicetree/bindings/hv/msft,vmbus.yaml
@@ -0,0 +1,34 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/hv/msft,vmbus.yaml#
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
+  ranges :
+    const: <0x00 0x00 0x0f 0xf0000000 0x10000000>
+
+required:
+  - compatible
+  - ranges
+
+examples:
+  - |
+        vmbus {
+		#address-cells = <0x02>;
+		#size-cells = <0x01>;
+		compatible = "msft,vmbus";
+		ranges = <0x00 0x00 0x0f 0xf0000000 0x10000000>;
+	};
-- 
1.8.3.1

