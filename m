Return-Path: <linux-hyperv+bounces-3995-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 23FBFA3E5C3
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Feb 2025 21:23:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB6B7AA31D
	for <lists+linux-hyperv@lfdr.de>; Thu, 20 Feb 2025 20:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D1A3213248;
	Thu, 20 Feb 2025 20:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="oFa9FR6g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04671DDC14;
	Thu, 20 Feb 2025 20:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740082986; cv=none; b=NzKNJhEGllz51dmKKpkYoagQM9rhHedjJsWLRFy5Ka0nIzj7FEuOthcionliZujKMK5qB+2IohG7ORVJUdjH1BHRCI/KFc0k4xrteUAdLchvlfJN+AbakW+ESftTeQ/Ak1G8YZRzCmz55EtBZHsxvt08nB5Sj5iyo7G7AGN47X0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740082986; c=relaxed/simple;
	bh=Ux/Fdr3dT4kZqn+2324S7+cSUHACMe0QH8JlEk+oZHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OrQh71rVURf8Ce+fZ1AQmTobuZqx3tTAqAtwW+xfmNcl5fSEdDRX4+O+Cjq/QoBcCkratDvQcDt8ALgBeTi4BJOxJlwt1iEIBL179biUFnM+TII6aekoJBlxEHasnAJ9UENPWw3tvI2n5CTUDcgyvuZfch6QDaYLuMHXTU2M2x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=oFa9FR6g; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 47282203EC16;
	Thu, 20 Feb 2025 12:23:04 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 47282203EC16
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740082984;
	bh=aIH3NGYqEanu6KoDYFwyLuHKO7OFTu2OStSMs8IQTWo=;
	h=From:To:Cc:Subject:Date:From;
	b=oFa9FR6gcpLD0hIx+dsIKfA9I8++Ve3hvVc08BdQfOi0bkgAAFOPWwGFW4QZsfzyK
	 nKCTarZk/WwxRVd9DrpH3mnOfyN1bii495/scPO/Newjn4H7KVL2uwQ4EjZZuWgCET
	 /eAbWpNkGK6RZ9JnHlBXVzgZ12Ro82XuIIG98/oM=
From: Roman Kisel <romank@linux.microsoft.com>
To: bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mingo@redhat.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	ssengar@linux.microsoft.com,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	sunilmut@microsoft.com
Subject: [PATCH hyperv-next v2 0/2] x86/hyperv: VTL mode reboot fixes
Date: Thu, 20 Feb 2025 12:23:00 -0800
Message-ID: <20250220202302.2819863-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The first patch defines a specialized machine emergency restart
callback not to write to the physical address of 0x472 which is
what the native_machine_emergency_restart() does unconditionally.

I first wanted to tweak that function[1], and in the course of
the discussion it looked as the risks of doing that would
outweigh the benefit: the bare-metal systems have likely adopted
that behavior as a standard although I could not find any mentions
of that magic address in the UEFI+ACPI specification.

The second patch removes the need to always supply "reboot=t"
to the kernel command line in the OpenHCL bootloader[2]. There is
no other option at the moment; when/if it appears the newly added
callback's code can be adjusted as required.

Signed-off-by: Roman Kisel <romank@linux.microsoft.com>

[1] https://lore.kernel.org/all/20250109204352.1720337-1-romank@linux.microsoft.com/
[2] https://github.com/microsoft/openvmm/blob/7a9d0e0a00461be6e5f3267af9ea54cc7157c900/openhcl/openhcl_boot/src/main.rs#L139

[V2]:
    - Fixed the warning from the kernel robot about using C23.
      ** Thank you, kernel robot!**

    - Tightened up wording in the comments and the commit
      descriptions.
      ** Thank you, Saurabh!**

    - Dropped the CC: stable tag as there is no specific commit
      this patch series fixes.
      ** Thank you, Saurabh!**

[V1]: https://lore.kernel.org/linux-hyperv/20250117210702.1529580-1-romank@linux.microsoft.com/

Roman Kisel (2):
  x86/hyperv: VTL mode emergency restart callback
  x86/hyperv: VTL mode callback for restarting the system

 arch/x86/hyperv/hv_vtl.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)


base-commit: 3a7f7785eae7cf012af128ca9e383c91e4955354
-- 
2.43.0


