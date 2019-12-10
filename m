Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67CE2118393
	for <lists+linux-hyperv@lfdr.de>; Tue, 10 Dec 2019 10:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727053AbfLJJb0 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 10 Dec 2019 04:31:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53712 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727007AbfLJJb0 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 10 Dec 2019 04:31:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id n9so2319681wmd.3;
        Tue, 10 Dec 2019 01:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9DZrOhSxmZrtCAd/3tbqJHs9aEowHU/izosPQ5cGbk=;
        b=BEgL4Kd+ydObViMuY3MaG2QmNzeEEAvj02GWKMVX+6EqBlZezgZ07zw8G6yqeM4oBn
         jXp/PvZCoC9AMNsGSnGnjEnrBJVBJXS7xNkPikou+MbzoLXXg/9bSVbn4JNlBIoGLqUW
         juGfdGXkd/o9P2Sn5c/aMfYeSruBd4ZJOu2mBCx7T2dRgv49N3jn9HNtuEwaxGzWyBhh
         C0EPDLVeNxrYkcWgELpgoabNVZacfSIAdvGS5WRN38n+HOrQ2m4dpJ81xRLRspGtFAJJ
         V0eTYKyKaH3Qn/nhs6pPrZMbdeDPWh81Z9JKsi1UU+GCeGG4t7FJ+Ny+iLInOy0fuY3g
         1KsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=x9DZrOhSxmZrtCAd/3tbqJHs9aEowHU/izosPQ5cGbk=;
        b=GZVRnKmv4XaaP99uITVqTrBnuvrNpa5cOsKkjureuyR+nfmCVGx2bHRk4tzMPxeicG
         vUscs/+fJICN913r4QQLBn7+bUTZ74JJs8D1DfBvvOXp2dNQz6ICQ50fl86xvVY8e8Z/
         OOjvH9Ka8B+XhasgrXIpgKr4228cXYmbn1BslOWhEplKPDZ4O4OFH4vVkms8FCk1Y5Q+
         OpFEFBGZowcf0zY/A0ku5CfXyLmpdi6aH1t/WyXL3oj2uFHS/H0/R+zQ691OpfPoH9Ru
         Kt0gYcjrp/Q6csT6yjO4fpSzhoHyB+xOx7KaUn2WL5BydsfetD1M7VVZECeq5tTDtgVk
         nI5w==
X-Gm-Message-State: APjAAAWv1p9ORYB/g+huNYTVCE7cDQ1JutiHFQdIIPQyz9eGZXtSrjVW
        KbnAPa7tCALUKTjfEb9gaHlmaY+TvrHhSAls
X-Google-Smtp-Source: APXvYqzfDGBIs3m0l03G86yVjS6f6fVilwgKpfB7uFjxONBLeOmqaicqJ3y5CGwXmUbUqcIosOMW6w==
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr3805484wmb.118.1575970283934;
        Tue, 10 Dec 2019 01:31:23 -0800 (PST)
Received: from localhost.localdomain (ip-213-220-200-127.net.upcbroadband.cz. [213.220.200.127])
        by smtp.gmail.com with ESMTPSA id n3sm2372611wmc.27.2019.12.10.01.31.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Dec 2019 01:31:23 -0800 (PST)
From:   Andrea Parri <parri.andrea@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org
Cc:     "K . Y . Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH 0/2] clocksource/hyperv: Miscellaneous changes
Date:   Tue, 10 Dec 2019 10:30:52 +0100
Message-Id: <20191210093054.32230-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Provide some refactoring and adjustments to the Hyper-V clocksources
code.  Applies to -rc1 plus Boqun's:

  https://lkml.kernel.org/r/20191126021723.4710-1-boqun.feng@gmail.com

Thanks,
  Andrea

Andrea Parri (2):
  clocksource/hyperv: Untangle stimers and timesync from clocksources
  clocksource/hyperv: Set TSC clocksource as default w/ InvariantTSC

 drivers/clocksource/hyperv_timer.c | 48 ++++++++++++++++++++----------
 drivers/hv/hv_util.c               |  8 ++---
 include/clocksource/hyperv_timer.h |  2 +-
 3 files changed, 38 insertions(+), 20 deletions(-)

-- 
2.24.0

