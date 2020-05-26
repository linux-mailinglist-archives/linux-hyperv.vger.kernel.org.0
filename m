Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADCE41E32A9
	for <lists+linux-hyperv@lfdr.de>; Wed, 27 May 2020 00:32:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391046AbgEZWcx (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 26 May 2020 18:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389482AbgEZWcx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 26 May 2020 18:32:53 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2A6C061A0F;
        Tue, 26 May 2020 15:32:52 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g9so19006841edw.10;
        Tue, 26 May 2020 15:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJPtXY7rywWNMHGLMQRGuyruXoczA5GNP3pv72cf6Nk=;
        b=AlSxKeJrUW6CwmH4f/Si/KnQjzte+1B+vdvUIGo4XJ7jg1WnkhqljoJgVS25wo4qXt
         cxBNrADOX0sEm2TsE+qT4CXXCjpVdzy977lT8bzvvTNTMr5XgHXpUwi255tYUDGGEskf
         PSGRrPubitMmeWYYBjc+iSC0Fm5SMWo0urv3X9e12nqaBh90FLjMbmvr9YDxdyuj1fzD
         S2JpYBRhFNi3lfkvPpdlS355iR3cDnoMEZRkvqQcuoUvc/XcKDhKwAjMY5t3foOfgYLQ
         1gdk7d2QUv3JpOtACdlgpMFmz+KRyKaO/CouJaIQawOwDCFZuDmnF5iohEnvSdvcOsOi
         O6Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EJPtXY7rywWNMHGLMQRGuyruXoczA5GNP3pv72cf6Nk=;
        b=aF0xTi57FxWf+Hvfi8nTI5UOcAzpNZ0NUf7KKsSJPM6mMBbGaRPwsVQ/jc5yTnO8Ei
         PjYY0esm4KXEyqpNfUoALdOL7XxZw4XC+Oz3IzLxrusy4PHUw+GQ5TcSrGICg2gOMsDI
         yaF0nUSmEs8ZAUnPkQkQULeRnVDBh3r2Cg0RdvlB4fbVQD0sMLvBstufvfihLiX3Kz70
         c3Cea27cEk2BFkdkR+RmQcIC24nXgDrXj4wCRUFjqHJUGR6gvb9Tkl3dGNmgM09JGMjy
         5Iintu0GaY91/60b0m371nSD+LMw+2S+bWPPWhzkfjMRRpLtjSlx0VLfXaYDkoSctmtu
         Y1rA==
X-Gm-Message-State: AOAM533r6mxmeq5ekA3Bx09lN0jL9+FKtuJn7+MNnEq44WC1CiPOIs7a
        /UbDn/CoTPrp3obwq/JBh+Tt0pLUjC2qug==
X-Google-Smtp-Source: ABdhPJzjQukRhxFb1ZFRbVe0ygSWfCk4R3hqvyETUxX4IzkJtbL/oVoQ9g8bQOVXc2+L5X2P+YDZmg==
X-Received: by 2002:a05:6402:3cd:: with SMTP id t13mr22714780edw.285.1590532370925;
        Tue, 26 May 2020 15:32:50 -0700 (PDT)
Received: from localhost.localdomain (ip-62-245-103-65.net.upcbroadband.cz. [62.245.103.65])
        by smtp.gmail.com with ESMTPSA id cd17sm68288ejb.115.2020.05.26.15.32.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2020 15:32:50 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Nuno Das Neves <nuno.das@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [RFC PATCH 0/2] VMBus channel interrupts re-balancing
Date:   Wed, 27 May 2020 00:32:16 +0200
Message-Id: <20200526223218.184057-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The RFC introduces constructs to re-balance the channel interrupts at
CPU hotplug and at device hotplug operations, the latter being indeed
"closure/opening operations" to enable the re-balancing also in cases
when the device is just being closed/re-opened (as in "ethtool -L").

These changes originated from (and address /try to resolve) two known
limitations of the current interrupts-to-CPUs mapping scheme, that is,
(1) the "static" nature of this mapping scheme (that, e.g., can end up
preventing the hot removal of certain CPUs) and (2) the lack of global
visibility in such scheme (where devices/channels are mapped only "one
at a time"/as they are offered, with the end result that globally the
various interrupts are not always evenly spread across CPUs).

Andrea Parri (Microsoft) (2):
  Drivers: hv: vmbus: Re-balance channel interrupts across CPUs at CPU
    hotplug
  Drivers: hv: vmbus: Re-balance channel interrupts across CPUs at
    device hotplug

 drivers/hv/channel.c      |  81 ++++++++++++
 drivers/hv/channel_mgmt.c | 263 ++++++++++++++++++++++++++++++++++++++
 drivers/hv/connection.c   |  32 +++--
 drivers/hv/hv.c           |  62 +++++----
 drivers/hv/hyperv_vmbus.h |  78 +++++++++++
 drivers/hv/vmbus_drv.c    |  45 ++-----
 include/linux/hyperv.h    |  26 ++++
 kernel/cpu.c              |   1 +
 8 files changed, 523 insertions(+), 65 deletions(-)

-- 
2.25.1

