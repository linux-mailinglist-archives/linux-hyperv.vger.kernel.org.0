Return-Path: <linux-hyperv+bounces-7328-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E0AC02FF8
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Oct 2025 20:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 47B59542075
	for <lists+linux-hyperv@lfdr.de>; Thu, 23 Oct 2025 18:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D4833557E9;
	Thu, 23 Oct 2025 18:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3mXFKU1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F305E34DB71
	for <linux-hyperv@vger.kernel.org>; Thu, 23 Oct 2025 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761244111; cv=none; b=rhiCQoeloO/k8B/kuD/DouH7wtwwcpBpCE/PzoDuZfziA9hUurzE7cCtjX5L0Un6XzDKOB/USaajXYytcMp2wsdS9y8YHUF6hW0VCxRGem4Il+XXk1tnG0NVFlmka1ONFtpDHISo2EmR7JamnfimMXZv3bZOp8RtuKsyrj27g6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761244111; c=relaxed/simple;
	bh=5F5v73spaO6g7IkcyDH3GDS87tLNHAMWY+Aqa2TXZbk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=e2wpznG/XplRkU4+8ze77//cS6/HJ0XN5cezF2O+A+lHp3iQET91FMz39C/TMcGaxoi8kezIAFxhNd55Zue92iSO8edHdNc6U65vYap+Yar9eAwWXQCaq5IPaLdn6Jgu1GyV1FP/lLciifbm3rSWz5eSg3dTk904eKeefc6jUaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3mXFKU1; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3307de086d8so1252247a91.2
        for <linux-hyperv@vger.kernel.org>; Thu, 23 Oct 2025 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761244095; x=1761848895; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=edpWGMd9VbWpBkt/1Y+NJ91tcxlgSe0i7beuNiNUjc4=;
        b=K3mXFKU1z8DIYxbpDKyktLYsC/hgT6Bvk5OrT5VySiqYV7V/79Ov1oDZSzNH1b62mG
         Hxp6rJy1jAY/7hVXibbWe1UFc/MvRkM1k5mHCYGDpC74WNKWwV8eYaYz3lr0kzE6p1tG
         DFepQjfMGH/K54xapxNktsHKS7Tm2lEsRW9Aha+yMUawDSqmMb7betN2QVpmoADlRqSI
         JEflOzK/A2WqCv1v+JKeS0596yhIqZ4kwVsK3s4qs0V3VXWyk3aNIqxl5oWHZjV44Q7f
         iiqBn56AagoeQHjtFsunyKzWTDc7qL4d2EZJzu/ytv9Zlvr9lKBhjDUG2CuwkTa58obc
         F89g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761244095; x=1761848895;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=edpWGMd9VbWpBkt/1Y+NJ91tcxlgSe0i7beuNiNUjc4=;
        b=qufof9GARlfwvcLMAC1ABdv5cysK8D10Nzs/5eNTndD6hjCOSXlZ43sshGT/fyhAYU
         Et24NJb/LiYC28O14cv2tPWC6LD3jXBt+s+l7jW4nBUZnSUyY1i+CcqSeD6kasIUH4Sk
         vWsj//aJzZk5vhFzJQj5BBk/OSnLSx9k8X5nHgjVbHry9rTZ7Ldzf2QmkcVihk2Xpgow
         YRThbQYK9zjkK2L9F4Nz7mBaLtfM2A+AZpCKrgu8khnvLJaLqYC6HnbJUA/9LS6ti6Sy
         305Oom5eBC9FQEXgiWlacZMsEzuPufJf1jX681iW4scekBUaM0cIv3SKqXIKnegrLKug
         9g0w==
X-Forwarded-Encrypted: i=1; AJvYcCWN/ORtaqiXvHlEGnznkxaRMF7EmTbuWoNLbkZk9M3Wo9FtbBf7CsF/ysV/3ELBaRUaxS2vgONd3GoZ3lU=@vger.kernel.org
X-Gm-Message-State: AOJu0YymLBliQKLt6Fv4trw79Elm3rCvA+UDWxm5XYxhBEuhmcUf1m0r
	4heYEslMBnmUUhVzbYMbMI0WL01QGUr3ol+VSZCMxTJNPxmK37MYXgDE
