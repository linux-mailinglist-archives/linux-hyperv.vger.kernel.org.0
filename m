Return-Path: <linux-hyperv+bounces-3030-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E5497A9FC
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Sep 2024 02:38:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 478411C272C6
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Sep 2024 00:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C8C01C6B2;
	Tue, 17 Sep 2024 00:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GQhXSInr"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156061C6A3;
	Tue, 17 Sep 2024 00:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726533517; cv=none; b=AHz/Q9pBFLyxVyoqspudtFZ85FATwZrT1CFUHTBr5Be/YptO//BqltOLocvbzVb7uigvFkC2wM5SofNTkq5LemWUBwceTnqS8ZNUMOB6yWS0A4B8cekBvD47NZ1XxesX3kgy7Srq6f155xIjK+6d/Kg2q04cxF3k4JXgUSNRKyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726533517; c=relaxed/simple;
	bh=i8NstBrUlbtzwhM3Nldx7FYmXK4bagD9WKh7WbF48uE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=E16aN9J0moOpPSRxJA7tbd8krWzjBue4Y9WPQhQnIX4yBOH4TCmJ3w1qIwbAUL6FFFBOI5J/6HH39bKsB1tZD8ajFEKIU2eO7hyjQE9TJLjEFhkxk+zeECs86ZTA1II53T+Y4q2AftvtvWP2IGL0wnBRKAZMaQmB5XeGqKlLAaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GQhXSInr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E188C4CEC5;
	Tue, 17 Sep 2024 00:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726533516;
	bh=i8NstBrUlbtzwhM3Nldx7FYmXK4bagD9WKh7WbF48uE=;
	h=Date:From:To:Cc:Subject:From;
	b=GQhXSInrGw1WfTHiFJTWBvR1gHkwH5znvDCx/wymxzEKHwmjXA8HapieHT4Ns45vn
	 T1MOyHrWdqEo6v1zb092o072z5jwYzMFPeF/Fl2MknqMqEnVNz7Xfvu2yR6feHcuCz
	 kTD51ASmeG0eV35PvI9Q8A+tl1hD7brrcHbGjpDZwfBD4UtrOBiVQwRHPAPj3CLQ7G
	 +Mf7uQo09cX4GOq8S/XkT82vwOhbqbzb0Gm5r/I8L379otbCcWw/7P/Nri27yUSFXY
	 JQJBxyHgOjng/MtnYbFO/AFDTzd3DqMmbJWJ6dwDW5t5007BkXc2JGNzERVAM9EIcs
	 HQYkxoSqQ2pxQ==
Date: Tue, 17 Sep 2024 00:38:37 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com
Subject: [GIT PULL] Hyper-V next for v6.12
Message-ID: <ZujPjfi61CEVvhw3@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit 47ac09b91befbb6a235ab620c32af719f8208399:

  Linux 6.11-rc4 (2024-08-18 13:17:27 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20240916

for you to fetch changes up to 94e86b174d103d941b4afc4f016af8af9e5352fa:

  tools/hv: Add memory allocation check in hv_fcopy_start (2024-09-09 01:09:27 +0000)

----------------------------------------------------------------
hyperv-next for v6.12
  - Optimize boot time by concurrent execution of hv_synic_init() (Saurabh Sengar)
  - Use helpers to read control registers in hv_snp_boot_ap() (Yosry Ahmed)
  - Add memory allocation check in hv_fcopy_start (Zhu Jun)
----------------------------------------------------------------
Saurabh Sengar (1):
      Drivers: hv: vmbus: Optimize boot time by concurrent execution of hv_synic_init()

Yosry Ahmed (1):
      x86/hyperv: use helpers to read control registers in hv_snp_boot_ap()

Zhu Jun (1):
      tools/hv: Add memory allocation check in hv_fcopy_start

 arch/x86/hyperv/ivm.c          |  6 +++---
 drivers/hv/vmbus_drv.c         | 34 +++++++++++++++++++++++++++++++---
 tools/hv/hv_fcopy_uio_daemon.c |  7 +++++++
 3 files changed, 41 insertions(+), 6 deletions(-)

