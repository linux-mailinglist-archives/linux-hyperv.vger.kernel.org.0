Return-Path: <linux-hyperv+bounces-8344-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 003FFD38887
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 22:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 31D5530A77E7
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 21:29:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D332B314D13;
	Fri, 16 Jan 2026 21:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQOcpz5M"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C926030FF28
	for <linux-hyperv@vger.kernel.org>; Fri, 16 Jan 2026 21:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598952; cv=none; b=CfdqNjnXHq0wzbRqO3tg8VECMJY5Jsk1FVVcDYXJjcGDiNcbq7n+Ac6ON4fMaDIzn24LDR2F38fFtIbsV75IQftybeqowxsCc/FWw1dgZbTuiE02S6nDWPg7C5b4vLbsb115BovknWvEhhe1XfZa7GI+f+IVg8ghoN/fGeRamJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598952; c=relaxed/simple;
	bh=1Q26HXpW7TYNGutKg90p+BWQKQP/kUEHf57kmmFmrxY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PBi+Drp1lvY+Jd9dMarAEHnNEoBDWAZgv7NMubHTrsZrBZebme3TYGDvaShJcxKFwWamWMBe5IRqVbk3f16kTKvXGKEbGUZ1SRglBUEdclO/uMhMa3k1Ryb7YqjLMEduHizXgOlz4mXf6+zm5uGrbPHVtuDW31s8z2Nra9Bt8uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQOcpz5M; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-790992528f6so23320467b3.1
        for <linux-hyperv@vger.kernel.org>; Fri, 16 Jan 2026 13:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598948; x=1769203748; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lG0BScxKvY/q9QPoykPF18FCgS+okYK88nxhg8/Kgqs=;
        b=MQOcpz5M11mInoEuv2G8jKvKY/BIrnZsbNIaMX3kSehgaMGIfTdqniY3c4ZbXzlgiR
         IDcnikL2v372frJZk6mLcCD/cxIDdeZbk3QA3ZCZSfzwryiF0XZ1o6SJdbI9syS17zw8
         3HLK7BrxKzxPI1wHLP2h51Qq+ItVkQZA18yzzM8oeJ3/Lp56WHU0uGtjiVtn5Vz0jgOC
         7PE7rBfTm4GGdXOxTrHhc8aiGzciiWAjsc2psy/rH2LF5MQSordjEpOupZJtnMWWCNT/
         Q+RfhylTg6QQMkfO7aTYHLmwVc0EgkSBdPRmNqSfRW0Ldbi9UmgOT+SH3RZjUjCUBxLD
         aLBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598948; x=1769203748;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lG0BScxKvY/q9QPoykPF18FCgS+okYK88nxhg8/Kgqs=;
        b=nTQBgoeN9X7qEzCOj7DPskf3/cc2jxEfLs/cmTts3dCnlBGTkZL4PuIbi5ZGQUrJeO
         Q12RkPFvECU3Y1h2qRliLGLIjJE3GcSJt3vH8YjgXJRV0/MsgQkajOoQb6q1vjB33T0d
         zmuAHNDhnTsJW05tY7aKlScq6Yql3VFa60s/6liQ04vPFkmvpvLaiKO/nKDFv7Pd02n6
         5vfVlmwZDwScWB17H2kt7T4TB2CuDDy0DxBquuibDrAr0YIbxwC4UXOBjMpfKDhBAVLb
         fffrdzypLoBlFYSiz/d5uo+XVWlO/GPbIhuKuy2dM89PKgDS+7HooiXxfVbcigYLmpGX
         DOvw==
X-Forwarded-Encrypted: i=1; AJvYcCUmD5dmAYt2jv5I8x3KP0QfSVWmpI0Xj+fc13S3pRuboNMcV0j0i7BcagN2f9PNJ1fNBad6WT96MPL1bqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTay2ibNeMrXgPCKFVG3ZfiucvJ48XyzGP5xBlCZMEMrePpXmE
	wj+LQCRoRp2F4KBM5uANPP3AhDFSRcYWZkL07kWRILScaqR3FfkszZKf
