Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519AC6D3B9E
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Apr 2023 03:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjDCB4Q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Sun, 2 Apr 2023 21:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjDCB4Q (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Sun, 2 Apr 2023 21:56:16 -0400
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE5B7299
        for <linux-hyperv@vger.kernel.org>; Sun,  2 Apr 2023 18:56:14 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id n10-20020a05600c4f8a00b003ee93d2c914so18470197wmq.2
        for <linux-hyperv@vger.kernel.org>; Sun, 02 Apr 2023 18:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680486973;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WAAaCKivN3aIEsmt6M1gXi1ghsiX3cSesaZT5Nsr3z0=;
        b=zfxfC6JYI6tAx0nVkc6xiG+aBf1CvQjlG135um46mVwcw8tuctD5Vpn8ti4cEMSyqt
         K9u5hPS4NV8mjuFJE7XjAgcZ/m1dUmioOXAK5MWknPuaFI59vx9V8txieYo9Cb5iE58z
         LFyKMyuEOswcOBRZZzPMSWzYIgsV/epLxhwT32yrLtRkY2Pa2SQXvB02SIctSgw1KLad
         HJ+N0jlf3D426B2l7fCg1W+Fg8GT+fPKwMH/FfaFi3VAkU4yerLHzQBKORo4Ho2EPqzX
         yJydra9mtJ6OQup50kfI6lhIva7nKPpt4JiJTwinFe+SDeAuoEGTTSll1xuDDhXetDrm
         Pn6w==
X-Gm-Message-State: AO0yUKVn3FmD03JMknXt9cvQ2CGp+ZfH1NwDE+zRv7Rn2Q2hZ1gWHIg/
        VSZdyE/sfC0/0u1effW2mWM=
X-Google-Smtp-Source: AK7set+VEMvL3yoYTlp9fVrHVL697QWRkP4GJTkP9C/PsZA4tKS+FXrM4Lyec0WbRySRcc74BSb5Rg==
X-Received: by 2002:a05:600c:2254:b0:3df:e41f:8396 with SMTP id a20-20020a05600c225400b003dfe41f8396mr24934985wmm.37.1680486973172;
        Sun, 02 Apr 2023 18:56:13 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id o39-20020a05600c512700b003edddae1068sm17940554wms.9.2023.04.02.18.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Apr 2023 18:56:12 -0700 (PDT)
Date:   Mon, 3 Apr 2023 01:55:37 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        kys@microsoft.com, haiyangz@microsoft.com, decui@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>
Subject: [GIT PULL] Hyper-V fixes for 6.3-rc6
Message-ID: <ZCoyGafhIVqHpekW@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:

  Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20230402

for you to fetch changes up to f8acb24aaf89fc46cd953229462ea8abe31b395f:

  x86/hyperv: Block root partition functionality in a Confidential VM (2023-03-17 10:57:35 +0000)

----------------------------------------------------------------
hyperv-fixes for 6.3-rc6
 - Fix a bug in channel allocation for VMbus (Mohammed Gamal)
 - Do not allow root partition functionality in CVM (Michael Kelley)
----------------------------------------------------------------
Michael Kelley (1):
      x86/hyperv: Block root partition functionality in a Confidential VM

Mohammed Gamal (1):
      Drivers: vmbus: Check for channel allocation before looking up relids

 arch/x86/kernel/cpu/mshyperv.c | 12 ++++++++----
 drivers/hv/connection.c        |  4 ++++
 2 files changed, 12 insertions(+), 4 deletions(-)
