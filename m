Return-Path: <linux-hyperv+bounces-8242-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FD7D166E5
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 04:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C0E23044C38
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 03:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCBF30F95A;
	Tue, 13 Jan 2026 03:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CHW4Jb/8"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB77B313E0C
	for <linux-hyperv@vger.kernel.org>; Tue, 13 Jan 2026 03:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768273985; cv=none; b=Ojqm/dUVUEKZFdew7X6TRMZNYp2Rf6hyV7SVLze+TgsXfH++nLOGyuhZjupXj1kkaLIOg4vZ2gh3Z9++CQbU40PEWsNM7c+QPTqDnk1I34pEp5gXp/P2LTjUPJmSrG19DouU1UzGeP3EYMW3h7JHSBhTx5f0AEd3UwcIE4G8EmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768273985; c=relaxed/simple;
	bh=A/Re4uBOGGe0FAXjhpo7AUAS6ISO6mznmR48rNydg0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t8wGDWOIebQjsVmiKUATOKIUiInuut+Bv5FAdNIu9V0GhQYkLwunSIuaNRGNc3VQspXjUUsujQyHWhxBWILUvWvxNfwBeWur7ACUxzWoxVfX8/bzaUcV3v2TX634A/HOpkeFE51cmicdhKJNqT9MBsWFDlheS1Hk5pB8F0+v0do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CHW4Jb/8; arc=none smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-6481bd1763bso1383186d50.3
        for <linux-hyperv@vger.kernel.org>; Mon, 12 Jan 2026 19:13:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768273982; x=1768878782; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMAS5pTBRt+D+YQ3hZNF0StDlF0aWH+C/CFg55tOZdw=;
        b=CHW4Jb/8fhd5vJDUj0zjCR2kjTvWSiK0d5E8xEs03aJjnzCJ6tJ/I2pf79/Ya7kaF6
         eZq4DmXtNQE4JDceVHeRAqHQsQFnRbTCx92onB9wVEHw+Z5jHz5D/C5lxsvWs9z8Ol2b
         KyROrKD3/50bMehrdeM2s9ZfO9LGQk3myUPkpp2IBByANYh7VtGsBgiU+SSIrfheOG2p
         eXkpigUKG+k5RLuEEyWFPLQcIS1cGiwR8ISMG54hu0/ZOw4Snis0+k89XFPjO8bUHrKQ
         dtqcaxl4v18oK/TlXWDaZla0g3ThPrkI5FGw3aedBtDOh9iD29HR22EzYJfbLITUjKew
         kIFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768273982; x=1768878782;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bMAS5pTBRt+D+YQ3hZNF0StDlF0aWH+C/CFg55tOZdw=;
        b=WGiFuDjMl3o+5vMl2aCTE5/iWZi+KoT0YKXf6GOtr8ihJApgD4bvHnCCcT9mV+R7El
         aucU4d4Pt1mK+sO/Pzyv1u4cVXL7rYZIreouQYFugLT/medbcP5knuL1QyICSmkD3C+E
         W5rrtd+DoinUsFpz/cQB0rpyyad5w28r2oy+gsJukWA14SZwrWW54X3XuQiUNHQxrteq
         KApsAoWI9zS8t8pHDG0KO9RpKV55ZLGAysi0tOcv/PrI0jX+ywe2IegA5RnDg2dsZRMD
         W3WBibv43PYrC5A7uhYoI6V0S2XULABZeEolF8L9PzRJgai/AVboCep7m2snY9mS9B61
         9S6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXBJwP2wpn7F7Vl93WgImuy5FipbdPQiMlcK71+vfno8aArUeWRjKDqNUSIMoKxvHe8M+M0nx+bJbdaTPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO547kOLvNNiGQ071aMx4HTfmH6UDNvSHZdtVCFZRlpdRVOEE+
	79emHxebIhC/YTgjH9hP4cgO0Tqt2lUb6VTzx8wwmzQqwc/UJ58S3IGo