X-Gm-Gg: ASbGncsBaKFTBdPwmgqvO5qwez5MT3hnGAZY1ECAfOobXBvkBrvYfnKElXoyYaUlWBn
	RZZZzeEK81rLduIRa9vyOZjeG12ij4fWR7bCDpkq7Xu0LEwD/uYPTXPDx6wA5KQ5BJfiZM3Kg10
	VAXfTzKUd9ptY0oGrRgiosXNvEQ+EgQjyRIJ+EP2gXp1m81M0VOxV4kd2LXcCA3NIHG9i7I2or9
	MWFNOnXblCpiMYzuZY5UoJNDiW0vnJ2mLJRD8znw/rJpH2u/bRpIo2rCw4v0t37eL1MxKiwHv2m
	pqFEfVOX5GTRZieseRw7RGkNg+K5/GciViXouZOaRBZWG8kZBt+A0yfrfGhejggsmDX057ARBdk
	dBmHGijeX0QukXjkBztbBLkQ4gXEwKbyfj3CIGif1m7VGhWGAYBBbNMj+28j92SZ1R5swDAvrAR
	V0nLCr0lA=
X-Google-Smtp-Source: AGHT+IHqGJGfE7/AR7EEKGb5aGT4lYi4Q0CdcUhFDN32WBMZZ/a+b4mtH/4xEGFnf/S5gHM7f9sTTQ==
X-Received: by 2002:a17:90b:2789:b0:329:e703:d00b with SMTP id 98e67ed59e1d1-33bcf8f769fmr34761255a91.19.1761244094881;
        Thu, 23 Oct 2025 11:28:14 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33dff46d539sm3689641a91.13.2025.10.23.11.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 11:28:14 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 23 Oct 2025 11:27:50 -0700
Subject: [PATCH net-next v8 11/14] selftests/vsock: add namespace tests for
 CID collisions
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-vsock-vmtest-v8-11-dea984d02bb0@meta.com>
References: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
In-Reply-To: <20251023-vsock-vmtest-v8-0-dea984d02bb0@meta.com>
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
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests to verify CID collision rules across different vsock namespace
modes.

1. Two VMs with the same CID cannot start in different global namespaces
   (ns_global_same_cid_fails)
2. Two VMs with the same CID can start in different local namespaces
   (ns_local_same_cid_ok)
3. VMs with the same CID can coexist when one is in a global namespace
   and another is in a local namespace (ns_global_local_same_cid_ok and
   ns_local_global_same_cid_ok)

The tests ns_global_local_same_cid_ok and ns_local_global_same_cid_ok
make sure that ordering does not matter.

The tests use a shared helper function namespaces_can_boot_same_cid()
that attempts to start two VMs with identical CIDs in the specified
namespaces and verifies whether VM initialization failed or succeeded.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 74 +++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index b775fb0cd4ed..f2a99cde9fb4 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -44,6 +44,10 @@ readonly TEST_NAMES=(
 	vm_loopback
 	ns_host_vsock_ns_mode_ok
 	ns_host_vsock_ns_mode_write_once_ok
+	ns_global_same_cid_fails
+	ns_local_same_cid_ok
+	ns_global_local_same_cid_ok
+	ns_local_global_same_cid_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -60,6 +64,18 @@ readonly TEST_DESCS=(
 
 	# ns_host_vsock_ns_mode_write_once_ok
 	"Check /proc/sys/net/vsock/ns_mode is write-once on the host."
+
+	# ns_global_same_cid_fails
+	"Check QEMU fails to start two VMs with same CID in two different global namespaces."
+
+	# ns_local_same_cid_ok
+	"Check QEMU successfully starts two VMs with same CID in two different local namespaces."
+
+	# ns_global_local_same_cid_ok
+	"Check QEMU successfully starts one VM in a global ns and then another VM in a local ns with the same CID."
+
+	# ns_local_global_same_cid_ok
+	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
@@ -548,6 +564,64 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+namespaces_can_boot_same_cid() {
+	local ns0=$1
+	local ns1=$2
+	local pidfile1 pidfile2
+	local rc
+
+	pidfile1=$(mktemp $PIDFILE_TEMPLATE)
+	vm_start "${pidfile1}" "${ns0}"
+
+	pidfile2=$(mktemp $PIDFILE_TEMPLATE)
+	vm_start "${pidfile2}" "${ns1}"
+
+	rc=$?
+	terminate_pidfiles "${pidfile1}" "${pidfile2}"
+
+	return $rc
+}
+
+test_ns_global_same_cid_fails() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "global0" "global1"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_local_global_same_cid_ok() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "local0" "global0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_global_local_same_cid_ok() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "global0" "local0"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
+test_ns_local_same_cid_ok() {
+	init_namespaces
+
+	if namespaces_can_boot_same_cid "local0" "local0"; then
+		return "${KSFT_FAIL}"
+	fi
+
+	return "${KSFT_PASS}"
+}
+
 test_ns_host_vsock_ns_mode_write_once_ok() {
 	add_namespaces
 

-- 
2.47.3


