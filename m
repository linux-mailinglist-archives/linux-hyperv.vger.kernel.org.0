Return-Path: <linux-hyperv+bounces-1905-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 550A1895749
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 16:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64F0DB22FFA
	for <lists+linux-hyperv@lfdr.de>; Tue,  2 Apr 2024 14:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6222913AD31;
	Tue,  2 Apr 2024 14:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="m7loHZSH"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B98E913A252;
	Tue,  2 Apr 2024 14:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712068836; cv=none; b=gdRqykrTz+ITRu1j/KkfMPuuS1FWoZ8z6xSH71Q35UOY3CSpoDXx3LaGOrZfv3qfsGW25m2cxijKtyS3ZKxvRV7TA9IbCayLnignO5M/S+ncxwUxNNLIOnw7At1cXDLvzD3tZ7sfvAWCiuCtMABqxUpC366KcC+kHsLLeuJYEac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712068836; c=relaxed/simple;
	bh=Jsd3zd17n/TDUkNXvdKZWgOsivzIMCoQWiDVfCJsJDE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PJn0p+YbnY9u65wiIjlEjIGorBerVDDjEzim4CRMwCDkZpLuD0mOagOFxBpYv+ZVlKdNCJ0rMMFIjjbMNmZ2YHZMTkgJ3mmF10aGSoGwuf/yUW6CK+W/72fK05GCjGYkJm07t/drxaSsBXuD6bEhtTPXMt1k0UBreyK1bXbHPQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=m7loHZSH; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net (linux.microsoft.com [13.77.154.182])
	by linux.microsoft.com (Postfix) with ESMTPSA id 4D8F420E8BE0;
	Tue,  2 Apr 2024 07:40:34 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4D8F420E8BE0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1712068834;
	bh=4LDBkzPb2RKVpqmA4ytrM1NP9pKwE8D6bhLFAbKn0cs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m7loHZSHvBjrkymqt3U0h6AmgggT1Xh3eRQqI3Vitz/jefURPPVRjFFO2O6F0Td/t
	 fAH1XMAqrBWkV8rshpvZwlsxZG1Zn0gfslUnG9xjH+eND3m8SAwhwNDYgFqWXEe43l
	 2o2MVk1YwtGgHGpQ2MtWfXzR3PK/i631M7R1BCkU=
From: Saurabh Sengar <ssengar@linux.microsoft.com>
To: kys@microsoft.com,
	haiyangz@microsoft.com,
	wei.liu@kernel.org,
	decui@microsoft.com,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	peterz@infradead.org,
	sboyd@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hyperv@vger.kernel.org
Cc: ssengar@microsoft.com
Subject: [PATCH v2 3/4] x86/of: Map NUMA node to CPUs as per DeviceTree
Date: Tue,  2 Apr 2024 07:40:29 -0700
Message-Id: <1712068830-4513-4-git-send-email-ssengar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1712068830-4513-1-git-send-email-ssengar@linux.microsoft.com>
References: <1712068830-4513-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>

Currently for DeviceTree bootup, x86 code does the default mapping of
CPUs to NUMA, which is wrong. This can cause incorrect mapping and WARN
on a SMT enabled systems like below:

CPU #1's smt-sibling CPU #0 is not on the same node! [node: 1 != 0]. Ignoring dependency.
WARNING: CPU: 1 PID: 0 at topology_sane.isra.0+0x5c/0x6d
match_smt+0xf6/0xfc
set_cpu_sibling_map.cold+0x24f/0x512
start_secondary+0x5c/0x110

Add the set_apicid_to_node() function in dtb_cpu_setup() for allowing
the NUMA to CPU mapping for DeviceTree platforms.

Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
---
 arch/x86/kernel/devicetree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index 0d3a50e8395d..b93ce8a39ff7 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -24,6 +24,7 @@
 #include <asm/pci_x86.h>
 #include <asm/setup.h>
 #include <asm/i8259.h>
+#include <asm/numa.h>
 #include <asm/prom.h>
 
 __initdata u64 initial_dtb;
@@ -137,6 +138,7 @@ static void __init dtb_cpu_setup(void)
 			continue;
 		}
 		topology_register_apic(apic_id, CPU_ACPIID_INVALID, true);
+		set_apicid_to_node(apic_id, of_node_to_nid(dn));
 	}
 }
 
-- 
2.34.1


