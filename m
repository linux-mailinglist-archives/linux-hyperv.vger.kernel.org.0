Return-Path: <linux-hyperv+bounces-8071-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 31CCECDAEC5
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Dec 2025 01:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F60B305E733
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Dec 2025 00:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98A22459FD;
	Wed, 24 Dec 2025 00:29:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H51LNra/"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C270E1EC01B
	for <linux-hyperv@vger.kernel.org>; Wed, 24 Dec 2025 00:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536144; cv=none; b=HO+e4aD5hHcjCzm/3MgznZH3kgDDns8XorUwIPfsKFu+LMUsucft2SL69K1+Uu9WOQ6VITNthJZ/HyryFKGe03rTuDkNmwuPgJnEsUiGH8u4Sq+TxlR1TIITXepvrGoBJYtxXygHFp5p0BhKQ04iChlqx+849boIoT3PxEtXwAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536144; c=relaxed/simple;
	bh=8kT9Sce1CZrAgVQ7vnNZA70o4fM254DKC0wfkmWzB90=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nSYrG0GOJB4y3q1L/pSxAqaSWoB+K0P/7K/GXJ1CIRokIUgOLEPm3bYvewqorRDXidQd8+xhVdEQDjSouHLjZgnksttUCkMvK1p+Lrwp3bgUZ0G1paD4mz28T5yczx9XKv3xLKrT9QK7u2e57TeDunT5eqTJ8j0tuCl+EsVVfMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H51LNra/; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c708702dfso5699853a91.1
        for <linux-hyperv@vger.kernel.org>; Tue, 23 Dec 2025 16:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536141; x=1767140941; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uP5dCmGJx/cfUOeiPby/DoTXnEYYyl2lr0FiheN3O+M=;
        b=H51LNra/E20XnIqPm6Sc47fNArqriNF6rwLiVuX6PRYhE7mgrUSuy1LUHsGMB9vQ46
         RDhz6J9PQDuzmBA0VfceITP/Dtm6w4GD/253tIkzLjpbDF9/cq7Qm5aEjAjWE3MSqsM2
         H38EsDR6mpny8TpchTiuwUXqu/Yz5RPviKEy767b9ddkQqPpu846VWIJYT8Acqg/sJ90
         zVLiTkn68wqwdFeeZSI8MB+cdSbf0VIGTjFSyDC/CFThpzIZW10B+GuUokCBmfUWZRAm
         qr1lz9m99CxsYQ6Xy/UoI+MUdalzQR5t/WVPSWVFpBDPll6NT7DEK/FcfzW7fIOhomUk
         4hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536141; x=1767140941;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uP5dCmGJx/cfUOeiPby/DoTXnEYYyl2lr0FiheN3O+M=;
        b=U0O7qEGcNr2QNXve88f6Vylv+2NtThzQpOS4SZQeuyTTaloZ1rmXApmB70HgLWS/nD
         2qiyiGlQjTZpVLY9OS7+pZIx2KIG9qsMeNCTbFopfLq86/9OeJ0Dzq8xcjJz+Bfz9oL9
         pe0+SQ04OdQO8pdFhi/ezD0sRW5KaGKRXmaa9a4xYs6/Ya1OQ8QaBxcVjjEy8nIYVvDW
         SjnQoJfyykzEhaLFqHv0SLtxKqh8Qx5o0c9j3TIZPc5oenBrgxD2bO+CMtEMdwKv2mJH
         AGXF2HKHwQAaJB/yGd2O8vQ3KVY1yojBMxEyXfTv5TcsZxbqM6tqMB9iszBWr1aJx9bm
         i69Q==
X-Forwarded-Encrypted: i=1; AJvYcCXZlcpYgonQyTPgRN57k5X00eb6cvknCFcntNTVrskA/+Edzy8zF7TkSowHLnQjeoVgZDc0N2l6ZzejhMw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaeGq3TTTPV7cQIBoqFix+tgxQ0bXzhq7jofWwM0zffbnTD3Fg
	fTGM2j34coV3PnnHoADogAslcnIje1ACcJbswk/sk14mxhs/OON5ZOqx8Eqlfw==
X-Gm-Gg: AY/fxX4Nu576w1j2WFaBW6UXc5rE/PuQJpSgl92vh7u0NQflJz3ON7Foi1PaluadCay
	+btJTot4kbHcIppedKUv5F2dkYNEqwDZzfJpn9jZA2ycyo6oFsblWL4ikkH4FWowE8jVpG1ZH3A
	CR+FePkZIGgLF76V9KgcvJfHoTFMQoA9DLzVIOZX/dVhmVmqcpyHHINkBEBM1hHVCHXVgwz0WUh
	fi+Z9OO920yvrLTL3M7w251BgOcbYecRBr0NVz410T7OduSKMiinB68X910kq2GTr1DY8/MuXCy
	p+i3MCuJRavTmspMy68Ysx+rufysE90P68kcOJRsgk7bs4QIH/tnTvLX4/+DgB5qXaMBfNrdENv
	ZWZ6WI/DmP2zgneiyyy5kWRZ/Zf2iUBToCkVzWC70OaOuehUCmWW8kovBNzOESu3GI5g+CcJv8q
	rSFSINnrWhZg/vw0M4hWM=
X-Google-Smtp-Source: AGHT+IHYttjQEhb9KjxqMyLHj/1hdXCnFP9vzlZa8bawr+JTs4i5zRKkDDsgduCmLxwKQO9RWMQpbg==
X-Received: by 2002:a17:90b:2688:b0:34a:a1c1:90a0 with SMTP id 98e67ed59e1d1-34e921be0e1mr12335108a91.28.1766536140885;
        Tue, 23 Dec 2025 16:29:00 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:3::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34ed530475bsm2112700a91.8.2025.12.23.16.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:29:00 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:39 -0800
Subject: [PATCH RFC net-next v13 05/13] selftests/vsock: increase timeout
 to 1200
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-5-9d6db8e7c80b@meta.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
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


