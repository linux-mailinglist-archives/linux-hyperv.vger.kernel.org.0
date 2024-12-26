Return-Path: <linux-hyperv+bounces-3521-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82669FCDA2
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 21:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4EC81635B0
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Dec 2024 20:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84BB714D6F6;
	Thu, 26 Dec 2024 20:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QVgb89/s"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEFE4146A9B;
	Thu, 26 Dec 2024 20:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735245054; cv=none; b=UK9nZEWmzUDlGc3RnqGR1wdigLMRlOyHa6eh5rQSTtoNOgCtdbPOQbHQN//S9YrwBDnQw50VFWH8dj6EGa4tpKEp3kZ0z+1+TTwyo5K6HrwkQcfzTP6fp39KlWsfPHVaXzJ3mekrlIZwHEZU/G2iwJ7/V6dF5RmkJJIftfOBMQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735245054; c=relaxed/simple;
	bh=h3cOvvgZCRj5Y6TKDOWOUJByC22Zq5u+LfW6iyMTg0o=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=D3M07D7ZbDdLIiAZiz2oXTf1M7LQfOtwCUFhEpFWKaVmY034NPvWxDjZibEGkhm6UKZtmEKS0DEwWVHSWI65g/EyCcJQKhBh2xjY7Q9YcpYjM4vJRk1cfflx2z8WDIy07EYIIAeWNtdZLxAhlg8GgCEeY+1D2h3EC9qrCVw9Fjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QVgb89/s; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 39960203EC21;
	Thu, 26 Dec 2024 12:30:52 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 39960203EC21
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735245052;
	bh=XlGE/r8EycbVyULc3rbICmMmQEDiENB2Fsgp3liFnfg=;
	h=From:To:Cc:Subject:Date:From;
	b=QVgb89/sIY5bH3+badSJW0lqMGaw/HYLZ80xtDjxAbpkUK+DaZXvw5cOJ8bYovkuu
	 8pNT9RQ2QAFenjWjM8hyng/OJc2OwxHe4PAu8DA6NucJrGWHvJc1uRGoZa10AEyrjG
	 xSpwIZzBskuC7bEgAKGV6Fjw5gQcZG7CDoIpPUn4=
From: Roman Kisel <romank@linux.microsoft.com>
To: hpa@zytor.com,
	kys@microsoft.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	eahariha@linux.microsoft.com,
	haiyangz@microsoft.com,
	mingo@redhat.com,
	mhklinux@outlook.com,
	nunodasneves@linux.microsoft.com,
	tglx@linutronix.de,
	tiala@microsoft.com,
	wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	ssengar@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH v2 0/3] hyperv: Fixes for get_vtl(void)
Date: Thu, 26 Dec 2024 12:30:47 -0800
Message-Id: <20241226203050.800524-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The get_vtl(void) function

* has got one bug when the code started using a wrong pointer type after
  refactoring, and also
* it doesn't adhere to the requirements of the Hypervisor Top-Level Funactional
  Specification[1, 2] as the code overlaps the input and output areas for a hypercall.

The first issue leads to a wrong 100% reproducible computation due to reading
a byte worth of data at a wrong offset. That in turn leads to using a nonsensical
value ("fortunately", could catch it easily!) for the current VTL when initiating
VMBus communications. As a repercussion from that, the system wouldn't boot. The
fix is straightforward: use the correct pointer type.

The second issue doesn't seem to lead to any reproducible breakage just yet. It is
fixed with using the output hypercall pages allocated per-CPU, and that isn't the
only or the most obvious choice so let me elaborate why that fix appears to be the
best one in my opinion out of the options I could conceive of.

The approach chosen for fixing the second issue makes two things shine through:

* `get_vtl(void)` is just getting a vCPU register, no special treatment needs
  to be involved,
* VTLs and dom0 can and should share code as both exist to provide services to
  a guest(s), be that from within the partition or from outside of it.

The projected benefits include replacing the function in question with a future
`hv_get_vp_registers` one shared between dom0 and VTLs to allow for a better test
coverage.

I have validated the fixes by booting the fixed kernel in VTL2 up using OpenVMM and
OpenHCL[3, 4].

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
[2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs
[3] https://openvmm.dev/guide/user_guide/openhcl.html
[4] https://github.com/microsoft/OpenVMM

[v2]
  - Used the suggestions to define an additional structure to improve code readability,
  - Split out the patch with that definition.

[v1]: https://lore.kernel.org/lkml/20241218205421.319969-1-romank@linux.microsoft.com/

Roman Kisel (3):
  hyperv: Define struct hv_output_get_vp_registers
  hyperv: Fix pointer type for the output of the hypercall in
    get_vtl(void)
  hyperv: Do not overlap the input and output hypercall areas in
    get_vtl(void)

 arch/x86/hyperv/hv_init.c   |  6 ++--
 drivers/hv/hv_common.c      |  6 ++--
 include/hyperv/hvgdk_mini.h | 58 +++++++++++++++++++++++++++++++++++--
 3 files changed, 62 insertions(+), 8 deletions(-)


base-commit: 4d4ace979a3066e5c940331571e6c1c3f280d1d3
-- 
2.34.1


