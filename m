Return-Path: <linux-hyperv+bounces-7300-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D13FDBF95B6
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Oct 2025 01:51:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9DEB19A2EAA
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Oct 2025 23:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E3A12F7460;
	Tue, 21 Oct 2025 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="acBU5El1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CCC82D9EEF
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Oct 2025 23:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090445; cv=none; b=lnUwuFu4vg/AWRwm4nvJD61uONMbsmWSFIpppXwMjpITVvcmXdunQOtRaoC39Ldu6ByDr4WkfHZC1ZxV0RAqfFMWCUIVfQxF2X6sWs6tI+xsnS2sWCpyOVrTbmo2WmB8odTV9cKiCLPk6hxgsM2Mqh0NGkdZHfUNQr1Xi1wFyLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090445; c=relaxed/simple;
	bh=Vq3JxLDexMAZpBZBOMz7RcnedkE0owAELSAnlUsmBpE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jdfm/UmHN5pMRb6bLQPpiF61AUYi95rpHA6KP3g+d0SNzeAraD0YWjrUB9TbOtzNS4N12qqB9YPU/37yc7L6DWkvSb1CMPrqIgyOTluhuTaOxvk54utoTzxVN8v38DOxGeTFSa4dnRjdInlIJKq1EX9ayRGdp8XADaPdd59RTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=acBU5El1; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-269af38418aso76751105ad.1
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Oct 2025 16:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090437; x=1761695237; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ziglltQonD40PF3NaoQP9RaIb5nYxZqEFCDNXD/J6U=;
        b=acBU5El1XUnF5ahrQ6RY667sgPxLgA4ZdJwjIRnfSKapdKibrM29eTmpmAJGeNqGam
         Vcpo5EVSM/PpE88hHnTPEhkCDnqRwI4cGqC5L+itv6PdAMBrIWmxYm6c3+oEBeygAmy6
         fu5bI3vqAMWu3xJuEIO0Rhb3GHPzv9pf+BzPM1LR40a9FHLJsf75hxbid5OouU2WBszC
         1uLIzC2hXnfIslq5jjHwcFSVb2CGnHOC6lJ6DmmhpmukPvJhLqyOQ/Ki5YffYmkwXBwl
         IVfJNKxJtnLyzFbeScTbyoOKiaWotKOmkrnlWFw7QJU8JyZV0addM1hna8phjUUpizMN
         04Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090437; x=1761695237;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0ziglltQonD40PF3NaoQP9RaIb5nYxZqEFCDNXD/J6U=;
        b=gtJllygt45kRiwbrxPE0TNR2N98kw/6s+uqrTh4Avk2KIKN87tiBMR8I9zd90H+MgC
         SoW8nOZeWDd/jt/E2sBV3PqegD68I0jae0O1HdyIgDzu+z5chyTPC68slV7fqU2SB8Xj
         6ekhkbU1uIsdypgL4jpXp+A6ZWvXFLG47sWlVhZsOK0MKys+oRi2nN2Q0OqFaoideA1O
         fGs9z1X+eTY8TDDRvvFz4Jisvfpjea7bL6kYm+BrFYVQ8mqkTMbSuE7fU1XjoKWmmJtg
         +16HkpN6JTTlSsXJVhBF/gj8PGM5BveggmbKUvvQWdLCLHBKO/XLj1TNipn7AhqV/HqO
         GCcQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjERQsHQQU7Rhx6irVpl5klqkw+n/vOqUyD6ZkeyQrOZFgPo7IrFetKEgjrWmNFqF5LrhrPvlxsfHPyvI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9RiiKEbVmlRHmaKksHtdyTm5PG39WnDHn7QTDODsUmJ5C5jwW
	nS/NAm9ZMgaQdrA5jLwKQ4dC0ig2ITLM+Mu+uMGPHWyTyGppSYILOOq3
X-Gm-Gg: ASbGncufzhaeG7xBzR7whJ9/seZDCfKY8x5BiJxz/q7WqS1Tb5batOwxUcuA3oQG4Eh
	e9/1Jj7mSSCgyBIonIpr7sZKa0SMcuUxXDVrpAr0hisj6A5rUHafbQoUeAsKu4hBp8DxHDmVKWF
	yIQTpvUUhQfxTzIwIVWvDwBIywQBXiGoOfWeYaR90FjT8UZJoDLXl+yaqHaLJPkILIFPC18IXKo
	m/b7A6PGOZY98lUfOzLHKEB9ND7cVYuoDImhY8fwqnAkFzKIMlgCWkKpfnWlLON43y0ey+xJK+5
	9te5X2LW+U8S6u8Z2+GqQVdWKAP0wAPnTXhPGm+9DZwfgzgV5fiAxCdA77S8TYVEngho1SuniT9
	n/PJY+OQ72qffpu2Zt5iuKUO/+r1ruROvsDYHYe5dHZbTHccqk+HOGSQbdA4Lf5KIakv4IuWdU8
	OCrH6PUrBo
X-Google-Smtp-Source: AGHT+IG5dGgoFfjLOrDybopHtR5kmquL2RmRYL/ZwgLqL0f5q8OPShyxosfyQ4g18ky0R7BE1MkTfw==
X-Received: by 2002:a17:902:e84b:b0:290:c0ed:de42 with SMTP id d9443c01a7336-290caf8582emr300060005ad.36.1761090436967;
        Tue, 21 Oct 2025 16:47:16 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-292471fdd10sm120304085ad.83.2025.10.21.16.47.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:16 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:02 -0700
Subject: [PATCH net-next v7 19/26] selftests/vsock: add BUILD=0 definition
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-19-0661b7b6f081@meta.com>
References: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
In-Reply-To: <20251021-vsock-vmtest-v7-0-0661b7b6f081@meta.com>
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
X-Mailer: b4 0.13.0

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add the definition for BUILD and initialize it to zero. This avoids
'bash -u vmtest.sh` from throwing 'unbound variable' when BUILD is not
set to 1 and is later checked for its value.

Fixes: a4a65c6fe08b ("selftests/vsock: add initial vmtest.sh for vsock")
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index e8f938419e8e..9afe8177167e 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -626,6 +626,7 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
 while getopts :hvsq:b o

-- 
2.47.3