X-Gm-Gg: AY/fxX744q2E/PJg+0tuF4rmeRkYtDxC9z2JhKJIs8zetgTB3V2WWl1H7C323WP/k8P
	E3tEj7ABXhhv8X7ldJHnWC6NjO3fYuNyTUBAcXC4K0XRl+ch1TE5GVnrN9n2VjO3dfPOtI11iBk
	4kot6N5RUuycuSfxdeDOm6exILjDJ3JMF79VGpIinh/cdtEJXIjp3AAGFpjdbwpZfjhKmIkyfMT
	3VEAdVv8U+laiUy+dOm+FJHoLrdIu9eU4vCj56N5hEUiWftU0GrUMSH+A3yRypcD3XlJlbXAXgo
	uH7SSezP1Aorr+6VVOfMwp1geLID+aj+kBpq8GcpRSX3rMeHF6h+ExrM8Pyo2yG7EVoozSeuSVW
	RKVsIPaMzjaTWfbY3uHgfVEsFZe9NABUF3dC6lEx7Nef7i0sNoXnzJ4GYz9Mlyu/T2SKxK16itq
	ICrwt1wvcMtA==
X-Received: by 2002:a05:690c:6185:b0:786:5ebb:483f with SMTP id 00721157ae682-793c54062b6mr33737067b3.65.1768598948005;
        Fri, 16 Jan 2026 13:29:08 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:56::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c686db17sm13146287b3.38.2026.01.16.13.29.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:07 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:46 -0800
Subject: [PATCH net-next v15 06/12] selftests/vsock: prepare vm management
 helpers for namespaces
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-6-bbfd1a668548@meta.com>
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

Add namespace support to vm management, ssh helpers, and vsock_test
wrapper functions. This enables running VMs and test helpers in specific
namespaces, which is required for upcoming namespace isolation tests.

The functions still work correctly within the init ns, though the caller
must now pass "init_ns" explicitly.

No functional changes for existing tests. All have been updated to pass
"init_ns" explicitly.

Affected functions (such as vm_start() and vm_ssh()) now wrap their
commands with 'ip netns exec' when executing commands in non-init
namespaces.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 93 +++++++++++++++++++++++----------
 1 file changed, 65 insertions(+), 28 deletions(-)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c2bdc293b94c..1d03acb62347 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -135,7 +135,18 @@ del_namespaces() {
 }
 
 vm_ssh() {
-	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
+	local ns_exec
+
+	if [[ "${1}" == init_ns ]]; then
+		ns_exec=""
+	else
+		ns_exec="ip netns exec ${1}"
+	fi
+
+	shift
+
+	${ns_exec} ssh -q -o UserKnownHostsFile=/dev/null -p "${SSH_HOST_PORT}" localhost "$@"
+
 	return $?
 }
 
