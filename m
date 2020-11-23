Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85F292C03C8
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Nov 2020 12:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgKWLB3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 23 Nov 2020 06:01:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:40504 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgKWLB3 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 23 Nov 2020 06:01:29 -0500
Received: by mail-wr1-f66.google.com with SMTP id m6so18127205wrg.7;
        Mon, 23 Nov 2020 03:01:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0qy2L1u963qQHTCpiSO9/NuKhM45RT7N67hbv22Yyus=;
        b=EYEt6kTGcOhx2Je0/ZTFDIaevVe1tGzLxRnygJtA4mJ7Ql8cCW/q8It+NrdHfXDcgo
         YQZCtg43syjEYa+Lf9VRLkpLvqdUgBUwGQUaK1Li4RXBz5IWZF0ffGaLqvaBM/te+WeL
         5UcREdOBpr/+BXkXzZBCKH88rQ+pChDT4hjVnJO41hxTpu1eXYPMYc40ocuQnqqgTaLH
         9eoYA0i+48LHmfw7PPU5rn0ozWoVhIb0DRuoSOYupJ2o9Or7dx7uh5plvDNiXts4IUOg
         dcOP6JJ5bynroJztVwW2u2rgh6m6MgnL9DyR6wOvWoJs7SZ23tJCDXWhEHKNtfwcQzM4
         22bg==
X-Gm-Message-State: AOAM531XjF7DW2I7XMkEjeA6X8cRdB0QPde/drJcpD3L4Iz/+2lgUgzi
        qUC/hvvptslHPhjDeAVAIJ1XExqSChQ=
X-Google-Smtp-Source: ABdhPJyU3IO7SXjYHrJlaT9/3BAH25fBPDqtR9Ybg1XI4bB1XyIXWSGNQNp+wWG3MYzeLUvbXl2cCw==
X-Received: by 2002:adf:f84e:: with SMTP id d14mr6428532wrq.390.1606129285845;
        Mon, 23 Nov 2020 03:01:25 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id m7sm14312679wmc.22.2020.11.23.03.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 03:01:25 -0800 (PST)
Date:   Mon, 23 Nov 2020 11:01:23 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Hyper-V fixes for 5.10-rc6
Message-ID: <20201123110123.yeaovck27pc2odiq@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

Please pull the following changes since commit 92e4dc8b05663d6539b1b8375f3b1cf7b204cfe9:

  Drivers: hv: vmbus: Allow cleanup of VMBUS_CONNECT_CPU if disconnected (2020-11-11 10:58:09 +0000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

for you to fetch changes up to 5f1251a48c17b54939d7477305e39679a565382c:

  video: hyperv_fb: Fix the cache type when mapping the VRAM (2020-11-20 12:24:14 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.10-rc6

  - One patch from Dexuan to fix VRAM cache type in Hyper-V framebuffer
    driver
----------------------------------------------------------------
Dexuan Cui (1):
      video: hyperv_fb: Fix the cache type when mapping the VRAM

 drivers/video/fbdev/hyperv_fb.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)
