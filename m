Return-Path: <linux-hyperv+bounces-7879-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EAD7C8D3A0
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Nov 2025 08:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8A1DF348C9B
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Nov 2025 07:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086E93242D8;
	Thu, 27 Nov 2025 07:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deBkStv4"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F941325731
	for <linux-hyperv@vger.kernel.org>; Thu, 27 Nov 2025 07:47:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764229679; cv=none; b=pZxQxy1O6rtV4CpxYK7PhLkjr7rmlYx/W5ygub+coNXVl0r3i3/0t/6q1LYH6wpJQ//D2TcQ5lBcMODZO8zLy+0i4qBE5eQ08R/AXjorSzqwogOVDvxzUfbBQ7Sfo+zMvnXSdU7I8oFUoUyyEB9+SOUyWTAJ+61KfNirFL9LG28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764229679; c=relaxed/simple;
	bh=F9qzWvarzspoUbvluZkW92TRtUEFCNdPtvyTfxTGneI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cH7mdHwFas0FWLbG9mws57bLCNFS4uN3efYk2CxLZDbNQZWZzkTz5UQtuEJCq6kPQchFGDzYEBHeUsC3SCzFuoHaUuNFfJacBiCWFTMH8IvIcta4Dh3f3kw+L8tUFoTysH5h3ziCvXGn/MJXNNUPzGziK5a7koSl6Emqci1SYWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deBkStv4; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7aa9be9f03aso487898b3a.2
        for <linux-hyperv@vger.kernel.org>; Wed, 26 Nov 2025 23:47:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764229672; x=1764834472; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t7w0kW50AlmYUAXmX9e+2xAS4l5tTncqOsdNWYiuLxg=;
        b=deBkStv440J/WPF0ePakSjKh8XC3N/uyPoV6vpxNJ6sYgGY0YtpiGnKBsQyRZHzrDc
         GFbjnNkbINoLVsIHdWOhtiSahHJ25mdZDcrxejbhX6KdvAG/GuYauLGxqTqXr5ZXBSGx
         GDfPoIKaBdUE3h4CZcF+nySqjy8A1nR27uwffbhXEBwnvQ0t9m47pBFLVOVEcNu9ndQ+
         3heQImDvFDAi2z3sW8LDU+vGsaFqWUN+mVtwxCRxakVw67l0O+wtZqgZEDsc4ANJ/y8T
         IPrm5DIaUebAvJGcmIW2i3I9j/P6J79htPxIkhi0Hfc2miAM+cYkEHmevf+4xe2S5Wos
         WgnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764229672; x=1764834472;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=t7w0kW50AlmYUAXmX9e+2xAS4l5tTncqOsdNWYiuLxg=;
        b=k/yPIqVrq+widsazL6AgXWzQxmDlCkwYPC+9LzSdMBARczKEnvGfV94ljFpr2lpTK9
         XV+UcwXPMPd3AIesTiPJwwyZvOMBveLinSPVXT4q5ON+s82QtjPwH4LrL37Zyn6KXrpQ
         LvpYHYehiOlAS9vDTQcqMSelWXjsO0LRs9P+q2MzVPWlQ4ztHRekYqpwizwfLC2yHCT3
         GS3XrwIzQNUMsAHOsc+N4SiPyXOPEqzA3yhyEwIRKPF4mq4vIF10mrf1Kzi2ufSH6ExP
         JXukRta/7cEO+x8hm202OdlxBnpitCfQB+23XJRWdNaSVNHzXp7Ty4s/a8Wb91hXeQwb
         WDkg==
X-Forwarded-Encrypted: i=1; AJvYcCXVAWtcQPFR7TnbaDbp/Xu1VUD39dkretUFuPEIw6RY4/nD82oT0KkWVOBxEZ5tBEbcxCo3EYsomvrRkEw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1AqoGBzPutoVrVdUzJji+Gox6aPjPzen0dhEVW57uYsQkBqwG
	YqmXc1rCld7GFL5ECOYuuse+JCbDdIHyF8TLG5W7W8KhO9g8/grXewNm
X-Gm-Gg: ASbGncu0lBWd6Z2s/xO6HsilStsHBypmfy8Werbm3I9br+XSUoA56jbUBokFncx7/or
	z8Sjr3q5bzmBTi7nJmw1BBjqT+wUxyc4FsYAmQ4/ClpVGHOTeIvRBRTCiM1+WYE8AcyISuShZg2
	w8q3J+jlCNGuSw8lx+ro4rAMageviX613vo8OCgDRYuyJfEAdpaDILqKW9T6iH0mr77HhM8rans
	EW48/fcvyL15OoCceQjD2s/DKFH9CyoWyBCz5PDySELJwYnwj57G3uCYW8uBMEDXDWeBvq2Eawq
	DBCpnevnafzT3hZfuMAXA5DcclL0yMJnUdjUffY3Fo6tBv5Zbfqm6gWXZ5WEyKWnRNv5dd05ggA
	qQNUH64IeOQDnvYly4/qTuwYuwn2tJYegHmSHMP/WQJP43ikxvz3cLLdjZCln5EyuIY1DKy3BCA
	XdDbbEsoOklVNsAgvDhbA=
X-Google-Smtp-Source: AGHT+IGEYmtf5UyCmZLOOSPGMZMDsJ6uWauj+yI5/GaJ4MNR6NysYv4OOh6lVMxLOGQMBecx4geSKw==
X-Received: by 2002:a05:6a20:3d07:b0:35d:53dc:cb60 with SMTP id adf61e73a8af0-36150e21647mr25470206637.6.1764229671642;
        Wed, 26 Nov 2025 23:47:51 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:9::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-be4fbb003a1sm1063358a12.8.2025.11.26.23.47.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 23:47:51 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 26 Nov 2025 23:47:38 -0800
