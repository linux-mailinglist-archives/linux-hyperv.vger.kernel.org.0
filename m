Return-Path: <linux-hyperv+bounces-4409-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 919D5A5D203
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 22:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2DCD03B564E
	for <lists+linux-hyperv@lfdr.de>; Tue, 11 Mar 2025 21:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F13264A68;
	Tue, 11 Mar 2025 21:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P22GLaP3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCEEE228C8D;
	Tue, 11 Mar 2025 21:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741729885; cv=none; b=r6XI/qNhBwMzUxknw+J/lq+VGPNbIAIX+z653lRcYGNT6nFq3VxtrHoogRhKT2z2sP+y1D8N1sYyYTDbJW67kSFPQkVpgKCyHfQASzZvaRYAmPhIiuu5BHKK1pclSLn6STvCFx5SC/LxErC3R469rNhby2h6Ub9xYzsfc0PubnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741729885; c=relaxed/simple;
	bh=uU1stOxg+F3UDLnXvZQqIKLpgieaFxKvWC8fsbh+udI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Y+h0mKuLyjOwQiF8kRW4VxQ04dJCsDIv/xgKXXOfIn1hj9KmLllNF9oVvBae9pwsnalu/LsbQXWrippBG4YUaobzXt0KHDg/Z723nof65lAUIm5srNkbUXf+twVJktvGlVK0CAVJAstHRRgfJgQrdjjSTGaaniw/f6Ms7IaAcsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P22GLaP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29F46C4CEE9;
	Tue, 11 Mar 2025 21:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741729885;
	bh=uU1stOxg+F3UDLnXvZQqIKLpgieaFxKvWC8fsbh+udI=;
	h=Date:From:To:Cc:Subject:From;
	b=P22GLaP3R01/FiUrduYE5ForhOECI3JYFJNCCTTpdN3sQ8D1te336ZXPTCGb47GVG
	 nAZi7hq0r4fnDGeodrbvmUzTFOIJznGEeCGsWq1yXVFLgG+0SNXCa+lhWCIOxwANfU
	 G6chTb3fsUdEkHE9qfRjTIZoxFKFdrK0aou21du2GaXTY/A3baA0qdnji62EE7XMAo
	 9ueTb2U+lxMYC7W6oA9rJnSTnCttwRaCtRayoIpCpOt69iNIFMvdbk65lFhSIstFu7
	 hkxOt1N84Slmzgy+QTofK2Jz9ozIzulkAYj/y5thUz9N2YF92XLtkZaqBe0zspnf3S
	 UO7ssh0jX2vNg==
Date: Tue, 11 Mar 2025 21:51:23 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for v6.14-rc7
Message-ID: <Z9CwWweWftt02ZWZ@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Linus,

The following changes since commit a64dcfb451e254085a7daee5fe51bf22959d52d3:

  Linux 6.14-rc2 (2025-02-09 12:45:03 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20250311

for you to fetch changes up to 73fe9073c0cc28056cb9de0c8a516dac070f1d1f:

  Drivers: hv: vmbus: Don't release fb_mmio resource in vmbus_free_mmio() (2025-03-10 16:54:06 +0000)

----------------------------------------------------------------
hyperv-fixes for v6.14-rc7
  - Patches to fix Hyper-v framebuffer code. (Michael Kelley and Saurabh
    Sengar)
  - Fix for Hyper-V output argument to hypercall that changes page
    visibility. (Michael Kelley)
  - Fix for Hyper-V VTL mode. (Naman Jain)
----------------------------------------------------------------
Michael Kelley (5):
      fbdev: hyperv_fb: iounmap() the correct memory when removing a device
      drm/hyperv: Fix address space leak when Hyper-V DRM device is removed
      fbdev: hyperv_fb: Fix hang in kdump kernel when on Hyper-V Gen 2 VMs
      x86/hyperv: Fix output argument to hypercall that changes page visibility
      Drivers: hv: vmbus: Don't release fb_mmio resource in vmbus_free_mmio()

Naman Jain (1):
      x86/hyperv/vtl: Stop kernel from probing VTL0 low memory

Saurabh Sengar (2):
      fbdev: hyperv_fb: Simplify hvfb_putmem
      fbdev: hyperv_fb: Allow graceful removal of framebuffer

 arch/x86/hyperv/hv_vtl.c                |  1 +
 arch/x86/hyperv/ivm.c                   |  3 +-
 drivers/gpu/drm/hyperv/hyperv_drm_drv.c |  2 ++
 drivers/hv/vmbus_drv.c                  | 13 +++++++++
 drivers/video/fbdev/hyperv_fb.c         | 52 +++++++++++++++++++++------------
 5 files changed, 51 insertions(+), 20 deletions(-)

