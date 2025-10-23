Return-Path: <linux-hyperv+bounces-7317-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A05BC02F41
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Oct 2025 20:29:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 831D35082DB
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Oct 2025 18:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3048734CFC6;
	Thu, 23 Oct 2025 18:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cpL9n6XP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD6634B406
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Oct 2025 18:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244092; cv=none; b=jqEmLXEbxsK7sTaJQGZIewseikTouHDWDlnmH43DTy9Ohcl5hTtRTLDsa818PUMTgZeYIVHdmPKUVKmumRe6NlbAL7gnOG0Hdla8062zQyDLLvDGlmVHCPtIBW5CVH3enJXYhgxTHQX4+ubhJf/e6rFjNBgpZFijkfl/nt7gXX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244092; c=relaxed/simple;
	bh=E8zs7SOpm1dhtUHfmzGbH/EMBHlnGgv32b4JqVbEuLo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=pLyN+u/ral4eGesqq7NdpemyCPFvNhwDR3WgIkm+DNInemwgf4PbnGVVwvvC5AN+nH5IeZYB7tug1GPgRI/+PAJo0f8m6jpd81zFrNu0cLACg5xAH4Slnr1EVjjjQP3nScMxhC24SZj/YzACVTvoxfKeJiGN0H/G3Zd4j1FXfdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cpL9n6XP; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-27c369f8986so9748425ad.3
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Oct 2025 11:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244084; x=1761848884; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vvFV8E+b7v3LABJUzfm2F4mViB8B92hiY0bikMbHgrc=;
        b=cpL9n6XPkpWoQrAj2zkqUCOnEhjcEV7P5ZJupYA9kCmeg63KUffKuynNSgxitpycG7
         qIR7bxTCFgvkb84o606oCKlsjWj/fgqqYs/QFa32AcVUi2108fTTl5259A5moFJIWXB9
         iKiMwPsKd6QuRyGyAyNWwR+K8Tq0PXltxb8thmwqnc5BLXLYCU63UG3zeUFzspWsCpfZ
         gsnoxyqWLucvcjoir316L/4/ndm1tZat6TRUrm0KpsIPwKEoR48893/noYkWPsM//+Ms
         AGO/bLXlBo6AHuGxUYMieF/xLiy77a5S4x+uwZFhXu8+gdd9AGgI8meIR0vqoUN46xil
         b6tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244084; x=1761848884;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vvFV8E+b7v3LABJUzfm2F4mViB8B92hiY0bikMbHgrc=;
        b=bSmypIdKUp4OJJ6N5Iz8HB1Q3IkN19HzP/Fairma/QztsXQXTlONU9o+Cv6l+gsuMJ
         qwsqiCt6M7fsRDbovi2cFYd7RbUjnWQH/ymxRmRxAqfrBTHR5UHXk/ecrjaXgmSWhRy7
         sqJ0RU4LY10aXrARsh5K1ENbB9WCoIlxwOqBVcMAaTA92wsfFBz4cKNet5pI8AgGQSqo
         zDRKY3brsULLraGnUWI7p1mLHgLbhGl2wfvEtXEgGBqZGhCzdSoSIrJB4my0xTlqPy+L
         Sf9ohxQz3h6NGJqr/fVjTlAGdiMq5STfylbVFBZCwuN/UNOpZek3mUDsrTV6Uke36Lw5
         PA8Q==
X-Forwarded-Encrypted: i=1; AJvYcCXb6aho3xqI2NugcGRZvpvgOS9wi1psgFBYzXH2i/AYupSS+yzjxjvaf7eYvisVHQ+hTEffSf35qU9y9Dc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzmmCa3BnWp+Az1zljCT8dq23bm4cJuV9YBlsVQmL2CjbUbJYo
	dho8UO3kRoNU8fDwYkrvXXIhdhUji1SG3PqaS18Zv1xJnwPRFzMd3nrl
X-Gm-Gg: ASbGncs3A01aT1iVff7CwsP9hnNVjuzDikMmxEc5sujxv63cWzL6gkCclqQSKXHhni8
	yShzx90OhZ3t0wE3MvsvobjO8m3+ansFvY881mU/f+hEKL0T2ZYiXtEQEI9pAnFdFqNToaCPofc
	2e2sIhsLR7k2+/X7493hhx1kXD1NC1U515yulkH28cok91eBdWm7h06MdsVso+GtIF16ogdNYX7
	GQ9LuGoW1GNs8e1skwSS235i7sgMquV6oj+NO1uhUTxChorB7/sCtIG2S8cK3ElMR7Qk0KKRX1C
	vW6Ofgbsh+r4eKVjuSc/xd1glrzU6x/zKp3nroYcGFVFe8zphnQF6DVhWpnDftM/GTZZMQqsQl2
	ciHqBPT0ZZJabVfrHP4WeohH49ioLkQGdtGq1V4celI2RbQHynr+AIthS/C7GctqG430jp+89MS
	3OGummOTB2
