Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87D52604337
	for <lists+linux-hyperv@lfdr.de>; Wed, 19 Oct 2022 13:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231857AbiJSLbt (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 19 Oct 2022 07:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231899AbiJSLbc (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 19 Oct 2022 07:31:32 -0400
Received: from relay.virtuozzo.com (relay.virtuozzo.com [130.117.225.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082FD1B866F
        for <linux-hyperv@vger.kernel.org>; Wed, 19 Oct 2022 04:06:31 -0700 (PDT)
Received: from dev011.ch-qa.sw.ru ([172.29.1.16])
        by relay.virtuozzo.com with esmtp (Exim 4.95)
        (envelope-from <alexander.atanasov@virtuozzo.com>)
        id 1ol5lV-00B8K8-SR;
        Wed, 19 Oct 2022 11:56:24 +0200
From:   Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     kernel@openvz.org,
        Alexander Atanasov <alexander.atanasov@virtuozzo.com>,
        kernel test robot <lkp@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Wei Liu <wei.liu@kernel.org>, Nadav Amit <namit@vmware.com>,
        pv-drivers@vmware.com, Jason Wang <jasowang@redhat.com>,
        virtualization@lists.linux-foundation.org,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: [RFC PATCH v5 0/8] Make balloon drivers' memory changes known to the rest of the kernel
Date:   Wed, 19 Oct 2022 12:56:12 +0300
Message-Id: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Currently balloon drivers (Virtio,XEN, HyperV, VMWare, ...)
inflate and deflate the guest memory size but there is no
way to know how much the memory size is changed by them.

Make it possible for the drivers to report the values to mm core.

Display reported InflatedTotal and InflatedFree in /proc/meminfo
and print these values on OOM and sysrq from show_mem().

The two values are the result of the two modes the drivers work
with using adjust_managed_page_count or without.

In earlier versions, there was a notifier for these changes
but after discussion - it is better to implement it in separate
patch series. Since it came out as larger work than initially expected.

Amount of inflated memory can be used:
 - totalram_pages() users working with drivers not using
    adjust_managed_page_count
 - si_meminfo(..) users can improve calculations
 - by userspace software that monitors memory pressure

Alexander Atanasov (8):
  mm: Make a place for a common balloon code
  mm: Enable balloon drivers to report inflated memory
  mm: Display inflated memory to users
  mm: Display inflated memory in logs
  drivers: virtio: balloon - report inflated memory
  drivers: vmware: balloon - report inflated memory
  drivers: hyperv: balloon - report inflated memory
  documentation: create a document about how balloon drivers operate

 Documentation/filesystems/proc.rst            |   6 +
 Documentation/mm/balloon.rst                  | 138 ++++++++++++++++++
 MAINTAINERS                                   |   4 +-
 arch/powerpc/platforms/pseries/cmm.c          |   2 +-
 drivers/hv/hv_balloon.c                       |  12 ++
 drivers/misc/vmw_balloon.c                    |   3 +-
 drivers/virtio/virtio_balloon.c               |   7 +-
 fs/proc/meminfo.c                             |  10 ++
 .../linux/{balloon_compaction.h => balloon.h} |  18 ++-
 lib/show_mem.c                                |   8 +
 mm/Makefile                                   |   2 +-
 mm/{balloon_compaction.c => balloon.c}        |  19 ++-
 mm/migrate.c                                  |   1 -
 mm/vmscan.c                                   |   1 -
 14 files changed, 213 insertions(+), 18 deletions(-)
 create mode 100644 Documentation/mm/balloon.rst
 rename include/linux/{balloon_compaction.h => balloon.h} (91%)
 rename mm/{balloon_compaction.c => balloon.c} (94%)

v4->v5:
 - removed notifier
 - added documentation
 - vmware update after op is done , outside of the mutex
v3->v4:
 - add support in hyperV and vmware balloon drivers
 - display balloon memory in show_mem so it is logged on OOM and on sysrq
v2->v3:
 - added missed EXPORT_SYMBOLS
Reported-by: kernel test robot <lkp@intel.com>
 - instead of balloon_common.h just use balloon.h (yes, naming is hard)
 - cleaned up balloon.h - remove from files that do not use it and
   remove externs from function declarations
v1->v2:
 - reworked from simple /proc/meminfo addition

Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Nadav Amit <namit@vmware.com>
Cc: pv-drivers@vmware.com
Cc: Jason Wang <jasowang@redhat.com>
Cc: virtualization@lists.linux-foundation.org
Cc: "K. Y. Srinivasan" <kys@microsoft.com>
Cc: Haiyang Zhang <haiyangz@microsoft.com>
Cc: Stephen Hemminger <sthemmin@microsoft.com>
Cc: Dexuan Cui <decui@microsoft.com>
Cc: linux-hyperv@vger.kernel.org
Cc: Juergen Gross <jgross@suse.com>
Cc: Stefano Stabellini <sstabellini@kernel.org>
Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Cc: xen-devel@lists.xenproject.org

base-commit: 9abf2313adc1ca1b6180c508c25f22f9395cc780
-- 
2.31.1

