Return-Path: <linux-hyperv+bounces-7738-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8005C77761
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 06:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 42EBC4E7190
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 05:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0BB304BC3;
	Fri, 21 Nov 2025 05:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Klkn0m20"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B34092F533E
	for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 05:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763703912; cv=none; b=A5GSupjcm095wBGOnnanhAOOh9452QZGCgu4UhoexudwyMX3EyBFG4+K1n50nY8RpH61rCXAfvRI2nEHOo/dvAT4fq3BJBQn7KqhZJUW6aX5kTOnpLsD7XWHhmMqpQo8Fdvss9lTnRtMP53L6jrIiICbBWqqrtX2BC/oEs/tunU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763703912; c=relaxed/simple;
	bh=HcFpLUc+G6pQCjiDu3dqqPPKH+0uQ8yqBNmFiEzDG9E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TV6RvFL3Apvk5K/1NsKWT8POOY5HOiL4L4F/ASjf7c2jyKm7ud/tWylcBCwoeCHWvBI+WFz/dvoB/bw+pFwQfEuIzlsp3/6jsfM9/pyf1vXjcfg1TwemQ3DNLV9N3TC0Z8To4a5KcUbk3fvD+8nK1Lzym50KsDFIqTUDfYFPknE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Klkn0m20; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-297e982506fso22342195ad.2
        for <linux-hyperv@vger.kernel.org>; Thu, 20 Nov 2025 21:45:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763703903; x=1764308703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V9sFl9qbvPwYtRInTuWVbglrBqV89lDCjlyhP3JynaY=;
        b=Klkn0m20fjLI6Vui0GWilQsRMEvbJFjTwZ9HtpseO8a271FSF86tEMIr9jBqtMe+NY
         TJYA97A1ZEWs0grA8NlWhm1EWLGRAruXtl8iIs8ASFE5QV4fKbklmTqKhlIZVPRLYfzE
         MU1JPTMrAYKAHrcT8hFsT+9geha38Rfd1/hvxu1enXwRRIdYWESM/fMhRRZFHgdeWVFz
         hbhEpJUIpYlIwCw5FHijmibnG6FU22ANSd3szZWWFTHlwUE3yPJhbSoOTMz8n0Ldj6+F
         MlW65xr+pYraqUw390l+Pb2JRj6s8bOgEd8Pvn6HcDp9Lb/NNMo0x10wjbTJ2N1GVqNb
         iMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763703903; x=1764308703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=V9sFl9qbvPwYtRInTuWVbglrBqV89lDCjlyhP3JynaY=;
        b=theZzQgAmqF6wjwwjB34HKCOEyaaf7i6EzR7wtRco6yzO8tGc9hbr/jfJ0MpNpkUV9
         AnWiwtQknk3xyPYm3mo8Wl2mkwOKnlqu1tqdSo84u7E/vZ0DdvGfNDkHlzaLUkA48ct2
         RNlQcIG9vc9VPZo3JhNOXoRLshAxJszd+4uZxzKCI2ZloHlnXvoZZksrAO/EPq6t6Ypl
         E9UYP4gGiqZwnUWUKxkz2IBZVlqvzWKOcaNniZaN9V6o2vbGTxGH2BrYVFhTwIXkvinJ
         7qfGfwwclp384CraQ1LeTXX38SxIjsNRiJ05ickpkhWvE8Z1LqAZ2u9BpPmr+1LlrccT
         gevA==
X-Forwarded-Encrypted: i=1; AJvYcCXcv7qUugCbJnLRU8TR0L5PEaIIrLwc2odCvzrKd/Yb4eEr1SDg+BN7BWi5VWGXPrGvU5FofK2UAEWYfGc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/rBpGrua1/t5rCjEOQRuxmzv9XQApc4d25uV3ehRxUqDnkDeQ
	pTzFg5A7FUWqQwA0yZx7wXtyl3DYcxcHEBz0C3FuAPWnNvMWvVDWMQ2p
