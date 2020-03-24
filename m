Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D885C1906EA
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Mar 2020 08:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727607AbgCXH5p (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 24 Mar 2020 03:57:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34866 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725923AbgCXH53 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 24 Mar 2020 03:57:29 -0400
Received: by mail-pf1-f196.google.com with SMTP id u68so8900936pfb.2;
        Tue, 24 Mar 2020 00:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=irBljOk0QGJugnxQ5NoCZPwwicJ4zDs3GnO11w4ORvU=;
        b=br2TskT81jlCGlhkMlcyUkXwfJ9+86FxwmIw3kWYiAoPf+WaTyYtOLzGwHo82lu0vU
         ZS0vfvkFrJwHxFg9eSK0gnxLGSzJMI4HfvYdA4KOLRVNRHNIJf/btU4N4zYWJJPEwVdo
         dvMXCMTkHzva+rO5PNA5ApOBlIzg6VRItPiywzt1qIx7HkR9P2t1RBAWyEtc70ERF+53
         bhw/YvLjZso1riMMAq/XvR0z2YRqzH7ja7Rfuh9OazCLw+HsMZYYFa10zq+SBG5jVmJA
         zhGvwqchsPvkr0wz2YRhDHty73M4rN0ATrbe02YBCnKlnrrh709mIYvbyeLxpzCnzxu6
         Utbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=irBljOk0QGJugnxQ5NoCZPwwicJ4zDs3GnO11w4ORvU=;
        b=l8oFQ2Wkfw+n69yIcTW54Vl0G7hE2D3BJ4OUxwKnOsru61/XlSMgWZWhEEWmuKnQVv
         P/3poxkIK4IfGvKeQ3s+lo5Mvl3XLmSQr0QQb3GhYGmeKG7ycdNR2YA7HYFIhlil+a66
         cUy/foa+Twtq4CkbPfx07MpAKvuI9AXYeKUAHBU320VHp4Hd4Rm6Vk0brSl1i1q544j8
         ehfGvewneWPPf7lieIAhTsnmZ8YEW75NdBhxFRC/oCQ5MlR75YMYauLXiiCouguWHrY6
         0EAxb2VOg5kVwUVV+IKgqgrrOcCe41rPQaSZmGqGhrX/5N8ZJP3FXlirFhzEr/x7zPYX
         zyTQ==
X-Gm-Message-State: ANhLgQ1fP+bzYRWxNAC15IfxkOc7B2g4ZifpSlw7abfBUB0dzDSs+udm
        3n1LJUgW4a9e3/eR5O8aTgw=
X-Google-Smtp-Source: ADFU+vslW5lXR6gN2jsy0EJxGIJIAnA6uHfaiA5mI/xhgDmAa7y64XzffE4scQVRaOFXvZhlBqiyfA==
X-Received: by 2002:a63:dd0a:: with SMTP id t10mr18825805pgg.50.1585036647270;
        Tue, 24 Mar 2020 00:57:27 -0700 (PDT)
Received: from localhost.corp.microsoft.com ([167.220.2.210])
        by smtp.googlemail.com with ESMTPSA id x71sm15452076pfd.129.2020.03.24.00.57.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Mar 2020 00:57:26 -0700 (PDT)
From:   ltykernel@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        liuwe@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, hpa@zytor.com, x86@kernel.org,
        michael.h.kelley@microsoft.com
Cc:     Tianyu Lan <Tianyu.Lan@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        vkuznets@redhat.com
Subject: [PATCH V3 0/6] x86/Hyper-V: Panic code path fixes
Date:   Tue, 24 Mar 2020 00:57:14 -0700
Message-Id: <20200324075720.9462-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

This patchset fixes some issues in the Hyper-V panic code path.
Patch 1 resolves issue that panic system still responses network
packets.
Patch 2-3,5-6 resolves crash enlightenment issues.
Patch 4 is to set crash_kexec_post_notifiers to true for Hyper-V
VM in order to report crash data or kmsg to host before running
kdump kernel.

Tianyu Lan (6):
  x86/Hyper-V: Unload vmbus channel in hv panic callback
  x86/Hyper-V: Free hv_panic_page when fail to register kmsg dump
  x86/Hyper-V: Trigger crash enlightenment only once during  system
    crash.
  x86/Hyper-V: Report crash register data or ksmg before  running crash
    kernel
  x86/Hyper-V: Report crash register data when sysctl_record_panic_msg
    is not set
  x86/Hyper-V: Report crash data in die() when panic_on_oops is set

 arch/x86/kernel/cpu/mshyperv.c | 10 +++++++
 drivers/hv/channel_mgmt.c      |  3 +++
 drivers/hv/vmbus_drv.c         | 61 +++++++++++++++++++++++++++++-------------
 3 files changed, 56 insertions(+), 18 deletions(-)

-- 
2.14.5

