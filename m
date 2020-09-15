Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 090D726A553
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Sep 2020 14:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgIOMel (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 15 Sep 2020 08:34:41 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:36026 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbgIOLqW (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 15 Sep 2020 07:46:22 -0400
Received: by mail-wm1-f68.google.com with SMTP id z9so3134715wmk.1;
        Tue, 15 Sep 2020 04:45:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=cjiBUhwXZk/V7w+hbRQc3+HINg0WkRcBhDhYopfJfBw=;
        b=Q55CffxSulb+lQbIXPIaJBjM9UenhHMt9F+X5vx8xYLEnX6M4iCvoOEZu0xgiFetVs
         glTrBXaQFPAyWmBjbrwJAimNgDPTx5ONCM3ARc4cLb8H2PASdHqCW+DhlaJfQGuHvb8c
         vAUTTCv90XZsgiB7o4n1fJOq6dMl6m/aG5tNoIfLQ801MD2CQDrFrOJ7vj7cm0UvFo9O
         UhFE5s8FCayQE0C9yniv0rGqv3pYlQqn6eRY3xZgUaF/QW/hlI+Y53aDKvrhK0aSTNDZ
         uZ8E0FXUlKSoxDXx/WL09bOa4p5YvNebVUgWeb8B0XIl/NwEbl+CNJTHwhbYhCwdu0f1
         nO7g==
X-Gm-Message-State: AOAM532JS81VF1fq52WznJv7k7NUegqJOyIg5B00EaTEYMcSJM/sPRMO
        DzXlNNdvJgwkYzYjErG4AhMHezUiCjw=
X-Google-Smtp-Source: ABdhPJzppTWi5yEHalB+rNJMPVioAq9SccBMvdYsdX8FNTLGzo/GrS/HIHUkNFmTeqRx8Q+0/RbkgQ==
X-Received: by 2002:a1c:6a14:: with SMTP id f20mr4181957wmc.81.1600170299495;
        Tue, 15 Sep 2020 04:44:59 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id b18sm26970403wrn.21.2020.09.15.04.44.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2020 04:44:59 -0700 (PDT)
Date:   Tue, 15 Sep 2020 11:44:57 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Hyper-V fixes for 5.9-rc6
Message-ID: <20200915114457.tozhtbxojblcnyow@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus

Please pull the following changes since commit b46b4a8a57c377b72a98c7930a9f6969d2d4784e:

  hv_utils: drain the timesync packets on onchannelcallback (2020-08-24 14:49:04 +0000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

for you to fetch changes up to 911e1987efc8f3e6445955fbae7f54b428b92bd3:

  Drivers: hv: vmbus: Add timeout to vmbus_wait_for_unload (2020-09-14 11:42:33 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.9-rc6

  - Two patches from Michael and Dexuan to fix vmbus hanging issues

----------------------------------------------------------------
Dexuan Cui (1):
      Drivers: hv: vmbus: hibernation: do not hang forever in vmbus_bus_resume()

Michael Kelley (1):
      Drivers: hv: vmbus: Add timeout to vmbus_wait_for_unload

 drivers/hv/channel_mgmt.c | 7 +++++--
 drivers/hv/vmbus_drv.c    | 9 +++++++--
 2 files changed, 12 insertions(+), 4 deletions(-)
