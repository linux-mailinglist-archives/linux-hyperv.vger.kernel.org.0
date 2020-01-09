Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3995135DA3
	for <lists+linux-hyperv@lfdr.de>; Thu,  9 Jan 2020 17:07:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbgAIQHS (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 9 Jan 2020 11:07:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:38698 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733124AbgAIQHP (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 9 Jan 2020 11:07:15 -0500
Received: by mail-wr1-f65.google.com with SMTP id y17so8001130wrh.5;
        Thu, 09 Jan 2020 08:07:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s8XaYpiTknCUGxhJs+u9aW8kr+hn4bCeVDWoTmPJYXI=;
        b=O5+7l3nPo+sBTvEtjt415SefwtLMdVPpkyzkRmDfkfYZtTKrG1Hg/PYtwLYDy/dzdd
         wBLshXJ1cVVcFyeihSCEcWroKIsb49DNS7pcmdvqIscbumCBc8Wr0zQQlrka6lpyh14K
         qQVcQEKNCNJSTDlwUuiviCSCL6gIA0WkZ5xgE0lqfBO1fRGSlsAIinnvMMPCzA2sekTJ
         nClNvZgmtl24UvxLnj313PCUIdCF5/eq+AelJz8dg8WpDguboISHuSLg8nnOLH1l6t0/
         l7HYHmz+dJ7jXcMcWNcP9bOyPIlLoOsq3gBf1PTXGdFePLCtaTSi1ezucApMdaoocOLi
         0teA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s8XaYpiTknCUGxhJs+u9aW8kr+hn4bCeVDWoTmPJYXI=;
        b=T4humhwLt3cm5TMOyvjF0PNsuKhPuBey+KK4AnPVM+cnMjXgObkMcGG76omzSf0vx2
         8Vl3vY3bUqdgSihLFRuGpoRSDws5uVX3K12lXVvqysNzTLDcSP1FlpcOEHtdwxgRzICn
         PqSOv4Z42GiTKzVlMqDWtqQHqpCxG7ZRsB22c1taCgah/h6ZGMxDtYKbOxxK1TcgYHCf
         6ZHVioMptcpJ34wupOj6nXv4ZvlBDIVozyQVstx1fTWLohqHGr/qAF5hGr1r//3KlIyS
         863lnB+Q0dN8eQg6IK9ylMTxzFTKiMNsm3NUWlRn5gs+Q502Q1wlZxHl0p54P9hE0gFR
         gFtw==
X-Gm-Message-State: APjAAAUUsl+bz6fdEi9ihnSyz1MiKUvZLK7iRi54dQiovxPEtgEAgoWu
        JtjSR3zWpZcgg502CFhzv11GBQZSBIZ9Jido
X-Google-Smtp-Source: APXvYqxGPjOI9IP9Y/FeROkOaOlVCaNiT7hdJ4Md3MVR9XqAazR40MtpEhUMGFtvyEyiJ+gXS5kXJg==
X-Received: by 2002:a5d:4a84:: with SMTP id o4mr11651297wrq.396.1578586032520;
        Thu, 09 Jan 2020 08:07:12 -0800 (PST)
Received: from andrea.access.network ([159.253.226.36])
        by smtp.gmail.com with ESMTPSA id d14sm8615867wru.9.2020.01.09.08.07.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 08:07:11 -0800 (PST)
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
        Dexuan Cui <decui@microsoft.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v2 0/2] clocksource/hyperv: Miscellaneous changes
Date:   Thu,  9 Jan 2020 17:06:48 +0100
Message-Id: <20200109160650.16150-1-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Provide some refactoring and adjustments to the Hyper-V clocksources
code.

Changes since v1 [1]:
  - Rebased on Daniel's repo/branch
  - Added Reviewed-by: tags

[1] https://lkml.kernel.org/r/20191210093054.32230-1-parri.andrea@gmail.com

Andrea Parri (2):
  clocksource/hyperv: Untangle stimers and timesync from clocksources
  clocksource/hyperv: Set TSC clocksource as default w/ InvariantTSC

 drivers/clocksource/hyperv_timer.c | 48 ++++++++++++++++++++----------
 drivers/hv/hv_util.c               |  8 ++---
 include/clocksource/hyperv_timer.h |  2 +-
 3 files changed, 38 insertions(+), 20 deletions(-)

-- 
2.24.0

