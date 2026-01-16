Return-Path: <linux-hyperv+bounces-8345-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97F45D3888E
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 22:40:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4103730AFDEF
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 21:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0735A315D5C;
	Fri, 16 Jan 2026 21:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTngvH+a"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f46.google.com (mail-yx1-f46.google.com [74.125.224.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 528FC3093A7
	for <linux-hyperv@vger.kernel.org>; Fri, 16 Jan 2026 21:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598953; cv=none; b=BSiUGKaMav6X5AuNk8Cz0BidWQ5kSbaHhwmYnjeKGn/vAzS2pzohJChKxlN2G4dOW8gFs22kAZSG9zWuA61JCzo24UsMmf9G6f5UcYRaGP4VmoPKK0IKBEl8u8ZpLYlreo6+I7meM/c32AbG5qaDByi9KG66ASJUyVhA/Mbr5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598953; c=relaxed/simple;
	bh=uCgr9JbNpxUqM9gbGsf2Jmk4aJqJ6fTLHuKaFTvudAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q08kUSyMgNQ3TrRujkEGc2AiUs6UUvoFTk901UcB9e3AA7FjVNXqFOoF+cZTGqCt9fNMtuVWXC2gMJpb+T35f/0UaKa7mvMu4q9jHLTXMymzJsfr48OyBMPPZ3m5Zrse/g9FNazgqdDAOzuLW3u9ayRtfwVf+U4x3wONtGCWMgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTngvH+a; arc=none smtp.client-ip=74.125.224.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f46.google.com with SMTP id 956f58d0204a3-6467b7c3853so1958961d50.0
        for <linux-hyperv@vger.kernel.org>; Fri, 16 Jan 2026 13:29:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598949; x=1769203749; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9UqzpQf1IlJwSFAKiovBpo5/3/EPxdibd9liBmZD9wA=;
        b=QTngvH+aHSlgpc6sbkMxQQXQgVjpHfvo8/ybabtKjpTSprv3GfeKKJBTALE6RgtdDg
         RswwtkZl+IAqTCdFrDCPHorrsMHWw0aGSIuwfImh/UGEDyme9oneRL6kbIwX9Efx4xYB
         mSieuSGsc5RLrst1Mabf/Ewlk7C2Dqx2NlbGcdszebK3DDxj6a+r+epSXdjJn0nDPKzT
         LlHE6x72Cg7y9/xaxwXYp/AuW6SFdnS4tBfDYGej85+UwalYdyDNm/lmAXapIFWbnshx
         Zf+/2YilCh3DnjHITvjH31s0Dihvq+0QcEtewyuuNiLeDx3Zqzetfk728lYJ+zB4Ell/
         0pBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598949; x=1769203749;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9UqzpQf1IlJwSFAKiovBpo5/3/EPxdibd9liBmZD9wA=;
        b=ciL/OucrShFccOLC4TsbiH56dBUsoBPRi6qp9GtgEYwYKMDsRAZyMh2v3FlWs2zEH9
         7fV0EZLi/sb73PkQNLzCUH49E5AKAtzzF2ebeutx//OsrKNSXrPkxCLDEI6KKxpQyxfn
         LyV+oesuaWt1W6XcPhEkXYjO+beXYlBkgYoGe1G00bE8Rl8jXT9rqL8R29m0/xVUduw3
         wDDOCwb5T1SMaHIgFbKw5CqvX1hdD3BgQHEd4YCSp5DVpDjvxPT1ekBAY+Mim02qCkXo
         /ZYOX6Vxp/5I1BdbTKTQtcUD8kalOe6kJyGy+oynL2JfQRbbwhXOV6xSNZY4Tt4j1Ul9
         ovuQ==
X-Forwarded-Encrypted: i=1; AJvYcCU14hSB0t7k6NZXDwYybYHfbWHxUx+SLuLiGBZfpaEfbRl5+QqRUccTuxHu2H5lMDPSTjE/Ohb8WJcJv/s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfyoanCOrA+ouaYKMh3A2FFf+USSnUbhWoqcrMop/TpQv9I44K
	ioIBt4G35AYkVeBZbaDBsHZ10H8sTRddtXoPPIX4MVSEpbgiCCLVypY/
