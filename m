Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3623B132730
	for <lists+linux-hyperv@lfdr.de>; Tue,  7 Jan 2020 14:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgAGNKC (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Tue, 7 Jan 2020 08:10:02 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:37812 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727814AbgAGNKC (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Tue, 7 Jan 2020 08:10:02 -0500
Received: by mail-pf1-f196.google.com with SMTP id p14so28581777pfn.4;
        Tue, 07 Jan 2020 05:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=MynZ1SAOGTU0nRDuQMo0BN+WB3hB2dVTwjekB0beWeg=;
        b=CAG+hGH+HLYjugqNRJ5nwUnqrtR/ShgD/WaMHtGal6Hb50pSfE7rapvmRZaszmVLWo
         3ZH4OQ/Ut7qHc+EjjkcYwV1Ot73EfLQp1U/gJ+5lVauptS9nG/3DT76/s39rwSk4dvP0
         YeRN1fUGDcZtsFVeBoZubap4Msg0wz2/6hYAvXcLY60WpEJvHTomJcFN3U5uisRSt0qk
         EXunpRffn2Uy6S774+MZlCLwGCVzVpAd4j60L0E/QrKtDjzcH1Wy0v72WDaEYLDrPTRk
         XwhxUnsPeJbCN6lN+XNkKxhJLHE9qN1ne/ZNx00g7FHqhPBI9gLNrqzsLnLTyBO7jaLX
         UoKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=MynZ1SAOGTU0nRDuQMo0BN+WB3hB2dVTwjekB0beWeg=;
        b=C5Qynd+DgZRO/cxId1IqADL64Kh4S/e/FlLLN+iGH7EVLeJlG5ecWYPSlYNJSnOgph
         EVeDWssXSVoK5pLBxnwohT7jZ21f56BcboriqfC8OszB4zOMY6umQ/KdZMW+8aaNs4m9
         NNd/Q5vdI6vlc++wZQzk5IJ0+BhamSS8UeBHJBckQy05ewEUXCViwOK+CfMnA93WxAWh
         A+OKjJF5qGz9fOoc6H9mihBVtnH0SKZmxmRPo/k+cIbqwmCNvanAFSFQU6r5MJp+BnJG
         wn5biplcaYuUmxUNb5BjpOYiyp6hWvcuecCwrPZbGLkdlMg52JuvmLCw779tEm5fbGmh
         Uhzw==
X-Gm-Message-State: APjAAAVVT8o7eqSu5YFOhrQHLa2fXZVtDCo5UfMCPeAEk4OXOcP6yAZT
        cLGibGAYUrN1dEgjYnt1ae8=
X-Google-Smtp-Source: APXvYqwQ4W0C7Jsq93dvxAKcJKEK9yPMyLQjdDmq1H/LycAYLDF051OolFCdns6C1W8REMVwtP8o+g==
X-Received: by 2002:a62:ac08:: with SMTP id v8mr116710991pfe.83.1578402601964;
        Tue, 07 Jan 2020 05:10:01 -0800 (PST)
Received: from localhost.corp.microsoft.com ([167.220.255.5])
        by smtp.googlemail.com with ESMTPSA id m71sm27522400pje.0.2020.01.07.05.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 07 Jan 2020 05:10:01 -0800 (PST)
From:   lantianyu1986@gmail.com
X-Google-Original-From: Tianyu.Lan@microsoft.com
To:     kys@microsoft.com, haiyangz@microsoft.com, sthemmin@microsoft.com,
        sashal@kernel.org, akpm@linux-foundation.org,
        dan.j.williams@intel.com, jgg@ziepe.ca,
        dave.hansen@linux.intel.com, richardw.yang@linux.intel.com,
        namit@vmware.com, Tianyu.Lan@microsoft.com, david@redhat.com,
        christophe.leroy@c-s.fr, michael.h.kelley@microsoft.com
Cc:     linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, vkuznets@redhat.com, eric.devolder@oracle.com
Subject: [RFC PATCH V2 00/10] x86/Hyper-V: Add Dynamic memory hot-remove function
Date:   Tue,  7 Jan 2020 21:09:40 +0800
Message-Id: <20200107130950.2983-1-Tianyu.Lan@microsoft.com>
X-Mailer: git-send-email 2.14.5
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

From: Tianyu Lan <Tianyu.Lan@microsoft.com>

Hyper-V provides dynamic memory hot add/remove function.
Memory hot-add has already enabled in Hyper-V balloon driver.
Now add memory hot-remove function.

This patchset is based on the David Hildenbrand's "virtio-mem:
paravirtualized memory" RFC V4 version and use new interface
offline_and_remove_memory().
https://lkml.org/lkml/2019/12/12/681

Change since V1:
	- Split patch into small patch for review.
	- Convert ha_lock from spin lock to mutex.
	- Add a common work to handle all mem hot plug and
	balloon msg
	- Use offline_and_remove_memory() to offline and remove
	memory.

Tianyu Lan (10):
  mm/resource: Move child to new resource when release mem region.
  mm: expose is_mem_section_removable() symbol
  x86/Hyper-V/Balloon: Replace hot-add and balloon up works with a
    common work
  x86/Hyper-V/Balloon: Convert spin lock ha_lock to mutex
  x86/Hyper-V/Balloon: Avoid releasing ha_lock when traverse
    ha_region_list
  x86/Hyper-V/Balloon: Enable mem hot-remove capability
  x86/Hyper-V/Balloon: Handle mem hot-remove request
  x86/Hyper-V/Balloon: Handle request with non-aligned page number
  x86/Hyper-V/Balloon: Hot add mem in the gaps of hot add region
  x86/Hyper-V: Workaround Hyper-V unballoon msg bug

 drivers/hv/hv_balloon.c | 754 ++++++++++++++++++++++++++++++++++++++++--------
 kernel/resource.c       |  38 ++-
 mm/memory_hotplug.c     |   1 +
 3 files changed, 673 insertions(+), 120 deletions(-)

-- 
2.14.5

