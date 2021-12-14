Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A241474B87
	for <lists+linux-hyperv@lfdr.de>; Tue, 14 Dec 2021 20:08:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbhLNTIh (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 14 Dec 2021 14:08:37 -0500
Received: from mail-wm1-f46.google.com ([209.85.128.46]:42871 "EHLO
        mail-wm1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232149AbhLNTIh (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 14 Dec 2021 14:08:37 -0500
Received: by mail-wm1-f46.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso1544878wme.1;
        Tue, 14 Dec 2021 11:08:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=Q+SnTgHeOhxd9QlFHUExAaUf9EHnPJVK61QWmTyxHqU=;
        b=V/AhT9qW2n2Dl30IJz4n0rEIKVKnlFiAbffxLhaIlH1WhO7RcwIBRNHVhNHBDoNcc0
         SJf/G2JlONQTGiL1Lv+cste7BAJGpq2GWJ7SpS5DQeIRZyfK2WKjP/p+fFcwBxZj5LEq
         amCKmMHbRyg4n85hvwgxQXtKpvHxxsjBtJiK2zoQVIOFfiYW3Nm5mNttNQKG0lgvwKq4
         jdW/YNUT9szjJnkTonurTjB6TCmjw2pbjgTYwnfE88lbdczYddMqI3kWJd0cZNiUQdG6
         HeqGw7as7E8AYyLRdcOgje4c1RZiW0KvLpod4RCFzBjQR2ye35z6EnyIGN1/vCeqW6R0
         TEiA==
X-Gm-Message-State: AOAM532HfEf3snMiNSpw093RnBsRc3B78Jjjtcd48S8IzKGjGXQIkC+r
        PKKRuaQZVNhvIgNTw0J87Tw=
X-Google-Smtp-Source: ABdhPJyRJQtMFbxbI28lZc+ybdfr4Llm0LQz2/J7lJb2XZsPO7ubhn3abhgW79+5QEv1Yqct6tILxA==
X-Received: by 2002:a7b:cf10:: with SMTP id l16mr1136400wmg.17.1639508915786;
        Tue, 14 Dec 2021 11:08:35 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id ay21sm3107963wmb.7.2021.12.14.11.08.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 11:08:35 -0800 (PST)
Date:   Tue, 14 Dec 2021 19:08:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        kys@microsoft.com, sthemmin@microsoft.com, haiyangz@microsoft.com,
        decui@microsoft.com, Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V fixes for 5.16-rc6
Message-ID: <20211214190833.a4cnzbygiph3ydl2@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit f3e613e72f66226b3bea1046c1b864f67a3000a4:

  x86/hyperv: Move required MSRs check to initial platform probing (2021-11-15 12:37:08 +0000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20211214

for you to fetch changes up to 1dc2f2b81a6a9895da59f3915760f6c0c3074492:

  hv: utils: add PTP_1588_CLOCK to Kconfig to fix build (2021-11-28 21:22:35 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.16-rc6
 - Fix build (Randy Dunlap)
----------------------------------------------------------------
Randy Dunlap (1):
      hv: utils: add PTP_1588_CLOCK to Kconfig to fix build

 drivers/hv/Kconfig | 1 +
 1 file changed, 1 insertion(+)
