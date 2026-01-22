Return-Path: <linux-hyperv+bounces-8448-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECPcEyuxcWlmLQAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8448-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 06:10:03 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id E760E61EB6
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 06:10:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6CB21547215
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 05:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1E9330640;
	Thu, 22 Jan 2026 05:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QGsXwm0K"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEA327FD40;
	Thu, 22 Jan 2026 05:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769058351; cv=none; b=G1WJjHYrP4nG2agiYL5wG8/GqjyQWnYrOJwb8SjgxraarasxPh4r1s9cMilcFdVAkB4VGWmuY24YM98y6pLF/FzR5xNy+aYe+J/tjm7/d5urRbEJN7E9Uo0MbmQWZriPegQhiXk5UUeXBN2oE+TKx8ZI4MYTST/ldXPWdxxVKGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769058351; c=relaxed/simple;
	bh=FbO4XJAhoyHTC1qMFBSuPB8/XkSCTX62CMZCGPOYvcI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=o+RFTuvjs3cZdchSdos1xwaSGNVYTGcYFw5LBWqLCUJuSxL+RK1JcYsbg5dOrL/LLyPK5tfirGAInY9mh0qqZ1iKsw3ziU2/rjTAWA5OcKjwcR3EcS1AtVMmZgHgovwZ675FZ7lHhVSfbpvZYeAn8zpUeRT51fZoamnzrahK5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QGsXwm0K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 883AEC116C6;
	Thu, 22 Jan 2026 05:05:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769058349;
	bh=FbO4XJAhoyHTC1qMFBSuPB8/XkSCTX62CMZCGPOYvcI=;
	h=Date:From:To:Cc:Subject:From;
	b=QGsXwm0K5CteMp6uBoDMbSfQdAeuWcElmKFm2IxPmUnA8PhOokBaU0mGZiBQeZyqt
	 UpEkP3SGbG6CBcWifaC78aqtLALb/bbegHTtCnEokK6B98xijM/ALZOQWT9FYNXVem
	 tuAwmXz8zlJkWRA6YkYLUY982hqpOJDtl50a/4McBb3pFgZbJqvljPvweCydzIR4GN
	 FUSeCEVjZeF12+C1FA5EX0wA2NNczSdBUcvRIi1CLVBXhPcE33aUtNG3tk4qIMkylh
	 JE2E0JyIHK+a7b12d8qKWVKhzvH+Ny9v4NUF873JyFCWp4P9iUQUx0cls/2NKceblI
	 HdAO4rE+uVs+A==
Date: Thu, 22 Jan 2026 05:05:48 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for v6.19-rc7
Message-ID: <20260122050548.GA909211@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-8448-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	TAGGED_RCPT(0.00)[linux-hyperv];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[liuwe-devbox-debian-v2.local:mid,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: E760E61EB6
X-Rspamd-Action: no action

Hi Linus,

The following changes since commit 173d6f64f9558ff022a777a72eb8669b6cdd2649:

  mshv: release mutex on region invalidation failure (2025-12-18 20:00:10 +0000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260121

for you to fetch changes up to 12ffd561d2de28825f39e15e8d22346d26b09688:

  mshv: handle gpa intercepts for arm64 (2026-01-15 07:29:14 +0000)

----------------------------------------------------------------
hyperv-fixes for v6.19-rc7
 - Fix ARM64 port of the MSHV driver (Anirudh Rayabharam)
 - Fix huge page handling in the MSHV driver (Stanislav Kinsburskii)
 - Minor fixes to driver code (Julia Lawall, Michael Kelley)
----------------------------------------------------------------
Anirudh Rayabharam (Microsoft) (2):
      mshv: add definitions for arm64 gpa intercepts
      mshv: handle gpa intercepts for arm64

Julia Lawall (1):
      Drivers: hv: vmbus: fix typo in function name reference

Michael Kelley (3):
      Drivers: hv: Always do Hyper-V panic notification in hv_kmsg_dump()
      mshv: Store the result of vfs_poll in a variable of type __poll_t
      mshv: Add __user attribute to argument passed to access_ok()

Stanislav Kinsburskii (1):
      mshv: Align huge page stride with guest mapping

 drivers/hv/hv_common.c      | 12 +++---
 drivers/hv/hyperv_vmbus.h   |  2 +-
 drivers/hv/mshv_eventfd.c   |  2 +-
 drivers/hv/mshv_regions.c   | 93 ++++++++++++++++++++++++++++++---------------
 drivers/hv/mshv_root_main.c | 17 +++++----
 include/hyperv/hvhdk.h      | 47 +++++++++++++++++++++++
 6 files changed, 127 insertions(+), 46 deletions(-)

