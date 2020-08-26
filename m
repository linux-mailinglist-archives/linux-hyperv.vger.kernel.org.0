Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42ED3253017
	for <lists+linux-hyperv@lfdr.de>; Wed, 26 Aug 2020 15:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730217AbgHZNlU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 26 Aug 2020 09:41:20 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:38652 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730239AbgHZNlP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 26 Aug 2020 09:41:15 -0400
Received: by mail-wm1-f68.google.com with SMTP id t14so1815639wmi.3;
        Wed, 26 Aug 2020 06:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=hbjlEvf8VmuZTXjhDuWXD81xvM/O9GqjsKWPZOVtdlg=;
        b=C7RzSM6gNsQ47qe7SeKplNZ1xq9T/blcVYZRDdilEdwfm1DH0BHL0p12ORkO08rdZD
         Fod1gVvvoj96hT6raLWX+t7m1subMtyW2AoRXuo3gZn0y09jhcNSK83+eloDwdP1zYuC
         AEf1FIKmUUnVxZpRoTxUN8Ev44ruD7I+5zUAEZTJ2pFTr7PGZh6Uzx7YRyLN/wjuufgQ
         qQzW1DkBl3OOGm/6tUEdB2E6ZXRkYoM+6O2mUJvj8WqLu7b6c4cQrZ20KfdALp7SQx6G
         9dlS/pzIHSuzctnorxKvcK5SZElBO9HGNq5yMCaUI4Ob8qmnQESw+NH+doEKEc37nMrF
         7zaQ==
X-Gm-Message-State: AOAM532LNAcdBywJ4OwNPIjVngRutHpxcnsJgff8TZ/vRV79VLbTeWzH
        dYTtz4M+SdFQFwie3YfF32CVWcZqJJ4=
X-Google-Smtp-Source: ABdhPJyRhHlxBLwKa7vAJR4RUydj0Jp3V2FaEuU7EE3n5PtxkKZ2l+CAaSKlRW9uTw7OMcuHhW19Bw==
X-Received: by 2002:a1c:ed15:: with SMTP id l21mr7233861wmh.56.1598449273629;
        Wed, 26 Aug 2020 06:41:13 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id c10sm5752188wrn.24.2020.08.26.06.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2020 06:41:13 -0700 (PDT)
Date:   Wed, 26 Aug 2020 13:41:11 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Hyper-V fixes for 5.9-rc3
Message-ID: <20200826134111.465ose3oyoyx6h7b@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus

Please pull the following changes since commit b9d8cf2eb3ceecdee3434b87763492aee9e28845:

  x86/hyperv: Make hv_setup_sched_clock inline (2020-08-11 10:41:15 +0000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

for you to fetch changes up to b46b4a8a57c377b72a98c7930a9f6969d2d4784e:

  hv_utils: drain the timesync packets on onchannelcallback (2020-08-24 14:49:04 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.9-rc3
  - Two patches from Vineeth to improve Hyper-V timesync facility

----------------------------------------------------------------
Vineeth Pillai (2):
      hv_utils: return error if host timesysnc update is stale
      hv_utils: drain the timesync packets on onchannelcallback

 drivers/hv/hv_util.c | 65 +++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 51 insertions(+), 14 deletions(-)
