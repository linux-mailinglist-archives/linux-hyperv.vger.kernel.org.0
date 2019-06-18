Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45BED499E8
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Jun 2019 09:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726330AbfFRHJc (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 18 Jun 2019 03:09:32 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46819 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725919AbfFRHJb (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 18 Jun 2019 03:09:31 -0400
Received: by mail-oi1-f195.google.com with SMTP id 65so8252992oid.13;
        Tue, 18 Jun 2019 00:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=lrt8d9CAxmtJXKTskrcOzMVi/9alFFJL9btIk5KPwBA=;
        b=BXa+wzozUTJ40dhrLI0q0wNeWpg9JApCN+gkavRZH8mOwWBcce94Z7D0SHgg+4AnE0
         zy9UoviQcsutrd1T+TOmQ6fDtjqmQ1xd7pLmVGFZsA+g4krzBMG94UXcfGsmW6ZXfFMR
         /jt9ajgFjFo1nUwI89g2pCqcHTUY/z9hmjBE/xMSLCbD1Ut0oP3S8niXiJi4vOvzt4iN
         c4dJSuYnn7ZJ4W9Folaow9kCujidWDQ0kmg91qp7xUB6VoG1lvCdag07H8RYdUWPPTY0
         cO5W3QFdCcJqDogCmUoh3wGNzAZicDvr8Ci/pL6t1D8ua+cZ8ouA3jyInReaKHePQmVa
         mG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=lrt8d9CAxmtJXKTskrcOzMVi/9alFFJL9btIk5KPwBA=;
        b=drJt2U5egWwPtsBGWzdE8ryanRzk91DCb+U7QqYnPpwqBEAVzi7kH8D5yYqUIqFmEJ
         KOmhi4zxaExZzPFwvCuDmm5ZgmP75hCPpu00wgPYFw62FbNR+qrm1jsuRqCJzEvnG1gl
         PrszXFmFwEfYW1CMb1ccwlJnx9ryGRADHuEhoPZPrjW7XTvw8B+g7wgwBzjoOJ8jH6ki
         ggbvtGDCiAYao4ZTdSjt5cMBDGJndsCzwPUK1crI4GNXPcrHUsUivmn2gwXpd75VisXW
         5UT5r+V/Gek/8b4Tkwm8Um1IFMLd5Rx1J49QMqYxlue3M/k6IFdhbffQoDAEEJoa9mah
         SQ0Q==
X-Gm-Message-State: APjAAAVgfacdq4TqE3FFrICWE7ShxDZAcoQz7z3iKClU67dBu61luf6v
        qkZv+vjZnRHpfGtbEVWkownoMaP1itM=
X-Google-Smtp-Source: APXvYqxIM5BUHJqfcb6TtvdsBS/ZQiLqfMJq4RMBwCcxPckgeMNAvLcvsVtocQalhZYYt4sv5zi2rw==
X-Received: by 2002:a63:e70a:: with SMTP id b10mr1082577pgi.26.1560838152279;
        Mon, 17 Jun 2019 23:09:12 -0700 (PDT)
Received: from maya190131 ([13.66.160.195])
        by smtp.gmail.com with ESMTPSA id l20sm12505501pff.102.2019.06.17.23.09.11
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Mon, 17 Jun 2019 23:09:11 -0700 (PDT)
Date:   Tue, 18 Jun 2019 06:09:11 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/5] hv: Remove dependencies on guest page size
Message-ID: <cover.1560837096.git.m.maya.nakamura@gmail.com>
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
the guest page size may not be 4096, and Hyper-V always runs with a
page size of 4096.

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

Changes in v3:
- [PATCH v2 2/5] Simplify expression for BUILD_BUG_ON().
- Add Link and Reviewed-by tags.

Change in v2:
- [PATCH 2/5] Replace with a new patch.

Maya Nakamura (5):
  x86: hv: hyperv-tlfs.h: Create and use Hyper-V page definitions
  x86: hv: hv_init.c: Add functions to allocate/deallocate page for
    Hyper-V
  hv: vmbus: Replace page definition with Hyper-V specific one
  HID: hv: Remove dependencies on PAGE_SIZE for ring buffer
  Input: hv: Remove dependencies on PAGE_SIZE for ring buffer

 arch/x86/hyperv/hv_init.c             | 14 ++++++++++++++
 arch/x86/include/asm/hyperv-tlfs.h    | 12 +++++++++++-
 drivers/hid/hid-hyperv.c              |  4 ++--
 drivers/hv/hyperv_vmbus.h             |  8 ++++----
 drivers/input/serio/hyperv-keyboard.c |  4 ++--
 5 files changed, 33 insertions(+), 9 deletions(-)

-- 
2.17.1

