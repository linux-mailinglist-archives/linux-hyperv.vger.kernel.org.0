Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEA6F24D277
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Aug 2020 12:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgHUKez (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 21 Aug 2020 06:34:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40491 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727827AbgHUKex (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 21 Aug 2020 06:34:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1598006091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=Lz1Dlp3n64jbr0nqc1nHMGKoG4tO/ALxoWb8NdfDDro=;
        b=domLTO7T0SoEgJNLvoTf5fxtxm7/j/b/PjYBNPAWSQvtncee6HUCUlFZiq/u5kkhamEbac
        hXYfmaM2s+D3E9gWdjUSca2fFOSRcOMJKpfp0lA7CiujOzAwGk35sEdcrc1IS6A0zGc5CJ
        QUTv78gqQ2+geCdDAvOO2pM/vpFIog0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-337-tNVl4_PKOqOy6s0hWbWRxQ-1; Fri, 21 Aug 2020 06:34:47 -0400
X-MC-Unique: tNVl4_PKOqOy6s0hWbWRxQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7C4AA100CF73;
        Fri, 21 Aug 2020 10:34:44 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-87.ams2.redhat.com [10.36.114.87])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D2F07756D7;
        Fri, 21 Aug 2020 10:34:32 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>, Baoquan He <bhe@redhat.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Jason Wang <jasowang@redhat.com>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        Kees Cook <keescook@chromium.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Liu <wei.liu@kernel.org>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH v1 0/5] mm/memory_hotplug: selective merging of system ram resources
Date:   Fri, 21 Aug 2020 12:34:26 +0200
Message-Id: <20200821103431.13481-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is the follow-up of "[PATCH RFCv1 0/5] mm/memory_hotplug: selective
merging of memory resources" [1]

Some add_memory*() users add memory in small, contiguous memory blocks.
Examples include virtio-mem, hyper-v balloon, and the XEN balloon.

This can quickly result in a lot of memory resources, whereby the actual
resource boundaries are not of interest (e.g., it might be relevant for
DIMMs, exposed via /proc/iomem to user space). We really want to merge
added resources in this scenario where possible.

Resources are effectively stored in a list-based tree. Having a lot of
resources not only wastes memory, it also makes traversing that tree more
expensive, and makes /proc/iomem explode in size (e.g., requiring
kexec-tools to manually merge resources when creating a kdump header. The
current kexec-tools resource count limit does not allow for more than
~100GB of memory with a memory block size of 128MB on x86-64).

Let's allow to selectively merge system ram resources directly below a
specific parent resource. Patch #3 contains a /proc/iomem example. Only
tested with virtio-mem.

Note: This gets the job done and is comparably simple. More complicated
approaches would require introducing IORESOURCE_MERGEABLE and extending our
add_memory*() interfaces with a flag, specifying that merging after adding
succeeded is acceptable. I'd like to avoid that complexity and code churn
for now.

[1] https://lkml.kernel.org/r/20200731091838.7490-1-david@redhat.com

RFC -> v1:
- Switch from rather generic "merge_child_mem_resources()" where a resource
  name has to be specified to "merge_system_ram_resources().
- Smaller comment/documentation/patch description changes/fixes

David Hildenbrand (5):
  kernel/resource: make release_mem_region_adjustable() never fail
  kernel/resource: merge_system_ram_resources() to merge resources after
    hotplug
  virtio-mem: try to merge system ram resources
  xen/balloon: try to merge system ram resources
  hv_balloon: try to merge system ram resources

 drivers/hv/hv_balloon.c     |   3 ++
 drivers/virtio/virtio_mem.c |  14 ++++-
 drivers/xen/balloon.c       |   4 ++
 include/linux/ioport.h      |   7 ++-
 kernel/resource.c           | 101 ++++++++++++++++++++++++++++--------
 mm/memory_hotplug.c         |  22 +-------
 6 files changed, 105 insertions(+), 46 deletions(-)

-- 
2.26.2

