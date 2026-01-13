Return-Path: <linux-hyperv+bounces-8252-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAF3D16B0D
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 06:19:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EE95300AAC8
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 05:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77AA3258EF3;
	Tue, 13 Jan 2026 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2gjyvaf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4912BD00C
	for <linux-hyperv@vger.kernel.org>; Tue, 13 Jan 2026 05:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768281581; cv=none; b=tD3sakYDqrEw3WE7E9k5lA32Le25w2r2dkPapLQ9vgcGdS/E8l0/6I+BNWnLBlJmYuw9NXSSgBxP/jpDt6BNiNizJSs+T8DB/Jv3hLjEE3EoB0ebOkmtyU0XlDbqTHcD9YxhMDsWU9O+eTbWUpg04ibXsru547uFVvFbL/OIxIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768281581; c=relaxed/simple;
	bh=CV2fwnUO8gdhzUFewWlJ97rJBZdABxHUXdkyCIJ0XlE=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=DegRSF6uUKqyH/yxB8fzlNE0yYZWogSaa/sxsIdq8i3C6vaSSqedsWPOCskFY6gi8yCYkdV3/klPaNCYrL0OMb+T1AXWcsKxqo94IwB2R5fYp78f4vniqy9ff+j8ntDtVyWZTZyeg/BuT1d1UuT2ODLz2+3vsuQFH8DA8P/Y5nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2gjyvaf; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-93f5667f944so4715603241.2
        for <linux-hyperv@vger.kernel.org>; Mon, 12 Jan 2026 21:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768281579; x=1768886379; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GqprqS6XZD/UF3ZjzkMVpuPhwhGmYnu66pPo4XaWWiw=;
        b=N2gjyvafaxJBhinBoi5l1N4ifYnvtscmjFV0WYUoba6Bx1J1rIwZpg0IiTKfyycFDI
         99XV/0iF/h9E5yIuYHKhulZOozJ/Tx9M/nNvBmJ+6vpYfSsKtcg+lz2eOznBCG5pKy1+
         r+1ahiqkinU7/uk7WQpzVM+WumMzxHSFZeiX+N7jNdhmQhLqIC3cwFTS3RYx0b6Un5vW
         RhCYbFBEt0LN3yEVz+181mF7HrPpZ1RhwW6dNK+dPYGOk19ijyQbKcMU8CA4N2mmSqu/
         JF6kNiun8+WQvFOdEswQVYPZiSFubUd4S0JU4aO+aeSwxnh713eHfVR0hHbWlTHjmEoW
         7V4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768281579; x=1768886379;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqprqS6XZD/UF3ZjzkMVpuPhwhGmYnu66pPo4XaWWiw=;
        b=ICNL1I3KV5K1Bgn7XffgGWaaEucdd30571r7Pw9chHEJ5/lkRbLj1m5bKDZgE9ltPq
         9ks8+iq7WjU6MHqFWpSHLqyaf/KW/g4BMtZIZ5VnOIaWmOiQgaJLyd/o9628Tp3KGU0N
         Ua+WuKP/sr1uv/qevNtO4c45c7fiAtsVXkklTQ0stAxhZqJZwdUJUxyyCva/NTqtKCXK
         t1y9yKnI27fJZQtbwu02aXIw1q+4eDo9IHDaycS4uuSaFdmzM3QTjLSMCvKEheg4KqD6
         pRDl9etQD+39XEtAj9DFB03zCFsFHY4H+XJzUUTwyquxHpr9RGWxMJJiYdSTaepYWEi2
         JpUw==
X-Forwarded-Encrypted: i=1; AJvYcCXDNQopnLID1clGlzSvl24AYJWRBepZZvWPGynrvcLaGsIhJNqOVnrlikRsHnip3AxSn4+yjWni03/WKb0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4PBnSk1nuBGp31c3Aek2nHrcchEgmwEN58bbCIjAdOGloazaw
	WdgLZxiPmt7yrTLT4gHkXFIM891HaRhXKydzdZTiAOx2fhAuFfzU7TkhA+7bpQ==
