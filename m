Return-Path: <linux-hyperv+bounces-3557-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AB209FE99F
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Dec 2024 19:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F1C01883000
	for <lists+linux-hyperv@lfdr.de>; Mon, 30 Dec 2024 18:09:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F951AF0DE;
	Mon, 30 Dec 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="TA81gK9W"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5AF4EDE;
	Mon, 30 Dec 2024 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735582185; cv=none; b=LBV9VgYKGvJGBkoHrbR7RKfOVDilHAeQT8+XOAfu86njurCRZl52WTd2H3uSQsxS8HPJzlCBNzvJJyQQCx+HUT25AQXWJWSSbYNLSh+1mfumK+3vRN/dKq7ni7bhaYxzXUJdRF4Innpg/Xk8dAh3z+CwioFvy7JO/62yGYkCXtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735582185; c=relaxed/simple;
	bh=vkiuRUB/8cvMIb27cfp621JQm7G5XgnfzkLyDFsyrr0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lsE/GrEhOiaCXEdASwv8r0YLM0e6gAMdQXgacya7gqQvzI76QfY11WPZQHz/hGAUKAhSWppmzc7Xz+3CKkDKX/pUdaXNKle+XgHgRncCjSMOP1YULa0bXZLGrZ+mQAk2w1CKJH8xREZ7XQLxicaN0dM3+aCVm+iDK+tJZFDc8Ok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=TA81gK9W; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 0A1AB205A74F;
	Mon, 30 Dec 2024 10:09:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0A1AB205A74F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1735582183;
	bh=StsDJbdEeWV+AJZCGyM7VuBeSiR0lxV8wW45Tl/vfoo=;
	h=From:To:Cc:Subject:Date:From;
	b=TA81gK9WT1YDL3rbRi23yGKpk58qDbmDLvYcMbsW02e3Defm52cO38GS+6TaQIVBk
	 5xH1FYiEZlopLRbGdQSugQbOmEInDKaRJ43jhyVQyer75O2Z6dZAKL0mMCRAxXP49H
	 xSnrLqtgWwbwxrOQ7BKEHCuwD3zF/B51zEUvJOB0=
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
Subject: [PATCH v5 0/5] hyperv: Fixes for get_vtl(), hv_vtl_apicid_to_vp_id()
Date: Mon, 30 Dec 2024 10:09:36 -0800
Message-Id: <20241230180941.244418-1-romank@linux.microsoft.com>
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
* the both function in question don't adhere to the requirements of
  the Hypervisor Top-Level Funactional Specification[1, 2] as the code overlaps
  the input and output areas for a hypercall.

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

* these functions just get a vCPU register, no special treatment needs to be
  involved,
* VTLs and dom0 can and should share code as both exist to provide services to
  a guest(s), be that from within the partition or from outside of it.

The projected benefits include replacing the functions in question with a future
`hv_get_vp_registers` one shared between dom0 and VTLs to allow for a better test
coverage.

I have validated the fixes by booting the fixed kernel in VTL2 up using OpenVMM and
OpenHCL[3, 4].

[1] https://learn.microsoft.com/en-us/virtualization/hyper-v-on-windows/tlfs/hypercall-interface
[2] https://github.com/MicrosoftDocs/Virtualization-Documentation/tree/main/tlfs
[3] https://openvmm.dev/guide/user_guide/openhcl.html
[4] https://github.com/microsoft/OpenVMM

[v5]
  - In the first patch, removed some arch-specific #ifdef guards to fix the
    arm64 build and stick to the direction chosen for the Hyper-V header files.
    I could not remove all of them as some interrupt state structures
    are defined differently for x64 and arm64 and are found in the same
    enclosing `union hv_register_value`.

    No changes to other patches (approved in v4).

[v4]: https://lore.kernel.org/lkml/20241227183155.122827-1-romank@linux.microsoft.com/
  - Wrapped DECLARE_FLEX_ARRAY into a struct and added one more
    member as the documentation requires,
  - Removed superfluous type coercion,
  - Fixed tags,
  - Rebased onto the latest hyperv-next branch.

[v3]: https://lore.kernel.org/lkml/20241226213110.899497-1-romank@linux.microsoft.com/
  - Added a fix for hv_vtl_apicid_to_vp_id(),
  - Split out the patch for enabling the hypercall output page,
  - Updated the title of the patch series,

[v2]: https://lore.kernel.org/lkml/20241226203050.800524-1-romank@linux.microsoft.com/
  - Used the suggestions to define an additional structure to improve code readability,
  - Split out the patch with that definition.

[v1]: https://lore.kernel.org/lkml/20241218205421.319969-1-romank@linux.microsoft.com/

Roman Kisel (5):
  hyperv: Define struct hv_output_get_vp_registers
  hyperv: Fix pointer type in get_vtl(void)
  hyperv: Enable the hypercall output page for the VTL mode
  hyperv: Do not overlap the hvcall IO areas in get_vtl()
  hyperv: Do not overlap the hvcall IO areas in hv_vtl_apicid_to_vp_id()

 arch/x86/hyperv/hv_init.c   |  6 ++---
 arch/x86/hyperv/hv_vtl.c    |  2 +-
 drivers/hv/hv_common.c      |  6 ++---
 include/hyperv/hvgdk_mini.h | 49 +++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 7 deletions(-)


base-commit: 26e1b813fcd02984b1cac5f3decdf4b0bb56fe02
-- 
2.34.1


