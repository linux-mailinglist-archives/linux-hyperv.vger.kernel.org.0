Return-Path: <linux-hyperv+bounces-2835-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D13695D999
	for <lists+linux-hyperv@lfdr.de>; Sat, 24 Aug 2024 01:24:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADA451C22043
	for <lists+linux-hyperv@lfdr.de>; Fri, 23 Aug 2024 23:24:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B86791CB326;
	Fri, 23 Aug 2024 23:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PqNnjeQY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6931C8FCD;
	Fri, 23 Aug 2024 23:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724455436; cv=none; b=mBTGhHS8p79YgLYE9vR/4XD9vvVHR1BDzoL+9kKTFtcINdFyl6yo5Jqhl5BPCtIsom37We4/be5TwZmzTttZRKViaEuELfOKkUpJWohczb1azRXHLRmmmVw46z69XLnIGG/9SGqr47Usil+UnNbj8xzqkWdNn4ZD4qzgY8xMRSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724455436; c=relaxed/simple;
	bh=5aUWzhfxxSKh30Kjsk9wURi3JaFA6i8cqmZJO5ucEhA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hH+IoyF+sY08Zs5exMwQgPdhbDBieDUC+XxKQkaCFjyzk8MgqlpFlXBKjj010x6uWBF0hQBLrpJsDn/knOFssOg2lUZCVdM1XiVxHnw9uSgbU2+p0cOU07uxK6HSFnDPYpxIVaWSSxRsvpnCkIahK9A5ILOUePCgjbZRpJoR/Gg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PqNnjeQY; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724455435; x=1755991435;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5aUWzhfxxSKh30Kjsk9wURi3JaFA6i8cqmZJO5ucEhA=;
  b=PqNnjeQYLS56b43W8P9uqlgHWkPGbjhsxgzGBFPnTHCyiqwt58HYYZB2
   77gu3RPGhxBAw7eb2OFtDEwFNN2QXK+kvWhoucmAnQ4kumV9t1tjhrpH5
   UdnqAqlx8Sv5NZjHRbUzjTssl6t6XjTpENT6vjZ01OggV9CFcCE2/i4sK
   FhQchAXalFyuRGnxJAI3TUfnepyyNRlVyRmAJlyRcBXIVSx5OJOuWsUYX
   4sLwH9AnwKD4ECXpMhLrqQNqklr2QeUbvRQcwGiAzZ0hwNK5jcyIY4F61
   ZGhfLwEHbZCrnLcjjoYun3j7Ux8qCHdLZlKFMJYABc64tOWnUv/U4MJlM
   g==;
X-CSE-ConnectionGUID: bFZGr8x7QvaHc0Xqb2vnxA==
X-CSE-MsgGUID: WPrbokiKRQ6Bg8quLdIiZg==
X-IronPort-AV: E=McAfee;i="6700,10204,11173"; a="33619284"
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="33619284"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2024 16:23:53 -0700
X-CSE-ConnectionGUID: 8TBNYtSjTwiYw+s5qjF87w==
X-CSE-MsgGUID: ZlVimoh6Qd+DrX0EfbVC0w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,171,1719903600"; 
   d="scan'208";a="61641002"
Received: from yjiang5-dev1.sc.intel.com ([172.25.103.134])
  by fmviesa007.fm.intel.com with ESMTP; 23 Aug 2024 16:23:52 -0700
From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	rafael@kernel.org,
	lenb@kernel.org,
	kirill.shutemov@linux.intel.com,
	yunhong.jiang@linux.intel.com
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH v2 2/9] dt-bindings: x86: Add a binding for x86 wakeup mailbox
Date: Fri, 23 Aug 2024 16:23:20 -0700
Message-Id: <20240823232327.2408869-3-yunhong.jiang@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
References: <20240823232327.2408869-1-yunhong.jiang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the binding to use mailbox wakeup mechanism to bringup APs.

Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
---
 .../devicetree/bindings/x86/wakeup.yaml       | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/x86/wakeup.yaml

diff --git a/Documentation/devicetree/bindings/x86/wakeup.yaml b/Documentation/devicetree/bindings/x86/wakeup.yaml
new file mode 100644
index 000000000000..cb84e2756bca
--- /dev/null
+++ b/Documentation/devicetree/bindings/x86/wakeup.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) 2024 Intel Corporation
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/x86/wakeup.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: x86 mailbox wakeup
+maintainers:
+  - Yunhong Jiang <yunhong.jiang@linux.intel.com>
+
+description: |
+  The x86 mailbox wakeup mechanism defines a mechanism to let the bootstrap
+  processor (BSP) to wake up application processors (APs) through a wakeup
+  mailbox.
+
+  The "wakeup-mailbox-addr" property specifies the wakeup mailbox address. The
+  wakeup mailbox is a 4K-aligned 4K-size memory block allocated in the reserved
+  memory.
+
+  The wakeup mailbox structure is defined as follows.
+
+    uint16_t command;
+    uint16_t reserved;
+    uint32_t apic_id;
+    uint64_t wakeup_vector;
+    uint8_t  reservedForOs[2032];
+
+  The memory after reservedForOs field is reserved and OS should not touch it.
+
+  To wakes up a AP, the BSP prepares the wakeup routine, fills the wakeup
+  routine's address into the wakeup_vector field, fill the apic_id field with
+  the target AP's APIC_ID, and write 1 to the command field. After receiving the
+  wakeup command, the target AP will jump to the wakeup routine.
+
+  For each AP, the mailbox can be used only once for the wakeup command. After
+  the AP jumps to the wakeup routine, the mailbox will no longer be checked by
+  this AP.
+
+  The wakeup mailbox structure and the wakeup process is the same as
+  the Multiprocessor Wakeup Mailbox Structure defined in ACPI spec version 6.5,
+  section 5.2.12.19 [1].
+
+  References:
+
+  [1] https://uefi.org/specs/ACPI/6.5/05_ACPI_Software_Programming_Model.html
+
+select: false
+
+properties:
+  wakeup-mailbox-addr:
+    $ref: /schemas/types.yaml#/definitions/uint64
+    description: |
+      The physical address of the wakeup mailbox data structure. The address
+      must be 4K bytes aligned 4k-size memory and it should be in the reserved
+      memory.
+
+      This requires the "enable-method" property in the cpus node is set to
+      "acpi-wakeup-mailbox".
+
+required:
+  - wakeup-mailbox-addr
+
+additionalProperties: false
-- 
2.25.1