X-Gm-Gg: AY/fxX64LwpZIi3nmg3hq9FZjnjSJWnRRpoO4UzgWbJDmz3JdTpgl6XATig9vR1TFvb
	wMUsq9NDEnsk+TBkbNM3WcS6nQsRuoMgtMAi1/55UOEgysF/0SJg7htemlNPJV2HZ92iPBrbu2u
	3eJFoD6g1bdjRRS5X73ATRrnLtE+sEg8P1AXioNJHiVppxwb7uA+GHPaWtMLHgAALf1iBhX+pIW
	eUIBKWtdUiE/XfHbHL2xWNvrue4W/klka8oHrLY9dLOiGbCRtpnUIGjWqj+6zzeCp6QfOKjS++Y
	urBupuzPXY6nCl8SQI0AH6qdc9uwv7YK/WqL1xmu07WnjeGf6I27MAb2uymV+r9X/qxb9sTCJG8
	7bDGnLUaDBtd4HdrFV72Jc0ZKcTdGJwj64/1+Qm4jrxGaLjv+UWTWysDdyezfmAAg6LWYIYG4Rx
	fFiVZCVo/d7Q==
X-Google-Smtp-Source: AGHT+IHEvqz6F5p7PryBFdPW7drnRDd9TzB6bNh+ElUhlxBsvZhx+8dgAoo5zTxbfe4+m0mCDXbGmA==
X-Received: by 2002:a05:690c:39a:b0:78d:b1e9:85ce with SMTP id 00721157ae682-790b5703932mr163750627b3.59.1768273976093;
        Mon, 12 Jan 2026 19:12:56 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:58::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7916d24ae23sm49625307b3.0.2026.01.12.19.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:12:55 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v14 00/12] vsock: add namespace support to
 vhost-vsock and loopback
Date: Mon, 12 Jan 2026 19:11:09 -0800
Message-Id: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAM+3ZWkC/5XTS27bQAyA4asIszYLkvP2KvcospgHlQit7VZSh
 RSB715ECerpOJuuhY+/QHBe1SLzJIs6Dq9qlm1apstZHQcyh0GV53R+EpiqOg6KkS1qtrAtl/I
 NttMqywpZJ6bKhFxYHQb1Y5ZxetnnfVVnWeEsL6t6PAzqeVrWy/x7D220f99HGsJ/R24EBKO2K
 VBNOYby8HRK0/cv5XLaB23cYt9hBgIdkRJ7rUlCj3WDOXRYAwEFSqMjp0ctPTY3bLEvGyBwwil
 6dlyqa/DhY30B7R1CQBulWEqZiB5OsqZb0DZB0p21QGDE22KSsUXyZ0H2dwgBc7IBs1SxuQu6N
 tj/rAOCmEYqBVlHxE+CkdwdQkBnKkvGEmLtgv5vkJCps363jrLPbsTQbOej919m74W21280AEK
 VFIOpyDljZwlvmO4uj/BNjxhGcja/XU+nqdF8d/QECNaWXAKyicn3mlvdL5kYENh6EaZSbW3b1
 /dnOcvPX9Myre9v8/F6/QPnmSjR+wMAAA==
X-Change-ID: 20250325-vsock-vmtest-b3a21d2102c2
To: Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

This series adds namespace support to vhost-vsock and loopback. It does
not add namespaces to any of the other guest transports (virtio-vsock,
hyperv, or vmci).

The current revision supports two modes: local and global. Local
mode is complete isolation of namespaces, while global mode is complete
sharing between namespaces of CIDs (the original behavior).

The mode is set using the parent namespace's
/proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
created. The mode of the current namespace can be queried by reading
/proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
has been created.

Modes are per-netns. This allows a system to configure namespaces
independently (some may share CIDs, others are completely isolated).
This also supports future possible mixed use cases, where there may be
namespaces in global mode spinning up VMs while there are mixed mode
namespaces that provide services to the VMs, but are not allowed to
allocate from the global CID pool (this mode is not implemented in this
series).

Additionally, added tests for the new namespace features:

tools/testing/selftests/vsock/vmtest.sh
1..25
ok 1 vm_server_host_client
ok 2 vm_client_host_server
ok 3 vm_loopback
ok 4 ns_host_vsock_ns_mode_ok
ok 5 ns_host_vsock_child_ns_mode_ok
ok 6 ns_global_same_cid_fails
ok 7 ns_local_same_cid_ok
ok 8 ns_global_local_same_cid_ok
ok 9 ns_local_global_same_cid_ok
ok 10 ns_diff_global_host_connect_to_global_vm_ok
ok 11 ns_diff_global_host_connect_to_local_vm_fails
ok 12 ns_diff_global_vm_connect_to_global_host_ok
ok 13 ns_diff_global_vm_connect_to_local_host_fails
ok 14 ns_diff_local_host_connect_to_local_vm_fails
ok 15 ns_diff_local_vm_connect_to_local_host_fails
ok 16 ns_diff_global_to_local_loopback_local_fails
ok 17 ns_diff_local_to_global_loopback_fails
ok 18 ns_diff_local_to_local_loopback_fails
ok 19 ns_diff_global_to_global_loopback_ok
ok 20 ns_same_local_loopback_ok
ok 21 ns_same_local_host_connect_to_local_vm_ok
ok 22 ns_same_local_vm_connect_to_local_host_ok
ok 23 ns_delete_vm_ok
ok 24 ns_delete_host_ok
ok 25 ns_delete_both_ok
SUMMARY: PASS=25 SKIP=0 FAIL=0

