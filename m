Return-Path: <linux-hyperv+bounces-3496-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 055DD9F6F13
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Dec 2024 21:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0BE57A2810
	for <lists+linux-hyperv@lfdr.de>; Wed, 18 Dec 2024 20:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43FD41FCCFB;
	Wed, 18 Dec 2024 20:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="glyBoNYB"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C8E224F6;
	Wed, 18 Dec 2024 20:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734555271; cv=none; b=Uk6bMvOoMuR5MwM/vBy6+IzumMdT1vpVyiLWLAUdV0PJAXhU7IKLffvX3rDXFbPkqqwJNQaWYkiSQ6tmJLS562qNxkaokpyRcrC+gGGNvTJgm7naNqOi2l+jq+tmp/yUrp37xu+dbnLFw8L8bXelmcC3ogiK4w/MgER3tY27DSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734555271; c=relaxed/simple;
	bh=4i6gPl8prCcnm5ifrtOOJdbjTMqrfbJvyPmRs9eUssA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=l5Y+8dZFevTr5/iSlg/EHxx3mOu3kR4u8Pf1k1RhmosUc+cwDK1kkfLcU0WqVzs5IPiR42GNcN2Oa1ysyX14vNJcE8ZXr3hnYbP+0WoB2mg2afv42P/igM0e5XznSqGDVPgptJek/VQKqw8kxA99w9oFCapHCBP1Hl/IXtH9lOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=glyBoNYB; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id DDA89203FC75;
	Wed, 18 Dec 2024 12:54:21 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com DDA89203FC75
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1734555262;
	bh=QABCi/+N6mhOYKA/Hsx3GAgEPDqw0OcJ8TMUxVwMDz8=;
	h=From:To:Cc:Subject:Date:From;
	b=glyBoNYB55JDSCfGqaalHzJF/b0ism/wTLlChXIKjKa+wX89xbq+hfxO1R9MDf8mG
	 W/GlhKjVdlQZf+SGj8hmyjXvFtOZWio3NMoICRwki4xc8ETIf8GXBXscVvj0TGRdZT
	 hNKotztkE6B0f9u8yeVHIgTGakoyo97AXJg4UEVQ=
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
Subject: [PATCH 0/2] hyperv: Fixes for get_vtl(void)
Date: Wed, 18 Dec 2024 12:54:19 -0800
Message-Id: <20241218205421.319969-1-romank@linux.microsoft.com>
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

An alternative approach could be to use an appropriately aligned space within the
input page that doesn't overlap with the input data, as a memory optimization.
Indeed, when considering a 1,000+ vCPU VM, allocating one page per-CPU makes the
system spend more time when booting and more space during its lifetime, let alone
that the kernel running in VTL2 is expected to be CPU and memory frugal. Although
saving on the hypercall output page allocation in just that function, we'd still
need to allocate the output pages later for other hypercalls to provide services
for the VTL0 guest (VTL2 works as an exclave of the hypervisor) so here we wouldn't
really save any memory in the long run.

One could also consider passing the input and output parameters in the registers
to get the function be faster potentially, and/or to avoid allocations altogether to
be able to call it from any context at any stage of booting the system. This function
is not in a hot path though, and if it ever is, adding support for the extended
fast hypercalls (that pass input and output in the XMM registers, here, due to
the size of output parameters for the GetVpregisters hypercall) will both make
the function faster and allocation-less. Then again, if either of that ever becomes
a concern.

I have validated the fixes by booting the fixed kernel in VTL2 up using OpenVMM and
OpenHCL[3, 4].

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
[2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs
[3] https://openvmm.dev/guide/user_guide/openhcl.html
[4] https://github.com/microsoft/OpenVMM

Roman Kisel (2):
  hyperv: Fix pointer type for the output of the hypercall in
    get_vtl(void)
  hyperv: Do not overlap the input and output hypercall areas in
    get_vtl(void)

 arch/x86/hyperv/hv_init.c   | 6 +++---
 drivers/hv/hv_common.c      | 6 +++---
 include/hyperv/hvgdk_mini.h | 3 ---
 3 files changed, 6 insertions(+), 9 deletions(-)


base-commit: 4d4ace979a3066e5c940331571e6c1c3f280d1d3
-- 
2.34.1


