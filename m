Return-Path: <linux-hyperv+bounces-7235-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5B5BE6221
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 04:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 624991A63F65
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 02:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BA302580D7;
	Fri, 17 Oct 2025 02:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NCL9u+vQ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0500B23C513;
	Fri, 17 Oct 2025 02:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760669332; cv=none; b=ZXuJohNTPpSHZ4DdmuXI6Yg1aQ0Ejv5lYPRb/5txefryNVb0EVR/MjVDjvAqgL3uU2oEx4q1vnO1mmRRjXyB8a6mc4Ti6i+XCPsdf5tfDsKzt9og1ZOKUWYDgwJle9i+K0I+uw4fMHN1PXuH4KOheKeaoJ+jG1YKTfEIMV7NRu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760669332; c=relaxed/simple;
	bh=oLg5R7JbaS7IswvOghRDP1lfAnfABVgOe/7DTtyNGok=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=a91+eGXGLI7LPt6f9LMJPHTVNuke2PAl9avg3jUFk6ZqfNdUTkmqw9c3DQ+P/639EmHDTg885is8GRnlypf2yxgOTD73XrjWf8hTd9QJGvXTJSF8lSM1drAPKmA1hhyDzi3AVZzkg7Ag6BKgjNqUXPX9FYFzaC5yx/4OuPyjDPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NCL9u+vQ; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760669331; x=1792205331;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=oLg5R7JbaS7IswvOghRDP1lfAnfABVgOe/7DTtyNGok=;
  b=NCL9u+vQ4RPwGrmbn7tlr7oGmRRI4pyHktDup4NoC/7DdvGiBt2Nndim
   JMiW+kacGSR/cSOpIchUFzOPyj6gbK9xe7UFqw+oXUBnCWfe0xdleJBNv
   XvsNy3+XjoUwIV7ieqvd8mLuDsZXsJLSzgnykoLPRep3CYlA3bdyJlh8+
   F4Z1L9Ai4lwmC+xB19GoXB2kESpKwnzpbb/WDfk3aDt/ux1jAueE4FqWY
   wwW/U/+6RX3nNXNNA4l1WEbpIWtdroDeZQLg1dbBQUp+rfTpnJJQ+CpWE
   08fEvRHZew3V5OOp9YvRlQiDgR4+89tiEeanOVJXWPwbohHmQCPT7AQfv
   g==;
X-CSE-ConnectionGUID: hH9BGodpRWOqM7zKGh82SA==
X-CSE-MsgGUID: 4JZRJ2p5Rv20aoTlNiqo4w==
X-IronPort-AV: E=McAfee;i="6800,10657,11584"; a="80321904"
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="80321904"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:49 -0700
X-CSE-ConnectionGUID: qyNL6wq2QliefQYQ1sEBEw==
X-CSE-MsgGUID: KCiAEd+eTqqVvucit5K1WA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,234,1754982000"; 
   d="scan'208";a="219776552"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Oct 2025 19:48:48 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Thu, 16 Oct 2025 19:57:25 -0700
Subject: [PATCH v6 03/10] dt-bindings: reserved-memory: Wakeup Mailbox for
 Intel processors
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251016-rneri-wakeup-mailbox-v6-3-40435fb9305e@linux.intel.com>
References: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
In-Reply-To: <20251016-rneri-wakeup-mailbox-v6-0-40435fb9305e@linux.intel.com>
To: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Chris Oo <cho@microsoft.com>, "Kirill A. Shutemov" <kas@kernel.org>, 
 linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Ricardo Neri <ricardo.neri@intel.com>, 
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1760669902; l=5084;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=oLg5R7JbaS7IswvOghRDP1lfAnfABVgOe/7DTtyNGok=;
 b=CI7wjInJve2S/liRXvszC3keOnFGYoDjantzRfogHbfd6i/q5hmH3jGhCk18xquLT29Dwplpd
 k1G8ZdZ7aOpA1Ld7XxRzlQ/kXkJumDUKqk3T6BY4iKr2UmpSWwfjfg9
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Add DeviceTree bindings to enumerate the wakeup mailbox used in platform
firmware for Intel processors.

