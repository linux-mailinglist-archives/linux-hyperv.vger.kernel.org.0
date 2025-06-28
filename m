Return-Path: <linux-hyperv+bounces-6037-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BABAEC487
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 05:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B1D454A7D16
	for <lists+linux-hyperv@lfdr.de>; Sat, 28 Jun 2025 03:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07B4C21D011;
	Sat, 28 Jun 2025 03:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dp9R4M1m"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2219821B9CE;
	Sat, 28 Jun 2025 03:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751081723; cv=none; b=F/6jbfHLIZ8ohS02E8Y2yOzP2nodmczjLzUeQXyyzM+yoO4UIwAw8O280kqY5cQ/i4xaEa+fHuKzTon4vSUwDuRq1IJxAxNZHJZSgAgwUaiVSkoRG4FhWKMZham/vZkYwcDx/Dj7TVuKG6eb8iWnAqoOM1nDdICvrd4GUtN/kbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751081723; c=relaxed/simple;
	bh=HLSJ1P1a0+J8j3M3+k+W/9+PRSEANrkFCHDDgD2xw+k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YImt1WJew2Ggl7jPhViCYoBOI6yId6wEwbvorxnpcz4kKKVRizOoZOYMgDEGHu7HmERFOmDOSG7LPZPaMg8T8AytYwepPD3qTcNndArTxdclJYTKs+aSo6nMzMsU/VrFddQ5PnEVROHM0yUIeeI0YnJx4WJNJqH6YPXpfVFBIys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dp9R4M1m; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751081722; x=1782617722;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=HLSJ1P1a0+J8j3M3+k+W/9+PRSEANrkFCHDDgD2xw+k=;
  b=dp9R4M1meDcFBaljuoIinoDlX74qC+PFhMpZkaoygROpbZoLh0pdhozK
   45E8JVSGjVjnBjklmhiVmJeP7JCPgWTCfa3TmN9nvniU8IE+4e/Sz7Nd5
   IX3kOmK/FAWirrRy8FtpgHutglC5xG8SSZ9lS25Lv6CMGxFYuDxwUtfwx
   9vPpHUGjFtrazPZ4a5P4xCbeP7harWzsquLytIKngJ64bndra5pA4C2KC
   9GdXaTsuep95s2fBwRuftuzPxil/pX6ieXbHRI4CRylylILMSKT7VH1Yd
   L3u5bG1Dg0REC+ohuyoqD+PNEsoEQpMemP3uw7zMc/aqwaltz3eAEIJg4
   g==;
X-CSE-ConnectionGUID: ubHgi4oURBObOTir33KIGQ==
X-CSE-MsgGUID: Q4pAb1PWSNGEPYzi/sLVmg==
X-IronPort-AV: E=McAfee;i="6800,10657,11477"; a="53335325"
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="53335325"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:20 -0700
X-CSE-ConnectionGUID: i1760zz6TF6Pwtpt1rMuLg==
X-CSE-MsgGUID: 3RVbVeNJShGwbqp4sFmLTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,272,1744095600"; 
   d="scan'208";a="153141926"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2025 20:35:19 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Fri, 27 Jun 2025 20:35:09 -0700
Subject: [PATCH v5 03/10] dt-bindings: reserved-memory: Wakeup Mailbox for
 Intel processors
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-rneri-wakeup-mailbox-v5-3-df547b1d196e@linux.intel.com>
References: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
In-Reply-To: <20250627-rneri-wakeup-mailbox-v5-0-df547b1d196e@linux.intel.com>
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
 Ricardo Neri <ricardo.neri@intel.com>, 
 Yunhong Jiang <yunhong.jiang@linux.intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751081737; l=4718;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=HLSJ1P1a0+J8j3M3+k+W/9+PRSEANrkFCHDDgD2xw+k=;
 b=ROTSW5k/L6MozCceFHd2ghE07viBG/E/oCWuJB5/1tx4K1HpwLgO5jBWY0P6BwqaM68gA2vUY
 IEt7NUbCyoYBTf4/Rx1v8lL9ePFDUN3YYhk+zbKQo/pJ2L+X5sgkU7Y
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


