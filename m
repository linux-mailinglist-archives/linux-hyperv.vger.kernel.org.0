Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99FD16684A
	for <lists+linux-hyperv@lfdr.de>; Fri, 12 Jul 2019 10:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726074AbfGLILU (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 12 Jul 2019 04:11:20 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39800 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbfGLILS (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 12 Jul 2019 04:11:18 -0400
Received: by mail-pl1-f194.google.com with SMTP id b7so4404078pls.6;
        Fri, 12 Jul 2019 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=M4aojHkTRgr5KR1nVQ76cFFCD98YRnC1NfZVjSYBlNk=;
        b=Ni8XL8v212tRdbisi8LSUtOWTiNTMLlyiFa83bbMOuJLAfScdz6uoEshtt9ucTSXaV
         QVG8DTLD6aSOIkrpeguq0w4ULqxvNyqIPV30grG9AuXzVM8yOAK3uFQGyPsp/M3lQS7P
         2AB8pwR8CodK83TeA0sVFmoU10cKemmfVXlVJ3xyl8Q8gzXJFr9+ZRLSIBRwisyhp7lp
         muZ5HVwQK6cHAjFbW4QvXVaxWrF2ATrD5en08vlbPaMfu9eEF++RGA/a5sLSYi68YAka
         dUIYf/bvKT73ccwp5vLE51SOnJhsEoKN3vAzpc0I/ZG/W/oukZlhZ55QYYWgcBSY2k/X
         fb2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=M4aojHkTRgr5KR1nVQ76cFFCD98YRnC1NfZVjSYBlNk=;
        b=JNsubdqipXD4Tktvd07zCaJeMBdoz9sZZhAfi/fdYMxz19O9A6XGpApMwyZRMkJdr1
         TK50KQcMAtp3bzku9ErkN9ZXX/czVPE8/zE3E29pmKj4uvZv1NpUU3OaXbfGDJI2vgCB
         P7aK1BgBgx0Aj4+srPov9uHM3a/G2mfbab20f5E2Ozf4nZSZxCrbLT4L78VAMWEAmz1S
         kyfeaygMXpsDpB+YxHyG5bAoRDT1F490cfPxKWqjcPA6MQ0iPiPYgPmd5wJTqHUGijA3
         5Ei0JAIPAMK41U1yDFiAZOPLbmyJ2gypUkSGC7IscHNK/Y2PWXaPVCsp7MP7F+fu//hQ
         mzag==
X-Gm-Message-State: APjAAAUxXFyDikkeNsE2Zp/jgT/DMA1sw2QQ1DY/IRq7F24oV71MbtpT
        q7g1T+1fzW0shCKctJSTQRRuzZMo3cZpEA==
X-Google-Smtp-Source: APXvYqyAS5YP5nGv7DRKpFwhIeSDumf77QEARmpZNer0pmdleI0B9QtricOEDvDCvBGyEtTM9luRkA==
X-Received: by 2002:a17:902:aa03:: with SMTP id be3mr9842898plb.240.1562919077770;
        Fri, 12 Jul 2019 01:11:17 -0700 (PDT)
Received: from maya190711 ([52.250.118.122])
        by smtp.gmail.com with ESMTPSA id t2sm7207474pgo.61.2019.07.12.01.11.17
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Fri, 12 Jul 2019 01:11:17 -0700 (PDT)
Date:   Fri, 12 Jul 2019 08:11:16 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] hv: Remove dependencies on guest page size
Message-ID: <cover.1562916939.git.m.maya.nakamura@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

The Linux guest page size and hypervisor page size concepts are
different, even though they happen to be the same value on x86. Hyper-V
code mixes up the two, so this patchset begins to address that by
creating and using a set of Hyper-V specific page definitions.

A major benefit of those new definitions is that they support non-x86
architectures, such as ARM64, that use different page sizes. On ARM64,
the guest page size may not be 4096, and Hyper-V always runs with a page
size of 4096.

In this patchset, the first two patches lay the foundation for the
others, creating definitions and preparing for allocation of memory with
the size and alignment that Hyper-V expects as a page. Patch 3 applies
the page size definition where the guest VM and Hyper-V communicate, and
where the code intends to use the Hyper-V page size. The last two
patches set the ring buffer size to a fixed value, removing the
dependency on the guest page size.

This is the initial set of changes to the Hyper-V code, and future
patches will make additional changes using the same foundation, for
example, replace __vmalloc() and related functions when Hyper-V pages
are intended.

Changes in v4 (all apply to patch 2 only):
- Remove file name from the subject.
- Include prototypes of two new functions.
- Add another Link tag.

Changes in v3:
- Simplify expression for BUILD_BUG_ON() in patch 2.
- Add Link and Reviewed-by tags.

Change in v2:
- Replace patch 2 with a new one.

Maya Nakamura (5):
  x86: hv: hyperv-tlfs.h: Create and use Hyper-V page definitions
  x86: hv: Add functions to allocate/deallocate page for Hyper-V
  hv: vmbus: Replace page definition with Hyper-V specific one
  HID: hv: Remove dependencies on PAGE_SIZE for ring buffer
  Input: hv: Remove dependencies on PAGE_SIZE for ring buffer

 arch/x86/hyperv/hv_init.c             | 14 ++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h    | 12 +++++++++++-
 arch/x86/include/asm/mshyperv.h       |  5 ++++-
 drivers/hid/hid-hyperv.c              |  4 ++--
 drivers/hv/hyperv_vmbus.h             |  8 ++++----
 drivers/input/serio/hyperv-keyboard.c |  4 ++--
 6 files changed, 37 insertions(+), 10 deletions(-)

-- 
2.17.1

