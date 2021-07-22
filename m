Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92FF23D2538
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jul 2021 16:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232166AbhGVN3S (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 22 Jul 2021 09:29:18 -0400
Received: from mail-wr1-f51.google.com ([209.85.221.51]:41482 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbhGVN3R (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 22 Jul 2021 09:29:17 -0400
Received: by mail-wr1-f51.google.com with SMTP id k4so6106331wrc.8;
        Thu, 22 Jul 2021 07:09:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=iK1KJpHvpUOPSAnxMC0sFeO0mFYkseDin9zJ6vd6y/o=;
        b=tzLs+OuIGAjr829/m+3N+T3ZlMt0MNxMk1DODgKOtBf1xgvESmgmWoGt5bMYg44uWK
         QLlJlad1hDHYvZvgOlS4ANw6pW2c/IkQwLwkveLLxVas0EUpZg8ItN1YQlefq7ygf0kc
         Oje9yuEPPRvfCx1lHWOMIuuk58vGYRGtMmsxOm13GxSUTV1An4JwKRdR9KritO1TflP0
         qtT+9n49X4Y6c+wyQ9qc3TcBCZEa/5cQ9cJnxNFqjSiXlLdrT0KvgVFr+7fLveYdIHSV
         8wuhac+uygrYLg3N4KxXZap3AKDNbgWWsMQTBWYUbmgwyDRUWijvbpUayL6grdJohKUy
         JAvA==
X-Gm-Message-State: AOAM530PoVZbYwuOmZ+XdhQapR2Lwq6ci5SPkO/IvP3H/0RNUXeb/ZsZ
        wcKGbnXVW3r5cL5++MkgqNdkT8MbFPY=
X-Google-Smtp-Source: ABdhPJwsFg9rnIh0o+ptn8qnUio595xkVhBJMZ3UUY3/1ZhZuc5GpdLvsIi+LAVRXcGqQCsh2KMfyg==
X-Received: by 2002:a5d:6644:: with SMTP id f4mr91617wrw.177.1626962990920;
        Thu, 22 Jul 2021 07:09:50 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f26sm24765858wmc.29.2021.07.22.07.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 07:09:50 -0700 (PDT)
Date:   Thu, 22 Jul 2021 14:09:49 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kys@microsoft.com, sthemmin@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V fixes for 5.14-rc3
Message-ID: <20210722140949.3knhduxozzaido2r@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit e73f0f0ee7541171d89f2e2491130c7771ba58d3:

  Linux 5.14-rc1 (2021-07-11 15:07:40 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20210722

for you to fetch changes up to f5a11c69b69923a4367d24365ad4dff6d4f3fc42:

  Revert "x86/hyperv: fix logical processor creation" (2021-07-21 15:55:43 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.14-rc3
  - A bug fix from Haiyang for vmbus CPU assignment
  - Reversion of a bogus patch that went into 5.14-rc1
----------------------------------------------------------------
Haiyang Zhang (1):
      Drivers: hv: vmbus: Fix duplicate CPU assignments within a device

Wei Liu (1):
      Revert "x86/hyperv: fix logical processor creation"

 arch/x86/kernel/cpu/mshyperv.c |  2 +-
 drivers/hv/channel_mgmt.c      | 96 ++++++++++++++++++++++++++++--------------
 2 files changed, 65 insertions(+), 33 deletions(-)
