Return-Path: <linux-hyperv+bounces-7298-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94CF8BF95AB
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Oct 2025 01:51:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 324F9583B00
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Oct 2025 23:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C95C2F7446;
	Tue, 21 Oct 2025 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d1Bkbsg0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87EC2F3622
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Oct 2025 23:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090445; cv=none; b=huxZwWp//vHU50WWalfTE0qf17KWDgK9uPLATb14LThaLdJwQaWjW5HgfxXDRRZqMyBvz1HVhhJoWMxAImHzfOYge5ZyP0hXgvndIaiIBKtZtpmAPJlIXldPAMkg468PadwTjvwVrMRohMfciujFRzVvquwB9vKKJJ8AzLrNY90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090445; c=relaxed/simple;
	bh=tkMGIMswqfAEZyDr4Cl0t0E9LZdA/zAbPpZnx5/so6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lJfDy0oI9l6v5Z4R26owhKBCmgya2wr7mUffxAFGhQaW9z07TwSXF1P77q0HHAeNSlDAn6q81FC7gpl39hetnjFba3D9tjKlWyj+0FYnuXok3d8EpU9rYjsetyIQfptKsbp00lVOD5sbtE0iEmN0cGFit2kIEF5amY0OG5M0WEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d1Bkbsg0; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-33067909400so4762917a91.2
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Oct 2025 16:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090439; x=1761695239; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MUSawlw3KS8OKu+neqC1xDDribwG4GyG+WJRI7AbHRY=;
        b=d1Bkbsg0KhrDQf0d4BSBKXEcgdAB5m1jsXNlG8+h7rM+KytqQx01sJEyhK5m9h62yM
         7kjrR7TpGTC16SyrHdXYc41vjLbSx621FxFVTfF3EmcuBIagtatVVRfpcyArwpru/NLq
         PVf5scU26XLWGQ/h7ZIs4jvYzOSj49OqmIOFkJFzNgT6HE4XG9PR0alQmW1niDUxO5Qf
         fLdv0CjLdgA+gse/uNPCW3gF5daIRttSD2sNkHXEbPj6wSJjbnsHbEfLH0XvxOYEEgD4
         uRPkSx+vb9P9r+aGIlGEq1ZiC2bqkNELwTwMPz6oPQCLbRALUtRVoMm8oO7407IrNufs
         7iVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090439; x=1761695239;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MUSawlw3KS8OKu+neqC1xDDribwG4GyG+WJRI7AbHRY=;
        b=o3b9RN8tI7LytcJNLWmEoO9zU705ZeQqOHzElK09XT/rF+clIhxlqAAkm+KmqGXV/x
         UeV2lBn8MDt8SulwbbcNNwOYbPruusWlcQDzSgLzwCDGaadh8aSYSXyj4zScfKUx0LKb
         2rbQUuqHCagjZlMk42Z5d6SSUmrlHUG4IBacvr52bLTcfBOgOGtX+tTfo3TBznzCubgt
         1GDgNFM7xt5iu6iHHa+Z0JG7oG1gAGKeV8l423mF+HNnjhXyT7oC3NfV/vfqTq+xE3st
         X/RmIrCEIjlmNXlGPb57pgHcKa+50rLpyw/w8ulokOhZwU9Rpj7GR+67s4wUq9O+H7ax
         bmhA==
X-Forwarded-Encrypted: i=1; AJvYcCUhYZ/+mCT39UcRoLt00q0rTf1V20gUeBwmCHbJKrP6UavzvDbe1ZQs50OqquBj4MSMMYFwvoWxwtA9lK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIlnFUrw3lWAexngMLDzfh1y/32rySgQihD9THh//9jE5mL8Ln
	GKRvjgsLGOEhcC7xjHPn23HtcE1nDq+1oeEHb2cbzK7IEjwEYPDVddve
X-Gm-Gg: ASbGnct4aAHSdmQ1w7FgDNXFvXLjCFK67uwd95x/FuuhqC43JOJIL9I33aOorY8GfwC
	LgHwmYC/VGCojrP/YM+X4FeYtpz6dFDeaF9fgI8KX2xhD6yxg+BepyUDIvOlLhORx1FGgq24df4
	83mCvdHjfu9r7ixW/MBJC+Wsll15RyAIgfjxPJ2KfIw12Fer5ENAwjFWWLKSXQZErpIJ3KuFfK8
	ZNcAsLWMhq9HyZmSqbTSTGxhfLvGWavxVQMOT/JASnd4rDH+s+JlMUVGOrqa8JsfNCFcW4oZFmZ
	oAKGjEdwu7/E8N8XfHgz2H+v4vRu2lOGzb1bMWIbETRE0TaPtIqePxm6S8Vf1Ua7TKO3pRNGQ9P
	+lPFievJlBDc9Z8ZnmgvlGWA8V2I4unjMA7xNSWsA0yfRRfSu5NqiNOepcBRA7MREmzVonr52BN
	6HOp02CVhK
