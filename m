Return-Path: <linux-hyperv+bounces-5732-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A96ABACD08F
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 02:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23A02176694
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Jun 2025 00:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A42681E871;
	Wed,  4 Jun 2025 00:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nBH6JF5n"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D23F379F5;
	Wed,  4 Jun 2025 00:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748996285; cv=none; b=JIpVniCEmn15C9vJzfNB4bB1a5842VvIk9E5hdAas7pks+l1TGCcRIW0NJbj2p+1a1wLcZlVLHfC2c4z4UY+AtuL3Xue2s5lMMkbe38iya2Gid0V/FkZl7VniKgmrdyRxXZA9wft0PzFfgALTKWnoBoJpl6DprglMxZpkapvpb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748996285; c=relaxed/simple;
	bh=vvzYz3uQ9MMaozEQnAeRM+GHHaJn/qRlXLRb/AZhEXU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aWQ08MpBV0gRLHt4+KV+bReLc7Opst/dJyhte+Kg201tb/t5Z8vMAxd6tg7rO8Ntl9MIlFxrjJjIwjJqkrKC9H8Z0RK/Agy+QVyKPOCehNqL/jxoEKJgJEthxPjjOMx2uwXVfVdyprCRSQcr31xQwZuVS8alWFxQWg6Jm1imj04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nBH6JF5n; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748996284; x=1780532284;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=vvzYz3uQ9MMaozEQnAeRM+GHHaJn/qRlXLRb/AZhEXU=;
  b=nBH6JF5nl13PWe/eFltzKrso1E0IHtq/G1BDdINmkM3NIuR1NTvn16fl
   zRbFuQpRX6iuHJ1pzG+lVhXGIRd6wHLW3MSsh/kpkqsUkwCwsY5ZtC7ob
   GD5DKe4yxeyMLxlR8hzXgwuqndCLA2zJw0KEPVl7u0iJFVTzppjidau9f
   ZsPEiovu3YlNrZ6EXBdPcgtSwUZDvJ0WQMj9V2bTk86xp5DmlBdiG0U4s
   bsb61FDqw9OaaFf5lHRbg91/JAYc2zaYqGk9zbVS4orFK/ZNaU8mpnfsj
   bVvbzBA54EJzquSJZ+ZJFvQsT8S2fYSfPEAxdZzvpdzAHxyTXOFUlqzgH
   Q==;
X-CSE-ConnectionGUID: 9f/zIW0gQ0KQGd6oIOT98w==
X-CSE-MsgGUID: 1R4tgbTfTJG/X1ieWWMXzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11453"; a="62112941"
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="62112941"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:18:01 -0700
X-CSE-ConnectionGUID: gFHP8ZaIQO2P1Wr1JTUmiQ==
X-CSE-MsgGUID: 3zZuiT82S5+dHL688F5yXw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,207,1744095600"; 
   d="scan'208";a="149904458"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2025 17:18:00 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Tue, 03 Jun 2025 17:15:15 -0700
Subject: [PATCH v4 03/10] dt-bindings: reserved-memory: Wakeup Mailbox for
 Intel processors
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-rneri-wakeup-mailbox-v4-3-d533272b7232@linux.intel.com>
References: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com>
In-Reply-To: <20250603-rneri-wakeup-mailbox-v4-0-d533272b7232@linux.intel.com>
To: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Michael Kelley <mhklinux@outlook.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>, 
 Chris Oo <cho@microsoft.com>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 linux-hyperv@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Ravi V. Shankar" <ravi.v.shankar@intel.com>, 
 Ricardo Neri <ricardo.neri@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1748996287; l=4376;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=vvzYz3uQ9MMaozEQnAeRM+GHHaJn/qRlXLRb/AZhEXU=;
 b=siYJEvDiKe+DCn4lcO2uPx6gRKyuWl+gMC+a9Alta4m8j0lQm1lqxadUmd+iFDNL+2Pi3JOgi
 PB/otJXRApoAc0Yp3dp/Gi29aWYTS+cdw7lqh56cjTOK7N9X7qBvGjl
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

Add DeviceTree bindings to enumerate the wakeup mailbox used in platform
firmware for Intel processors.

x86 platforms commonly boot secondary CPUs using an INIT assert, de-assert
followed by Start-Up IPI messages. The wakeup mailbox can be used when this
mechanism is unavailable.

The wakeup mailbox offers more control to the operating system to boot
secondary CPUs than a spin-table. It allows the reuse of same wakeup vector
for all CPUs while maintaining control over which CPUs to boot and when.
While it is possible to achieve the same level of control using a spin-
table, it would require to specify a separate `cpu-release-addr` for each
secondary CPU.

The operation and structure of the mailbox is described in the
Multiprocessor Wakeup Structure defined in the ACPI specification. Note
that this structure does not specify how to publish the mailbox to the
operating system (ACPI-based platform firmware uses a separate table). No
ACPI table is needed in DeviceTree-based firmware to enumerate the mailbox.

Add a `compatible` property that the operating system can use to discover
the mailbox. Nodes wanting to refer to the reserved memory usually define a
`memory-region` property. /cpus/cpu* nodes would want to refer to the
mailbox, but they do not have such property defined in the DeviceTree
specification. Moreover, it would imply that there is a memory region per
CPU.

Co-developed-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
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
 .../reserved-memory/intel,wakeup-mailbox.yaml      | 48 ++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
new file mode 100644
index 000000000000..f18643805866
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
@@ -0,0 +1,48 @@
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
+  Wakeup Structure of the ACPI specification.
+
+  The implementation of the mailbox in platform firmware is described in the
+  Intel TDX Virtual Firmware Design Guide section 4.3.5.
+
+  See https://www.intel.com/content/www/us/en/content-details/733585/intel-tdx-virtual-firmware-design-guide.html
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


