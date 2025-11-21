Return-Path: <linux-hyperv+bounces-7737-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B53A9C7772E
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 06:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2527A35ECD6
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 05:47:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 243FA302152;
	Fri, 21 Nov 2025 05:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FNf8Z88Y"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C7192FF157
	for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 05:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703908; cv=none; b=eDljMHD1zSvlIimyuny6Sfhq5HJFyB94QlRRUyhAOiUUW6LtSMIFnKEWAoT6XvyKBGrAUZm3/YVZ/pNSGEbl2LXKYOlsohzYSJhp6HoNW9gfjqInW59hgcjTV3GXgjgjzoK11eskTI2JjquUwtyopVslWRDljF9MXvQqimSqwAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703908; c=relaxed/simple;
	bh=S0OTYm3s0WeftWD4AqPQ/rzlCPMOTr3mHqDyBo2IzPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=T2A1KXW6XqkwP7vx0ILIbZ6B+c4AvdQf51SHG3ZDTV+0zvq1JOa+0ii44xCzSBbeebcWs51HI4zLxT3+bnJ5vK/y99urNt/x24YKMHJizOtOoBxKWnN+HoBZpBYWK3U29TCGlIA6ANX7l3GkRUXEW23TsOAjJw20b/mXeO/26OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FNf8Z88Y; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-343684a06b2so1651336a91.1
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Nov 2025 21:45:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703902; x=1764308702; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ukEcgJRgkjZjmBgpWiJDnd24uu19PQYcukqnsJV0jE0=;
        b=FNf8Z88Y4Oz5X1VuMZOrmSJ4CyYP18JGMeaD3wE91y7au4XThrpiH8BZqKV3XUDEVl
         rxFqwwuDAVbK4fqMzsU9dAswOj3xEVv0+BvlWae09hSiV8PMc3FgD0BfC8BgNLNsoPyh
         kPjTeSTZsuuvlqYgKa7Zk3Y7DLdl2vpDh5tYMZA1adAV5VV3VPcaiEIRju/cCdcSYs1Q
         D0AEWZhC7tL33IS+cG6fUKMKGBSTfpXT+XpRAhNswlWS/hlRuYr+9VNe2JF5bp+FQwwX
         iJDoDsnfgRZQdflGqJaqxiilnOF5A7Z/9EvJ2AUNOyVGMQ3DnRUS1eKom9LkG61t6Z58
         2yoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703902; x=1764308702;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ukEcgJRgkjZjmBgpWiJDnd24uu19PQYcukqnsJV0jE0=;
        b=B+VaQ8e2i5GxjXW8wemeH7kfo26bV036oUheWNdTgTV/Nrf94ZyRP55iLS71M+rqEF
         HPxS1Fx+yIXMAnZ4UxvT3ZnIBF7M9JNpV3iKDbAE7It2XSetFu8SPsqjFMC2u+6g7jnU
         RuoQs/B/DVjwF1ersYHKuiCiazsGw3rMzHOPlcmHMgzDOIpG/q30BpqS6qFKXVy3GpRl
         /I4E1D/CRkcS2MfATtCStNt0GmtiAKQSnIdnhuRwJiJEvGWP+2/q2I8slyVPs4YSEPj5
         xBnVc+foLJh/erPAH1kgKIh85x4orXXBTrYl3s0ki5vA1wS7MFaiCjPNeo+6peUbFi/1
         9kHw==
X-Forwarded-Encrypted: i=1; AJvYcCWqGV2K3vN+66nfxcVWQ8rcoJPHppqFytZJ4YgRAe40LjWvzcjFyb+tAAUS6ccGzAK8arLY6OijW6lUc40=@vger.kernel.org
X-Gm-Message-State: AOJu0YwEpKqHCiSq93sJ/fxfEqIdI+PwqHo1mqgkfnMrn1Iv9YcPuqnG
	XtxzDPZgAlIfWZRgTyF2JXbbaVjpkneK8s8Szp1MuJvsvKpqd33CQk5D