X-Google-Smtp-Source: AGHT+IGVmTvJcaaeium/CjIOh4QxM0abBhdJ4Oh9ByAkPzM+Q8M0uXOXPNdLcRH+7a1HhSHbc6Gzaw==
X-Received: by 2002:a17:903:3546:b0:267:e097:7a9c with SMTP id d9443c01a7336-290cc6d4ba8mr332311835ad.53.1761244083585;
        Thu, 23 Oct 2025 11:28:03 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:74::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e0f64f9sm30846755ad.86.2025.10.23.11.28.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:03 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: [PATCH net-next v8 00/14] vsock: add namespace support to
 vhost-vsock
Date: Thu, 23 Oct 2025 11:27:39 -0700
Message-Id: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJxz+mgC/5WS3WrbQBBGX0XstafMzP5pTSl5j+KL/RklopGUa
 lWREvzuxapJXDk3vV7OOcPyvakqcy9VHZs3Ncva134a1bFpD43KT3F8FOiLOjaKkS1qtrDWKf+
 AdVikLpB0ZCpMyJnVoVEvs3T966b7rkZZYJTXRZ0OjXrq6zLNv7fOStv7pjSE/ypXAoJO29hSi
 Sm0+eFxiP3zlzwNm2jlW9jvYAYCHZAie61J2j2sb2Bud7AGAmopdo6c7rTsYfMBW9yXDRA44Rg
 8O87F3cCH6/e1aO8gBLRBsqWYiOhhkCV+BO1NkPSOtUBgxNtsorFZ0mdB9ncQAqZoW0xSxKZd0
 N0G98c6IAixo5yRdUD8JBjI3UEI6ExhSZjbUHZB/x4kZNqxfmMdJZ9ch+3N71x7/8Wczn8HOsv
 PX33tl+tKB6k1bjM/Nl+vUr5Kqzx3F22FbdUQxwL98DJPqwwyLvUyVgQpksiH4ozT77lvlxtTr
 AJ5GoZ+OTbBccw2xxCizVq8cYHJps5469kYNMilKzao0/n8B79To5yXAwAA
X-Change-ID: 20250325-vsock-vmtest-b3a21d2102c2
To: Stefano Garzarella <sgarzare@redhat.com>, Shuah Khan <shuah@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryan-bt.tan@broadcom.com>, 
 Vishnu Dasa <vishnu.dasa@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: virtualization@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

This series adds namespace support to vhost-vsock and loopback. It does
not add namespaces to any of the other guest transports (virtio-vsock,
hyperv, or vmci).

The current revision supports two modes: local and global. Local
mode is complete isolation of namespaces, while global mode is complete
sharing between namespaces of CIDs (the original behavior).

The mode is set using /proc/sys/net/vsock/ns_mode.

Modes are per-netns and write-once. This allows a system to configure
namespaces independently (some may share CIDs, others are completely
isolated). This also supports future possible mixed use cases, where
there may be namespaces in global mode spinning up VMs while there are
mixed mode namespaces that provide services to the VMs, but are not
allowed to allocate from the global CID pool (this mode not implemented
in this series).

If a socket or VM is created when a namespace is global but the
namespace changes to local, the socket or VM will continue working
normally. That is, the socket or VM assumes the mode behavior of the
namespace at the time the socket/VM was created. The original mode is
captured in vsock_create() and so occurs at the time of socket(2) and
accept(2) for sockets and open(2) on /dev/vhost-vsock for VMs. This
prevents a socket/VM connection from suddenly breaking due to a
namespace mode change. Any new sockets/VMs created after the mode change
will adopt the new mode's behavior.

Additionally, added tests for the new namespace features:

