Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6A891BE372
	for <lists+linux-hyperv@lfdr.de>; Wed, 29 Apr 2020 18:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727023AbgD2QIw (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 29 Apr 2020 12:08:52 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31038 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726858AbgD2QIw (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 29 Apr 2020 12:08:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588176530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cZEMgwn0RdunIfg2yunfCJF8r1H9z41yqLf2sGNY0wM=;
        b=M0WbGyn9Y19J0as6sn0UpHe8NbyjD34/LSPGlzdKvj7WR00VV9+gvk4tmvIkwqCWT9U/4T
        wcWrDIQHYBZab7OgRPUYvsSApxpciT/uXpP1HQryPqjU8Nb+B1PJZpe6xqLGi4nMBznR0Q
        gsl9e4Zwo6FfbniZqKlhsXg5FO9KvSU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-pvtDQR0OOPCL64QlN-zLcg-1; Wed, 29 Apr 2020 12:08:46 -0400
X-MC-Unique: pvtDQR0OOPCL64QlN-zLcg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B80BA107ACCA;
        Wed, 29 Apr 2020 16:08:44 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-55.ams2.redhat.com [10.36.114.55])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8D1E3605F7;
        Wed, 29 Apr 2020 16:08:41 +0000 (UTC)
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
        Jason Wang <jasowang@redhat.com>,
        Michal Hocko <mhocko@suse.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH v1 3/3] virtio-mem: Add memory with MHP_DRIVER_MANAGED
Date:   Wed, 29 Apr 2020 18:08:03 +0200
Message-Id: <20200429160803.109056-4-david@redhat.com>
In-Reply-To: <20200429160803.109056-1-david@redhat.com>
References: <20200429160803.109056-1-david@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

We don't want /sys/firmware/memmap entries and we want to indicate
our memory as "System RAM (driver managed)" in /proc/iomem. This is
especially relevant for kexec-tools, which have to be updated to
support dumping virtio-mem memory after this patch. Expected behavior in
kexec-tools:
- Don't use this memory when creating a fixed-up firmware memmap. Works
  now out of the box on x86-64.
- Don't use this memory for placing kexec segments. Works now out of the
  box on x86-64.
- Consider "System RAM (driver managed)" when creating the elfcorehdr
  for kdump. This memory has to be dumped. Needs update of kexec-tools.

With this patch on x86-64:

/proc/iomem:
	00000000-00000fff : Reserved
	00001000-0009fbff : System RAM
	[...]
	fffc0000-ffffffff : Reserved
	100000000-13fffffff : System RAM
	140000000-147ffffff : System RAM (driver managed)
	340000000-347ffffff : System RAM (driver managed)
	348000000-34fffffff : System RAM (driver managed)
	[..]
	3280000000-32ffffffff : PCI Bus 0000:00

/sys/firmware/memmap:
	0000000000000000-000000000009fc00 (System RAM)
	000000000009fc00-00000000000a0000 (Reserved)
	00000000000f0000-0000000000100000 (Reserved)
	0000000000100000-00000000bffe0000 (System RAM)
	00000000bffe0000-00000000c0000000 (Reserved)
	00000000feffc000-00000000ff000000 (Reserved)
	00000000fffc0000-0000000100000000 (Reserved)
	0000000100000000-0000000140000000 (System RAM)

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 3101cbf9e59d..6f658d1aeac4 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -421,7 +421,8 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, u=
nsigned long mb_id)
 		nid =3D memory_add_physaddr_to_nid(addr);
=20
 	dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
-	return add_memory(nid, addr, memory_block_size_bytes(), 0);
+	return add_memory(nid, addr, memory_block_size_bytes(),
+			  MHP_DRIVER_MANAGED);
 }
=20
 /*
--=20
2.25.3

