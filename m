Return-Path: <linux-hyperv+bounces-8178-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A5C6D003AC
	for <lists+linux-hyperv@lfdr.de>; Wed, 07 Jan 2026 22:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E9D173065783
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jan 2026 21:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0671D303C86;
	Wed,  7 Jan 2026 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EVca2MYY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143782FF143;
	Wed,  7 Jan 2026 21:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822365; cv=none; b=SBvj4L7ISXZR5/Ul6TqPcVsukuZ3xFfJKmFzplmKcbQgo+qZL30Kh8Ztj+ja2MxCNQmHsMlNK3PHfj9vfqeHT/MRD0lgFX9CrmaJ8E3Xnn5xTzII1NLL9shSbu2wjXxw8UMCyinxQOsDf7e2LL9ER+BrOCrUTRzeltDBtn846pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822365; c=relaxed/simple;
	bh=82xM+H3fSBvMvy2l03PKfAo5wxYdkZ9cWHesuRhC6vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=owfy3eD3ut5J4aGnviK0JGxKvY97WBfc8bwl8zx+35SDuo+MSY0bjxyHiLJN6AsqGO/UWtTGfFWyOosw6ZWcAzIlHeYEmxvm2rtnE8iHh9aRqQTTM50Oag3Evbn+j61AbYTXjRZWiUDFkAXkACVM5R518NDHDMdLVt+IOXzBDM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EVca2MYY; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767822364; x=1799358364;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=82xM+H3fSBvMvy2l03PKfAo5wxYdkZ9cWHesuRhC6vg=;
  b=EVca2MYYOGgXKqmLQW3d9rQ2lGw6oV09CZMO4/SWOFbA4d7BlEisbg+D
   OLSYfxcSpPwfQyAgElDRTQQ80nbP2u7iaTyO2IylF1Nj/vHwlGMpHjUm2
   nR7xWzng8EqVhD+cjONMd91TLeJtwQOIbjdyHv7nYD7sAthdOfDNMyTIQ
   2644arpX25iqH02njzHDjtcWUCDY+JlHzCcMVmMJEiW+Z5JtEbKPDZWZm
   rlR9yIg2TKpdQQ5fpqMiU6sn+zOvtJBLxfUjcRm+sPE9J8oPvOH6TFRbO
   7abNtQyQNIlMMGWr0VVlNHKUWkXxyAU65NvsaHDv5yrfDm1+lY0jsZH2c
   g==;
X-CSE-ConnectionGUID: /CWzgBcnRkmUF2j9IhFwCw==
X-CSE-MsgGUID: MeycyyG3TD6I7k+jLLAS6A==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69359277"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69359277"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:02 -0800
X-CSE-ConnectionGUID: Q78kZ40SReKKG/bEeJJVwg==
X-CSE-MsgGUID: LIfGvrzHTU2MYwcwCTJUvA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="207510900"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:01 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 07 Jan 2026 13:44:39 -0800
Subject: [PATCH v8 03/10] dt-bindings: reserved-memory: Wakeup Mailbox for
 Intel processors
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-rneri-wakeup-mailbox-v8-3-2f5b6785f2f5@linux.intel.com>
References: <20260107-rneri-wakeup-mailbox-v8-0-2f5b6785f2f5@linux.intel.com>
In-Reply-To: <20260107-rneri-wakeup-mailbox-v8-0-2f5b6785f2f5@linux.intel.com>
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
 "Rafael J. Wysocki (Intel)" <rafael.j.wysocki@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767822314; l=5190;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=82xM+H3fSBvMvy2l03PKfAo5wxYdkZ9cWHesuRhC6vg=;
 b=YIDmY0zSODSmEsmAdICm50Xs5tZBWPI6wqhrTPofOUtSyei06dvakB3Ms82f8KOOYroQGPl3h
 eO1AVqDz2+NDbZ5cDGluvPQZPOS9vkb8y6r1zS36lI6kAWR/cYpWvOF
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
Acked-by: Rafael J. Wysocki (Intel) <rafael.j.wysocki@intel.com>
Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
Changes in v8:
 - None

Changes in v7:
 - Fixed Acked-by tag from Rafael to include the "(Intel)" suffix.

Changes in v6:
 - Reworded the changelog for clarity.
 - Added Acked-by tag from Rafael. Thanks!
 - Added Reviewed-by tag from Rob. Thanks!
 - Added Reviewed-by tag from Dexuan. Thanks!

Changes in v5:
 - Specified the version and section of the ACPI spec in which the
   wakeup mailbox is defined. (Rafael)
 - Fixed a warning from yamllint about line lengths of URLs.

Changes in v4:
 - Removed redefinitions of the mailbox and instead referred to ACPI
   specification as per discussion on LKML.
 - Clarified that DeviceTree-based firmware do not require the use of
   ACPI tables to enumerate the mailbox. (Rob)
 - Described the need of using a `compatible` property.
 - Dropped the `alignment` property. (Krzysztof, Rafael)
 - Used a real address for the mailbox node. (Krzysztof)

Changes in v3:
 - Implemented the mailbox as a reserved-memory node. Add to it a
   `compatible` property. (Krzysztof)
 - Explained the relationship between the mailbox and the `enable-mehod`
   property of the CPU nodes.
 - Expanded the documentation of the binding.

Changes in v2:
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