X-Gm-Gg: AY/fxX6QpfWPMyfLliWJsALiKF3nwr/umarwfLipGUtsR6M3jlvWjya4m0R2P/Sp87G
	x1jMcaxqE0fL1Sve3NkuK15Y+Fpj145jCKlUaTpGehs2VKnU/td0qe41ulIygN8NHNBMsLoObKJ
	/Hr+OP6LmCmxo0mcW+7O75xmhBxHpVsZDBGpKkxykZoWxuBx6+LcqwZa2bEpC4/zSc/XPyXSskg
	vIXR/HExEfugL5ErOzoYV1y00MZK5MSeyOWeYVGiyMBsNxGZOvgb2l/wzOpVK+GNFfH4+/yK5a8
	vHSfxNnkXdaFs+bB6exLvDbUlPy/2b35Yix0/aDEYH0U6SK3y6nsOekX8Z/VcRfHhmaTOzaRCSS
	oqiKevzeLPEG3yqf7mzpZX4aCHRvbd+/fNFT1Y8sb8Rm8P7krkFyBQTaPcDtTJIJFpAx8byrEJQ
	O6GU9gTkkbTQ==
X-Google-Smtp-Source: AGHT+IGkQoS0QBXW7yISdzqc/XM0pcHr9WRNy/nnkdRa0saRQjs66Xbn3T42Y7YnRdRrb2CT86Wdpw==
X-Received: by 2002:a05:690e:1907:b0:644:795a:391 with SMTP id 956f58d0204a3-64716c67b3bmr15939380d50.60.1768273981699;
        Mon, 12 Jan 2026 19:13:01 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:5d::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6470d8b246fsm8746996d50.17.2026.01.12.19.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 19:13:01 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Mon, 12 Jan 2026 19:11:14 -0800
Subject: [PATCH net-next v14 05/12] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-vsock-vmtest-v14-5-a5c332db3e2b@meta.com>
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

Add functions for initializing namespaces with the different vsock NS
modes. Callers can use add_namespaces() and del_namespaces() to create
namespaces global0, global1, local0, and local1.

The add_namespaces() function initializes global0, local0, etc... with
their respective vsock NS mode by toggling child_ns_mode before creating
the namespace.

Remove namespaces upon exiting the program in cleanup(). This is
unlikely to be needed for a healthy run, but it is useful for tests that
are manually killed mid-test.

This patch is in preparation for later namespace tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v13:
- intialize namespaces to use the child_ns_mode mechanism
- remove setting modes from init_namespaces() function (this function
  only sets up the lo device now)
- remove ns_set_mode(ns) because ns_mode is no longer mutable
---
 tools/testing/selftests/vsock/vmtest.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c7b270dd77a9..c2bdc293b94c 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -49,6 +49,7 @@ readonly TEST_DESCS=(
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly NS_MODES=("local" "global")
 
 VERBOSE=0
 
@@ -103,6 +104,36 @@ check_result() {
 	fi
 }
 
+add_namespaces() {
+	local orig_mode
+	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
+
+	for mode in "${NS_MODES[@]}"; do
+		echo "${mode}" > /proc/sys/net/vsock/child_ns_mode
+		ip netns add "${mode}0" 2>/dev/null
+		ip netns add "${mode}1" 2>/dev/null
+	done
+
+	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
+}
+
+init_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		# we need lo for qemu port forwarding
+		ip netns exec "${mode}0" ip link set dev lo up
+		ip netns exec "${mode}1" ip link set dev lo up
+	done
+}
+
+del_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		ip netns del "${mode}0" &>/dev/null
+		ip netns del "${mode}1" &>/dev/null
+		log_host "removed ns ${mode}0"
+		log_host "removed ns ${mode}1"
+	done
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -110,6 +141,7 @@ vm_ssh() {
 
 cleanup() {
 	terminate_pidfiles "${!PIDFILES[@]}"
+	del_namespaces
 }
 
 check_args() {

-- 
2.47.3