X-Gm-Gg: AY/fxX4VkOhxpWSZcso29+fC2+z+GuHSP57d/JUlfn17fSMf1DW0GdrYfhkVSOSaJl+
	9NN5Dk5okmivLeYQs8ilpDd4PYuuFsCJO3WmTL0xz982lJIYlbESlarObACWP9S6ObdD8a2Ccd0
	s/RJrx/ZPP/hh7dOmQYn1qzOJ336UGjZ79+mb172lqm2WBa1c3XFFibyZPBCP8F4FHEFvnBFAdK
	vI8DClFun/LuJrfH7BlarIoOBfAh56QPeCHbpNtii8HuZKmHd9bDEJCW1KR1Vapq7xn0b7RA35b
	NSOv49Sk2qWoha3s7pyl2ezPZ14vEzA8hQ0gmChPERFQ3+jN7/IIywi1aImfJpTS8R0Ke4LjyTX
	yiD3iQti29Awfaazs97VStPJFPYKBSO/gAYAr6sTU9KnUSQUqg0Ehkm0F8xfym672sakgQBrwwH
	dH/9Jr5MKl
X-Received: by 2002:a05:690e:d8d:b0:644:60d9:8667 with SMTP id 956f58d0204a3-64917773d86mr2650287d50.88.1768598948802;
        Fri, 16 Jan 2026 13:29:08 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:8::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649170d2f04sm1663457d50.22.2026.01.16.13.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:08 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:47 -0800
Subject: [PATCH net-next v15 07/12] selftests/vsock: add
 vm_dmesg_{warn,oops}_count() helpers
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-7-bbfd1a668548@meta.com>
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

These functions are reused by the VM tests to collect and compare dmesg
warnings and oops counts. The future VM-specific tests use them heavily.
This patches relies on vm_ssh() already supporting namespaces.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- break these out into an earlier patch so that they can be used
  directly in new patches (instead of causing churn by adding this
  later)
---
 tools/testing/selftests/vsock/vmtest.sh | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 1d03acb62347..4b5929ffc9eb 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -380,6 +380,17 @@ host_wait_for_listener() {
 	fi
 }
 
+vm_dmesg_oops_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg 2>/dev/null | grep -c -i 'Oops'
+}
+
+vm_dmesg_warn_count() {
+	local ns=$1
+
+	vm_ssh "${ns}" -- dmesg --level=warn 2>/dev/null | grep -c -i 'vsock'
+}
 
 vm_vsock_test() {
 	local ns=$1
@@ -587,8 +598,8 @@ run_shared_vm_test() {
 
 	host_oops_cnt_before=$(dmesg | grep -c -i 'Oops')
 	host_warn_cnt_before=$(dmesg --level=warn | grep -c -i 'vsock')
-	vm_oops_cnt_before=$(vm_ssh -- dmesg | grep -c -i 'Oops')
-	vm_warn_cnt_before=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_oops_cnt_before=$(vm_dmesg_oops_count "init_ns")
+	vm_warn_cnt_before=$(vm_dmesg_warn_count "init_ns")
 
 	name=$(echo "${1}" | awk '{ print $1 }')
 	eval test_"${name}"
@@ -606,13 +617,13 @@ run_shared_vm_test() {
 		rc=$KSFT_FAIL
 	fi
 
-	vm_oops_cnt_after=$(vm_ssh -- dmesg | grep -i 'Oops' | wc -l)
+	vm_oops_cnt_after=$(vm_dmesg_oops_count "init_ns")
 	if [[ ${vm_oops_cnt_after} -gt ${vm_oops_cnt_before} ]]; then
 		echo "FAIL: kernel oops detected on vm" | log_host
 		rc=$KSFT_FAIL
 	fi
 
-	vm_warn_cnt_after=$(vm_ssh -- dmesg --level=warn | grep -c -i 'vsock')
+	vm_warn_cnt_after=$(vm_dmesg_warn_count "init_ns")
 	if [[ ${vm_warn_cnt_after} -gt ${vm_warn_cnt_before} ]]; then
 		echo "FAIL: kernel warning detected on vm" | log_host
 		rc=$KSFT_FAIL

-- 
2.47.3


