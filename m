Return-Path: <linux-hyperv+bounces-8179-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA702D003BE
	for <lists+linux-hyperv@lfdr.de>; Wed, 07 Jan 2026 22:50:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 56BA93073F87
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Jan 2026 21:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE19C3164B8;
	Wed,  7 Jan 2026 21:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="k0QqEpPa"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B072FD675;
	Wed,  7 Jan 2026 21:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767822366; cv=none; b=dNzD7X9ACSASheOyL93AD29ed3K58xRSfUQancVbtBfcxW/kl7kfBJ4+HLHre7JOHevBTVg0/SrAlWsY1Ue6NgDqC7dF5IEDF4wS0J8gF5jiykdM1i4CNft7ptes4X7D2RpxQ8nFsB5NyL/z/m6pZjL7r15nd+yibAkf6NiR3f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767822366; c=relaxed/simple;
	bh=NdS4ZdXBkkRN7K08sIvtbJQP3h4b7Q0tVM5s2X+lZ14=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R5iFNsvv3dI7+1Dc62HKB1fcXW4MIt+8GBuYWfRWRG5p8anh8VxjvvCMrmFyGL+a3oxu/EVA1X1LpJtO9LwvIo8PMnJaxxBgzYDQhDMvd+xWbm0jCskZRCeXXCjITZ3GUTgVL3wIYwP1rH23/3vepJe4/9ziknFCGOAPfmmyVGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=k0QqEpPa; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767822364; x=1799358364;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=NdS4ZdXBkkRN7K08sIvtbJQP3h4b7Q0tVM5s2X+lZ14=;
  b=k0QqEpPaY2EdNkSsUuGA5VS8ZprSZAOCmALi/q0HlqBzJ0Nbnpiz5fCh
   pGjGfiuffe4LoKtj/TZv0qu9dFW0uAnU+ZiZerwsbw4hNhpEfyMMhVUqM
   Cy4LuWiuTRfEQvihC3ZDmHwtmaBrGnrfEn4EkTaAl7QXdjPx9Gl2viWSu
   lUhERxT34yhgFyUly53xUQGIykYXga4/4j6PRyCDXjzq2xYUkk+FoQn4y
   kSZizWircY5NmDv/19jQBLc6MdBkc04ds+ClNiwHgoWbRm8Ifp/5clklE
   t7a/2wxfIx6ymtw6XO1542c2PXntx6gkSS9hEsMxY+NCEtxoKoaoeadYg
   g==;
X-CSE-ConnectionGUID: 2spQBLkZTJ6AjRPCMjWG3Q==
X-CSE-MsgGUID: 0McTCgOeSDaqy/wTvEaHMw==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="69359269"
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="69359269"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:01 -0800
X-CSE-ConnectionGUID: UzgZZJMtS7aXDaIuk6g7VA==
X-CSE-MsgGUID: P8DIsaDNT42ExW8cS8eopQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,209,1763452800"; 
   d="scan'208";a="207510892"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 13:46:01 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 07 Jan 2026 13:44:37 -0800
Subject: [PATCH v8 01/10] x86/topology: Add missing struct declaration and
 attribute dependency
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260107-rneri-wakeup-mailbox-v8-1-2f5b6785f2f5@linux.intel.com>
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
 Ricardo Neri <ricardo.neri@intel.com>, kernel test robot <lkp@intel.com>, 
 Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1767822314; l=2940;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=NdS4ZdXBkkRN7K08sIvtbJQP3h4b7Q0tVM5s2X+lZ14=;
 b=xzVydyLiGWBex4Xjw66rRDOffP2UTOf3Endcem8IFBdIE53KV79bxtqRpwLb5Jp//9h9bP6O5
 KCAUXTXotX9BpQwKpYwD1EYV3XTvCS2Eta6qsqzTFlNQZUx94abv6Zy
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=

The prototypes for get_topology_cpu_type_name() and
get_topology_cpu_type() take a pointer to struct cpuinfo_x86, but
asm/topology.h neither includes nor forward-declares the structure.
Including asm/topology.h, directly or indirectly, without including
asm/processor.h triggers a warning:

    ./arch/x86/include/asm/topology.h:159:47: error: ‘struct cpuinfo_x86’
    declared inside parameter list will not be visible outside of this
    definition or declaration [-Werror]
    159 | const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c);
        |                                               ^~~~~~~~~~~

Since only a pointer is needed, add a forward declaration of struct
cpuinfo_x86.

Additionally, sysctl_sched_itmt_enabled is declared in asm/topology.h with
the __read_mostly attribute, but the header does not include linux/cache.h.
This causes a build failure when including asm/topology.h but not linux/
cache.h:

     ./arch/x86/include/asm/topology.h:264:27: error: expected ‘=’, ‘,’,
     ‘;’, ‘asm’ or ‘__attribute__’ before ‘sysctl_sched_itmt_enabled’
     264 | extern bool __read_mostly sysctl_sched_itmt_enabled;
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~

Include the required header.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511181954.UMxCeTV1-lkp@intel.com/
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202511190008.AA0NTn3G-lkp@intel.com/
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
I independently found this issue when including asm/acpi.h to arch/x86/
hyperv/hv_vtl.c, which implicitly includes asm/topology.h but not asm/
processor.h nor linux/cache.h.
---
Changes in v8:
 - Added this patch.

Changes in v7:
 - N/A

Changes in v6:
 - N/A

Changes in v5:
 - N/A

Changes in v4:
 - N/A

Changes in v3:
 - N/A

Changes in v2:
 - N/A

Changes in v3:
 - N/A

Changes in v2:
 - N/A
---
 arch/x86/include/asm/topology.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index 1fadf0cf520c..630521a03982 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -156,6 +156,8 @@ extern unsigned int __max_threads_per_core;
 extern unsigned int __num_threads_per_package;
 extern unsigned int __num_cores_per_package;
 
+struct cpuinfo_x86;
+
 const char *get_topology_cpu_type_name(struct cpuinfo_x86 *c);
 enum x86_topology_cpu_type get_topology_cpu_type(struct cpuinfo_x86 *c);
 
@@ -259,6 +261,7 @@ extern bool x86_topology_update;
 
 #ifdef CONFIG_SCHED_MC_PRIO
 #include <asm/percpu.h>
+#include <linux/cache.h>
 
 DECLARE_PER_CPU_READ_MOSTLY(int, sched_core_priority);
 extern bool __read_mostly sysctl_sched_itmt_enabled;

-- 
2.43.0