Thanks again for everyone's help and reviews!

Suggested-by: Sargun Dhillon <sargun@sargun.me>
Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>

Changes in v14:
- squashed 'vsock: add per-net vsock NS mode state' into 'vsock: add
  netns to vsock core' (MST)
- remove RFC tag
- fixed base-commit (still had b4 configured to depend on old vmtest.sh
  series)
- Link to v13: https://lore.kernel.org/all/20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com/

Changes in v13:
- add support for immutable sysfs ns_mode and inheritance from sysfs child_ns_mode
- remove passing around of net_mode, can be accessed now via
  vsock_net_mode(net) since it is immutable
- update tests for new uAPI
- add one patch to extend the kselftest timeout (it was starting to
  fail with the new tests added)
- Link to v12: https://lore.kernel.org/r/20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com

Changes in v12:
- add ns mode checking to _allow() callbacks to reject local mode for
  incompatible transports (Stefano)
- flip vhost/loopback to return true for stream_allow() and
  seqpacket_allow() in "vsock: add netns support to virtio transports"
  (Stefano)
- add VMADDR_CID_ANY + local mode documentation in af_vsock.c (Stefano)
- change "selftests/vsock: add tests for host <-> vm connectivity with
  namespaces" to skip test 29 in vsock_test for namespace local
  vsock_test calls in a host local-mode namespace. There is a
  false-positive edge case for that test encountered with the
  ->stream_allow() approach. More details in that patch.
- updated cover letter with new test output
- Link to v11: https://lore.kernel.org/r/20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com

Changes in v11:
- vmtest: add a patch to use ss in wait_for_listener functions and
  support vsock, tcp, and unix. Change all patches to use the new
  functions.
- vmtest: add a patch to re-use vm dmesg / warn counting functions
- Link to v10: https://lore.kernel.org/r/20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com

Changes in v10:
- Combine virtio common patches into one (Stefano)
- Resolve vsock_loopback virtio_transport_reset_no_sock() issue
  with info->vsk setting. This eliminates the need for skb->cb,
  so remove skb->cb patches.
- many line width 80 fixes
- Link to v9: https://lore.kernel.org/all/20251111-vsock-vmtest-v9-0-852787a37bed@meta.com

Changes in v9:
- reorder loopback patch after patch for virtio transport common code
- remove module ordering tests patch because loopback no longer depends
  on pernet ops
- major simplifications in vsock_loopback
- added a new patch for blocking local mode for guests, added test case
  to check
- add net ref tracking to vsock_loopback patch
- Link to v8: https://lore.kernel.org/r/20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com

Changes in v8:
- Break generic cleanup/refactoring patches into standalone series,
  remove those from this series
- Link to dependency: https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/
- Link to v7: https://lore.kernel.org/r/20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com

Changes in v7:
- fix hv_sock build
- break out vmtest patches into distinct, more well-scoped patches
- change `orig_net_mode` to `net_mode`
- many fixes and style changes in per-patch change sets (see individual
  patches for specific changes)
- optimize `virtio_vsock_skb_cb` layout
- update commit messages with more useful descriptions
- vsock_loopback: use orig_net_mode instead of current net mode
- add tests for edge cases (ns deletion, mode changing, loopback module
  load ordering)
- Link to v6: https://lore.kernel.org/r/20250916-vsock-vmtest-v6-0-064d2eb0c89d@meta.com