x86 platforms commonly boot secondary CPUs using an INIT assert, de-assert
followed by Start-Up IPI messages. The wakeup mailbox can be used when this
mechanism is unavailable.

The wakeup mailbox offers more control to the operating system to boot
secondary CPUs than a spin-table. It allows the reuse of the same wakeup
vector for all CPUs while maintaining control over which CPUs to boot and
when. While it is possible to achieve the same level of control using a
spin-table, it would require specifying a separate `cpu-release-addr` for
each secondary CPU.

The operation and structure of the mailbox are described in the
Multiprocessor Wakeup Structure defined in the ACPI specification. Note
that this structure does not specify how to publish the mailbox to the
operating system (ACPI-based platform firmware uses a separate table). No
ACPI table is needed in DeviceTree-based firmware to enumerate the mailbox.

Nodes that want to refer to the reserved memory usually define
a `memory-region` property. /cpus/cpu* nodes would want to refer to the
mailbox, but they do not have such property defined in the DeviceTree
specification. Moreover, it would imply that there is a memory region per
CPU. Instead, add a `compatible` property that the operating system can use
to discover the mailbox.

Reviewed-by: Dexuan Cui <decui@microsoft.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes since v5:
 - Reworded the changelog for clarity.
 - Added Acked-by tag from Rafael. Thanks!
 - Added Reviewed-by tag from Rob. Thanks!
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes since v4:
 - Specified the version and section of the ACPI spec in which the
   wakeup mailbox is defined. (Rafael)
 - Fixed a warning from yamllint about line lengths of URLs.

Changes since v3:
 - Removed redefinitions of the mailbox and instead referred to ACPI
   specification as per discussion on LKML.
 - Clarified that DeviceTree-based firmware do not require the use of
   ACPI tables to enumerate the mailbox. (Rob)
 - Described the need of using a `compatible` property.
 - Dropped the `alignment` property. (Krzysztof, Rafael)
 - Used a real address for the mailbox node. (Krzysztof)

Changes since v2:
 - Implemented the mailbox as a reserved-memory node. Add to it a
   `compatible` property. (Krzysztof)
 - Explained the relationship between the mailbox and the `enable-mehod`
   property of the CPU nodes.
 - Expanded the documentation of the binding.

Changes since v1:
 - Added more details to the description of the binding.
 - Added requirement a new requirement for cpu@N nodes to add an
   `enable-method`.
---
 .../reserved-memory/intel,wakeup-mailbox.yaml      | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
new file mode 100644
index 000000000000..a80d3bac44c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
@@ -0,0 +1,50 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/reserved-memory/intel,wakeup-mailbox.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wakeup Mailbox for Intel processors
+
+description: |
+  The Wakeup Mailbox provides a mechanism for the operating system to wake up
+  secondary CPUs on Intel processors. It is an alternative to the INIT-!INIT-
+  SIPI sequence used on most x86 systems.
+
+  The structure and operation of the mailbox is described in the Multiprocessor
+  Wakeup Structure of the ACPI specification version 6.6 section 5.2.12.19 [1].
+
+  The implementation of the mailbox in platform firmware is described in the
+  Intel TDX Virtual Firmware Design Guide section 4.3.5 [2].
+
+  1: https://uefi.org/specs/ACPI/6.6/05_ACPI_Software_Programming_Model.html#multiprocessor-wakeup-structure
+  2: https://www.intel.com/content/www/us/en/content-details/733585/intel-tdx-virtual-firmware-design-guide.html
+
+
+maintainers:
+  - Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
+
+allOf:
+  - $ref: reserved-memory.yaml
+
+properties:
+  compatible:
+    const: intel,wakeup-mailbox
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    reserved-memory {
+        #address-cells = <2>;
+        #size-cells = <1>;
+
+        wakeup-mailbox@ffff0000 {
+            compatible = "intel,wakeup-mailbox";
+            reg = <0x0 0xffff0000 0x1000>;
+        };
+    };

-- 
2.43.0


