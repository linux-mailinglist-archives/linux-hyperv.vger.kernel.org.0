Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A73E1DEE11
	for <lists+linux-hyperv@lfdr.de>; Fri, 22 May 2020 19:19:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730780AbgEVRTd (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 22 May 2020 13:19:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730471AbgEVRTd (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 22 May 2020 13:19:33 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30690C061A0E;
        Fri, 22 May 2020 10:19:33 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id x20so13815521ejb.11;
        Fri, 22 May 2020 10:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5DFL46w0De6RV+vzshdpvwcQwsH91Oira8M1QMNZD+k=;
        b=TXTf9VkjVPZ7EJ79Zzhx6A7rv42PABOwEaL9suY5dzHkDPuGOzoMzc2kG7uEXT70Y3
         QOs7JeF1gyDFj5GKFLwFracJgnUEa8JFhfjfiMlf2snitIr4ryBMjo4JKNP/KuGJG66x
         0htcrmw+HhAF8NFh1nh+aeRtStk6jS6kPEElgi2uFrMoo5o+Bm241jWu9SSB2uxao5Gf
         TIaKN6n4TSNMBPB+Hj9R19XqjS1cGKq72pvEOvzotofk+6rUzC1Mk79SYyOF9wWwQmcx
         jWhYLwI5SmpKLH3qFgk9kHFXtRRa8ve4TDsEiRcEMXcoMF2UZDl3hwjgmukbckL7hdVX
         vxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5DFL46w0De6RV+vzshdpvwcQwsH91Oira8M1QMNZD+k=;
        b=nUGN41ePQIYJDEg5/3kTLzWIo/Hi+auxKYCLkQxdPHiDIRW704X7FrXuLeR5KaSTm2
         OKa8zBZ/i0tLpxoJrctY1Q1i4wrFaZ/jWrZ1KhLSKLSVmy0fQ3SbJIgBUEWkYDlqV2xz
         lMI1QaCjfghTf6Upv/P/Zf1K/wMN5jyo5eiKzfGRB63pl4jl7NofmE5ZDW0n9xoMiYkr
         ZyHWTIpk+M0kXIsIW7Ztdqfbs72ckL2ocirM3wIynXVYLUsTF3NS+F9063C4gkOXRxLu
         3gsjf0PcsIkjQwRwUgaR3xVC4s0Ww6T9RgCkV3FuRHIPHEmzvAYjynNtCMft+yQ5R8Hm
         HNRA==
X-Gm-Message-State: AOAM5339TfOlA/QWE1QBl7NI8IMAwTLRKS+sn+cZIaEpJIIL4x7JM9I6
        HX6tSxmGvwOvlyuGbj+g+qJo8U4lN6Q/HEBF
X-Google-Smtp-Source: ABdhPJya+geTz1otm+oIm2pTnzBGxzeqISILM5r1CvHgDLsmfvdP2ELu50+oAPNGD8hc62zlqI16FA==
X-Received: by 2002:a17:906:4009:: with SMTP id v9mr8728190ejj.63.1590167971452;
        Fri, 22 May 2020 10:19:31 -0700 (PDT)
Received: from localhost.localdomain (ip-62-245-103-65.net.upcbroadband.cz. [62.245.103.65])
        by smtp.gmail.com with ESMTPSA id ay6sm7483094edb.29.2020.05.22.10.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 10:19:31 -0700 (PDT)
From:   "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
To:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        "Andrea Parri (Microsoft)" <parri.andrea@gmail.com>
Subject: [PATCH] VMBus channel interrupts reassignment - Fixes
Date:   Fri, 22 May 2020 19:18:59 +0200
Message-Id: <20200522171901.204127-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Two fixes on top of the channel interrupts reassignment series, both
addressing race conditions between the initialization of the target
CPUs and the CPU hot removal path.   (Fixes: tags refer to commit IDs
from the hyperv tree and should be considered as placeholders; please
let me know how you'd prefer to handle these...)

Thanks,
  Andrea

Andrea Parri (Microsoft) (2):
  Drivers: hv: vmbus: Resolve race between init_vp_index() and CPU
    hotplug
  Drivers: hv: vmbus: Resolve more races involving init_vp_index()

 drivers/hv/channel_mgmt.c | 66 +++++++++++++++++++--------------------
 drivers/hv/hyperv_vmbus.h | 48 ++++++++++++++++++++++++++++
 drivers/hv/vmbus_drv.c    | 19 +++++++----
 include/linux/hyperv.h    |  7 +++++
 4 files changed, 101 insertions(+), 39 deletions(-)

-- 
2.25.1

