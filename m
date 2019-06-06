Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50CA536DFB
	for <lists+linux-hyperv@lfdr.de>; Thu,  6 Jun 2019 10:00:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726014AbfFFIAR (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 6 Jun 2019 04:00:17 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:39471 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbfFFIAR (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 6 Jun 2019 04:00:17 -0400
Received: by mail-pf1-f196.google.com with SMTP id j2so1004558pfe.6;
        Thu, 06 Jun 2019 01:00:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=7w8grN6Jf3tef1Ky0Ozizi80VlqAjKUQXZ1TYmC2bF4=;
        b=JQbewRilIfujSoeqXSHpPlbYwRe56mt2fMQsJOKRBH8xkCHJ4kRlfVsUY6m61IAu4g
         PBIUDG3SsSq7lKh/rujQvk/dCauQKEbkh+WuuMZyL44nSGdINuTpQFNXm4O3MKAoFXQ0
         jhZW44hgQzFwzf8GEqcb7rAxs+/5dfxyygTq8T7rPrNt6rGIKrKP3rHa9WOMLN6eftR/
         ItuA9eebbh2Xryy+ufP7figAzOHhb32zEB2CqKWi2N/TjQRinKktixLoGA/RXbVflyNd
         vy72WDCALPvpOsbHI1PuV3BL/1B5oTC/6AvErZu7TihFVrOcNmoYCP0i1i56LTPs2SHG
         BdYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=7w8grN6Jf3tef1Ky0Ozizi80VlqAjKUQXZ1TYmC2bF4=;
        b=jW/Zaq0z7GAMunhgGIqlY8qX1v58cOCI3JtcnMWELYc0HGNxzb6seVmW010Ur5tFq4
         e4ef4FvSnnC8iWHaXtfRUiSinZVv0BLgDuzOPlVJXAnTpv2ubMAbfDdHO3d09m7UsQbS
         BApVYqXfuRukEraKkjKyJtsS3LBVtGTFyIB6qZsOavJY+BxOfeStuS/9+PECyiuD7tyz
         RtpFGW14waA133vjMsCer8S4mfhke6gYiHW9MJkjO6j5u9NLDe41xGovZPr/+ynSCP7u
         cXyrKDUTvD0yhf6EFErHa5L6fBzFJIK9TKN69ViXgqMVE/VdK+gxDHzp3L6E5HQiIIQ2
         FcZQ==
X-Gm-Message-State: APjAAAU6b5KkhB0mTKf8KL3rw4OeEMcqYf2uw2M3Pwp1AUEujlYYjYW0
        DJGv7PR3cZWvaGXCkCIAAXwO+nmrSBQ=
X-Google-Smtp-Source: APXvYqzWmcIYGfLSXfIy7t9xgDhYYUo+JJ7EIW+npf701Gjeu5zeVQQyC6kUmrlNMFDzKDe+nqQHDQ==
X-Received: by 2002:a65:48c3:: with SMTP id o3mr2172233pgs.351.1559808016233;
        Thu, 06 Jun 2019 01:00:16 -0700 (PDT)
Received: from maya190131 ([13.66.160.195])
        by smtp.gmail.com with ESMTPSA id i5sm977527pjj.8.2019.06.06.01.00.15
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 06 Jun 2019 01:00:16 -0700 (PDT)
Date:   Thu, 6 Jun 2019 08:00:15 +0000
From:   Maya Nakamura <m.maya.nakamura@gmail.com>
To:     mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
        sthemmin@microsoft.com, sashal@kernel.org
Cc:     x86@kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/5] hv: Remove dependencies on guest page size
Message-ID: <cover.1559807514.git.m.maya.nakamura@gmail.com>
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

Changes in v2:
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

