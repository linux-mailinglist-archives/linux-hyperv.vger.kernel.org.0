Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C58F42447B1
	for <lists+linux-hyperv@lfdr.de>; Fri, 14 Aug 2020 12:07:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726340AbgHNKHz (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 14 Aug 2020 06:07:55 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42103 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726012AbgHNKHy (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 14 Aug 2020 06:07:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id r4so7812580wrx.9;
        Fri, 14 Aug 2020 03:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=wWMPlpEysbeh+9oHwzYIhWRMCYIYWjE6IREABOeiArU=;
        b=IOuBBx9QXctSZrr9tpG9IiA4Pi8ucldh80uwBltf/xhz6TGhQaJ+PLL7Qy0He9YnD8
         aR2ZjqYZDzrgooFQA4RY2UIbnEOUi0pWO0I+2W4tkB1f6DQN37a0iXYDMt8LcPGTIpj9
         YpoiMi+HVN3J0z6hgagBuVXr7ZBMAJGFRsmRxGG/9DSFVZ5+HewxM/X3lQtJclYBAg6l
         Xd9/sOonQItlsjASDlJmn0tbf1VV7uUUZld5LFESvOcJq99dten3zRKRmV6aTpdPNxdo
         HklDJf5+6ABABFb0RacV1R5XDOqDfwvyLyTsggR2ecODdZsyhEjfiabKecTZneZY6wyU
         p2Gw==
X-Gm-Message-State: AOAM533wyoxKymoXab990mWeLPm6PdaMZRDfEUaAPzcOQCxyJ8ymXxz+
        5zpDM4ygzUYpiP6eFRw6f4E=
X-Google-Smtp-Source: ABdhPJzuvj4U+j94q6bEs1j/7eW78Dn92QuFxQgqHIMaRXZURUgroBp6V38HvMRvtwQGMqnHxLN3xQ==
X-Received: by 2002:a5d:54ce:: with SMTP id x14mr2041299wrv.52.1597399673055;
        Fri, 14 Aug 2020 03:07:53 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id g16sm13131133wrs.88.2020.08.14.03.07.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 03:07:52 -0700 (PDT)
Date:   Fri, 14 Aug 2020 10:07:51 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Hyper-V fixes for 5.9-rc1
Message-ID: <20200814100751.uirns3llugywet2x@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus

Please pull the following changes since commit bcf876870b95592b52519ed4aafcf9d95999bc9c:

  Linux 5.8 (2020-08-02 14:21:45 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

for you to fetch changes up to b9d8cf2eb3ceecdee3434b87763492aee9e28845:

  x86/hyperv: Make hv_setup_sched_clock inline (2020-08-11 10:41:15 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.9-rc
  - One patch to fix oops reporting on Hyper-V
  - One patch to make objtool happy

----------------------------------------------------------------
Michael Kelley (2):
      Drivers: hv: vmbus: Only notify Hyper-V for die events that are oops
      x86/hyperv: Make hv_setup_sched_clock inline

 arch/x86/include/asm/mshyperv.h | 12 ++++++++++++
 arch/x86/kernel/cpu/mshyperv.c  |  7 -------
 drivers/hv/vmbus_drv.c          |  4 ++++
 include/asm-generic/mshyperv.h  |  1 -
 4 files changed, 16 insertions(+), 8 deletions(-)
