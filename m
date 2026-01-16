Return-Path: <linux-hyperv+bounces-8342-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB4BD3885A
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 22:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C5119301A22E
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 21:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CC00314A95;
	Fri, 16 Jan 2026 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6ZuMxt9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F237D308F0A
	for <linux-hyperv@vger.kernel.org>; Fri, 16 Jan 2026 21:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598952; cv=none; b=GDcSBRc3PjE/W6JvRit5rZOL3tbpLZozoClP5OdG9oIdUDSmjQzCBMpxlC5EfU7WOm45wpSLyj3RcSrbVBV8TeNd9fzXcHYF0uMLrpbU7IruyjtVWX3I0vcVIKzYf8snJquACIypJnVXpnvBqY/DgRh+Ey1ou+Ow+8l1jmwJpXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598952; c=relaxed/simple;
	bh=QFGTndIZnCvd5tocHyARHg0OdzlZifxdeujSy28wwJs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cpAAOszMIfT6KmbC1rSOuJQtWWGYpt0MPh91zxJXbWQ4TdUSkEhMYWMIlFXhIAcW4BRC2Mpgev/hEdFubkl3GeLP/Pg+3zIqKOsuKJRi7GB+Q957gRnRr2FOxkFgfzecHIoAJdBWXst4xf5tn5B+4LrhYocIYTf4CuthvhwSY/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6ZuMxt9; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7926d5dbdf7so20595327b3.2
        for <linux-hyperv@vger.kernel.org>; Fri, 16 Jan 2026 13:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598946; x=1769203746; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mqm0dBa6mjJHml1X9kPKSm15M0oyticD3F9JJwXOMvg=;
        b=N6ZuMxt97tRHsctEEofq6oCk4HrU+Bc4QwXdsJmotoTXAOmHwj31WOS8aazpc/8MmR
         ie6rVcjI4jO5c2YBazRZC6Jysgi1HYSF+nKRUQ+ANXgmo3xmlJgIsIx3xI7ssB9UTNGG
         An9nQhkeL9c7ftpUxYfA7cyz4PG8msfg75fyWelol/Iir3k/WYNZHKz2VWbyBrUPlOWI
         G0EBl9XgKRIDxsTIMA83B6PcMvJNvpKBlIWZJ32KYNtmZRkSb4XpB/3gBj4WP2QpxMh8
         R2z9Qgi3gU+Ns+2ZE2+9DxM6wvJfOtdSjDLIGM55lfKLwxqlN97GHOSRt+QSzNSNYxDK
         C+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598946; x=1769203746;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=mqm0dBa6mjJHml1X9kPKSm15M0oyticD3F9JJwXOMvg=;
        b=X48aCHvrtA9YKtWzhPAjLUjWq+PclBgCGbMbHezmPHKduzGWiTfj6pB+4NI8MRFJGg
         FRtQsUqbKjxbgE8i5F82z7JYLhnCTZ5rYyDbO2FXVG6vLhPF1YZQFQCKXTyembv6OALA
         Ht+Pttp81yv+qwmZUtBQThim2CmZNSfAA+5F7Hiq1xqK0EnxXJU1J8Q1W+QtUnBM9YWD
         loCnmwhlX74sVF/nJg8ljvnZJ3cyZ+aNMXz1YD8Gww56PqybJgRPBMXxikbxsDTEK32p
         J+TqTq+j0bcYHSWLzVEvGMeKx0muK2/h4ssKefDFrz2fFkoP1Dt+votWPxxx+/IxEOV3
         JDNA==
X-Forwarded-Encrypted: i=1; AJvYcCWX6AvOgi04SEcXi94i5qNj/9yjxNos+idW5dsKlpHb8Bc0b4Jrcm3hL3a9IwANunXolPtYnfpPPoKcoD4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXxP70BE1ymj3DzgFwNEYZteAGGKXbsOEaYRJkfeKC1vZPf6X4
	PgONvcin4t1Rl8Ln6Z32J1KnDFAzNt2m1EpCtQXkVjv5I1hmqLrWUfIP
X-Gm-Gg: AY/fxX7O+2iJjnLAVdcaMhXX4AhVLasoBBxkac4BzB9Tj5fB+jQJAEchSJVXQxsM7rp
	/BYPhIFmy4qMkKP3W4oAhGgbdNBC6dUIZfVIeulUmQ7TB2lMOgN4qHxX2szw4Mt7Y+QNLCLjQx8
	XKKotBLJ1P/1/+h0txh9ofUbIL0NeQVcO4Q6+F7sYU/qddjTagiq6R8RSQoc0+/wCoxWxV4TIaz
	sdEUVlJM+D2IRAd/gh3Z6l1Iy4th7r1MAEIUsI4vFsLqfxi4kTKmq6s0M06JKKB+YZsVVc0mbhJ
	nmf5upmVr/yrScLkDJl0oSce7h3LmZMZSflOd3ZLpFsVUN3GFaq5KLYiEk7d9r4+wPOdahBN/YU
	nOXmksRMqsFhJebwmPhzkDfkthGX2N63Z2zb/F9BD/VywRCZe6FyHgkzm7ew9ZBQ6Bo/03qPAc6
	OSGREl+e+Q
X-Received: by 2002:a05:690c:e3ea:b0:793:ad61:b5d3 with SMTP id 00721157ae682-793c52e44e4mr31233967b3.31.1768598946238;
        Fri, 16 Jan 2026 13:29:06 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:a::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c6882ea7sm13097717b3.44.2026.01.16.13.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:05 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:44 -0800
Subject: [PATCH net-next v15 04/12] selftests/vsock: increase timeout to
 1200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-4-bbfd1a668548@meta.com>
References: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
In-Reply-To: <20260116-vsock-vmtest-v15-0-bbfd1a668548@meta.com>
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
 Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
 Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org, 
 Bobby Eshleman <bobbyeshleman@gmail.com>, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Increase the timeout from 300s to 1200s. On a modern bare metal server
my last run showed the new set of tests taking ~400s. Multiply by an
(arbitrary) factor of three to account for slower/nested runners.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/settings | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/settings b/tools/testing/selftests/vsock/settings
index 694d70710ff0..79b65bdf05db 100644
--- a/tools/testing/selftests/vsock/settings
+++ b/tools/testing/selftests/vsock/settings
@@ -1 +1 @@
-timeout=300
+timeout=1200

-- 
2.47.3


