Return-Path: <linux-hyperv+bounces-8241-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B6AD166BF
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 04:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58CD53038381
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 03:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81F81312803;
	Tue, 13 Jan 2026 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNf5jAgS"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE0230F818
	for <linux-hyperv@vger.kernel.org>; Tue, 13 Jan 2026 03:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273982; cv=none; b=mOzr1ClXEs50lbl3zuklJQQ+eNLzLMDXHvJemNmes1BcQahi9WzpjfijkUnPIV1aaxjLTBoKIVrKn5cWoch1XdlF4XmPI1bgfo9J83sHT7QoCgVDK9gQQUAnMtw0SBrRzQB5n5Zktg1r2lzJNzyo5yhh6iU3QrNMGRgiX/ZxS/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273982; c=relaxed/simple;
	bh=8kT9Sce1CZrAgVQ7vnNZA70o4fM254DKC0wfkmWzB90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uSGJMGi5uC8hL7i2BecFP3m2h3/9ZUUIpZd3fzOrsJKTv4+um88cHnTwWwUF89IQs2YC4pJZWLa16X/6/+XHVD84s09nk6ye0JGOTCx1LVlZzlAOzXwnC1Jlcg0qDqwoNkCD1hUYMoIXVWfLTJeczUfwmRhnLECNoimklXUHrQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNf5jAgS; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-64760131fc1so3750597d50.2
        for <linux-hyperv@vger.kernel.org>; Mon, 12 Jan 2026 19:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273980; x=1768878780; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uP5dCmGJx/cfUOeiPby/DoTXnEYYyl2lr0FiheN3O+M=;
        b=kNf5jAgSfyX83zzdIsjOmR0MpWpvZAPS3A6ymeDkmMlJLH+GYer+D1vPm+Sb9M8/Ky
         Kxaemr6+MEPEybdfLaAEaJt06RaLvSdZpnbfQBlFD4zb1JfA9GAbru597Y++tW1jUWi9
         iQKsofYC23fgZsAmzW4P/m/9ts+byCXIxLPctBzRPVOVO2/naIEUjhlTKwB4pauE18Uw
         U0MKanpcuxsfZHHTmTNetDFspfmXJDrAuwK0+eP/Amn5QR2AW0Tl4+iY9v3W7qZA2hwX
         Wrf8uKvIsOlxj/VpeKSCfO+uzwUmAKcMXlQccJ4YkVJKTtw8OIwUrOxYizFZ99mRkWls
         R2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273980; x=1768878780;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uP5dCmGJx/cfUOeiPby/DoTXnEYYyl2lr0FiheN3O+M=;
        b=JBYrb6XDwcPoQs3o6cmD1j7EcOZeCGj4oJTNSrzaNNuqN4j0zv3i2IB2RcQWUsRUAR
         OtHPi82EeHnI45oEPG3pflTwlrVTRIH/UsFkppdguwtXbsfHF+qShOBjBJtStw0TF+68
         6ESrnKIu9enw3A0rNWd+P7ec9LWM19GKE/2VFIO2n4I06xPC8i1HIDcz2TGL4/p8V5wd
         DE4ZRPjIRFgpNs3E2BbKGIq1KVqCaFgFL/9/NsJ2RQj1q9HIi8lvja/ziyI9IBk1Ngyc
         ++lBI48K/PIXIJhLvBEL8ZhGnLxU9lzQmOs57NN0LCAXdbEluzCn5HS4BaJ3gprOmtfW
         fxxw==
X-Forwarded-Encrypted: i=1; AJvYcCXNF37KXK2vZAMfVqTJd3VojWw1pDgEUNCufHj2s7a0dxoTHyqyNdMx2AId5EsFK1WJTUsFDbtjd1SBCvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxgbeiVi05G7tUpOFAWA99S+OfNhj207M3AqeiPAd3Dgxx5+eO4
	t+V7YZgyMwbAA2Tr1l06/EWCc/gXlFzhsmB1Vy1mFqD5h+KrBD9HEiVBCyC9Cg==
X-Gm-Gg: AY/fxX6GzNYCKoHLElSheciWY25uzm0laNPvTVrbWecUr+FVZRNogtFz1AQR3ltaRN3
	OLYrSW6PcHTqZ7I3z6L3EadYWupDAtYzBzw8+qzdaWtH9tDP/KqPYxUF2dBC2XL4Dh/Fx7Y+zBf
	dkO9gZUH3uqt5DA+qItl2rYdLsBPoI6Ew+0nQTMJ8yhtonX/W7zIA+UtzBbojwLPx9PmemXOjxh
	NmUvI3ka6vTii2vtqMYmtIOt654jv+9h1F+f3X9w2ZEI6rzErAGjSjqUX0gmL7s/KC8IDiHCbsP
	gWxYzLnqeM+6RUOjrs7taQHugPlSmldqBRW/YyMiAqQ01/4vJeI/BMPLZnlwWClN4eZ3xgQ0K2x
	6jPVFbb742+h1LjL2BH0/V+jxw2PF+kBcf66VfQP9CBxt5mjKpWv7rsFQK9rfb/UmH4lCwctMRF
	kPmRuGQmSB4g==
X-Google-Smtp-Source: AGHT+IEb6SZC7b3qvFJYt3k7Bek7L59Xocc4oQtKoQnzhDn4qYGn5XzM6bedIh0Pal8eLsRvCLYfaw==
X-Received: by 2002:a05:690c:9c0c:b0:787:e3c0:f61f with SMTP id 00721157ae682-790b5834fe3mr369495447b3.57.1768273979828;
        Mon, 12 Jan 2026 19:12:59 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5e::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8c52b3sm8800897d50.25.2026.01.12.19.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:12:59 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:13 -0800
Subject: [PATCH net-next v14 04/12] selftests/vsock: increase timeout to
 1200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-4-a5c332db3e2b@meta.com>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
In-Reply-To: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
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

From: Bobby Eshleman <bobbyeshleman@meta.com>

Increase the timeout from 300s to 1200s. On a modern bare metal server
my last run showed the new set of tests taking ~400s. Multiply by an
(arbitrary) factor of three to account for slower/nested runners.

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


