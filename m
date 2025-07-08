Return-Path: <linux-hyperv+bounces-6144-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D282FAFC2FB
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 08:43:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2721428063
	for <lists+linux-hyperv@lfdr.de>; Tue,  8 Jul 2025 06:42:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEC8A221D87;
	Tue,  8 Jul 2025 06:42:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b="Yffa7m7r"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from out28-75.mail.aliyun.com (out28-75.mail.aliyun.com [115.124.28.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF6E21FF36;
	Tue,  8 Jul 2025 06:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751956929; cv=none; b=QuVXVSTVPIse13lrjxQ13rMeey7Lx8I+GGrQDgN1y/3qD8n4wWzO0acSye8SiegvKjxXpYV/uj4tW30mZshL6P/+nTsZG8EF6lH82IuJc73nUT2c8IjFcBp9/WgibOn5eICNHVcY7JARBHjml2ho2LryCjahIAGZ5agHEzS6EHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751956929; c=relaxed/simple;
	bh=Wv2kT9Ln8pLYeJZZzZEW3fma7QpVSKp+868WRyuBk30=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=IuwF33oHKuo2zju7loluFKu0Y/EWgTOgASl6PEkRHRWC3A/OGhNjZ12rJlmmu0W0y0COCDjKYGkoaBsqitcN22F2Nvjm276FWylgGeOxivwuEAI8GN/CVmdYfHoPaZQ2rgM3cSgPCkTI+Ytqm1g48M2JxP1s9uTyOc/qw24ZfxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com; spf=pass smtp.mailfrom=antgroup.com; dkim=pass (1024-bit key) header.d=antgroup.com header.i=@antgroup.com header.b=Yffa7m7r; arc=none smtp.client-ip=115.124.28.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=antgroup.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=antgroup.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1751956922; h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To;
	bh=aKt2ISTj4W3hvabaV4qI8Q34/Ft6hEq9xsElq9goj8M=;
	b=Yffa7m7rHok9lDIKWdPqfBYkM+MzTMgKVpoN5xU0TLqq7pYpNB5oCkbPPgGnT48t0BEJFWO1Wjuxf7ypM5IxM1cc91/vIZDKGEq9GOlenQtCz5DzB66XCZZp0nfT9Fo7/+xmp+pmL837+jG08XDaP8hnhw/19tA/A/ERMJ2v+rY=
Received: from 127.0.0.1(mailfrom:niuxuewei.nxw@antgroup.com fp:SMTPD_---.dhGPAOy_1751956592 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 08 Jul 2025 14:36:41 +0800
From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH net-next v6 0/4] vsock: Introduce SIOCINQ ioctl support
Date: Tue, 08 Jul 2025 14:36:10 +0800
Message-Id: <20250708-siocinq-v6-0-3775f9a9e359@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFq8bGgC/z2NQQ6CMBBFr0Jmbc0EbKGuvIdhgWWEWdhCWxsM6
 d1tiHH58l/e3yGQZwpwrXbwlDiwswXUqQIzD3YiwWNhqLGW2GIjimDYrkJTrbHVje5QQbEXT0/
 ejtIdLEVhaYvQl2XmEJ3/HBdJHvuvpv61JAWKbsSHVkPXXpS8DTZO3r2Xs3Ev6HPOX+D/ni6rA
 AAA
X-Change-ID: 20250703-siocinq-9e2907939806
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xuewei Niu <niuxuewei.nxw@antgroup.com>, niuxuewei97@gmail.com
X-Mailer: b4 0.14.2

Introduce SIOCINQ ioctl support for vsock, indicating the length of unread
bytes.

Similar with SIOCOUTQ ioctl, the information is transport-dependent.

The first patch adds SIOCINQ ioctl support in AF_VSOCK.

Thanks to @dexuan, the second patch is to fix the issue where hyper-v
`hvs_stream_has_data()` doesn't return the readable bytes.

The third patch wraps the ioctl into `ioctl_int()`, which implements a
retry mechanism to prevent immediate failure.

The last one adds two test cases to check the functionality. The changes
have been tested, and the results are as expected.

Signed-off-by: Xuewei Niu <niuxuewei.nxw@antgroup.com>

--

v1->v2:
https://lore.kernel.org/lkml/20250519070649.3063874-1-niuxuewei.nxw@antgroup.com/
- Use net-next tree.
- Reuse `rx_bytes` to count unread bytes.
- Wrap ioctl syscall with an int pointer argument to implement a retry
  mechanism.

v2->v3:
https://lore.kernel.org/netdev/20250613031152.1076725-1-niuxuewei.nxw@antgroup.com/
- Update commit messages following the guidelines
- Remove `unread_bytes` callback and reuse `vsock_stream_has_data()`
- Move the tests to the end of array
- Split the refactoring patch
- Include <sys/ioctl.h> in the util.c

v3->v4:
https://lore.kernel.org/netdev/20250617045347.1233128-1-niuxuewei.nxw@antgroup.com/
- Hyper-v `hvs_stream_has_data()` returns the readable bytes
- Skip testing the null value for `actual` (int pointer)
- Rename `ioctl_int()` to `vsock_ioctl_int()`
- Fix a typo and a format issue in comments
- Remove the `RECEIVED` barrier.
- The return type of `vsock_ioctl_int()` has been changed to bool

v4->v5:
https://lore.kernel.org/netdev/20250630075727.210462-1-niuxuewei.nxw@antgroup.com/
- Put the hyper-v fix before the SIOCINQ ioctl implementation.
- Remove my SOB from the hyper-v fix patch.
- Move the `need_refill` initialization into the `case 1` block.
- Remove the `actual` argument from `vsock_ioctl_int()`.
- Replace `TIOCINQ` with `SIOCINQ`.

v5->v6:
https://lore.kernel.org/netdev/20250706-siocinq-v5-0-8d0b96a87465@antgroup.com/
- Correct the author
- Fix a typo in hyper-v fix

---
Dexuan Cui (1):
      hv_sock: Return the readable bytes in hvs_stream_has_data()

Xuewei Niu (3):
      vsock: Add support for SIOCINQ ioctl
      test/vsock: Add retry mechanism to ioctl wrapper
      test/vsock: Add ioctl SIOCINQ tests

 net/vmw_vsock/af_vsock.c         | 22 +++++++++++
 net/vmw_vsock/hyperv_transport.c | 17 +++++++--
 tools/testing/vsock/util.c       | 30 ++++++++++-----
 tools/testing/vsock/util.h       |  1 +
 tools/testing/vsock/vsock_test.c | 79 ++++++++++++++++++++++++++++++++++++++++
 5 files changed, 137 insertions(+), 12 deletions(-)
---
base-commit: 5f712c3877f99d5b5e4d011955c6467ae0e535a6
change-id: 20250703-siocinq-9e2907939806

Best regards,
-- 
Xuewei Niu <niuxuewei.nxw@antgroup.com>


