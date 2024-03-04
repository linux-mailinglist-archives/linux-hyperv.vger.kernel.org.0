Return-Path: <linux-hyperv+bounces-1655-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D382F86F9FF
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Mar 2024 07:22:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 105A71C2096F
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Mar 2024 06:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 975BBBE4C;
	Mon,  4 Mar 2024 06:22:12 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22577C2C8;
	Mon,  4 Mar 2024 06:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709533332; cv=none; b=CXTUc1KYw11/lcKP4ex2Q1aX3n3qzlv+imwgTRab62YKj5tyaIXWJeXR1W14u7NE/VcEZNIDDV2eps/wXU/2gtnV7KL9bIJqpma+JWny9M7vJ0P5Kc9e9nDhuNSAUFwPH1agiQ1PBHMgJATXMhsrPg8K3TBxHRdlOZwoG5HqpA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709533332; c=relaxed/simple;
	bh=X1D7s0fm2PMS0AJTwarQBIFcT1TzEvEHovub1KFd0gU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=NmxYf09I68HQH1gWjM5GTINCLwRilfZtNlTKzBa1a5lM8nDAlf0dpvUsL10oqf7cc4nZqJGB2bT08eZggNBifRLqiK+vE9lwOrQhT5L8Cxpzw+RT8Zc9jfMwkct8KL0ArCHPegPL7gpqzNNtNNYDxWBKEI+vbHOzrtv4I1zxkxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-29b2c48fa3dso679595a91.1;
        Sun, 03 Mar 2024 22:22:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709533330; x=1710138130;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Lgbpy/xhGDqTmje0FzgN23UkMz4aW7iaL1u0lYB0pLc=;
        b=czK+7cLHCTuXT0AOZ8YeIApGpoenPoG9Dc34dByeuArZNwjctEYzycRHYRDTG9lKHQ
         MZchpkOBiFDMp8LJdqMra5Yz/YPiflE5XdcbFJ/tMrPP7qrVuyrFnPrQ9kM1egzM7roS
         iaMjcdTrXvuXQuAPGuanJYf013zef2T+3rqvjRESJuPStxDHswBVcfzXjTyzjrFu1erZ
         wNzwhLwdyI1F+OUrtZe8KDPrRCwhnBEeLYoG/OvRoFgO1+bDJCcI8E9uen6x+zLgPpVb
         CGaU+wfCdct7LELgN1b1TBIsyFYhGnFkUc7TFrVrnlJWwNp4bZUgZMpanZLsVtwVR6dc
         prRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHP18EwWNswF9pJv82lxt6e1G6yFsLhaCG0UdszOY8B9hdwH0Kmbl7Hu99UTjQf75+t8Lj+zVVTf4kIPiVNluduXH6sVUx9nyxtBHvCA2KqlbPfVEa7c+2BnuP1eGZ8rnIjpntG/e3o2Ki
X-Gm-Message-State: AOJu0YwbEiXjoYPh5wnGW6WC4frWY0rPJUL4UO3dG2LkwS3WNiGxgEpO
	zJ86qO0oxyqzIUFuBVCx1YZTW6ee5sHSBNaiQOyAiaRN/1ohOmjhy45YZF/R
X-Google-Smtp-Source: AGHT+IHpHhgFnFo7Zehyy4S+XRY7h9ujyWWNAjRKInsd4YEHOw2mwxTQxFa0UDd1dT+rUzd1JY6KGQ==
X-Received: by 2002:a17:90a:a884:b0:29a:9c12:785 with SMTP id h4-20020a17090aa88400b0029a9c120785mr5890475pjq.1.1709533330360;
        Sun, 03 Mar 2024 22:22:10 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id y5-20020a17090aca8500b0029b59bf77b4sm31318pjt.42.2024.03.03.22.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 22:22:09 -0800 (PST)
Date: Mon, 4 Mar 2024 06:22:05 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>, kys@microsoft.com,
	haiyangz@microsoft.com, decui@microsoft.com
Subject: [GIT PULL] Hyper-V fixes for 6.8-rc8
Message-ID: <ZeVojbuNPk3SMDIn@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Hi Linus,

The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20240303

for you to fetch changes up to aa707b615ce1551c25c5a3500cca2cf620e36b12:

  Drivers: hv: vmbus: make hv_bus const (2024-03-03 02:32:35 +0000)

----------------------------------------------------------------
hyperv-fixes for v6.8
 - Multiple fixes, cleanups and documentations for Hyper-V core code and
   drivers.
----------------------------------------------------------------
Michael Kelley (8):
      Drivers: hv: vmbus: Calculate ring buffer size for more efficient use of memory
      fbdev/hyperv_fb: Fix logic error for Gen2 VMs in hvfb_getmem()
      Drivers: hv: vmbus: Remove duplication and cleanup code in create_gpadl_header()
      Drivers: hv: vmbus: Update indentation in create_gpadl_header()
      Documentation: hyperv: Add overview of PCI pass-thru device support
      x86/hyperv: Use slow_virt_to_phys() in page transition hypervisor callback
      x86/mm: Regularize set_memory_p() parameters and make non-static
      x86/hyperv: Make encrypted/decrypted changes safe for load_unaligned_zeropad()

Peter Martincic (1):
      hv_utils: Allow implicit ICTIMESYNCFLAG_SYNC

Ricardo B. Marliere (1):
      Drivers: hv: vmbus: make hv_bus const

Saurabh Sengar (1):
      x86/hyperv: Allow 15-bit APIC IDs for VTL platforms

 Documentation/virt/hyperv/index.rst |   1 +
 Documentation/virt/hyperv/vpci.rst  | 316 ++++++++++++++++++++++++++++++++++++
 arch/x86/hyperv/hv_vtl.c            |   7 +
 arch/x86/hyperv/ivm.c               |  65 +++++++-
 arch/x86/include/asm/set_memory.h   |   1 +
 arch/x86/mm/pat/set_memory.c        |  24 +--
 drivers/hv/channel.c                | 176 ++++++++------------
 drivers/hv/hv_util.c                |  31 +++-
 drivers/hv/vmbus_drv.c              |   2 +-
 drivers/video/fbdev/hyperv_fb.c     |   2 -
 include/linux/hyperv.h              |  22 ++-
 11 files changed, 521 insertions(+), 126 deletions(-)
 create mode 100644 Documentation/virt/hyperv/vpci.rst

