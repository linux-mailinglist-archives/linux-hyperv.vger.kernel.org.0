Return-Path: <linux-hyperv+bounces-10311-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKgGDANw6GmbKQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-10311-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 08:51:47 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B34A84429B3
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 08:51:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38EF03078AF8
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Apr 2026 06:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E8C531E84F;
	Wed, 22 Apr 2026 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BsPPxzDA"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB6E295DA6;
	Wed, 22 Apr 2026 06:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776840506; cv=none; b=s3amQJncwJC2UMx81d/d/CmDmoYeXndxPMe8NTgz6ooV6XOwC71uMUT/YykmloCRgO/TFp+p4ZLzYPyEoKxrUcLFXC8o+ZdzZT77+sNjhR1AEQViIITHXFsy122k1REkNissrwwiwjvXiGga5kz+/wsbfSkjuCRDrsYCtrQ8eaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776840506; c=relaxed/simple;
	bh=aZHfvZ5EHLHt6AqTBMd/1n+jYeVmAE9mUGPzpWpqkH4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BqzFl5N/0WovLYUq+NUEd/jyyj1fFOeo17CoumDQRicFYWf9A38AsO7nAXrNDoFBvZEmERbcjCY4LXLeNZmXRbZnMaTs4nLgpMUPobHK/LIwieSyw9jMgkJwKYLn3zAJ31MmlPXF/IcOFTyLu9kmzpszAQuChYwCF1ktbJEIw4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BsPPxzDA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6579C19425;
	Wed, 22 Apr 2026 06:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776840505;
	bh=aZHfvZ5EHLHt6AqTBMd/1n+jYeVmAE9mUGPzpWpqkH4=;
	h=Date:From:To:Cc:Subject:From;
	b=BsPPxzDA4n9LbpZh5Kc2Pth9m0wH9jxLgkT/EQh2+RAQBRSUwIZJI+mWDK0wwnaoS
	 42fEvVvu03JdsIspuyGLUNbQB+tdn0UD95ARaGufdlpO2bLtpsajkmSWJGg1OC0Upq
	 Q+HcJXv6vwWwRQQXoxpTf972KHhVEQfbGNYECaDi0oGpGaSNpeqvgrLQlo1kEOZtnU
	 eXmyOVXdDYrh2aBL4IM13xP46kc/TfVs0/yZLq9Iv3pPA/sumVN5+z3hQnfFe7J5kj
	 YIEcBUu+vXUUF1rZGMvGGF0EXozo/HGYOicLVI66D6tgZreenP29I4TZBdABRjQsqY
	 vENEna3n7jKvw==
Date: Wed, 22 Apr 2026 06:48:24 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Subject: [GIT PULL] Hyper-V next for v7.1
Message-ID: <20260422064824.GC805420@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10311-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[liuwe-devbox-debian-v2.local:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B34A84429B3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Linus,

The following changes since commit 028ef9c96e96197026887c0f092424679298aae8:

  Linux 7.0 (2026-04-12 13:48:06 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20260421

for you to fetch changes up to 5170a82e89211d876af17bf3d94a511fb2bb4921:

  x86/hyperv: Skip LP/VP creation on kexec (2026-04-22 06:23:25 +0000)

----------------------------------------------------------------
hyperv-next for v7.1
 - Fix cross-compilation for hv tools (Aditya Garg)
 - Fix vmemmap_shift exceeding MAX_FOLIO_ORDER in mshv_vtl (Naman Jain)
 - Limit channel interrupt scan to relid high water mark (Michael Kelley)
 - Export hv_vmbus_exists() and use it in pci-hyperv (Dexuan Cui)
 - Fix cleanup and shutdown issues for MSHV (Jork Loeser)
 - Introduce more tracing support for MSHV (Stanislav Kinsburskii)
----------------------------------------------------------------
Aditya Garg (1):
      tools: hv: Fix cross-compilation

Dexuan Cui (1):
      Drivers: hv: vmbus: Export hv_vmbus_exists() and use it in pci-hyperv

Jork Loeser (3):
      Drivers: hv: vmbus: fix hyperv_cpuhp_online variable shadowing
      x86/hyperv: move stimer cleanup to hv_machine_shutdown()
      x86/hyperv: Skip LP/VP creation on kexec

Michael Kelley (1):
      Drivers: hv: vmbus: Limit channel interrupt scan to relid high water mark

Naman Jain (1):
      mshv_vtl: Fix vmemmap_shift exceeding MAX_FOLIO_ORDER

Stanislav Kinsburskii (2):
      mshv: Introduce tracing support
      mshv: Add tracepoint for GPA intercept handling

 arch/x86/kernel/cpu/mshyperv.c      |  15 +-
 drivers/hv/Makefile                 |   1 +
 drivers/hv/channel_mgmt.c           |  16 +-
 drivers/hv/hv_proc.c                |  47 ++++
 drivers/hv/hyperv_vmbus.h           |   3 +-
 drivers/hv/mshv_eventfd.c           |  14 +
 drivers/hv/mshv_irq.c               |   4 +
 drivers/hv/mshv_root.h              |   1 +
 drivers/hv/mshv_root_hv_call.c      |  22 +-
 drivers/hv/mshv_root_main.c         |  84 +++++-
 drivers/hv/mshv_trace.c             |   9 +
 drivers/hv/mshv_trace.h             | 544 ++++++++++++++++++++++++++++++++++++
 drivers/hv/mshv_vtl_main.c          |  12 +-
 drivers/hv/vmbus_drv.c              |  29 +-
 drivers/pci/controller/pci-hyperv.c |   2 +-
 include/asm-generic/mshyperv.h      |  10 +
 include/hyperv/hvgdk_mini.h         |   1 +
 include/hyperv/hvhdk_mini.h         |  12 +
 include/linux/hyperv.h              |   2 +
 include/uapi/linux/mshv.h           |   2 +-
 tools/hv/Makefile                   |   4 +-
 21 files changed, 783 insertions(+), 51 deletions(-)
 create mode 100644 drivers/hv/mshv_trace.c
 create mode 100644 drivers/hv/mshv_trace.h

