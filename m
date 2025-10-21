Return-Path: <linux-hyperv+bounces-7291-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 270F9BF953E
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Oct 2025 01:50:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CD4FF4F7FCC
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Oct 2025 23:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 992CF2EFDA1;
	Tue, 21 Oct 2025 23:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V5w6B0ZJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745862E7F03
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Oct 2025 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090436; cv=none; b=oOrwQz8Qk0nbHIhNhlkQCSYgvQNiVnWh4YeHbj/GZQbrIFcNs5p9dN0BjUG2zxGX28wZksfcXmDS40xwvME5l7TxSpZik8lJAZgdSLMebopTinub4aLjnQEr+P/vTsbxc78YL0K/MWfzeH9/6Z2GaO903m27ExL7w9r/0puAp20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090436; c=relaxed/simple;
	bh=sFmiWiqcfg8xXVngUspNtrgGk8pAsdPv+UUIRplZPLI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=INTVS5XFyFThbak3fuyHbpORMgu91oYnVnzSER7H/6Z1rVBwnGQJ7BbblYuypaF7+p9qNztojeg8uHXMudptiHTp3DIK0kf138nwGW1SSDD6zm2Qx7asbBWtyyRtPBBc1OY3ik46dehgRVaQTlCYkjfhDLy4l/3V0E15E8tu16Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V5w6B0ZJ; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-789fb76b466so5173677b3a.0
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Oct 2025 16:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090430; x=1761695230; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6Lx0Vsy3+YgWmRX9GABJkmBtAr8R5JRasWccNZRzMeM=;
        b=V5w6B0ZJQCwTfCtO7I91J2tvyL/SZY+dKcKM/ZSTCGmXFn+uZS3Zgy9/vw/BmVhkJw
         Fo7qWb/fhwFDmXhHgWiEH6lTicnillbZmtMOG24ahvMSpaaZ+V0FMB2ob3F9X3W5MXvg
         eU6SdHEC32W7j0DyAIPbXGZ2gdnKRn4EonlVaavHMJ0a7rx30dEPOaeKw1wXVmx6unVW
         kyApOWzSE4uEG4ObG6H0kk5ooKvjCeo0o5fvKb+KxPSCkNFoKrjYLJwiVfDBA6QqaZ3A
         kts6xEGkq1UHN0AL7BQEw7x6L7ZKkpPnsQz0KIQaee9Rf1Oi3lyUg5c+I4mwnnR+Xn6R
         CDWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090430; x=1761695230;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6Lx0Vsy3+YgWmRX9GABJkmBtAr8R5JRasWccNZRzMeM=;
        b=iKnfMSSVWHxUqQZCd/pUS6eA4P/JovXYAOohulPU4SZhBiPGdFvv8bo1loGMY9jqJE
         1MSAMu4j2CFdiHPxry1IJsVYcDTDPKl6+uJhXoeJH5DJX78YjWB9IvNIn9/j3bAIl3Ce
         9mw0XhCiYWpabebZH1FZFnry8PAT5gnm3GqGHkw0hzefsNJH0SoGlNl5TmXhq6sdlWVn
         cIcvpQ580fR2XcoDW+082xiBY5cvjE7yo3vlsiarBVXsThcm6qqX7rwH4eyhGnduHT0c
         Y/P1aS1kw5L85oMmpmMkTJfcs36T0hTfPf9S6xzzSVestHfrP59ijJpTk15UKn0xf8ZO
         ZzwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkjEkrlqFOi01WT67EorzbUdPjp/OQZ2891qmPCKsQW4gkGuqOAGXKCOF07Y3JvK/aQ5W9psTE5vOFntw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLiPB2KCC5spcF9m2GY52FLmP+CLWrtabwnwFOVPBjjc+zIcBE
	FKF7GEwkf+L6R+KGgmuwLwhGsvo5+I8uxYyGl5d2z19YDF43FCqiA+pU
X-Gm-Gg: ASbGncv1WyT+Bxl2iCkTvRmr+7wPWvmROkIraKNpNB18WtSNEXnSEOy9+uPgYFSrjCo
	dQGxF8MaJd9WmRrZM0RHmhLEltWSpIHbEFdmeSQIcZmt88Yk6OHQBNjtYU0xldDdlLEUO4KeCEe
	y67yFU3LGmt+Nad+1ttEP534iqYNNJZ0I3rl2AUgrYOmHOrx90coy9zxDnBdgny1ByyuO6UytdY
	ubSOLLyrA6annWiqHcIdRMzTn0JKm424/q0SU07ioPKjFgrFETL/xmENdrpiYsF5kCdGOulrUGg
	QyVLsDGgIr7D4O7BVfEQ8D6CckMhKYrV29zmutPAPM661Q8idODXgCrejwo1gpgwWtvhCByUcpK
	eimIUmohnLyyocG2l8x2gtikZptGEHyJEYokPZEAsilQyC8LSTU/VeJ4WFKdEEYYTfd4C/kfJO/
	1i6tPc/LkcYeqAmJTOL4k=
X-Google-Smtp-Source: AGHT+IHBIC1WFg0H2qiLSSMrqYIuCevWaKcWLpJLUcG8eiGjix0DgQfBr2qDeIJoI8W1LO6p9Cikzw==
X-Received: by 2002:a05:6a00:130e:b0:77e:8130:fda with SMTP id d2e1a72fcca58-7a220aa090dmr21331246b3a.13.1761090430385;
        Tue, 21 Oct 2025 16:47:10 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff1599dsm12619953b3a.4.2025.10.21.16.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:10 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:46:55 -0700
Subject: [PATCH net-next v7 12/26] selftests/vsock: do not unconditionally
 die if qemu fails
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-12-0661b7b6f081@meta.com>
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

If QEMU fails to boot, then set the returncode (via timeout) instead of
unconditionally dying. This is in preparation for tests that expect QEMU
to fail to boot. In that case, we just want to know if the boot failed
or not so we can test the pass/fail criteria, and continue executing the
next test.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 9958b3250520..d53dd25f5b48 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -221,10 +221,8 @@ vm_start() {
 		--append "${KERNEL_CMDLINE}" \
 		--rw  &> ${logfile} &
 
-	if ! timeout ${WAIT_TOTAL} \
-		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'; then
-		die "failed to boot VM"
-	fi
+	timeout "${WAIT_TOTAL}" \
+		bash -c 'while [[ ! -s '"${pidfile}"' ]]; do sleep 1; done; exit 0'
 }
 
 vm_wait_for_ssh() {

-- 
2.47.3


