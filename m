Return-Path: <linux-hyperv+bounces-7296-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91E99BF957A
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Oct 2025 01:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D74118C862D
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Oct 2025 23:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103482F39A8;
	Tue, 21 Oct 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+gt5wjc"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF8F2EF660
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Oct 2025 23:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090440; cv=none; b=ri3Vx0+UBjdZvL2MRuSrwYQQakyF7zH4pTbW0107Q04P0CydBBCHOHh8Aj32bBdGANHC/hmeLWPtLERoKW7Fz5VmViTiI30hMgzriij5RxkeOYuuuhJt57rU0R+6KAEG10LaaFcLhKnrwaVyqdjIQhC+skZoIA5NPAFjYguTCkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090440; c=relaxed/simple;
	bh=MF/czfrq9R+gzUXq3nakRInrzOwnmvgXgQyREpFMOsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Sqhvj7GqcdJ5/d0LTmdnQYTzpO9D5uBH9DrsnG5m4BCsDgdkuAkLM5zL2Xof/it7Ad5/E2Y0nkca8rZ7OnEAecN76HFRYnNWn16a9yKndgnrwPa6DS4Rvz46R7ui7RZqe0iJpDZC52MjaCghoQyBnIssZZb9PF7svbFgQ88apgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+gt5wjc; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-33be037cf73so4836425a91.2
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Oct 2025 16:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090435; x=1761695235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D6mUZMq9SVTZCVxtIiXitg02c6DGfDqdmAO69aX2eA4=;
        b=Q+gt5wjcUAWtZ1+Pa+QKWygd7P0u+N4yhjAijbU6jC2CCxufGapnDsR1Ijcr3Oi3SD
         ojh9jDqGB0Xnt1ExxkM7bqyKm9mi+xF830Wz1EgVDCSL/rsy/RoTL0qnEis2Y8ls1rO/
         pmqxqOPscZTQEs7Z942VDGmhNBd7iw2TDBokfXWzl2kPtB1n9Es0dK2F/TxAZj72N2e+
         68M+2YfrBnwaKrYKxcwcrHHhkg9gnxyf+9GvkRuJRAoXYObbpqbFd44a3bGVhfVsfsTe
         AaOiI5dmeI2ucyLa0eKl9kyned47owzg3NkYy1ZHB+n3PvC0Jdy2kd/kuntVANcluzAy
         udrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090435; x=1761695235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D6mUZMq9SVTZCVxtIiXitg02c6DGfDqdmAO69aX2eA4=;
        b=jnpk123OViwgxVl4IrW717TM/JJey3yaFPWUb25utGypRLayG2WfNkYxq4l3w73nOa
         TCe1dtJ8JkLNI+YZZIeQzh62JG+ArZVOIcFgQJURE+pq0fTFMlPDD3MXYK3luh/+ThPE
         09XEFEAaOgegGr0p9QZKCfs7WsQ0Nuk7mEyLy7wiC7Y7Z50O7butGqa6ze90Sjoo4oWa
         6j2mX5ybxL5PxF4YNWwa6b3uY59dkOOuYHYyYTpQniHtKtEIdnjEoEEUfy1CFb+DNLHm
         I+FT3gsYessuQuTkGor+d1Vsf6S/NnDq3ByoVaACFEXWMJ1jTsuXQO7ztVeCbtNim/Pr
         qOTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVUhx6c/npZFHoD3dOblD1qsZz31IQIQHEOJG927eADp/zD2rhIjH5DKOF5jk9llWoeXNtg34RmAgWEHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YziTjPPW4MSXTeU/EgJmdWxMm3PHbaISjxhRgF3Swx32HCFIk6p
	NCEgkSrXpOOBnKIzxFwoY1u7Oo7St1Ss3GXegARQBg9DL5laAFwWW7fT
X-Gm-Gg: ASbGncuuYTgtdf8ma7HYfm2ExrABROIAvZZlb2k8C4scc4MLiI1+9IC8jaAePK5b5Q1
	BrRVs/lRZWSW0BjWdtDT/JeG8Hed2Ixv/1uoof5V+fNsdc++eQIB0LwFhdHjgJhG0cJ1JAv9lwg
	uTb6vaEJNlOZmbAW9wV5yYfXDiIOHbMHaaBOPAC1/dbKUxw4sZkEickaj/HvTCj0BVo1lAPtmCx
	7DZt8AUSxESSowHao+FuUS5XBoMyuSXX75vRK3hZgJ2hwf2ffu7YOB8cZB81q3P3e1TylF0tJci
	lb1B+oQqI8Ak+m37t9c2GzhtrnpuW3p062cQ2KTklh6rWaMG891npn+c5tbkPjSHEYfu723bMyU
	n/s8HfndSgpDFG7kaoy7XwdZt23NPaTPBUFTc5W+bVrXurdgMtRGwpoogTZhWfSy0s0ssm4pN
X-Google-Smtp-Source: AGHT+IFVbMkOuOiBDnCJEvlMwLaZ7DlmhKs/V/NW1acHbQ/gNGtWZNBni32L0tz8fkkeIan2KaLV9w==
X-Received: by 2002:a17:90a:d60f:b0:32e:d600:4fdb with SMTP id 98e67ed59e1d1-33bcf8e61b8mr21858888a91.18.1761090435179;
        Tue, 21 Oct 2025 16:47:15 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33e223e223esm711430a91.7.2025.10.21.16.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:14 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:00 -0700
Subject: [PATCH net-next v7 17/26] selftests/vsock: remove namespaces in
 cleanup()
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-17-0661b7b6f081@meta.com>
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

Remove the namespaces upon exiting the program in cleanup().  This is
unlikely to be needed for a healthy run, but it is useful for tests that
are manually killed mid-test. In that case, this patch prevents the
subsequent test run from finding stale namespaces with
already-write-once-locked vsock ns modes.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 914d7c873ad9..49b3dd78efad 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -145,6 +145,9 @@ vm_ssh() {
 	return $?
 }
 
+cleanup() {
+	del_namespaces
+}
 
 check_args() {
 	local found

-- 
2.47.3


