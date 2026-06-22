Return-Path: <linux-hyperv+bounces-11648-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id y9oMEZnaOGpkjAcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11648-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jun 2026 08:47:53 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 91CA26AD027
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jun 2026 08:47:52 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="kSZ9q/2V";
	spf=pass (mail.lfdr.de: domain of "linux-hyperv+bounces-11648-lists+linux-hyperv=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-hyperv+bounces-11648-lists+linux-hyperv=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CE52301DE04
	for <lists+linux-hyperv@lfdr.de>; Mon, 22 Jun 2026 06:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E29163603C0;
	Mon, 22 Jun 2026 06:45:51 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47E935F5E0;
	Mon, 22 Jun 2026 06:45:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782110751; cv=none; b=g8Eu/5Kdx88jhOYx7hva/Bocq4y2EaDcZZn+eVdRdNq+8UbiVYfuWv6vArLsn/wz/T/G0R/o1P4ZLPNsDw9aHJqEv9upwZfrZAgJSgE6Hs1HyYNnlxVQqVFR6g1PygX3o7/19HgsQnP+YEFPwAPPAdffKBMR/a45gzbmg+weFTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782110751; c=relaxed/simple;
	bh=y1I3u/afEn9O94REbH/FpWkDVbTSTPIQxNWBaWOWFYQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=onSNiSAQz7YesPeLH/w8Xi3XkOEKDCjnK6CbZ4cM2IQI8o60u6aC0pbdy2XOHU4MZsFr4z8P6niEWizFzBWJS9Sl/Kx3+VZeR76m9DpuK1Oc8T/UQeGtnqBwISvHF717KzBAcl6lUi4+k5W6HOd16ijku3c9z4JJwisX0Qgt7nE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kSZ9q/2V; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975AB1F000E9;
	Mon, 22 Jun 2026 06:45:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782110750;
	bh=yHDiJFwQGFxBDfaT1cAwGauqjmXicWvmurNlYMz6EsA=;
	h=Date:From:To:Cc:Subject;
	b=kSZ9q/2VElCe1rEuFNlsEodRRKcMDDmUDOxYws678pVGTu8ZfWOB125tAL8jfyuVf
	 0dTH0Fgpk2JRptEhDpE5xhDrX9FUXpsQsJv7DKOoEHaVp27YkhyTiEPSZUW6QtP9uy
	 zhMhqJkJg7F3Ju5H+lSRZXQ8hz7p2RscYbSh5FNhLpd1z4p2aN9pnZ9okPz9a2GUBK
	 7ku0AfawT1IgimbRawVbGZSrEOxiEIVKqSqgr9PWdVQBdMTE02+ynOIvHSEJs6aty4
	 HBsZzINzHG3xvsSO60FxBOIOR8GLhNPr3SuISanrFsRvEvSsHYEiYouCM4ujpkX96G
	 gTWVMU9xGjd+Q==
Date: Sun, 21 Jun 2026 23:45:49 -0700
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Subject: [GIT PULL] Hyper-V patches for v7.2
Message-ID: <20260622064549.GA2852659@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11648-lists,linux-hyperv=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:torvalds@linux-foundation.org,m:wei.liu@kernel.org,m:linux-hyperv@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:kys@microsoft.com,m:haiyangz@microsoft.com,m:decui@microsoft.com,m:longli@microsoft.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TAGGED_RCPT(0.00)[linux-hyperv];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 91CA26AD027

Hi Linus,

The following changes since commit e7ae89a0c97ce2b68b0983cd01eda67cf373517d:

  Linux 7.1-rc5 (2026-05-24 13:48:06 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20260621

for you to fetch changes up to a4ffc59238be84dd1c26bf1c001543e832674fc6:

  mshv: add bounds check on vp_index in mshv_intercept_isr() (2026-06-07 23:22:46 -0700)

----------------------------------------------------------------
hyperv-next for v7.2-rc1
 - Use wakeup mailbox to boot APs in Hyper-V VTL2 TDX guests (Yunhong Jiang,
   Ricardo Neri)
 - Move the Hyper-V IOMMU to its own subdirectory (Mukesh Rathor)
 - Cosmetic changes to mshv and balloon driver (Junrui Luo, Markus
   Elfring)
----------------------------------------------------------------
Junrui Luo (1):
      mshv: add bounds check on vp_index in mshv_intercept_isr()

Markus Elfring (1):
      hv_balloon: Simplify data output in hv_balloon_debug_show()

Mukesh R (2):
      iommu/hyperv: Create hyperv subdirectory under drivers/iommu
      x86/hyperv: Cosmetic changes in irqdomain.c for readability

Ricardo Neri (6):
      x86/topology: Add missing struct declaration and attribute dependency
      x86/acpi: Add functions to setup and access the wakeup mailbox
      dt-bindings: reserved-memory: Wakeup Mailbox for Intel processors
      x86/dt: Parse the Wakeup Mailbox for Intel processors
      x86/acpi: Add a helper to get the address of the wakeup mailbox
      x86/hyperv/vtl: Use the wakeup mailbox to boot secondary CPUs

Yunhong Jiang (4):
      x86/hyperv/vtl: Set real_mode_header in hv_vtl_init_platform()
      x86/realmode: Make the location of the trampoline configurable
      x86/hyperv/vtl: Setup the 64-bit trampoline for TDX guests
      x86/hyperv/vtl: Mark the wakeup mailbox page as private

 .../reserved-memory/intel,wakeup-mailbox.yaml      |  49 +++++
 MAINTAINERS                                        |   2 +-
 arch/x86/hyperv/hv_vtl.c                           |  38 +++-
 arch/x86/hyperv/irqdomain.c                        | 198 +++++++++++----------
 arch/x86/include/asm/acpi.h                        |  16 ++
 arch/x86/include/asm/topology.h                    |   3 +
 arch/x86/include/asm/x86_init.h                    |   3 +
 arch/x86/kernel/acpi/madt_wakeup.c                 |  16 ++
 arch/x86/kernel/devicetree.c                       |  47 +++++
 arch/x86/kernel/x86_init.c                         |   3 +
 arch/x86/realmode/init.c                           |   7 +-
 drivers/hv/hv_balloon.c                            |   4 +-
 drivers/hv/mshv_synic.c                            |   5 +
 drivers/iommu/Kconfig                              |   9 -
 drivers/iommu/Makefile                             |   2 +-
 drivers/iommu/hyperv/Makefile                      |   2 +
 .../{hyperv-iommu.c => hyperv/hv-irq-remap-x86.c}  |   6 +-
 drivers/iommu/irq_remapping.c                      |   2 +-
 18 files changed, 290 insertions(+), 122 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reserved-memory/intel,wakeup-mailbox.yaml
 create mode 100644 drivers/iommu/hyperv/Makefile
 rename drivers/iommu/{hyperv-iommu.c => hyperv/hv-irq-remap-x86.c} (99%)