X-Gm-Gg: ASbGncvcNCFnF1DYB9S3dnAQWliOky+7SDzrenktU5HByq1DZok3I+bAiSkDFYU6YHr
	N7wCEbIuQyZrMpDUI5PrwbZzl7817PkZDJt0wzizho+vfEeTmLBumK/rVh5EtbJgFX0UurZrtXH
	+QYdFIooDe9YHCtpAm/53oW6+CQ8Fb83jMhgptrmkMhXSmSZsi1NlcvokHbLTO7R65uIZ4fFi6A
	HadAa47DAnMykQ0HPgs9sH3jhTCnr/aKPKC2kOUL+FUSJkPgzAhclT/pN2xmY3oGhaWEU1PBvUo
	uORXaDrjRfEYjXLx7KQRvmWgYXVDYI+tusHQUwpcdSLVZdN7y+vFGrbUMmQMcJTIu7Zd4jBdmDu
	3/+8OQu7ZwLJcCLByy6xnpd3PfbuwIy4ocsYNDztBiZrU3kvIJmlVsOermnZ28PZhwb33XuiTPL
	v4ZXO446WvaUT4NuBYU+p+
X-Google-Smtp-Source: AGHT+IFELQgLCRsG8NRuOCsGBzSRJdEH8+ehXXOKkL8vFZuPvZ3QfZTp5lGjY+9g40dgcEdSszo9Aw==
X-Received: by 2002:a17:90a:c2cd:b0:339:eff5:ef26 with SMTP id 98e67ed59e1d1-34733f40d29mr1247312a91.30.1763703901651;
        Thu, 20 Nov 2025 21:45:01 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:70::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34727be2fa7sm4195843a91.6.2025.11.20.21.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:45:01 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:43 -0800
Subject: [PATCH net-next v11 11/13] selftests/vsock: add namespace tests
 for CID collisions
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-11-55cbc80249a7@meta.com>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
In-Reply-To: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
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
 Shuah Khan <shuah@kernel.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, berrange@redhat.com, 
 Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@gmail.com>, 
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
Changes in v11:
- check vm_start() rc in namespaces_can_boot_same_cid() (Stefano)
- fix ns_local_same_cid_ok() to use local0 and local1 instead of reusing
  local0 twice. This check should pass, ensuring local namespaces do not
  collide (Stefano)
---
 tools/testing/selftests/vsock/vmtest.sh | 78 +++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 2e077e8a1777..f84da1e8ad14 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -51,6 +51,10 @@ readonly TEST_NAMES=(
 	ns_host_vsock_ns_mode_ok
 	ns_host_vsock_ns_mode_write_once_ok
 	ns_vm_local_mode_rejected
+	ns_global_same_cid_fails
+	ns_local_same_cid_ok
+	ns_global_local_same_cid_ok
+	ns_local_global_same_cid_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -70,6 +74,18 @@ readonly TEST_DESCS=(
 
 	# ns_vm_local_mode_rejected
 	"Test that guest VM with G2H transport cannot set namespace mode to 'local'"
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
 
 readonly USE_SHARED_VM=(
@@ -581,6 +597,68 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+namespaces_can_boot_same_cid() {
+	local ns0=$1
+	local ns1=$2
+	local pidfile1 pidfile2
+	local rc
+
+	pidfile1="$(create_pidfile)"
+
+	# The first VM should be able to start. If it can't then we have
+	# problems and need to return non-zero.
+	if ! vm_start "${pidfile1}" "${ns0}"; then
+		return 1
+	fi
+
+	pidfile2="$(create_pidfile)"
+	vm_start "${pidfile2}" "${ns1}"
+	rc=$?
+	terminate_pidfiles "${pidfile1}" "${pidfile2}"
+
+	return "${rc}"
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
+	if namespaces_can_boot_same_cid "local0" "local1"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
 test_ns_host_vsock_ns_mode_write_once_ok() {
 	for mode in "${NS_MODES[@]}"; do
 		local ns="${mode}0"

-- 
2.47.3