X-Gm-Gg: ASbGncucSWbupGzxDOSI79GAbBny6Eo06GvMuzzH7Kx8SrWgJrzKs0Se+VzQ7u8JptR
	yVFIlzTRpWGBBLEcyqJN/8bPy8CUPvERyzwJna+9TEtFZJp4CChGzC6uW6QPnM8csrZ/QoXaIiQ
	CS/DJFjqMFiLm2k/mtObkeqjeroZKNmvWZlj2cmJcQDEfrsIS5c9+0xHSyfm6EMvPTX6azpaAD0
	Qf+vsRMwQp0pz0oSrzJZU+Yr5Qsv953Sz2Ynka6/jCf+CrPDGWxgAGneDAlHBL/S+8xBI4D1ruk
	DlkdHLNG1+fkYqPJ0gUrRslwjP5oodrlTxUdjAg0u1d2DhWPNa/ksGkrA5N8mW503H7VEFH5O+S
	L0GQqMjWVko/NoZ6UuXJtD3YvF78GuLbQeliXZuPZYUi8LY5ieGqMa0IEFtcu4oqFXw1MOtXPLX
	5r8EsHNYA7CsUAWlkRzTs=
X-Google-Smtp-Source: AGHT+IGNogkw6+aYEKeY1jIA1/MWu6kqW3NQeqBIULV4beIyW6SfaQAClzFvrrHi8XqojUq6urD3Lg==
X-Received: by 2002:a17:903:19ec:b0:297:f8dd:4d8e with SMTP id d9443c01a7336-29b6bf37d9dmr17593035ad.30.1763703903500;
        Thu, 20 Nov 2025 21:45:03 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:6::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29b5b25e0f0sm42902025ad.46.2025.11.20.21.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 21:45:03 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Thu, 20 Nov 2025 21:44:45 -0800
Subject: [PATCH net-next v11 13/13] selftests/vsock: add tests for
 namespace deletion and mode changes
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251120-vsock-vmtest-v11-13-55cbc80249a7@meta.com>
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

Add tests that validate vsock sockets are resilient to deleting
namespaces or changing namespace modes from global to local. The vsock
sockets should still function normally.

The function check_ns_changes_dont_break_connection() is added to re-use
the step-by-step logic of 1) setup connections, 2) do something that
would maybe break the connections, 3) check that the connections are
still ok.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- remove pipefile (Stefano)

