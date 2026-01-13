Return-Path: <linux-hyperv+bounces-8255-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5392FD16E37
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 07:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 142B630169B1
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 06:47:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA35430DD10;
	Tue, 13 Jan 2026 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eRtSOlxY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B0630C632;
	Tue, 13 Jan 2026 06:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768286831; cv=none; b=UaRh4b3ihkjbJM619IMhjGBOThdHLkzIMSkCNswKX/6WgnZxp4jIRy92uHEQ3zP/o1/y9LHilD1B5Ab40+rsB5+cVB3od8aXDZEyt6ak6ZGjjmsCrbv7LixFIaEFp7ZablZclmBiG+4mjWJBF7YVYPcwLVYmQ3XOdPZgFgdJTWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768286831; c=relaxed/simple;
	bh=mdvi0sho3J11rbUfNlKjVGYmRahhS36qJXvwj6oxH5E=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=OBsVHK/YKvwkYa7fIRzDt3rLJs3SqQ6jo3lDsgDI56lgLdkgpWME/+WNcN8fNjf5/mAOvXNEUuDnpuBlQloJFDafxaOVEgsNCF8LLos8FPBggl7lAU6+qqMvtTS9GiDasPc+8j5Xk2uxFZ4KH2UK1AL+VtWO4RMF0f7B8XKA9Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eRtSOlxY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05BCC116C6;
	Tue, 13 Jan 2026 06:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768286831;
	bh=mdvi0sho3J11rbUfNlKjVGYmRahhS36qJXvwj6oxH5E=;
	h=Date:From:To:Cc:Subject:From;
	b=eRtSOlxY5WutuL9BCWalFjGeuDXWgVafJnzQcVPZgo/Wfg94AZqOTpu/7X0KhoIH0
	 V3D+FGyryWMWj2+OWzLNPDEq1eVwc65SFt/RDsgD1ohM4etX07Dk08n2lVgDIYsHt6
	 1ZALTHK9uKtByRKwSkwjRCcyOj85BkigI5jIw6xvFSe5pwH2Z95fQTUwnXSFxHZq/o
	 qk3U/3QvgiDEegvgwlvV11LX/ei4oumtRrb0k8ha3g+MfgKp039WCkCQAcE1K+ypR/
	 PfPi3EcmZ4QMQSDOElFb7irUVkEpCb5E9Chi6fL4LHvUTALQJriWUNdoC696y6SuuG
	 MTaQV53aTouzw==
Date: Tue, 13 Jan 2026 06:47:09 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com, longli@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for v6.19-rc6
Message-ID: <20260113064709.GA3099059@liuwe-devbox-debian-v2.local>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 8f0b4cce4481fb22653697cced8d0d04027cb1e8:

  Linux 6.19-rc1 (2025-12-14 16:05:07 +1200)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20260112

for you to fetch changes up to 173d6f64f9558ff022a777a72eb8669b6cdd2649:

  mshv: release mutex on region invalidation failure (2025-12-18 20:00:10 +0000)

----------------------------------------------------------------
hyperv-fixes for v6.19-rc6
  - Minor fixes and cleanups for the MSHV driver
----------------------------------------------------------------
Anirudh Rayabharam (Microsoft) (1):
      mshv: release mutex on region invalidation failure

Arnd Bergmann (1):
      mshv: hide x86-specific functions on arm64

Gustavo A. R. Silva (1):
      hyperv: Avoid -Wflex-array-member-not-at-end warning

Stanislav Kinsburskii (2):
      mshv: Use PMD_ORDER instead of HPAGE_PMD_ORDER when processing regions
      mshv: Initialize local variables early upon region invalidation

 drivers/hv/mshv_common.c    |  2 ++
 drivers/hv/mshv_regions.c   | 20 +++++++++++---------
 include/hyperv/hvgdk_mini.h |  7 +++++--
 3 files changed, 18 insertions(+), 11 deletions(-)

