Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 442ED3530ED
	for <lists+linux-hyperv@lfdr.de>; Fri,  2 Apr 2021 23:55:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhDBVzj (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 2 Apr 2021 17:55:39 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:46056 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbhDBVzj (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 2 Apr 2021 17:55:39 -0400
Received: by mail-wr1-f54.google.com with SMTP id j9so5714161wrx.12;
        Fri, 02 Apr 2021 14:55:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qtj+FVbg/e9bVo/D1F6NgFjUb3C3ANtmd+GZLfq6gPQ=;
        b=owAuOhN8qG2T4Y8uBk47zyvLoyNSJcNXQzvRvu/ykPSeQ75YQv7u8VIAMhNqBUzeu6
         7BoSQBRenuEPLpMZ5fcfkX4khUe9NiSiu6ZFW3gmeY8EDalISceT/ydFx+f68pQdZt5X
         lM5e69e4ZQYwPCNigfl4xWNbwjWxWlXQEitpv8s86YPEIEhQYS5m8ku7WD7stYLYpAUr
         bebH8WJ19jXOER9Vmp+osVPjAJwDMp5WmFkSid+q33oGT4oTxCW0deC+luHJ+xw4Wmdi
         5MkO2K/8QRlDGkCB6Cd2aKHa9N6cWp5HeDjNo0ScCjxttDgqcUSUYOWnPSnByVFW+YKA
         LbeQ==
X-Gm-Message-State: AOAM5317nomIE8qx8pt/XEXArQ5w9b+LZdDR+phTF+P8YbWsodSrarYV
        B7gjqoxY56pRJtMHrj9VZ22ZG0UEguA=
X-Google-Smtp-Source: ABdhPJxKm+jXlAQH86NTLDpmYTuigs/vfMAGM00/neX7QoEBH7IH55JI6P9waaep7rn3zcOizVKrYw==
X-Received: by 2002:a5d:6443:: with SMTP id d3mr17299226wrw.292.1617400535585;
        Fri, 02 Apr 2021 14:55:35 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id j123sm13661361wmb.1.2021.04.02.14.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Apr 2021 14:55:35 -0700 (PDT)
Date:   Fri, 2 Apr 2021 21:55:33 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Wei Liu <wei.liu@kernel.org>, kys@microsoft.com,
        sthemmin@microsoft.com, haiyangz@microsoft.com,
        Michael Kelley <mikelley@microsoft.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: [GIT PULL] Hyper-V fixes for 5.12-rc6
Message-ID: <20210402215533.56z6kk56s6wxannw@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Hi Linus,

The following changes since commit fe07bfda2fb9cdef8a4d4008a409bb02f35f1bd8:

  Linux 5.12-rc1 (2021-02-28 16:05:19 -0800)

are available in the Git repository at:

  ssh://git@gitolite.kernel.org/pub/scm/linux/kernel/git/hyperv/linux.git tags/hyperv-fixes-signed-20210402

for you to fetch changes up to 37df9f3fedb6aeaff5564145e8162aab912c9284:

  video: hyperv_fb: Fix a double free in hvfb_probe (2021-03-25 13:31:20 +0000)

----------------------------------------------------------------
hyperv-fixes for 5.12-rc6
  - One patch from Lu Yunlong to fix a double free in hvfb_probe

----------------------------------------------------------------
Lv Yunlong (1):
      video: hyperv_fb: Fix a double free in hvfb_probe

 drivers/video/fbdev/hyperv_fb.c | 3 ---
 1 file changed, 3 deletions(-)
