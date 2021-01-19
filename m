Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF8682FBA93
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 Jan 2021 15:58:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391544AbhASOyA (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 Jan 2021 09:54:00 -0500
Received: from mail-wr1-f51.google.com ([209.85.221.51]:42269 "EHLO
        mail-wr1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389574AbhASLbb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 Jan 2021 06:31:31 -0500
Received: by mail-wr1-f51.google.com with SMTP id m4so19356270wrx.9;
        Tue, 19 Jan 2021 03:31:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=UhfaWmZsXLaTMQjB6+oOVMMKsehL/8ca0yWncg5/3jA=;
        b=RM/H9IZttvi3H33Q+iZjRy40MID+oTS3K4tPLh1GfYp82a8mAMhpPIxoriSk27kNup
         +ZckK3h1wWWPLvqP6iTQX7utdV/t//GFoOtGtsaXktJc9gzpWaRZcBSJltMTod08llFT
         3jwidtCt7+dyodXhYJEjQK++poSLb1Pf7r9eS1PCbI2c0R4fZuBfhsH/041v4a/3zS/I
         PysiKYe6P+fr9IGkGW0r3e8PURQnKjgIOfrNc9bIgmyT9rV3gW96yMRmo/XAVBtSiBa2
         PmkQTrrABvv4djo1RMYG5othcbJZRXPPfhvO/QbP9vl75PfS8wHUHoOp4G5HNnrkGIud
         f3vQ==
X-Gm-Message-State: AOAM532pIi3QmFVxFb2MRLjkt2NexpiI3aoV/4NTzxlpvnj+mVJS+WqW
        08rvSLiJVZHQNSooSYQ8qJtb1psfvME=
X-Google-Smtp-Source: ABdhPJxrOKni4Y6K6MGLHpA1iOon4Cbuoh6zaaZY2zXekxfmar9HgSq0aQDNj7p4uw/ecFO0guFXvw==
X-Received: by 2002:a5d:510f:: with SMTP id s15mr3864700wrt.21.1611055842269;
        Tue, 19 Jan 2021 03:30:42 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id l1sm36079237wrq.64.2021.01.19.03.30.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jan 2021 03:30:41 -0800 (PST)
Date:   Tue, 19 Jan 2021 11:30:40 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Hyper-V fixes for 5.11-rc5
Message-ID: <20210119113040.cy7x6hilvts56xan@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit ad0a6bad44758afa3b440c254a24999a0c7e35d5:

  x86/hyperv: check cpu mask after interrupt has been disabled (2021-01-06 11:03:16 +0000)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20210119

for you to fetch changes up to fff7b5e6ee63c5d20406a131b260c619cdd24fd1:

  x86/hyperv: Initialize clockevents after LAPIC is initialized (2021-01-17 15:20:50 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.11-rc5
  - One patch from Dexuan to fix clockevent initialization
----------------------------------------------------------------
Dexuan Cui (1):
      x86/hyperv: Initialize clockevents after LAPIC is initialized

 arch/x86/hyperv/hv_init.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)
