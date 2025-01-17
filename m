Return-Path: <linux-hyperv+bounces-3716-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69928A158CA
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 22:07:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C670C3A94B9
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Jan 2025 21:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFDB21A9B2B;
	Fri, 17 Jan 2025 21:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="gzOXF5oA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66EB619993B;
	Fri, 17 Jan 2025 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737148030; cv=none; b=hRRyqc/RdYFiL2wSPy4kofAcIzWRujoMcUHGXKimBnJdggFrI2+XNEw6nAQLKb1STWuki3zKnqm4V8WVCAT8NDvbv7Cosd/J8g00McK7216mFQ/6JYqxZdPgTWIaPeY1822gaJuD0/cS5iGJctND38NCiNdYiBtZvVjYESbbcPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737148030; c=relaxed/simple;
	bh=xrvNzagBDqrQ9BUdnh4LrSE95mjUaFh9DDBy3prWIKo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m1AH/D15r5SqPalqEdTHdO0l+ookF7J3IIUOvc6ApZ0erIiN2UNaEfukiCd6RpBnxPXzH+AQqS38mDr/0kbNWWFC5ihHtbH17sRVJjrDEIFOWs8r/SXM7adTx2IIZXuc7PKMQs2WjSLeqxU8nj2rdlRGg44rSBM6fzHoRkTZ3Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=gzOXF5oA; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from romank-3650.corp.microsoft.com (unknown [131.107.160.188])
	by linux.microsoft.com (Postfix) with ESMTPSA id 9589120591BB;
	Fri, 17 Jan 2025 13:07:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9589120591BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1737148023;
	bh=/Uzvh8YJhJBStfh25f7oVgVnZZ+0NfuKAjLsMf09uMQ=;
	h=From:To:Cc:Subject:Date:From;
	b=gzOXF5oAdb1OatFZ1zfPMofqHO5XWPtbAymkWBh+FyLm9C8W4HlOFmvpHbhBqAEAc
	 VNCU+x4dEPbt8jFJKP7j13Z2p/J6Ad9HA+0klxOWAbttZwgYcHR/6npNuWGrZMNZjT
	 59LlZuXJwYiRPscKGn1wNdaUhKuLUNFITDvLzvGw=
From: Roman Kisel <romank@linux.microsoft.com>
To: bp@alien8.de,
	dave.hansen@linux.intel.com,
	decui@microsoft.com,
	haiyangz@microsoft.com,
	hpa@zytor.com,
	kys@microsoft.com,
	mingo@redhat.com,
	ssengar@linux.microsoft.com,
	tglx@linutronix.de,
	wei.liu@kernel.org,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: apais@microsoft.com,
	benhill@microsoft.com,
	sunilmut@microsoft.com,
	vdso@hexbites.dev
Subject: [PATCH hyperv-next 0/2] x86/hyperv: VTL mode reboot fixes
Date: Fri, 17 Jan 2025 13:07:00 -0800
Message-Id: <20250117210702.1529580-1-romank@linux.microsoft.com>
X-Mailer: git-send-email 2.34.1
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
to the kernel command line in the OpenHCL bootloader [2]. There is
no other option at the moment; when/if it appears the newly added
callback's code can be adjusted as required.

It would be great to apply this to the stable tree if no concerns,
should apply cleanly.

[1] https://lore.kernel.org/all/20250109204352.1720337-1-romank@linux.microsoft.com/
[2] https://github.com/microsoft/openvmm/blob/7a9d0e0a00461be6e5f3267af9ea54cc7157c900/openhcl/openhcl_boot/src/main.rs#L139

Roman Kisel (2):
  x86/hyperv: VTL mode emergency restart callback
  x86/hyperv: VTL mode callback for restarting the system

 arch/x86/hyperv/hv_vtl.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)


base-commit: 2e03358be78b65d28b66e17aca9e0c8700b0df78
-- 
2.34.1