Changes in v9:
- more consistent shell style
- clarify -u usage comment for pipefile
---
 tools/testing/selftests/vsock/vmtest.sh | 119 ++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index dfa895abfc7f..5f0b24845fad 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -69,6 +69,12 @@ readonly TEST_NAMES=(
 	ns_same_local_loopback_ok
 	ns_same_local_host_connect_to_local_vm_ok
 	ns_same_local_vm_connect_to_local_host_ok
+	ns_mode_change_connection_continue_vm_ok
+	ns_mode_change_connection_continue_host_ok
+	ns_mode_change_connection_continue_both_ok
+	ns_delete_vm_ok
+	ns_delete_host_ok
+	ns_delete_both_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -139,6 +145,24 @@ readonly TEST_DESCS=(
 
 	# ns_same_local_vm_connect_to_local_host_ok
 	"Run vsock_test client in VM in a local ns with server in same ns."
+
+	# ns_mode_change_connection_continue_vm_ok
+	"Check that changing NS mode of VM namespace from global to local after a connection is established doesn't break the connection"
+
+	# ns_mode_change_connection_continue_host_ok
+	"Check that changing NS mode of host namespace from global to local after a connection is established doesn't break the connection"
+
+	# ns_mode_change_connection_continue_both_ok
+	"Check that changing NS mode of host and VM namespaces from global to local after a connection is established doesn't break the connection"
+
+	# ns_delete_vm_ok
+	"Check that deleting the VM's namespace does not break the socket connection"
+
+	# ns_delete_host_ok
+	"Check that deleting the host's namespace does not break the socket connection"
+
+	# ns_delete_both_ok
+	"Check that deleting the VM and host's namespaces does not break the socket connection"
 )
 
 readonly USE_SHARED_VM=(
@@ -1288,6 +1312,101 @@ test_ns_vm_local_mode_rejected() {
 	return "${KSFT_PASS}"
 }
 
+check_ns_changes_dont_break_connection() {
+	local pipefile pidfile outfile
+	local ns0="global0"
+	local ns1="global1"
+	local port=12345
+	local pids=()
+	local rc=0
+
+	init_namespaces
+
+	pidfile="$(create_pidfile)"
+	if ! vm_start "${pidfile}" "${ns0}"; then
+		return "${KSFT_FAIL}"
+	fi
+	vm_wait_for_ssh "${ns0}"
+
+	outfile=$(mktemp)
+	vm_ssh "${ns0}" -- \
+		socat VSOCK-LISTEN:"${port}",fork STDOUT > "${outfile}" 2>/dev/null &
+	pids+=($!)
+	vm_wait_for_listener "${ns0}" "${port}" "vsock"
+
+	# We use a pipe here so that we can echo into the pipe instead of using
+	# socat and a unix socket file. We just need a name for the pipe (not a
+	# regular file) so use -u.
+	pipefile=$(mktemp -u /tmp/vmtest_pipe_XXXX)
+	ip netns exec "${ns1}" \
+		socat PIPE:"${pipefile}" VSOCK-CONNECT:"${VSOCK_CID}":"${port}" &
+	pids+=($!)
+
+	timeout "${WAIT_PERIOD}" \
+		bash -c 'while [[ ! -e '"${pipefile}"' ]]; do sleep 1; done; exit 0'
+
+	if [[ $2 == "delete" ]]; then
+		if [[ "$1" == "vm" ]]; then
+			ip netns del "${ns0}"
+		elif [[ "$1" == "host" ]]; then
+			ip netns del "${ns1}"
+		elif [[ "$1" == "both" ]]; then
+			ip netns del "${ns0}"
+			ip netns del "${ns1}"
+		fi
+	elif [[ $2 == "change_mode" ]]; then
+		if [[ "$1" == "vm" ]]; then
+			ns_set_mode "${ns0}" "local"
+		elif [[ "$1" == "host" ]]; then
+			ns_set_mode "${ns1}" "local"
+		elif [[ "$1" == "both" ]]; then
+			ns_set_mode "${ns0}" "local"
+			ns_set_mode "${ns1}" "local"
+		fi
+	fi
+
+	echo "TEST" > "${pipefile}"
+
+	timeout "${WAIT_PERIOD}" \
+		bash -c 'while [[ ! -s '"${outfile}"' ]]; do sleep 1; done; exit 0'
+
+	if grep -q "TEST" "${outfile}"; then
+		rc="${KSFT_PASS}"
+	else
+		rc="${KSFT_FAIL}"
+	fi
+
+	terminate_pidfiles "${pidfile}"
+	terminate_pids "${pids[@]}"
+	rm -f "${outfile}" "${pipefile}"
+
+	return "${rc}"
+}
+
+test_ns_mode_change_connection_continue_vm_ok() {
+	check_ns_changes_dont_break_connection "vm" "change_mode"
+}
+
+test_ns_mode_change_connection_continue_host_ok() {
+	check_ns_changes_dont_break_connection "host" "change_mode"
+}
+
+test_ns_mode_change_connection_continue_both_ok() {
+	check_ns_changes_dont_break_connection "both" "change_mode"
+}
+
+test_ns_delete_vm_ok() {
+	check_ns_changes_dont_break_connection "vm" "delete"
+}
+
+test_ns_delete_host_ok() {
+	check_ns_changes_dont_break_connection "host" "delete"
+}
+
+test_ns_delete_both_ok() {
+	check_ns_changes_dont_break_connection "both" "delete"
+}
+
 shared_vm_test() {
 	local tname
 

-- 
2.47.3


