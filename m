Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACA51BF565
	for <lists+linux-hyperv@lfdr.de>; Thu, 30 Apr 2020 12:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbgD3K3q (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 30 Apr 2020 06:29:46 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:24542 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725280AbgD3K3q (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 30 Apr 2020 06:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588242584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=F00GW0IDxO2YtXf8I1Htd7Li0LSvuJyIHlJhh9ba9cc=;
        b=OVSlYlCZ2E3cHN0Js+7WHt5F1UfPjr1sI639y5jPoY/o5E2c0Rjfcnc2i8iymUtQTxujJU
        R+c8aNGTDnYlI+DGUp6GNvmaDED+6ot8ymJwCGYeaYi7oJAPClpWpT89FDlvlR406D2UAR
        zZTExmFEMkIxhq2XFZIg53dVl5iwqwk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-319-F5xrMv_8M0upE38nqrJ6fA-1; Thu, 30 Apr 2020 06:29:37 -0400
X-MC-Unique: F5xrMv_8M0upE38nqrJ6fA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0BD301899521;
        Thu, 30 Apr 2020 10:29:32 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-172.ams2.redhat.com [10.36.113.172])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 963F15D780;
        Thu, 30 Apr 2020 10:29:16 +0000 (UTC)
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
        Dave Hansen <dave.hansen@linux.intel.com>,
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
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Wei Liu <wei.liu@kernel.org>,
        Wei Yang <richard.weiyang@gmail.com>
Subject: [PATCH v2 0/3] mm/memory_hotplug: Allow to not create firmware memmap entries
Date:   Thu, 30 Apr 2020 12:29:05 +0200
Message-Id: <20200430102908.10107-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

This is the follow up of [1]:
	[PATCH v1 0/3] mm/memory_hotplug: Make virtio-mem play nicely with
	kexec-tools

I realized that this is not only helpful for virtio-mem, but also for
dax/kmem - it's a fix for that use case (see patch #3) of persistent
memory.

Also, while testing, I discovered that kexec-tools will *not* add dax/kme=
m
memory (anything not directly under the root when parsing /proc/iomem) to
the elfcorehdr, so this memory will never get included in a dump. This
probably has to be fixed in kexec-tools - virtio-mem will require this as
well.

v1 -> v2:
- Don't change the resource name
- Rename the flag to MHP_NO_FIRMWARE_MEMMAP to reflect what it is doing
- Rephrase subjects/descriptions
- Use the flag for dax/kmem

I'll have to rebase virtio-mem on these changes, there will be a resend.

[1] https://lkml.kernel.org/r/20200429160803.109056-1-david@redhat.com

David Hildenbrand (3):
  mm/memory_hotplug: Prepare passing flags to add_memory() and friends
  mm/memory_hotplug: Introduce MHP_NO_FIRMWARE_MEMMAP
  device-dax: Add system ram (add_memory()) with MHP_NO_FIRMWARE_MEMMAP

 arch/powerpc/platforms/powernv/memtrace.c       |  2 +-
 arch/powerpc/platforms/pseries/hotplug-memory.c |  2 +-
 drivers/acpi/acpi_memhotplug.c                  |  2 +-
 drivers/base/memory.c                           |  2 +-
 drivers/dax/kmem.c                              |  3 ++-
 drivers/hv/hv_balloon.c                         |  2 +-
 drivers/s390/char/sclp_cmd.c                    |  2 +-
 drivers/xen/balloon.c                           |  2 +-
 include/linux/memory_hotplug.h                  | 15 ++++++++++++---
 mm/memory_hotplug.c                             | 14 ++++++++------
 10 files changed, 29 insertions(+), 17 deletions(-)

--=20
2.25.3

