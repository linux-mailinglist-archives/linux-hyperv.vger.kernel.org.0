Return-Path: <linux-hyperv+bounces-2510-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD0BE91DA1B
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 10:37:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4769DB207FC
	for <lists+linux-hyperv@lfdr.de>; Mon,  1 Jul 2024 08:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE111C144;
	Mon,  1 Jul 2024 08:37:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dg771uiv"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6879D2C6BB
	for <linux-hyperv@vger.kernel.org>; Mon,  1 Jul 2024 08:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823070; cv=none; b=UCsb2Oz1nW3r8IwgKClUUeznSynrOP4t+OgCIh9noDVbcVFIMYWG8T49QTGpjhmGWxXDtH+uNZ2COE0Z4j6VY+aaBYP1vTbpH2k3Sa9dCwi629t6Jelv+1M90OMUly3w45Tdyha5obs9XzR/uWkZ8RC3chIHO1/YxRXVsPDv23c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823070; c=relaxed/simple;
	bh=c4cWViksxlV1AZY1IdTsd8wh4QTXnLbNVosxvs7/Js0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=IZO1wuli0JbY1dS2GETq2iKykLI2KSAmJG0+Pex3tIsnoc0/L8TblyaeOD6m6Atw/O3/E4xbqOji3gj5eL1VyqoC0EuoKC3htv2Ar5de2XN4gIpsk/gvcz+opTfeKIYl5be46+9l712KQUQppI0xYQTOA3hKbUmx2UiPyzuFiNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dg771uiv; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-70683d96d0eso1448632b3a.0
        for <linux-hyperv@vger.kernel.org>; Mon, 01 Jul 2024 01:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719823068; x=1720427868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CLT2u1IgJly2bHB8vwMCHTWIybJZJ4OoHUhhxxDVW70=;
        b=dg771uiv3ZrEZPm4o4bv/4iO63EHkStIjxLC6ccUN+fowuR9wnhC3cGZ0ARJh3KMxT
         qGdBqys+KFWyXUSg4TG3P4L6dToKrxCpEKrZR6jLoYwdL6WTZEbYoKgS60t5Ndu8gFTN
         Mp8HzRfmf3ops+0asOobrdTn7TlPhCcvw838We5nrBMzanE9YilZjeLcIVbL5sfQX1Vq
         mVHCJ8UsIRS6o//DRGSU5Ko718zZDNIqL7ckrLp0FeetE9LTTTDVcg9mlmxkiFpX5PNw
         KdI2Wys58wUohFIpjJpfNnHjlr6EpeJl0d5/JW9m2mHuQM6ZZGjoc0DVFq8zc3XwAu6g
         um+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719823068; x=1720427868;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CLT2u1IgJly2bHB8vwMCHTWIybJZJ4OoHUhhxxDVW70=;
        b=Mtl0RupRczn2EBiTTqrvOGs+9sqaic0/wevlCzyyPcbNeKSZElTEJDWb2RNqT0v/pc
         TB8ZTPjgS4WYpMWJnnjoGiTTwX9AmMmym2gs645XdUCmWxu7iibyFiQdg0Ga9UuSm9FB
         SmbpzgZqj9b3NMt7/K5yDhfxeXi2yWXPNknBBky+aKNBfGkXNiBWAjDz72suS5XcQoH9
         C82g7Qloik/0SCq3PLLSL6WC2NkQhm0tpIq3GykwEZj10plASaJ1CBRLPed/ngRKA958
         5ptYu/1XpvwU368xPXKpzPv1owEIKWd5213KLWkSzG+FY4m75qRNrxj0JHGs83j6J34b
         K/Mg==
X-Gm-Message-State: AOJu0Yy3GOxzV8VnQknYuKJ5QQmdtSRlUjMPJkVlthC4Es9NrrqWfIwk
	AlDzk6HsVMrAFbMHLNeNblxg2ShN7eWFqbySNYwRoTkyEee/oaInvk1ht7nG
X-Google-Smtp-Source: AGHT+IE9HB+eJ5SVVUnVnbC98u8fDPJVl6J+7M2+uguqVEKqdDmB5qOOHAJo4t0a4lpcao3Lx18OZA==
X-Received: by 2002:a05:6a20:a11a:b0:1be:c967:311f with SMTP id adf61e73a8af0-1bef611b816mr3598455637.13.1719823068310;
        Mon, 01 Jul 2024 01:37:48 -0700 (PDT)
Received: from lab-vm-annandaa-0607173234-role-0.. ([20.171.147.130])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fac10e2197sm59027105ad.63.2024.07.01.01.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 01:37:48 -0700 (PDT)
From: Anthony Nandaa <profnandaa@gmail.com>
To: linux-hyperv@vger.kernel.org,
	decui@microsoft.com,
	mhklinux@outlook.com
Cc: kys@microsoft.com,
	Anthony Nandaa <profnandaa@gmail.com>
Subject: [PATCH] tools: hv: lsvmbus: change shebang to use python3
Date: Mon,  1 Jul 2024 08:35:55 +0000
Message-Id: <20240701083554.11967-1-profnandaa@gmail.com>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch updates the shebang in the lsvmbus tool to use python3
instead of python. The change is necessary because Python 2 has
reached its end of life as of January 1, 2020, and is no longer
maintained[1]. Many modern systems do not have python pointing to
Python 2, and instead use python3.

By explicitly using python3, we ensure compatibility with modern
systems since Python 2 is no longer being shipped by default.

This change also updates the file permissions to make the script
executable, so that the script runs out of the box.
Also, similar scripts within `tools/hv` have mode `755`:

```
-rwxr-xr-x 1 labuser labuser   930 Jun 28 16:15 hv_get_dhcp_info.sh
-rwxr-xr-x 1 labuser labuser   622 Jun 28 16:15 hv_get_dns_info.sh
-rwxr-xr-x 1 labuser labuser  1888 Jun 28 16:15 hv_set_ifconfig.sh
```

Before fix, this is what you get when you attempt to run `lsvmbus`:
```
/usr/bin/env: ‘python’: No such file or directory
```

[1] https://www.python.org/doc/sunset-python-2/

Signed-off-by: Anthony Nandaa <profnandaa@gmail.com>
---
 tools/hv/lsvmbus | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
 mode change 100644 => 100755 tools/hv/lsvmbus

diff --git a/tools/hv/lsvmbus b/tools/hv/lsvmbus
old mode 100644
new mode 100755
index 55e7374bade0..23dcd8e705be
--- a/tools/hv/lsvmbus
+++ b/tools/hv/lsvmbus
@@ -1,4 +1,4 @@
-#!/usr/bin/env python
+#!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
 import os
-- 
2.33.8


