Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DA32A839A
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Nov 2020 17:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgKEQg1 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 5 Nov 2020 11:36:27 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:34761 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727851AbgKEQg1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 5 Nov 2020 11:36:27 -0500
Received: by mail-wm1-f67.google.com with SMTP id 23so1480178wmg.1;
        Thu, 05 Nov 2020 08:36:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=0MCExL8TskiJCP2VSdbtqMQPSQyKB5RAHMaaU1ri694=;
        b=sx+fiwruhfTcDDprjDwVnGW8zEvq6phu06ozC+yWUGJLNH6DMNVTKBMewHJsbRIAGN
         XmetE6p8KUANhbvEQqCvGbT13TL6fisdGHLIG1YRrgH6bDb8InjBpGN/3FEn0UEDvUyy
         apfXGjI+aJgQDihzo+Jo2MhWuNW08X8OzZcMoKn087LW16Gfbfuiy8ksgr1h2QNzvu5P
         dT0U9q2wqZ3GfKIwV7CljM+FWixzqOrA2owUmDpsWXObrJj3hRJrmyx2oTW5RFTIpIAa
         NrAUrxo8UtvSxipTk/LlF3i3fZdblsCJIJi99HSaoXfEJq7F+aPEchjZOguhNTipGB3M
         Po3w==
X-Gm-Message-State: AOAM531htlkf7Iukp2JTEDCKSCwPIVFdAC+YAB44WIw/7uVL4Y0AK+B0
        jQrALaOo5QSnJA1unKsv4ko=
X-Google-Smtp-Source: ABdhPJyEGeh32rqBr75J6AcmYa56z13YHA6rmZMYcOLFm7I7TZAm73f8L4l7T1LJoM2i/LOAySYE0Q==
X-Received: by 2002:a1c:9e12:: with SMTP id h18mr3595306wme.11.1604594185210;
        Thu, 05 Nov 2020 08:36:25 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id f17sm3199008wmf.41.2020.11.05.08.36.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2020 08:36:24 -0800 (PST)
Date:   Thu, 5 Nov 2020 16:36:22 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: [GIT PULL] Hyper-V fixes for 5.10-rc3
Message-ID: <20201105163622.dgcchoa47cetr5e6@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus

Please pull the following changes since commit bbf5c979011a099af5dc76498918ed7df445635b:

  Linux 5.9 (2020-10-11 14:15:50 -0700)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

for you to fetch changes up to dbf563eee0b8cc056744514d91c5ffc2fa6c0982:

  x86/hyperv: Clarify comment on x2apic mode (2020-10-26 16:28:06 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.10-rc3
  - One patch to clarify a comment from Michael.
  _ One patch to change pr_warn to pr_info from Olaf.
----------------------------------------------------------------
Michael Kelley (1):
      x86/hyperv: Clarify comment on x2apic mode

Olaf Hering (1):
      hv_balloon: disable warning when floor reached

 arch/x86/hyperv/hv_apic.c | 14 +++++++++-----
 drivers/hv/hv_balloon.c   |  2 +-
 2 files changed, 10 insertions(+), 6 deletions(-)
