Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D460234249
	for <lists+linux-hyperv@lfdr.de>; Fri, 31 Jul 2020 11:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732082AbgGaJSy (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 31 Jul 2020 05:18:54 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53500 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732014AbgGaJSx (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 31 Jul 2020 05:18:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596187132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=7KJjJxh3LrCrOmiVZX7zoQLv4kMydPtkCS0ZPjF2DUk=;
        b=FiVCuRWJSMGZ4b9rF+wVB+oQueeP82nv2MDSJXC97CSYubtzlZHiU4XN51U+MCOWqScXy8
        mOJ5H3TdGy9NiTd9bNPGBy6/T2Pi1zPyT9nihh7T1WgqSXEDzxIznsR0G+aUURlfjq5x2+
        Z2D/MUYHNS4JWwHc9/lynTjt6YU/6eY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-SolxhgZkNXO5E6nSxUQ3oA-1; Fri, 31 Jul 2020 05:18:49 -0400
X-MC-Unique: SolxhgZkNXO5E6nSxUQ3oA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 07FF759;
        Fri, 31 Jul 2020 09:18:47 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-22.ams2.redhat.com [10.36.113.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BC0631A835;
        Fri, 31 Jul 2020 09:18:39 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-hyperv@vger.kernel.org, xen-devel@lists.xenproject.org,
        David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Juergen Gross <jgross@suse.com>, Julien Grall <julien@xen.org>,
        Kees Cook <keescook@chromium.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Michal Hocko <mhocko@suse.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wei Liu <wei.liu@kernel.org>,
        Wei Yang <richardw.yang@linux.intel.com>
Subject: [PATCH RFCv1 0/5] mm/memory_hotplug: selective merging of memory resources
Date:   Fri, 31 Jul 2020 11:18:33 +0200
Message-Id: <20200731091838.7490-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

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
current kexec-tools resource count limit does not allow more than ~100GB
of memory with a memory block size of 128MB on x86-64).

Let's allow to selectively merge resources, speciyfing a parent node and
a resource idendifier string. The memory unplug path will properly split
up merged resources again.

Patch #3 contains a /proc/iomem example. Only tested with virtio-mem.

Note: This gets the job done and is comparably simple. More complicated
approaches would require introducing IORESOURCE_MERGEABLE and extending our
add_memory*() interfaces with a flag, specifying that merging after adding
succeeded is acceptable. I'd like to avoid that complexity and code churn
for now.

David Hildenbrand (5):
  kernel/resource: make release_mem_region_adjustable() never fail
  kernel/resource: merge_child_mem_resources() to merge memory resources
    after adding succeeded
  virtio-mem: try to merge "System RAM (virtio_mem)" resources
  xen/balloon: try to merge "System RAM" resources
  hv_balloon:: try to merge "System RAM" resources

 drivers/hv/hv_balloon.c     |   3 ++
 drivers/virtio/virtio_mem.c |  14 ++++-
 drivers/xen/balloon.c       |   4 ++
 include/linux/ioport.h      |   7 ++-
 kernel/resource.c           | 105 ++++++++++++++++++++++++++++--------
 mm/memory_hotplug.c         |  22 +-------
 6 files changed, 109 insertions(+), 46 deletions(-)

-- 
2.26.2

