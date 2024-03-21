Return-Path: <linux-hyperv+bounces-1802-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B230881BCB
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 05:09:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 072891F21D94
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Mar 2024 04:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7A2C13C;
	Thu, 21 Mar 2024 04:09:18 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38141BA4B;
	Thu, 21 Mar 2024 04:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710994158; cv=none; b=lUpvfjm0fd7gS5V3e7gh1txJgUHrJK8L8vfyMNPqGnutP3fKeRhuoaNYzVXtCvX966qP6aG5tDxXcRmnkPUAxyotbAEtQck/4VBMfpyujYq5A/92J5/xzDPR0xRWq56LC0o4jjJIczyVHoX6ZbGhNqvtRoZFyJ/moFBiN1JHsR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710994158; c=relaxed/simple;
	bh=6NIHl82hxaXF8/BemQLM3ZTmC/d3w305ahJ/4ejg6e0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Aa76u63nmCJaY4jkpjiWSFsxQhehkLsGL/AAdOJVY/aK7nLAgmTqsJzcYyFJcRWjs385wuXX+66OeRSnoOfHqXNx1X75gxcDEqNwKWA1wU81MvCcHU7Wa+2cPjvPtgrw6xwD+qf9YIBtvB5U2Af8WR63ZOUGr0CnoIs1QQJD8mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5cf2d73a183so1079886a12.1;
        Wed, 20 Mar 2024 21:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710994156; x=1711598956;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fsrvmp+bFMjvUNFgFHA1I3YQMLlHm4YITClohzEVJDo=;
        b=i3f3PNDh4mnKvhvc5rhzPcMyXm0v6Yba+Mc95VKOeO6r1aic/pTpLoxFhtSWlBUGKF
         LD3/fnAqehBfAhBk+yWvcjO0gZvOqsDBVQtozmNsmmJKidVoDK7Za+XJMJXMTd/ioQTV
         xIyL79sTUPeXWuy2yZR6Gc3CtGjmUoL2VrIDK5m5BagUzEi14JfkO8t/1zxZ6Hk0/Ebn
         P2wewZwjJocgpd4C3Lb/Bjz44aOCws7xCIGJE3fSW+yKfnHrY27T6idNzUH8nBwCOjYG
         h20KpLaNq0NG26E3G1DuBNUndLPqK7UqSnR0G3zMpmsbr/X08OoOyk8HlFxLzcpcv7cc
         CfEw==
X-Forwarded-Encrypted: i=1; AJvYcCXfEkKQ8X+UTP9XGMtNzxVjqi2HkyyYSRtzHpgXZyR2mScKRlFDZVbCshwQVnwNoIXGXtvzFCS/KdPTqcbU0XX7HikOUnPPyVqsfXXjbLiQeA0Xms2Yxd86XB9sJQaxX/N1dMFqkaNRKcOf
X-Gm-Message-State: AOJu0Yx8DN4ucX/Y4jrRHi6WxdVw8L9Y5CYsXigV2EWSp41+XxFhQaao
	AHyh5o7d7XBXmdnr2MU/2g5onrfcKsjS540v5Hxz6piWfHgvfQrg
X-Google-Smtp-Source: AGHT+IE1bbvVFcS2D/R/wlzNbCYLAuwrRnQu0dyFoB/jGaTh3PXAFvIyCKBnFYLNw1jTAmuDQva4cA==
X-Received: by 2002:a17:90a:1149:b0:29b:46f0:6f8e with SMTP id d9-20020a17090a114900b0029b46f06f8emr2361631pje.8.1710994156381;
        Wed, 20 Mar 2024 21:09:16 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id j1-20020a17090a060100b0029c73ed3748sm2765414pjj.6.2024.03.20.21.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 21:09:15 -0700 (PDT)
Date: Thu, 21 Mar 2024 04:09:09 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Linux Kernel List <linux-kernel@vger.kernel.org>,
	Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
	kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com
Subject: [GIT PULL] Hyper-V commits for 6.9
Message-ID: <Zfuy5ZyocT7SRNCa@liuwe-devbox-debian-v2>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit d206a76d7d2726f3b096037f2079ce0bd3ba329b:

  Linux 6.8-rc6 (2024-02-25 15:46:06 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-next-signed-20240320

for you to fetch changes up to f2580a907e5c0e8fc9354fd095b011301c64f949:

  x86/hyperv: Use Hyper-V entropy to seed guest random number generator (2024-03-18 22:01:52 +0000)

----------------------------------------------------------------
hyperv-next for v6.9
  - Use Hyper-V entropy to seed guest random number generator (Michael Kelley)
  - Convert to platform remove callback returning void for vmbus (Uwe Kleine-König)
  - Introduce hv_get_hypervisor_version function (Nuno Das Neves)
  - Rename some HV_REGISTER_* defines for consistency (Nuno Das Neves)
  - Change prefix of generic HV_REGISTER_* MSRs to HV_MSR_* (Nuno Das Neves)
  - Cosmetic changes for hv_spinlock.c (Purna Pavan Chandra Aekkaladevi)
  - Use per cpu initial stack for vtl context (Saurabh Sengar)
----------------------------------------------------------------
Michael Kelley (1):
      x86/hyperv: Use Hyper-V entropy to seed guest random number generator

Nuno Das Neves (3):
      hyperv-tlfs: Change prefix of generic HV_REGISTER_* MSRs to HV_MSR_*
      mshyperv: Introduce hv_get_hypervisor_version function
      hyperv-tlfs: Rename some HV_REGISTER_* defines for consistency

Purna Pavan Chandra Aekkaladevi (1):
      x86/hyperv: Cosmetic changes for hv_spinlock.c

Saurabh Sengar (1):
      x86/hyperv: Use per cpu initial stack for vtl context

Uwe Kleine-König (1):
      hv: vmbus: Convert to platform remove callback returning void

 arch/arm64/hyperv/hv_core.c          |  14 ++--
 arch/arm64/hyperv/mshyperv.c         |  22 +++---
 arch/arm64/include/asm/hyperv-tlfs.h |  45 +++++------
 arch/arm64/include/asm/mshyperv.h    |   4 +-
 arch/x86/hyperv/hv_init.c            |   8 +-
 arch/x86/hyperv/hv_spinlock.c        |   3 +-
 arch/x86/hyperv/hv_vtl.c             |  19 ++++-
 arch/x86/include/asm/hyperv-tlfs.h   | 145 ++++++++++++++++++-----------------
 arch/x86/include/asm/mshyperv.h      |  30 ++++----
 arch/x86/kernel/cpu/mshyperv.c       |  93 +++++++++++-----------
 drivers/clocksource/hyperv_timer.c   |  26 +++----
 drivers/hv/Kconfig                   |   1 +
 drivers/hv/hv.c                      |  36 ++++-----
 drivers/hv/hv_common.c               |  99 +++++++++++++++++++++---
 drivers/hv/vmbus_drv.c               |   5 +-
 include/asm-generic/hyperv-tlfs.h    |  55 ++++++++++++-
 include/asm-generic/mshyperv.h       |   6 +-
 17 files changed, 375 insertions(+), 236 deletions(-)