@@ -258,10 +269,12 @@ terminate_pidfiles() {
 
 vm_start() {
 	local pidfile=$1
+	local ns=$2
 	local logfile=/dev/null
 	local verbose_opt=""
 	local kernel_opt=""
 	local qemu_opts=""
+	local ns_exec=""
 	local qemu
 
 	qemu=$(command -v "${QEMU}")
@@ -282,7 +295,11 @@ vm_start() {
 		kernel_opt="${KERNEL_CHECKOUT}"
 	fi
 
-	vng \
+	if [[ "${ns}" != "init_ns" ]]; then
+		ns_exec="ip netns exec ${ns}"
+	fi
+
+	${ns_exec} vng \
 		--run \
 		${kernel_opt} \
 		${verbose_opt} \
@@ -297,6 +314,7 @@ vm_start() {
 }
 
 vm_wait_for_ssh() {
+	local ns=$1
 	local i
 
 	i=0
@@ -304,7 +322,8 @@ vm_wait_for_ssh() {
 		if [[ ${i} -gt ${WAIT_PERIOD_MAX} ]]; then
 			die "Timed out waiting for guest ssh"
 		fi
-		if vm_ssh -- true; then
+
+		if vm_ssh "${ns}" -- true; then
 			break
 		fi
 		i=$(( i + 1 ))
@@ -338,30 +357,41 @@ wait_for_listener()
 }
 
 vm_wait_for_listener() {
-	local port=$1
+	local ns=$1
+	local port=$2
 
-	vm_ssh <<EOF
+	vm_ssh "${ns}" <<EOF
 $(declare -f wait_for_listener)
 wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
 EOF
 }
 
 host_wait_for_listener() {
-	local port=$1
+	local ns=$1
+	local port=$2
 
-	wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+	if [[ "${ns}" == "init_ns" ]]; then
+		wait_for_listener "${port}" "${WAIT_PERIOD}" "${WAIT_PERIOD_MAX}"
+	else
+		ip netns exec "${ns}" bash <<-EOF
+			$(declare -f wait_for_listener)
+			wait_for_listener ${port} ${WAIT_PERIOD} ${WAIT_PERIOD_MAX}
+		EOF
+	fi
 }
 
+
 vm_vsock_test() {
-	local host=$1
-	local cid=$2
-	local port=$3
+	local ns=$1
+	local host=$2
+	local cid=$3
+	local port=$4
 	local rc
 
 	# log output and use pipefail to respect vsock_test errors
 	set -o pipefail
 	if [[ "${host}" != server ]]; then
-		vm_ssh -- "${VSOCK_TEST}" \
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
 			--mode=client \
 			--control-host="${host}" \
 			--peer-cid="${cid}" \
@@ -369,7 +399,7 @@ vm_vsock_test() {
 			2>&1 | log_guest
 		rc=$?
 	else
-		vm_ssh -- "${VSOCK_TEST}" \
+		vm_ssh "${ns}" -- "${VSOCK_TEST}" \
 			--mode=server \
 			--peer-cid="${cid}" \
 			--control-port="${port}" \
@@ -381,7 +411,7 @@ vm_vsock_test() {
 			return $rc
 		fi
 
-		vm_wait_for_listener "${port}"
+		vm_wait_for_listener "${ns}" "${port}"
 		rc=$?
 	fi
 	set +o pipefail
@@ -390,22 +420,28 @@ vm_vsock_test() {
 }
 
 host_vsock_test() {
-	local host=$1
-	local cid=$2
-	local port=$3
+	local ns=$1
+	local host=$2
+	local cid=$3
+	local port=$4
 	local rc
 
+	local cmd="${VSOCK_TEST}"
+	if [[ "${ns}" != "init_ns" ]]; then
+		cmd="ip netns exec ${ns} ${cmd}"
+	fi
+
 	# log output and use pipefail to respect vsock_test errors
 	set -o pipefail
 	if [[ "${host}" != server ]]; then
-		${VSOCK_TEST} \
+		${cmd} \
 			--mode=client \
 			--peer-cid="${cid}" \
 			--control-host="${host}" \
 			--control-port="${port}" 2>&1 | log_host
 		rc=$?
 	else
-		${VSOCK_TEST} \
+		${cmd} \
 			--mode=server \
 			--peer-cid="${cid}" \
 			--control-port="${port}" 2>&1 | log_host &
@@ -416,7 +452,7 @@ host_vsock_test() {
 			return $rc
 		fi
 
-		host_wait_for_listener "${port}"
+		host_wait_for_listener "${ns}" "${port}"
 		rc=$?
 	fi
 	set +o pipefail
@@ -460,11 +496,11 @@ log_guest() {
 }
 
 test_vm_server_host_client() {
-	if ! vm_vsock_test "server" 2 "${TEST_GUEST_PORT}"; then
+	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
 		return "${KSFT_FAIL}"
 	fi
 
-	if ! host_vsock_test "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
+	if ! host_vsock_test "init_ns" "127.0.0.1" "${VSOCK_CID}" "${TEST_HOST_PORT}"; then
 		return "${KSFT_FAIL}"
 	fi
 
@@ -472,11 +508,11 @@ test_vm_server_host_client() {
 }
 
 test_vm_client_host_server() {
-	if ! host_vsock_test "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
+	if ! host_vsock_test "init_ns" "server" "${VSOCK_CID}" "${TEST_HOST_PORT_LISTENER}"; then
 		return "${KSFT_FAIL}"
 	fi
 
-	if ! vm_vsock_test "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
+	if ! vm_vsock_test "init_ns" "10.0.2.2" 2 "${TEST_HOST_PORT_LISTENER}"; then
 		return "${KSFT_FAIL}"
 	fi
 
@@ -486,13 +522,14 @@ test_vm_client_host_server() {
 test_vm_loopback() {
 	local port=60000 # non-forwarded local port
 
-	vm_ssh -- modprobe vsock_loopback &> /dev/null || :
+	vm_ssh "init_ns" -- modprobe vsock_loopback &> /dev/null || :
 
-	if ! vm_vsock_test "server" 1 "${port}"; then
+	if ! vm_vsock_test "init_ns" "server" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi
 
-	if ! vm_vsock_test "127.0.0.1" 1 "${port}"; then
+
+	if ! vm_vsock_test "init_ns" "127.0.0.1" 1 "${port}"; then
 		return "${KSFT_FAIL}"
 	fi
 
@@ -621,8 +658,8 @@ cnt_total=0
 if shared_vm_tests_requested "${ARGS[@]}"; then
 	log_host "Booting up VM"
 	pidfile="$(create_pidfile)"
-	vm_start "${pidfile}"
-	vm_wait_for_ssh
+	vm_start "${pidfile}" "init_ns"
+	vm_wait_for_ssh "init_ns"
 	log_host "VM booted up"
 
 	run_shared_vm_tests "${ARGS[@]}"

-- 
2.47.3


