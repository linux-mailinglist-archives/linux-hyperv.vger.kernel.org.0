Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC042B4C5D
	for <lists+linux-hyperv@lfdr.de>; Mon, 16 Nov 2020 18:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732537AbgKPRN5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 16 Nov 2020 12:13:57 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37248 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732359AbgKPRN5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 16 Nov 2020 12:13:57 -0500
Received: by mail-wm1-f67.google.com with SMTP id h21so3541983wmb.2;
        Mon, 16 Nov 2020 09:13:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=aLfhMOiTl1Lms5ArW/mqI+//S9qOeKPPPhV7GBg5++U=;
        b=gtKVxVvmGSt1C0I56+/FpHoXkGCv1/R/EeozwtTV9bpGy5R4RS3JePxYjmq9kELIuU
         EpognlTZQwf/LWLG/IbKAnqRdXHYMH+ZHNDVKDhaZOLN+bBWxMD3Pb6c817NPjXYNydG
         MU2Y1oPTsypwQ/CtBmhchrjqEn1rINIpKbO/DOM5NIGQMsrzbmakhOvezjD8QwxC6Dcz
         r1umUBz++QiwTBj7uW+i44k2tuxu17jhmMrd5JpRSXTftTgP9/DXtvQo5enMJw7HmIa0
         YVLW/69zTMfEn2IgsgrJ2mRHkU01yw2mNNP7VNsMyq1RWROVzT5Q9zEPjeSVLqGU89Mx
         R+zA==
X-Gm-Message-State: AOAM532PUg1UUuww7P1K0fdN2z+yV+Polz3sKsH17qGYHXnNOLWnljQq
        Zh8S6SqpKJOmYgrMDsX8SMo=
X-Google-Smtp-Source: ABdhPJzXXgY5r+CFSRiPlfSMKqAzCzlv0DjSBEkEYtcDHooQ/7zpvhHVy2dx0y7lAkmUto17qHSYHQ==
X-Received: by 2002:a1c:6a11:: with SMTP id f17mr16158766wmc.24.1605546835542;
        Mon, 16 Nov 2020 09:13:55 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z19sm20034948wmk.12.2020.11.16.09.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2020 09:13:54 -0800 (PST)
Date:   Mon, 16 Nov 2020 17:13:53 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Hyper-V fixes for 5.10-rc5
Message-ID: <20201116171353.ebq6iwpe4cdp5j2a@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

Please pull the following changes since commit dbf563eee0b8cc056744514d91c5ffc2fa6c0982:

  x86/hyperv: Clarify comment on x2apic mode (2020-10-26 16:28:06 +0000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

for you to fetch changes up to 92e4dc8b05663d6539b1b8375f3b1cf7b204cfe9:

  Drivers: hv: vmbus: Allow cleanup of VMBUS_CONNECT_CPU if disconnected (2020-11-11 10:58:09 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.10-rc5
  - One patch from Chris to fix kexec on Hyper-V
----------------------------------------------------------------
Chris Co (1):
      Drivers: hv: vmbus: Allow cleanup of VMBUS_CONNECT_CPU if disconnected

 drivers/hv/hv.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
