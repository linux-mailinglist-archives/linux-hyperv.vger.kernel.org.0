Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3777AFC327
	for <lists+linux-hyperv@lfdr.de>; Thu, 14 Nov 2019 10:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfKNJ6F (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 14 Nov 2019 04:58:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53400 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726024AbfKNJ6E (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 14 Nov 2019 04:58:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1573725482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=i+ghB/wyVNL5oaMuN4UVb/xQcoBfZlXxJT0AidebzUE=;
        b=WY7XwU4zBL+GP+EBPahkfp7diEcPl0uG+32HHqFv2q7YHaoMsbSKIuVyBZbv5mEJdIZ+ce
        3yuA6D6eIwfFcx+PqgMPc56oxOOmwA3gstThlbdKRVDOoZH5HoXk4UhNJ06ipn4iBXHxyH
        JKSy447x4gi2clqIjQZFbWHVO7zzbLU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-hkAcOLRiNvW9sTlvdhU7Sw-1; Thu, 14 Nov 2019 04:58:01 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3AB44800EBE;
        Thu, 14 Nov 2019 09:57:59 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-117-81.ams2.redhat.com [10.36.117.81])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1E6E0A7F1;
        Thu, 14 Nov 2019 09:57:50 +0000 (UTC)
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     netdev@vger.kernel.org
Cc:     Stephen Hemminger <sthemmin@microsoft.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jorgen Hansen <jhansen@vmware.com>,
        Jason Wang <jasowang@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        virtualization@lists.linux-foundation.org, kvm@vger.kernel.org,
        Sasha Levin <sashal@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org
Subject: [PATCH net-next v2 00/15] vsock: add multi-transports support
Date:   Thu, 14 Nov 2019 10:57:35 +0100
Message-Id: <20191114095750.59106-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: hkAcOLRiNvW9sTlvdhU7Sw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Most of the patches are reviewed by Dexuan, Stefan, and Jorgen.
The following patches need reviews:
- [11/15] vsock: add multi-transports support
- [12/15] vsock/vmci: register vmci_transport only when VMCI guest/host
          are active
- [15/15] vhost/vsock: refuse CID assigned to the guest->host transport

RFC: https://patchwork.ozlabs.org/cover/1168442/
v1: https://patchwork.ozlabs.org/cover/1181986/

v1 -> v2:
- Patch 11:
    + vmci_transport: sent reset when vsock_assign_transport() fails
      [Jorgen]
    + fixed loopback in the guests, checking if the remote_addr is the
      same of transport_g2h->get_local_cid()
    + virtio_transport_common: updated space available while creating
      the new child socket during a connection request
- Patch 12:
    + removed 'features' variable in vmci_transport_init() [Stefan]
    + added a flag to register only once the host [Jorgen]
- Added patch 15 to refuse CID assigned to the guest->host transport in
  the vhost_transport

This series adds the multi-transports support to vsock, following
this proposal: https://www.spinics.net/lists/netdev/msg575792.html

With the multi-transports support, we can use VSOCK with nested VMs
(using also different hypervisors) loading both guest->host and
host->guest transports at the same time.
Before this series, vmci_transport supported this behavior but only
using VMware hypervisor on L0, L1, etc.

The first 9 patches are cleanups and preparations, maybe some of
these can go regardless of this series.

Patch 10 changes the hvs_remote_addr_init(). setting the
VMADDR_CID_HOST as remote CID instead of VMADDR_CID_ANY to make
the choice of transport to be used work properly.

Patch 11 adds multi-transports support.

Patch 12 changes a little bit the vmci_transport and the vmci driver
to register the vmci_transport only when there are active host/guest.

Patch 13 prevents the transport modules unloading while sockets are
assigned to them.

Patch 14 fixes an issue in the bind() logic discoverable only with
the new multi-transport support.

Patch 15 refuses CID assigned to the guest->host transport in the
vhost_transport.

I've tested this series with nested KVM (vsock-transport [L0,L1],
virtio-transport[L1,L2]) and with VMware (L0) + KVM (L1)
(vmci-transport [L0,L1], vhost-transport [L1], virtio-transport[L2]).

Dexuan successfully tested the RFC series on HyperV with a Linux guest.

Stefano Garzarella (15):
  vsock/vmci: remove unused VSOCK_DEFAULT_CONNECT_TIMEOUT
  vsock: remove vm_sockets_get_local_cid()
  vsock: remove include/linux/vm_sockets.h file
  vsock: add 'transport' member in the struct vsock_sock
  vsock/virtio: add transport parameter to the
    virtio_transport_reset_no_sock()
  vsock: add 'struct vsock_sock *' param to vsock_core_get_transport()
  vsock: handle buffer_size sockopts in the core
  vsock: add vsock_create_connected() called by transports
  vsock: move vsock_insert_unbound() in the vsock_create()
  hv_sock: set VMADDR_CID_HOST in the hvs_remote_addr_init()
  vsock: add multi-transports support
  vsock/vmci: register vmci_transport only when VMCI guest/host are
    active
  vsock: prevent transport modules unloading
  vsock: fix bind() behaviour taking care of CID
  vhost/vsock: refuse CID assigned to the guest->host transport

 drivers/misc/vmw_vmci/vmci_driver.c     |  67 +++++
 drivers/misc/vmw_vmci/vmci_driver.h     |   2 +
 drivers/misc/vmw_vmci/vmci_guest.c      |   2 +
 drivers/misc/vmw_vmci/vmci_host.c       |   7 +
 drivers/vhost/vsock.c                   | 102 ++++---
 include/linux/virtio_vsock.h            |  18 +-
 include/linux/vm_sockets.h              |  15 -
 include/linux/vmw_vmci_api.h            |   2 +
 include/net/af_vsock.h                  |  45 +--
 include/net/vsock_addr.h                |   2 +-
 net/vmw_vsock/af_vsock.c                | 382 ++++++++++++++++++------
 net/vmw_vsock/hyperv_transport.c        |  70 ++---
 net/vmw_vsock/virtio_transport.c        | 177 ++++++-----
 net/vmw_vsock/virtio_transport_common.c | 166 +++++-----
 net/vmw_vsock/vmci_transport.c          | 140 ++++-----
 net/vmw_vsock/vmci_transport.h          |   3 -
 net/vmw_vsock/vmci_transport_notify.h   |   1 -
 17 files changed, 679 insertions(+), 522 deletions(-)
 delete mode 100644 include/linux/vm_sockets.h

--=20
2.21.0

