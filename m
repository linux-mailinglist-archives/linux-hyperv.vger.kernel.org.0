Return-Path: <linux-hyperv+bounces-5187-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 778C5A9E58A
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 02:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05CE57A436E
	for <lists+linux-hyperv@lfdr.de>; Mon, 28 Apr 2025 00:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A66876026;
	Mon, 28 Apr 2025 00:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LUFL/Uci"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E278928691;
	Mon, 28 Apr 2025 00:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745801041; cv=none; b=VSktHvJOzvLTtX4yILD7rGwIOa+LbvWbkB8MMFlZP7cV8pucewXAZc03RlRoQEMIHA0YmH+KsDibEtIgQoEw8XRWHrTe4f/pM0Jj88lVwuW8VBIhImm/wqal28luxN5x3N0Y2MoSN1bODVKKp8HHqJ8jJcKfCbXY9R2rnI8I9AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745801041; c=relaxed/simple;
	bh=4FUgbOTRV6YZ/bDX+OGRRtXpOGaE8ViT2b+FPW9kaUU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mMyMR+fREwjuv2Qh3ZjrmGjsKcpVRNNdopPpY9M7JRgqytABAr4ObQoc8yzIx32ICujPBJiIAiDwoIbA3p/3zhHuoR/rMPls5W5NIJWfH3BH+ArP/hBTpfvt2YCeVzaRWxSIf5iXUMDpEuvi4v2QZY0faa8+YrwoOU+9RrppvII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LUFL/Uci; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D0A9C4CEEC;
	Mon, 28 Apr 2025 00:44:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745801040;
	bh=4FUgbOTRV6YZ/bDX+OGRRtXpOGaE8ViT2b+FPW9kaUU=;
	h=Date:From:To:Cc:Subject:From;
	b=LUFL/UcivJvGhNa+7q4ahf/9KZ5x39f7TjVHpFLlM3H7LzSFPGYQT+ckMB/35jvZ7
	 JjXE60Cf51TjaZdRMvz9pAOCZQAXc3p0ObhzFoRVEdddAp//fS5lINxcWYH6WT6ex7
	 eDRbUsMzzg7adb2QoOp/1PM/MXPzxqjCiCAPUE0s21ZIqxbXEL81vVysbi0uTdvbrU
	 wYYnblNNBRJdV4wkVJVbzVUCcccgNg0W3SOem16qKxoQt/iqH+CkQMo7Z+Wcs000Tk
	 UBJWPGDE80yfTqzJ69vnlaYJNejVPqUD71ZlD4Dz3VPYPpOfC35RkMuIexWLTjPa5a
	 +hGEuLUWzY7/Q==
Date: Mon, 28 Apr 2025 00:43:59 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for 6.15-rc5
Message-ID: <aA7PT_nDBiIk27w7@liuwe-devbox-ubuntu-v2.tail21d00.ts.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 0af2f6be1b4281385b618cb86ad946eded089ac8:

  Linux 6.15-rc1 (2025-04-06 13:11:33 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20250427

for you to fetch changes up to 14ae3003e73e777c9b36385a7c86f754b50a1821:

  Drivers: hv: Fix bad ref to hv_synic_eventring_tail when CPU goes offline (2025-04-25 21:13:53 +0000)

----------------------------------------------------------------
hyperv-fixes for 6.15-rc5
 - Bug fixes for the Hyper-V driver and kvp_daemon
----------------------------------------------------------------
Michael Kelley (1):
      Drivers: hv: Fix bad ref to hv_synic_eventring_tail when CPU goes offline

Nuno Das Neves (1):
      Drivers: hv: Fix bad pointer dereference in hv_get_partition_id

Olaf Hering (1):
      tools/hv: update route parsing in kvp daemon

 drivers/hv/hv_common.c   |  10 +++--
 tools/hv/hv_kvp_daemon.c | 108 ++++++++++++++++++++++++++++++++++++-----------
 2 files changed, 90 insertions(+), 28 deletions(-)