Subject: [PATCH net-next v12 09/12] selftests/vsock: add tests for proc sys
 vsock ns_mode
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-vsock-vmtest-v12-9-257ee21cd5de@meta.com>
References: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
In-Reply-To: <20251126-vsock-vmtest-v12-0-257ee21cd5de@meta.com>
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

Add tests for the /proc/sys/net/vsock/ns_mode interface.  Namely,
that it accepts "global" and "local" strings and enforces a write-once
policy.

Start a convention of commenting the test name over the test
description. Add test name comments over test descriptions that existed
before this convention.

Add a check_netns() function that checks if the test requires namespaces
and if the current kernel supports namespaces. Skip tests that require
namespaces if the system does not have namespace support.

Add a test to verify that guest VMs with an active G2H transport
(virtio-vsock) cannot set namespace mode to 'local'. This validates
the mutual exclusion between G2H transports and LOCAL mode.

This patch is the first to add tests that do *not* re-use the same
shared VM. For that reason, it adds a run_tests() function to run these
tests and filter out the shared VM tests.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v12:
- remove ns_vm_local_mode_rejected test, due to dropping that constraint

Changes in v11:
- Document ns_ prefix above TEST_NAMES (Stefano)

Changes in v10:
- Remove extraneous add_namespaces/del_namespaces calls.
- Rename run_tests() to run_ns_tests() since it is designed to only
  run ns tests.

Changes in v9:
- add test ns_vm_local_mode_rejected to check that guests cannot use
  local mode
---
 tools/testing/selftests/vsock/vmtest.sh | 118 +++++++++++++++++++++++++++++++-
 1 file changed, 116 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index e32997db322d..28b91b906cdc 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -41,14 +41,38 @@ readonly KERNEL_CMDLINE="\
 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
 "
 readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
-readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
+
+# Namespace tests must use the ns_ prefix. This is checked in check_netns() and
+# is used to determine if a test needs namespace setup before test execution.
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
 
-readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly USE_SHARED_VM=(
+	vm_server_host_client
+	vm_client_host_server
+	vm_loopback
+)
 readonly NS_MODES=("local" "global")
 
 VERBOSE=0
@@ -205,6 +229,20 @@ check_deps() {
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
@@ -528,6 +566,32 @@ log_guest() {
 	LOG_PREFIX=guest log "$@"
 }
 
+test_ns_host_vsock_ns_mode_ok() {
+	for mode in "${NS_MODES[@]}"; do
+		if ! ns_set_mode "${mode}0" "${mode}"; then
+			return "${KSFT_FAIL}"
+		fi
+	done
+
+	return "${KSFT_PASS}"
+}
+
+test_ns_host_vsock_ns_mode_write_once_ok() {
+	for mode in "${NS_MODES[@]}"; do
+		local ns="${mode}0"
+		if ! ns_set_mode "${ns}" "${mode}"; then
+			return "${KSFT_FAIL}"
+		fi
+
+		# try writing again and expect failure
+		if ns_set_mode "${ns}" "${mode}"; then
+			return "${KSFT_FAIL}"
+		fi
+	done
+
+	return "${KSFT_PASS}"
+}
+
 test_vm_server_host_client() {
 	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
 		return "${KSFT_FAIL}"
@@ -601,6 +665,11 @@ run_shared_vm_tests() {
 			continue
 		fi
 
+		if ! check_netns "${arg}"; then
+			check_result "${KSFT_SKIP}" "${arg}"
+			continue
+		fi
+
 		run_shared_vm_test "${arg}"
 		check_result "$?" "${arg}"
 	done
@@ -654,6 +723,49 @@ run_shared_vm_test() {
 	return "${rc}"
 }
 
+run_ns_tests() {
+	for arg in "${ARGS[@]}"; do
+		if shared_vm_test "${arg}"; then
+			continue
+		fi
+
+		if ! check_netns "${arg}"; then
+			check_result "${KSFT_SKIP}" "${arg}"
+			continue
+		fi
+
+		add_namespaces
+
+		name=$(echo "${arg}" | awk '{ print $1 }')
+		log_host "Executing test_${name}"
+
+		host_oops_before=$(dmesg 2>/dev/null | grep -c -i 'Oops')
+		host_warn_before=$(dmesg --level=warn 2>/dev/null | grep -c -i 'vsock')
+		eval test_"${name}"
+		rc=$?
+
+		host_oops_after=$(dmesg 2>/dev/null | grep -c -i 'Oops')
+		if [[ "${host_oops_after}" -gt "${host_oops_before}" ]]; then
+			echo "FAIL: kernel oops detected on host" | log_host
+			check_result "${KSFT_FAIL}" "${name}"
+			del_namespaces
+			continue
+		fi
+
+		host_warn_after=$(dmesg --level=warn 2>/dev/null | grep -c -i 'vsock')
+		if [[ "${host_warn_after}" -gt "${host_warn_before}" ]]; then
+			echo "FAIL: kernel warning detected on host" | log_host
+			check_result "${KSFT_FAIL}" "${name}"
+			del_namespaces
+			continue
+		fi
+
+		check_result "${rc}" "${name}"
+
+		del_namespaces
+	done
+}
+
 BUILD=0
 QEMU="qemu-system-$(uname -m)"
 
@@ -699,6 +811,8 @@ if shared_vm_tests_requested "${ARGS[@]}"; then
 	terminate_pidfiles "${pidfile}"
 fi
 
+run_ns_tests "${ARGS[@]}"
+
 echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
 echo "Log: ${LOG}"
 

-- 
2.47.3


