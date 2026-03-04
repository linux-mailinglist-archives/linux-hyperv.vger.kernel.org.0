Return-Path: <linux-hyperv+bounces-9138-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mD40E3DDqGk0xAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-9138-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:42:40 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C21209069
	for <lists+linux-hyperv@lfdr.de>; Thu, 05 Mar 2026 00:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 899D9304AAC1
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Mar 2026 23:42:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A22C383C8F;
	Wed,  4 Mar 2026 23:42:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Fdm0pSz4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB3141754;
	Wed,  4 Mar 2026 23:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772667751; cv=none; b=dHwS9X+dr82CCa35JuYwsikSIVNNZJO+kFrU/rMb4dFT7GbXX8LWOKv4sv2m4T2EM4rw5/vPRWqWA3m7Rdh9YswGac+tcmJwdSVAdZOl687UNDUrabGH2truOzKdgvSDRsr3qzKo77YQ5U00X1y53172W2I4NhkBqM4r9dI3/bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772667751; c=relaxed/simple;
	bh=AsC53VQpxshrYaK5CTrmNsNOCmmO1YYSnmYNNFi25DA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FrOtxUaYqEFCOkwCxWvunAaSHlz8zOobFTmu4Y0nRZmaTVPrRAIyOYqCzwNpZJ0T/6LdcpWxU0hAPuY4S5OCr8ZeD9JsulCK21o5Ksq4NblxTJE+2q0htKvXQcocaUSK/TM/84cHwoMchKCoTOzHv3HyU12h8ve7t6ZkEC7i6KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Fdm0pSz4; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772667750; x=1804203750;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=AsC53VQpxshrYaK5CTrmNsNOCmmO1YYSnmYNNFi25DA=;
  b=Fdm0pSz4I54BnEiReOl120qzb3eIOgYV5wPhvTxG/NhPTQG3/a7ZrWXJ
   1dd1CQzRyfMbzK50hGRG9O+DYfDH6WZYcqob3rHfCm1JgVAMrtnagMYOg
   6EI8xPL7TRqXWCS6Wm8LGXPp2yTOobjPw6lwtVjKEcQ1Ul0NyeQymzlsK
   sPEJBSGxC9W2I23Fe19L0ZzBysLYioN+NNFrYAnwO14vhf0F/05cBsj97
   uCsijrTcVdOblJqRN7/0BjjDXqsZv8PP/wob8RG3+vRfEzRoO2l7FYkVQ
   hWJcT5mYQozUqsgbF8fAZAkoMyDWIPOefikXoKmP/iGTXT3QnSVOU2PJu
   Q==;
X-CSE-ConnectionGUID: I6VsfV1uRL+qg+h3ZZoxQg==
X-CSE-MsgGUID: Uuy9SolCTuO0vvuiKR/FDg==
X-IronPort-AV: E=McAfee;i="6800,10657,11719"; a="96359362"
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="96359362"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:29 -0800
X-CSE-ConnectionGUID: BEGLUdsRQMWyDupAX6ra8Q==
X-CSE-MsgGUID: OsSNdvBUSrqLUGRiO0UKfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,324,1763452800"; 
   d="scan'208";a="215376892"
Received: from unknown (HELO [172.25.112.21]) ([172.25.112.21])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Mar 2026 15:42:28 -0800
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Wed, 04 Mar 2026 15:41:12 -0800
Subject: [PATCH v9 01/10] x86/topology: Add missing struct declaration and
 attribute dependency
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260304-rneri-wakeup-mailbox-v9-1-a5c6845e6251@linux.intel.com>
References: <20260304-rneri-wakeup-mailbox-v9-0-a5c6845e6251@linux.intel.com>
In-Reply-To: <20260304-rneri-wakeup-mailbox-v9-0-a5c6845e6251@linux.intel.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1772667694; l=2967;
 i=ricardo.neri-calderon@linux.intel.com; s=20250602;
 h=from:subject:message-id; bh=AsC53VQpxshrYaK5CTrmNsNOCmmO1YYSnmYNNFi25DA=;
 b=oTMx0bNW62KmU7FERERGRoTrWCkbfnKuQLaCgJQGZRDr0FKG5kr+bLvT1v0ltjm5m4iKokUus
 QlnUwRGkdvnAif2ZABY6lZ5ljS5gbc2z+hSnAVsQzURcmj8HBlzdAQr
X-Developer-Key: i=ricardo.neri-calderon@linux.intel.com; a=ed25519;
 pk=NfZw5SyQ2lxVfmNMaMR6KUj3+0OhcwDPyRzFDH9gY2w=
X-Rspamd-Queue-Id: E9C21209069
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9138-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[kernel.org,microsoft.com,outlook.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ricardo.neri-calderon@linux.intel.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[intel.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-hyperv,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,intel.com:dkim,intel.com:email]
X-Rspamd-Action: no action

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
Changes in v9:
 - None

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


