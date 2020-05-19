Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721301D93DF
	for <lists+linux-hyperv@lfdr.de>; Tue, 19 May 2020 11:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726121AbgESJ5t (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 19 May 2020 05:57:49 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42922 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbgESJ5s (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 19 May 2020 05:57:48 -0400
Received: by mail-wr1-f66.google.com with SMTP id s8so15158243wrt.9;
        Tue, 19 May 2020 02:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=XcZdnNbjUxNJonRYWUt2OpSPCEqV9lbSIqWq3MeRpC8=;
        b=ad0WOgv2GpkpFAut4Wlc/UBJYKQChn5h4c0HzZI3Jr9RPISX/qx11JWibMKhIsPleg
         lRFqGn6jhvm7BFsVzcgpoBLSQGjIjXyT2WjxFzKrYZTA/UszlmMuAVlJTciou1vXIb5i
         7gXS8WUGUZ0RBaxbZ035goJMNA5GlgUamUQpNowZKJ30pqm3R1Nm930TAgEEB5aa46ne
         Ky2waNhLSJN1ZhygD7ZPcPykmAFF0RCga/hZqkxj+X1LNbTlxlLJbiqHIEu2RUlTcCe+
         qb/UZkHQfjypxRF6AIHDnlIybBhKLKCTJku9nWLO7Q6eiySFQaN5BmNbM/+RhCJilna9
         ENjA==
X-Gm-Message-State: AOAM532hRXhr8ByoOKyde4frs3M5N8Agcko3Z1rXl7u0wdKu+uXbfGQg
        gpPp7ABeNxRS7/0uKg7Ewr4=
X-Google-Smtp-Source: ABdhPJxdkmriqKduIARZx7na0VRznmMviFKMxw3uOQmPsmPUjCCCkW3NHtSJOCqjZY0ZG5sAAGfmRg==
X-Received: by 2002:a5d:4747:: with SMTP id o7mr24359081wrs.11.1589882266918;
        Tue, 19 May 2020 02:57:46 -0700 (PDT)
Received: from liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id v22sm3172280wml.21.2020.05.19.02.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 02:57:46 -0700 (PDT)
Date:   Tue, 19 May 2020 09:57:44 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Hyper-V fixes for v5.7-rc7
Message-ID: <20200519095744.kxco5eoo6462tto2@liuwe-devbox-debian-v2.j3c5onc20sse1dnehy4noqpfcg.zx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20180716
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus

Please pull the following changes since commit f081bbb3fd03f949bcdc5aed95a827d7c65e0f30:

  hyper-v: Remove internal types from UAPI header (2020-04-22 21:10:05 +0100)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed

for you to fetch changes up to 38dce4195f0daefb566279fd9fd51e1fbd62ae1b:

  x86/hyperv: Properly suspend/resume reenlightenment notifications (2020-05-13 15:02:03 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.7-rc6
  - One patch from Vitaly to fix reenlightenment notifications

----------------------------------------------------------------
Vitaly Kuznetsov (1):
      x86/hyperv: Properly suspend/resume reenlightenment notifications

 arch/x86/hyperv/hv_init.c | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)
