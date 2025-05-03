Return-Path: <linux-hyperv+bounces-5332-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90881AA822B
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 21:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D53587AFD39
	for <lists+linux-hyperv@lfdr.de>; Sat,  3 May 2025 19:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECF227FD74;
	Sat,  3 May 2025 19:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CHUaGMjs"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A9427F720;
	Sat,  3 May 2025 19:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746299417; cv=none; b=irfRCzpTPtyWT058KahgKCUn/1EQMuWhStGw1R81l1/uLx630Kpcx+qMJGiy+EBV7Rjzsxj1OqpNThleog9zw7so2N1JGzDwAO8C6FX4cwUMsRA11X4uYzIlVJb82iswzYNPTQCaplGi+Ix2QKEaDdu03XZgbb/DK0ODaABFeOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746299417; c=relaxed/simple;
	bh=wTx5/iOJcza0p8s8BG5SJVFyK91RfaaB8NxoOR0pRRk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=UN9Bh7fsLnrZFKd3i97XGrhQFYeL/ixhQtzMoUD7qF2r/ot+Qr5W2nSlZudgbPcdu2Dob6Grzf/vWsD7/mGy/6J/Y9wgArE33WrTQvc4BflbNhKJ7Dd6PRCbVNA7noqRZxs44w5PMD1JZ95bxsOyy95ihRElldhllsZeP0GrKhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CHUaGMjs; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746299416; x=1777835416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=wTx5/iOJcza0p8s8BG5SJVFyK91RfaaB8NxoOR0pRRk=;
  b=CHUaGMjsT7IxVfu1BhaoM3gap7V2udBfeWcU5bYsf2dp4vdgiEqf0vqq
   OdENMFxvyfeZSan2eZ3k1GWg+8QMZ282s5renwOw9oYlHv9uoZwojU+li
   ZglALUgz1uwTyq0XYgY25sKb1qruZ7OyUBF1wLAVMU61edYECjiDU+VCF
   gA4vlBloy5zZE1IDZW5zwUnsxir371vg0bbEBWLVqZTM9xRhaR/TkAC8k
   Ou0feSpK8T3Xs13rCB+DdNYNl8rlfAWufptVgP7r5WepzqhcDfu/SK7TB
   vodE/8WeyH5argXoLmsdW8uI6KgQjXDyzC8M4haOpdqZmLaffWNwWwrBr
   A==;
X-CSE-ConnectionGUID: rDH+oDFhQtiJ1KLH9Ubt7Q==
X-CSE-MsgGUID: FtE2UcXjQl+drehsZGOrMA==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="48095629"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="48095629"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:10:13 -0700
X-CSE-ConnectionGUID: 30VHknrlRmiUEXLJ1DNokQ==
X-CSE-MsgGUID: Hcm5FjxaTkGd/DLZ8YfWWQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="140046098"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by fmviesa004.fm.intel.com with ESMTP; 03 May 2025 12:10:12 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: x86@kernel.org,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>
Cc: devicetree@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>,
	linux-hyperv@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-acpi@vger.kernel.org ,
	linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: [PATCH v3 06/13] dt-bindings: reserved-memory: Wakeup Mailbox for Intel processors
Date: Sat,  3 May 2025 12:15:08 -0700
Message-Id: <20250503191515.24041-7-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Add DeviceTree bindings for the wakeup mailbox used on Intel processors.

x86 platforms commonly boot secondary CPUs using an INIT assert, de-assert
followed by Start-Up IPI messages. The wakeup mailbox can be used when this
mechanism unavailable.

The wakeup mailbox offers more control to the operating system to boot
secondary CPUs than a spin-table. It allows the reuse of same wakeup vector
for all CPUs while maintaining control over which CPUs to boot and when.
While it is possible to achieve the same level of control using a spin-
table, it would require to specify a separate cpu-release-addr for each
secondary CPU.

Originally-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
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
 .../reserved-memory/intel,wakeup-mailbox.yaml | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml

diff --git a/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
new file mode 100644
index 000000000000..d97755b4673d
--- /dev/null
+++ b/Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
@@ -0,0 +1,87 @@
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
+  Firmware must define the enable-method property in the CPU nodes as
+  "intel,wakeup-mailbox" to use the mailbox.
+
+  Firmware implements the wakeup mailbox as a 4KB-aligned memory region of size
+  of 4KB. It is memory that the firmware reserves so that each secondary CPU can
+  have the operating system send a single message to them. The firmware is
+  responsible for putting the secondary CPUs in a state to check the mailbox.
+
+  The structure of the mailbox is as follows:
+
+  Field           Byte   Byte  Description
+                 Length Offset
+  ------------------------------------------------------------------------------
+  Command          2      0    Command to wake up the secondary CPU:
+                                        0: Noop
+                                        1: Wakeup: Jump to the wakeup_vector
+                                        2-0xFFFF: Reserved:
+  Reserved         2      2    Must be 0.
+  APIC_ID          4      4    APIC ID of the secondary CPU to wake up.
+  Wakeup_Vector    8      8    The wakeup address for the secondary CPU.
+  ReservedForOs 2032     16    Reserved for OS use.
+  ReservedForFW 2048   2048    Reserved for firmware use.
+  ------------------------------------------------------------------------------
+
+  To wake up a secondary CPU, the operating system 1) prepares the wakeup
+  routine; 2) populates the address of the wakeup routine address into the
+  Wakeup_Vector field; 3) populates the APIC_ID field with the APIC ID of the
+  secondary CPU; 4) writes Wakeup in the Command field. Upon receiving the
+  Wakeup command, the secondary CPU acknowledges the command by writing Noop in
+  the Command field and jumps to the Wakeup_Vector. The operating system can
+  send the next command only after the Command field is changed to Noop.
+
+  The secondary CPU will no longer check the mailbox after waking up. The
+  secondary CPU must ignore the command if its APIC_ID written in the mailbox
+  does not match its own.
+
+  When entering the Wakeup_Vector, interrupts must be disabled and 64-bit
+  addressing mode must be enabled. Paging mode must be enabled. The virtual
+  address of the Wakeup_Vector page must be equal to its physical address.
+  Segment selectors are not used.
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
+  alignment:
+    description: The mailbox must be 4KB-aligned.
+    const: 0x1000
+
+required:
+  - compatible
+  - alignment
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
+        wakeup-mailbox@12340000 {
+            compatible = "intel,wakeup-mailbox";
+            alignment = <0x1000>;
+            reg = <0x0 0x12340000 0x1000>;
+        };
+    };
-- 
2.43.0