tools/testing/selftests/vsock/vmtest.sh
1..30
ok 1 vm_server_host_client
ok 2 vm_client_host_server
ok 3 vm_loopback
ok 4 ns_host_vsock_ns_mode_ok
ok 5 ns_host_vsock_ns_mode_write_once_ok
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
ok 23 ns_mode_change_connection_continue_vm_ok
ok 24 ns_mode_change_connection_continue_host_ok
ok 25 ns_mode_change_connection_continue_both_ok
ok 26 ns_delete_vm_ok
ok 27 ns_delete_host_ok
ok 28 ns_delete_both_ok
ok 29 ns_loopback_global_global_late_module_load_ok
ok 30 ns_loopback_local_local_late_module_load_fails
SUMMARY: PASS=30 SKIP=0 FAIL=0

Dependent on series:
https://lore.kernel.org/all/20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com/

Thanks again for everyone's help and reviews!

Signed-off-by: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
To: Shuah Khan <shuah@kernel.org>
To: David S. Miller <davem@davemloft.net>
To: Eric Dumazet <edumazet@google.com>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Simon Horman <horms@kernel.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
To: Michael S. Tsirkin <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Eugenio Pérez <eperezma@redhat.com>
To: K. Y. Srinivasan <kys@microsoft.com>
To: Haiyang Zhang <haiyangz@microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
To: Dexuan Cui <decui@microsoft.com>
To: Bryan Tan <bryan-bt.tan@broadcom.com>
To: Vishnu Dasa <vishnu.dasa@broadcom.com>
To: Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
Cc: virtualization@lists.linux.dev
Cc: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org
Cc: linux-hyperv@vger.kernel.org
Cc: berrange@redhat.com

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
Bobby Eshleman (14):
      vsock: a per-net vsock NS mode state
      vsock/virtio: pack struct virtio_vsock_skb_cb
      vsock: add netns to vsock skb cb
      vsock: add netns to vsock core
      vsock/loopback: add netns support
      vsock/virtio: add netns to virtio transport common
      vhost/vsock: add netns support
      selftests/vsock: add namespace helpers to vmtest.sh
      selftests/vsock: prepare vm management helpers for namespaces
      selftests/vsock: add tests for proc sys vsock ns_mode
      selftests/vsock: add namespace tests for CID collisions
      selftests/vsock: add tests for host <-> vm connectivity with namespaces
      selftests/vsock: add tests for namespace deletion and mode changes
      selftests/vsock: add tests for module loading order

 MAINTAINERS                             |    1 +
 drivers/vhost/vsock.c                   |   48 +-
 include/linux/virtio_vsock.h            |   47 +-
 include/net/af_vsock.h                  |   70 ++-
 include/net/net_namespace.h             |    4 +
 include/net/netns/vsock.h               |   22 +
 net/vmw_vsock/af_vsock.c                |  264 +++++++-
 net/vmw_vsock/virtio_transport.c        |    7 +-
 net/vmw_vsock/virtio_transport_common.c |   21 +-
 net/vmw_vsock/vsock_loopback.c          |   89 ++-
 tools/testing/selftests/vsock/vmtest.sh | 1044 ++++++++++++++++++++++++++++++-
 11 files changed, 1532 insertions(+), 85 deletions(-)
---
base-commit: 962ac5ca99a5c3e7469215bf47572440402dfd59
change-id: 20250325-vsock-vmtest-b3a21d2102c2
prerequisite-message-id: <20251022-vsock-selftests-fixes-and-improvements-v1-0-edeb179d6463@meta.com>
prerequisite-patch-id: a2eecc3851f2509ed40009a7cab6990c6d7cfff5
prerequisite-patch-id: 501db2100636b9c8fcb3b64b8b1df797ccbede85
prerequisite-patch-id: ba1a2f07398a035bc48ef72edda41888614be449
prerequisite-patch-id: fd5cc5445aca9355ce678e6d2bfa89fab8a57e61
prerequisite-patch-id: 795ab4432ffb0843e22b580374782e7e0d99b909
prerequisite-patch-id: 1499d263dc933e75366c09e045d2125ca39f7ddd
prerequisite-patch-id: f92d99bb1d35d99b063f818a19dcda999152d74c
prerequisite-patch-id: e3296f38cdba6d903e061cff2bbb3e7615e8e671
prerequisite-patch-id: bc4662b4710d302d4893f58708820fc2a0624325
prerequisite-patch-id: f8991f2e98c2661a706183fde6b35e2b8d9aedcf
prerequisite-patch-id: 44bf9ed69353586d284e5ee63d6fffa30439a698
prerequisite-patch-id: d50621bc630eeaf608bbaf260370c8dabf6326df

Best regards,
-- 
Bobby Eshleman <bobbyeshleman@meta.com>


