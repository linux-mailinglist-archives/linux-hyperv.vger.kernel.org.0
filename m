Return-Path: <linux-hyperv+bounces-6110-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B828AFA319
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Jul 2025 06:37:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B08B6300ED0
	for <lists+linux-hyperv@lfdr.de>; Sun,  6 Jul 2025 04:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E7B3194A65;
	Sun,  6 Jul 2025 04:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVKhuxNe"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC8152E36EC;
	Sun,  6 Jul 2025 04:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751776629; cv=none; b=IfAIfYPqhVTZHJemZpShDGxKKTTZWR5klXMuC5Sqf0lg6NQik1O+ltp7/6qCTQJXg67lB8p0SjHKUG+YzBxQJYnjZlJnyhxq+AzhA9feuExM4rg6fkKNw2Dn1bno4mK99pp+ImYESowyZRKA5ZElB9H1L2A/m2N9rUT03cgJFrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751776629; c=relaxed/simple;
	bh=RB96hsETxyFhkCY3Rf/ba9ONKkbVHSSjgVT5eGABabk=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=Vz1QKALa8gfR/BsKF+i56i661VXxtrEgBDqyAFCFJi/kiEpKZ+KPyskpLNLkmMD90AvLYPkbZ3JFwjRr5frQeWwdLXI8BSVAmjN9klGYrx7YzGwCYBS5QSOen9fGBA+MWVR/uNn1c626N9POJY+KXJFhX6h5Q2QlLK4A2teEsE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JVKhuxNe; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-74b56b1d301so1207909b3a.1;
        Sat, 05 Jul 2025 21:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751776627; x=1752381427; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eDDm71p/LyQ0DztRLcG3POrUg3Q40Pul2j5qon54l58=;
        b=JVKhuxNeHYbEB8dQzhyNmujU6sV/VxN+JBRUWExNWxvxOvmGs02aIcLpotdgO6BNSL
         dRa92yNkWyHYX3vKJs17Wiz4nXB4Dd/a95RdQ5KOSB/pEztBP1276LgXdQOK/tLkJRfv
         UBzTvKFyHRGOev4460Sbg1ean/BUDA6va5zF01AlnE3K1biEJOYPiYU2XLRz6YVFjb9J
         aFncmVV6xQmFZoIWDHRtN3e95voA+MLSOwJUt9VverZ3XtopVs0W4wUCMzMvI6t5xTNa
         veOcnqWC2YvzYAo+lcQr7gUuH6oevUFdsTeyGoG6/0qSmnSnZdgiJS+pmMXbDw0R9GLL
         2C2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751776627; x=1752381427;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eDDm71p/LyQ0DztRLcG3POrUg3Q40Pul2j5qon54l58=;
        b=XNA4f/gdNISko2+m72fsHoyw0A2J9EfFEvTmPEFXrrwZ+mU3RKDP3929uwLFMl7XhV
         y9cw7lqlk3AlC1t+iLuBSveagGS1vTgXiOOqVxcBYe3eckBzTk47RagubBrhZm6nm9WX
         qSj4YT1bmbgb1gYB1qjWygkkiVqtI5kgH5K/Ob/tq33ycayCPc6AUat2auU0BqxWGtIp
         xyEZHICKr46pPkP1nh7bPVm8ZoVy8EGhqxM21lSqgXQCtdCQWi+wsWttKC8v/mVZwNxh
         jBW4b4VcD07C/odRsVRReMK/mrMQh429vfuEWK6pq2yCwWLCbDB+6MmJEeVvgcgSGY1m
         oEYw==
X-Forwarded-Encrypted: i=1; AJvYcCWDkLydvvZvweRoUURpWMj1k4SduzqazgLRAHXZxMTVXxKh81/DG6UkAfS1QvkSVJ7nhNsbU+a4@vger.kernel.org, AJvYcCXY3N+WGeasydpwRhEUG+B0FQUwL9W02tyYlcKuhCtPyFO+ee9zL80lJ3h6ebd+3DDXhSHLji2Bua0AjB4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyeiDbcAnOurFyVb3AlMefLpsJJMg0c+ZMcoKJik/ABJJa6pgiA
	SY8hYR7Y6Pi4qGkPhdTLc1tqddwgVjlI5e3mgfrmmkn9tRag+GOqcYGb
X-Gm-Gg: ASbGnct7zjOdG8Cm5Z/z2U+IqJNDTGk7eFVMdtQON5TU+KujYbSpIPCS7UQNiQQecQa
	AWkNAeh3MmEQrciP/bM0b1dZsQWGqVfikLiEHXIrMVwvnuTmJCvcfWK7AG/mzLS8PceXF8RXpft
	JB/2GNphPDAjvWEagV7LMlUAYjTMtWHeKEBS38lWdQsIGuK4t3qUyBMcw0awepKVEB1U7FfINHO
	JBaqiQcyWgwTVZQwKbgs7eXy9+oL/AzssjDq7Zoct55ad42+xiGW/wgJRKCJcgnF9A51/2PoqcO
	8qtKutMseQvWcvIF9zcAqRaxYQyt+BLbbsgIYbUzb2JlGn7jWJNcBFfuuZSy2ArxPg==
X-Google-Smtp-Source: AGHT+IFrSnC8xZNgvCqQZwnhSbar6h72ees0YA62Gk1LYF6Q/EVgY/OklZdSIQbVWRaludW1bdB8hA==
X-Received: by 2002:a05:6a21:6f09:b0:216:6108:788f with SMTP id adf61e73a8af0-2260ba7221emr12156252637.35.1751776626886;
        Sat, 05 Jul 2025 21:37:06 -0700 (PDT)
Received: from [127.0.0.1] ([47.89.83.0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce35cc2cesm6105137b3a.59.2025.07.05.21.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Jul 2025 21:37:06 -0700 (PDT)
From: Xuewei Niu <niuxuewei97@gmail.com>
X-Google-Original-From: Xuewei Niu <niuxuewei.nxw@antgroup.com>
Subject: [PATCH net-next v5 0/4] vsock: Introduce SIOCINQ ioctl support
Date: Sun, 06 Jul 2025 12:36:28 +0800
Message-Id: <20250706-siocinq-v5-0-8d0b96a87465@antgroup.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAEz9aWgC/x3MMQqAMAxA0atIZguhUrVeRRykRs0StRUpFO9uc
 Pzw+AUSRaYEQ1Ug0sOJD9FwdQVhn2Ujw4s2WLQOO2yMgsByGU/WY+cb32MLqs9IK+f/NILQbYT
 yDdP7fmU+x+FjAAAA
X-Change-ID: 20250703-siocinq-9e2907939806
To: "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Xuewei Niu <niuxuewei.nxw@antgroup.com>, fupan.lfp@antgroup.com
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

---
Xuewei Niu (4):
      hv_sock: Return the readable bytes in hvs_stream_has_data()
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