X-Google-Smtp-Source: AGHT+IFovlERrPh42B70YTWXTmz2rKyfI2eDHBwzjrpjJJS/U4lT6i41uck3W1mtdr1D6DfW2bDl7g==
X-Received: by 2002:a17:90b:2d83:b0:32e:5b07:15dd with SMTP id 98e67ed59e1d1-33bcf8628demr21493620a91.1.1761090438795;
        Tue, 21 Oct 2025 16:47:18 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:72::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a22ff34b8bsm12570317b3a.22.2025.10.21.16.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:18 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:04 -0700
Subject: [PATCH net-next v7 21/26] selftests/vsock: add tests for proc sys
 vsock ns_mode
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-21-0661b7b6f081@meta.com>
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

Add tests for the /proc/sys/net/vsock/ns_mode interface.  Namely,
that it accepts "global" and "local" strings and enforces a write-once
policy.

Start a convention of commenting the test name over the test
description. Add test name comments over test descriptions that existed
before this convention.

Add a check_netns() function that checks if the test requires namespaces
and if the current kernel supports namespaces. Skip tests that require
namespaces if the system does not have namespace support.

This patch is the first to add tests that do *not* re-use the same
shared VM. For that reason, it adds a run_tests() function to run these
tests and filter out the shared VM tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 99 ++++++++++++++++++++++++++++++++-
 1 file changed, 98 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index b129976e27fc..4defadad5701 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -38,11 +38,28 @@ readonly KERNEL_CMDLINE="\
 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
 "
 readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
-readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly TEST_NAMES=(
+	vm_server_host_client
+	vm_client_host_server
+	vm_loopback
+	ns_host_vsock_ns_mode_ok
+	ns_host_vsock_ns_mode_write_once_ok
+)
 readonly TEST_DESCS=(
+	# vm_server_host_client
 	"Run vsock_test in server mode on the VM and in client mode on the host."
+
+	# vm_client_host_server
 	"Run vsock_test in client mode on the VM and in server mode on the host."
+
+	# vm_loopback
 	"Run vsock_test using the loopback transport in the VM."
+
+	# ns_host_vsock_ns_mode_ok
+	"Check /proc/sys/net/vsock/ns_mode strings on the host."
+
+	# ns_host_vsock_ns_mode_write_once_ok
+	"Check /proc/sys/net/vsock/ns_mode is write-once on the host."
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
@@ -201,6 +218,20 @@ check_deps() {
 	fi
 }
 
+check_netns() {
+	local tname=$1
+
+	# If the test requires NS support, check if NS support exists
+	# using /proc/self/ns
+	if [[ "${tname}" =~ ^ns_ ]] &&
+	   [[ ! -e /proc/self/ns ]]; then
+		log_host "No NS support detected for test ${tname}"
+		return 1
+	fi
+
+	return 0
+}
+
 check_vng() {
 	local tested_versions
 	local version
@@ -500,6 +531,43 @@ log_guest() {
 	LOG_PREFIX=guest log $@
 }
 
+test_ns_host_vsock_ns_mode_ok() {
+	add_namespaces
+
+	for mode in "${NS_MODES[@]}"; do
+		if ! ns_set_mode "${mode}0" "${mode}"; then
+			del_namespaces
+			return "${KSFT_FAIL}"
+		fi
+	done
+
+	del_namespaces
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_host_vsock_ns_mode_write_once_ok() {
+	add_namespaces
+
+	for mode in "${NS_MODES[@]}"; do
+		local ns="${mode}0"
+		if ! ns_set_mode "${ns}" "${mode}"; then
+			del_namespaces
+			return "${KSFT_FAIL}"
+		fi
+
+		# try writing again and expect failure
+		if ns_set_mode "${ns}" "${mode}"; then
+			del_namespaces
+			return "${KSFT_FAIL}"
+		fi
+	done
+
+	del_namespaces
+
+	return "${KSFT_PASS}"
+}
+
 test_vm_server_host_client() {
 	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
 		return "${KSFT_FAIL}"
@@ -573,6 +641,11 @@ run_shared_vm_tests() {
 			continue
 		fi
 
+		if ! check_netns "${arg}"; then
+			check_result "${KSFT_SKIP}"
+			continue
+		fi
+
 		run_shared_vm_test "${arg}"
 		check_result $?
 	done
@@ -626,6 +699,28 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+run_tests() {
+	for arg in "${ARGS[@]}"; do
+		if shared_vm_test "${arg}"; then
+			continue
+		fi
+
+		if ! check_netns "${arg}"; then
+			check_result "${KSFT_SKIP}"
+			continue
+		fi
+
+		add_namespaces
+
+		name=$(echo "${arg}" | awk '{ print $1 }')
+		log_host "Executing test_${name}"
+		eval test_"${name}"
+		check_result $?
+
+		del_namespaces
+	done
+}
+
 BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
@@ -671,6 +766,8 @@ if shared_vm_tests_requested "${ARGS[@]}"; then
 	terminate_pidfiles "${pidfile}"
 fi
 
+run_tests "${ARGS[@]}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3