Changes in v6:
- define behavior when mode changes to local while socket/VM is alive
- af_vsock: clarify description of CID behavior
- af_vsock: use stronger langauge around CID rules (dont use "may")
- af_vsock: improve naming of buf/buffer
- af_vsock: improve string length checking on proc writes
- vsock_loopback: add space in struct to clarify lock protection
- vsock_loopback: do proper cleanup/unregister on vsock_loopback_exit()
- vsock_loopback: use virtio_vsock_skb_net() instead of sock_net()
- vsock_loopback: set loopback to NULL after kfree()
- vsock_loopback: use pernet_operations and remove callback mechanism
- vsock_loopback: add macros for "global" and "local"
- vsock_loopback: fix length checking
- vmtest.sh: check for namespace support in vmtest.sh
- Link to v5: https://lore.kernel.org/r/20250827-vsock-vmtest-v5-0-0ba580bede5b@meta.com

Changes in v5:
- /proc/net/vsock_ns_mode -> /proc/sys/net/vsock/ns_mode
- vsock_global_net -> vsock_global_dummy_net
- fix netns lookup in vhost_vsock to respect pid namespaces
- add callbacks for vsock_loopback to avoid circular dependency
- vmtest.sh loads vsock_loopback module
- remove vsock_net_mode_can_set()
- change vsock_net_write_mode() to return true/false based on success
- make vsock_net_mode enum instead of u8
- Link to v4: https://lore.kernel.org/r/20250805-vsock-vmtest-v4-0-059ec51ab111@meta.com

Changes in v4:
- removed RFC tag
- implemented loopback support
- renamed new tests to better reflect behavior
- completed suite of tests with permutations of ns modes and vsock_test
  as guest/host
- simplified socat bridging with unix socket instead of tcp + veth
- only use vsock_test for success case, socat for failure case (context
  in commit message)
- lots of cleanup

Changes in v3:
- add notion of "modes"
- add procfs /proc/net/vsock_ns_mode
- local and global modes only
- no /dev/vhost-vsock-netns
- vmtest.sh already merged, so new patch just adds new tests for NS
- Link to v2:
  https://lore.kernel.org/kvm/20250312-vsock-netns-v2-0-84bffa1aa97a@gmail.com

Changes in v2:
- only support vhost-vsock namespaces
- all g2h namespaces retain old behavior, only common API changes
  impacted by vhost-vsock changes
- add /dev/vhost-vsock-netns for "opt-in"
- leave /dev/vhost-vsock to old behavior
- removed netns module param
- Link to v1:
  https://lore.kernel.org/r/20200116172428.311437-1-sgarzare@redhat.com

Changes in v1:
- added 'netns' module param to vsock.ko to enable the
  network namespace support (disabled by default)
- added 'vsock_net_eq()' to check the "net" assigned to a socket
  only when 'netns' support is enabled
- Link to RFC: https://patchwork.ozlabs.org/cover/1202235/

---
Bobby Eshleman (12):
      vsock: add netns to vsock core
      virtio: set skb owner of virtio_transport_reset_no_sock() reply
      vsock: add netns support to virtio transports
      selftests/vsock: increase timeout to 1200
      selftests/vsock: add namespace helpers to vmtest.sh
      selftests/vsock: prepare vm management helpers for namespaces
      selftests/vsock: add vm_dmesg_{warn,oops}_count() helpers
      selftests/vsock: use ss to wait for listeners instead of /proc/net
      selftests/vsock: add tests for proc sys vsock ns_mode
      selftests/vsock: add namespace tests for CID collisions
      selftests/vsock: add tests for host <-> vm connectivity with namespaces
      selftests/vsock: add tests for namespace deletion

 MAINTAINERS                             |    1 +
 drivers/vhost/vsock.c                   |   44 +-
 include/linux/virtio_vsock.h            |    9 +-
 include/net/af_vsock.h                  |   53 +-
 include/net/net_namespace.h             |    4 +
 include/net/netns/vsock.h               |   17 +
 net/vmw_vsock/af_vsock.c                |  297 ++++++++-
 net/vmw_vsock/hyperv_transport.c        |    7 +-
 net/vmw_vsock/virtio_transport.c        |   22 +-
 net/vmw_vsock/virtio_transport_common.c |   62 +-
 net/vmw_vsock/vmci_transport.c          |   26 +-
 net/vmw_vsock/vsock_loopback.c          |   22 +-
 tools/testing/selftests/vsock/settings  |    2 +-
 tools/testing/selftests/vsock/vmtest.sh | 1055 +++++++++++++++++++++++++++++--
 14 files changed, 1488 insertions(+), 133 deletions(-)
---
base-commit: 2f2d896ec59a11a9baaa56818466db7a3178c041
change-id: 20250325-vsock-vmtest-b3a21d2102c2

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


