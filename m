Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94C314545E5
	for <lists+linux-hyperv@lfdr.de>; Wed, 17 Nov 2021 12:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236907AbhKQLvS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Nov 2021 06:51:18 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:35629 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235513AbhKQLvS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Nov 2021 06:51:18 -0500
Received: by mail-wr1-f44.google.com with SMTP id i5so4130922wrb.2;
        Wed, 17 Nov 2021 03:48:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=FipmrGJsMbXdacPZM5RYuZYLZuiUt9ubG7V553ELRwU=;
        b=glTJrvvXkIn568kmbS22Y1AH8kgYOaDiDiYi6V8KSXxijkyCRPnOrCeFxYIyG8QL4P
         mFerUPQ37ALtk2bVN5XiZVMJVBwpBj5BzX+8xDNnFy2ihtSZKgeR73RIJHeoDd9OS+gS
         N81SJkrFgZZg47TbClHDLaLNWGy4YmCWyklxsNUangOCMklqYM9dETTO1a176JwTev35
         mxACTergKJL46g8/qrHNS/UEcxJ1Q0QmNa8MCqTdFNa876lU7KS98EF12569CuMQrl9L
         Gc/vSjqXEK2m0kd3yUbTP1oRis9cU0W/WeZ9lFxvtA2Pq8hIhXCFdF5ZAFFoPL5TNhhc
         2vyw==
X-Gm-Message-State: AOAM532gu3EWCwFZOrH/eWPHkNxXHQYPeB9D7lSLhPS2wdVKHPwPFMBl
        /ErqjszANIjvDeN8EHB+HRKzaPIn0b4=
X-Google-Smtp-Source: ABdhPJwejG54iCxlJlNjUVlSWBwDabHwHd1/E/qzz0g9Ja9pNmg+Mpyhe6KdORPt3eMmSI39lLoSvg==
X-Received: by 2002:adf:8008:: with SMTP id 8mr18738165wrk.188.1637149692226;
        Wed, 17 Nov 2021 03:48:12 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id az15sm591800wmb.0.2021.11.17.03.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Nov 2021 03:48:11 -0800 (PST)
Date:   Wed, 17 Nov 2021 11:48:10 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V fixes for 5.16-rc2
Message-ID: <20211117114810.favtd35s5gra7lli@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit fa55b7dcdc43c1aa1ba12bca9d2dd4318c2a0dbf:

  Linux 5.16-rc1 (2021-11-14 13:56:52 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20211117

for you to fetch changes up to f3e613e72f66226b3bea1046c1b864f67a3000a4:

  x86/hyperv: Move required MSRs check to initial platform probing (2021-11-15 12:37:08 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.16-rc2
  - Fix ring size calculation for balloon driver (Boqun Feng)
  - Fix issues in Hyper-V setup code (Sean Christopherson)
----------------------------------------------------------------
Boqun Feng (1):
      Drivers: hv: balloon: Use VMBUS_RING_SIZE() wrapper for dm_ring_size

Sean Christopherson (2):
      x86/hyperv: Fix NULL deref in set_hv_tscchange_cb() if Hyper-V setup fails
      x86/hyperv: Move required MSRs check to initial platform probing

 arch/x86/hyperv/hv_init.c      | 12 ++++--------
 arch/x86/kernel/cpu/mshyperv.c | 20 +++++++++++++++-----
 drivers/hv/hv_balloon.c        |  2 +-
 3 files changed, 20 insertions(+), 14 deletions(-)
