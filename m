Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671B51BE356
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2020 18:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbgD2QId (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 Apr 2020 12:08:33 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:40698 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726476AbgD2QId (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 Apr 2020 12:08:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588176511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RqcnavPFirGVOTXHhjY5q5DM9FLFgis6bxz7RvWdVJE=;
        b=NF6SEmoBSLh35Rr3F64TX3eRiuQXkAGm8LorPyCM5HmprmxyAAldtWA+3Sj1UyO2h+TvVv
        iLSafCwCdbKMvRI2i0Hqzrv7uQ3RW+yhIwnLc7KFGzOxOMS+tfZjLU591tlom7QnJKafiB
        JGqZLz+jaj54hzZwZxm7d62QrC+Rhj8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-480-F36vCcGRMVu93iH7TXheIg-1; Wed, 29 Apr 2020 12:08:26 -0400
X-MC-Unique: F36vCcGRMVu93iH7TXheIg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E4E0C1895A28;
        Wed, 29 Apr 2020 16:08:21 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-55.ams2.redhat.com [10.36.114.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BAF7C605FB;
        Wed, 29 Apr 2020 16:08:07 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtio-dev@lists.oasis-open.org,
        virtualization@lists.linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org,
        linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Juergen Gross <jgross@suse.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Len Brown <lenb@kernel.org>,
        Leonardo Bras <leobras.c@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michal Hocko <mhocko@suse.com>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        Oscar Salvador <osalvador@suse.de>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v1 0/3] mm/memory_hotplug: Make virtio-mem play nicely with kexec-tools
Date:   Wed, 29 Apr 2020 18:08:00 +0200
Message-Id: <20200429160803.109056-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This series is based on [1]:
	[PATCH v2 00/10] virtio-mem: paravirtualized memory
That will hopefull get picked up soon, rebased to -next.

The following patches were reverted from -next [2]:
	[PATCH 0/3] kexec/memory_hotplug: Prevent removal and accidental use
As discussed in that thread, they should be reverted from -next already.

In theory, if people agree, we could take the first two patches via the
-mm tree now and the last (virtio-mem) patch via MST's tree once picking =
up
virtio-mem. No strong feelings.


Memory added by virtio-mem is special and might contain logical holes,
especially after memory unplug, but also when adding memory in
sub-section size. While memory in these holes can usually be read, that
memory should not be touched. virtio-mem managed device memory is never
exposed via any firmware memmap (esp., e820). The device driver will
request to plug memory from the hypervisor and add it to Linux.

On a cold start, all memory is unplugged, and the guest driver will first
request to plug memory from the hypervisor, to then add it to Linux. Afte=
r
a reboot, all memory will get unplugged (except in rare, special cases). =
In
case the device driver comes up and detects that some memory is still
plugged after a reboot, it will manually request to unplug all memory fro=
m
the hypervisor first - to then request to plug memory from the hypervisor
and add to Linux. This is essentially a defragmentation step, where all
logical holes are removed.

As the device driver is responsible for detecting, adding and managing th=
at
memory, also kexec should treat it like that. It is special. We need a wa=
y
to teach kexec-tools to not add that memory to the fixed-up firmware
memmap, to not place kexec images onto this memory, but still allow kdump
to dump it. Add a flag to tell memory hotplug code to
not create /sys/firmware/memmap entries and to indicate it via
"System RAM (driver managed)" in /proc/iomem.

Before this series, kexec_file_load() already did the right thing (for
virtio-mem) by not adding that memory to the fixed-up firmware memmap and
letting the device driver handle it. With this series, also kexec_load() =
-
which relies on user space to provide a fixed up firmware memmap - does
the right thing with virtio-mem memory.

When the virtio-mem device driver(s) come up, they will request to unplug
all memory from the hypervisor first (esp. defragment), to then request t=
o
plug consecutive memory ranges from the hypervisor, and add them to Linux
- just like on a reboot where we still have memory plugged.

[1] https://lore.kernel.org/r/20200311171422.10484-1-david@redhat.com/
[2] https://lore.kernel.org/r/20200326180730.4754-1-james.morse@arm.com

David Hildenbrand (3):
  mm/memory_hotplug: Prepare passing flags to add_memory() and friends
  mm/memory_hotplug: Introduce MHP_DRIVER_MANAGED
  virtio-mem: Add memory with MHP_DRIVER_MANAGED

 arch/powerpc/platforms/powernv/memtrace.c     |  2 +-
 .../platforms/pseries/hotplug-memory.c        |  2 +-
 drivers/acpi/acpi_memhotplug.c                |  2 +-
 drivers/base/memory.c                         |  2 +-
 drivers/dax/kmem.c                            |  2 +-
 drivers/hv/hv_balloon.c                       |  2 +-
 drivers/s390/char/sclp_cmd.c                  |  2 +-
 drivers/virtio/virtio_mem.c                   |  3 +-
 drivers/xen/balloon.c                         |  2 +-
 include/linux/memory_hotplug.h                | 15 +++++++--
 mm/memory_hotplug.c                           | 31 +++++++++++++------
 11 files changed, 44 insertions(+), 21 deletions(-)

--=20
2.25.3

