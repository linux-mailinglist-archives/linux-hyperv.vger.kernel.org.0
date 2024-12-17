Return-Path: <linux-hyperv+bounces-3489-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 898DA9F569D
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 19:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1AC616B49D
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Dec 2024 18:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FCD21F8AE7;
	Tue, 17 Dec 2024 18:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rf5sPkVG"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79801F8ADF;
	Tue, 17 Dec 2024 18:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734461705; cv=none; b=Fmxa4Ef3X46ZFtDClN0uktpgoopzYFaJ7UmWRej+tnv1QK/5PsIMsNo4x8bzenTLAisEWqGOr4W1wHU4948fL/Hp3Iv5nA84hqxd1wAI9LK47GAeYfl7cFbY9LobKQr4NWB+T7N4hDuOdJBfGg0psj6JPAO5ACANF1PdqfU+duM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734461705; c=relaxed/simple;
	bh=oFnWjm+pqO0sYESC0cwc19ZduXpRAMOUBhQG0fcGYb0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=IpIT6t5kc9qsk3w2mO68eHLdaIT84S0hYZasKPZckBozRyEURNFU5q80QeC9D+fBH1T/jzk1Fv45VSxYhqJVSFgpC7zolLkmAkl/x7bOglwV4FCRJj3mMRlthFzb1ESlObD2a0dCEGAZjKbXJCOT+fLYCoCM8vU1LHrGXrfVRAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rf5sPkVG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B474C4CED3;
	Tue, 17 Dec 2024 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734461704;
	bh=oFnWjm+pqO0sYESC0cwc19ZduXpRAMOUBhQG0fcGYb0=;
	h=Date:From:To:Cc:Subject:From;
	b=rf5sPkVGqYAUNBUOicc+FNzgfIalPd/+cCHpGpUixLPjZypeFs/2eeWipBT5a8R9v
	 TOUThH9k1EnVBjiFShDZR4kFIypHJU2tE+W6VNr7dYdHWbFvjUKGsMz5Ew43Sd1lrT
	 a46B8iEd6+LJnvsz/LNNylUr2mjlXVqyiQ1M8Avt0eZGG+gx7nP1WeFrZfl6A5axL3
	 HnJj4KELkgdFHqcbB8EfSBquHVzjM95lphYmC2xPlMcmjPPNgEsNsBgM72HWZhBQX/
	 C5iiuoa1IYcclVaqz8hWJvukUue+GpsiaWNu1GkWWwdm0bCWTfMGSENaTOCUsFB20j
	 xEiGT9kSBr0Uw==
Date: Tue, 17 Dec 2024 18:55:03 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com
Subject: [GIT PULL] Hyperv-fixes for v6.13-rc4
Message-ID: <Z2HJB0qky91FHC7C@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit fac04efc5c793dccbd07e2d59af9f90b7fc0dca4:

  Linux 6.13-rc2 (2024-12-08 14:03:39 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20241217

for you to fetch changes up to 175c71c2aceef173ae6d3dceb41edfc2ac0d5937:

  tools/hv: reduce resource usage in hv_kvp_daemon (2024-12-09 18:44:15 +0000)

----------------------------------------------------------------
hyperv-fixes for v6.13-rc4
  - Various fixes to Hyper-V tools in the kernel tree (Dexuan Cui,
    Olaf Hering, Vitaly Kuznetsov)
  - Fix a bug in the Hyper-V TSC page based sched_clock() (Naman Jain)
  - Two bug fixes in the Hyper-V utility functions (Michael Kelley)
  - Convert open-coded timeouts to secs_to_jiffies() in Hyper-V drivers
    (Easwar Hariharan)
----------------------------------------------------------------
Dexuan Cui (1):
      tools: hv: Fix a complier warning in the fcopy uio daemon

Easwar Hariharan (1):
      drivers: hv: Convert open-coded timeouts to secs_to_jiffies()

Michael Kelley (2):
      Drivers: hv: util: Don't force error code to ENODEV in util_probe()
      Drivers: hv: util: Avoid accessing a ringbuffer not initialized yet

Naman Jain (1):
      x86/hyperv: Fix hv tsc page based sched_clock for hibernation

Olaf Hering (5):
      tools: hv: change permissions of NetworkManager configuration file
      tools/hv: terminate fcopy daemon if read from uio fails
      tools/hv: reduce resouce usage in hv_get_dns_info helper
      tools/hv: add a .gitignore file
      tools/hv: reduce resource usage in hv_kvp_daemon

Vitaly Kuznetsov (1):
      hv/hv_kvp_daemon: Pass NIC name to hv_get_dns_info as well

 arch/x86/kernel/cpu/mshyperv.c     | 58 ++++++++++++++++++++++++++++++++++++++
 drivers/clocksource/hyperv_timer.c | 14 ++++++++-
 drivers/hv/hv_balloon.c            |  9 +++---
 drivers/hv/hv_kvp.c                | 10 +++++--
 drivers/hv/hv_snapshot.c           |  9 +++++-
 drivers/hv/hv_util.c               | 13 +++++++--
 drivers/hv/hyperv_vmbus.h          |  2 ++
 drivers/hv/vmbus_drv.c             |  2 +-
 include/clocksource/hyperv_timer.h |  2 ++
 include/linux/hyperv.h             |  1 +
 tools/hv/.gitignore                |  3 ++
 tools/hv/hv_fcopy_uio_daemon.c     | 12 ++++----
 tools/hv/hv_get_dns_info.sh        |  4 +--
 tools/hv/hv_kvp_daemon.c           |  9 +++---
 tools/hv/hv_set_ifconfig.sh        |  2 +-
 15 files changed, 125 insertions(+), 25 deletions(-)
 create mode 100644 tools/hv/.gitignore

