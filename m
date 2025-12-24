Return-Path: <linux-hyperv+bounces-8078-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 45134CDB000
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Dec 2025 01:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F13A30B3048
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Dec 2025 00:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C81F2C0F6F;
	Wed, 24 Dec 2025 00:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCkClzuW"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A88A21773D
	for <linux-hyperv@vger.kernel.org>; Wed, 24 Dec 2025 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536159; cv=none; b=mcwoD1RcRK4pxBPdxT1sKPlzzESB4ZABzx8glQDWuOmeV7//GWQ4mKkC2Q3CoUJkCiO++6S1SdCn2TyBownrm368nSBc0wk6VrKC2o6q6RNn2rLKKhudVJpI02nquSdgJAND1XB9vtsIXcmZHPvTICOG6EY4zfOyrpIFijENZOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536159; c=relaxed/simple;
	bh=ucIpPosqEiSMdZEyChVr+4AmgFcQlUgInXBmbAzH57o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HUtN3I7M0+7pnlcUusyooSlWJyqJrGq5/WWXy8BxurwLYuCU7djhu9/iwfWXDMTF1Id0K3cC/vixw/Uyqrmml+sdThx7xrc4G49evS66GrSHD1TOyxHLLTez8w3UAeYyu8cYKav1X9mZwYOajNCq2bta7T9PmkHaVuNhPKIkX74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCkClzuW; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7f121c00dedso7350529b3a.0
        for <linux-hyperv@vger.kernel.org>; Tue, 23 Dec 2025 16:29:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536150; x=1767140950; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sNxNvDBVFHGq590i7LC9o7diq8A3tmTtfQIAa+Qj48w=;
        b=YCkClzuWa0dohbxJhDpKDpGU2nayGLYWt65Q1nq1mCRXFmqaSICDMPkK79PQLZNxyQ
         XgD9fTSB9Y2xXyP7j2B6VeWey7Vy8+ntwCChKmB/WaenrUiN0pPORSBbZaWVW0s7dC88
         aDc+mOIDxd4GAzcqGRuy9pC8IXd/oJ02p1v1wGkr/wBcwtcpMsZcZ38u6BxbJ1L+SpmE
         ZctlakSEVjYfduvH7lXnWh7+1vIWxNBkW9j0jIV+1KBoyk4+7GquI3y/uXIDVLB1Mw1S
         ZVPeWHwRAATxDT80pWTY3r8E+Qdu3PHhn3Q7bOcWOdPTv1/fAX2MKQzR/PAupqiWW3X7
         SuJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536150; x=1767140950;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sNxNvDBVFHGq590i7LC9o7diq8A3tmTtfQIAa+Qj48w=;
        b=NgRMYBGDmOQ4nHQliX76iOuWJKnKBXoTUWo4zfJedCJaYUYYAVzE+m1lUXJhdPofT7
         YtMRfge3hM+54Wo2OUgwzS1qXEBz2e1KihCh1AG0Ed+3h+dIsgOL3AFOanVYxcZ3gyQE
         F6kurwDzYxetTvqPHVJa+sSJq/+4ZGb7ZvlKbjd+ixKl98W6cHfiYBO/izjUTjJk1ZTh
         MJswAupil4L0my5eyYp9axm0Ww+9VsssnPFSB1Ry+pAel+kpz6gtXImn5LGzbcGtaBJE
         o/pfDWELwsqc0do8M20C9GjWIQVghA7OtakG0rFNjErishczmOlD3mfIfxgWlzehUy6Q
         seDA==
X-Forwarded-Encrypted: i=1; AJvYcCXtKzRL8+xiFCE/fdPMJs8jOg16p+Q3mSiSAauvG3TTdFLI2KldorrPFWvIkZdynEMGspyKtEyBwHvmWN8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/bszuifd+eBnR2WgqBlMm6qJBmnrV+H2GufxyW3AC9UsRs1Ey
	XaXr+mcK6BItLLLmD1iea4Zuvm8JJI+JWaJcsYYnKR5EiS20tPAoDWPRCeMWBg==
X-Gm-Gg: AY/fxX582FRdrf3JQGR7Bjo7Ft+Redk5sFN0mhaazdtFttg1Zt4a2+ELCdLN3ESqTTz
	0U63W+kUHgW+YpwpIKnd49BPvAhTPqOf+uvkb1hvVvfA8qBx8niGfNWyM3Ef0KiNV9elJtstqqU
	fquakju7eXadzaNstxHUwVHIcJ04NNif6v8vEe3hp4RmuZO4Sre9MuPpzWbQK/uiw9gakGxLnak
	tKKQnF+Q+Nsleaspi3KZVhM9khwpmx3pNTroOZq6hbSNQKBQVP05V6uZKIj7QWSyKAkHamEQj3M
	xXZuLZhQ6tnMh+0pgLT2TusdBIV4eqbMViXdIfnegrid4cWM8RxIbpOz8OroC428csbsoc165Rl
	5h8lp1m2NQzch4Te4ZPjnxomqh1hK6aIzhyN4cSidHRT/ZfDcKrgRNrFx2Lg8tjs85LgxKqtR/g
	wZsV4fKhZx0L7PTrO0aPVs
X-Google-Smtp-Source: AGHT+IGKtnBjY8qVMQri7rK2UM9kYsU1JWM0jsDUq4zxMWO7Sx0v5+rbDtIzGBXE3bX4EOFk1Fr9Zg==
X-Received: by 2002:a05:6a00:e11:b0:7b8:ac7f:5969 with SMTP id d2e1a72fcca58-7ff646f92f6mr15898637b3a.4.1766536149791;
        Tue, 23 Dec 2025 16:29:09 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e48cea1sm15118831b3a.45.2025.12.23.16.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:29:09 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:47 -0800
Subject: [PATCH RFC net-next v13 13/13] selftests/vsock: add tests for
 namespace deletion
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-13-9d6db8e7c80b@meta.com>
References: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
In-Reply-To: <20251223-vsock-vmtest-v13-0-9d6db8e7c80b@meta.com>
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

Add tests that validate vsock sockets are resilient to deleting
namespaces. The vsock sockets should still function normally.

The function check_ns_delete_doesnt_break_connection() is added to
re-use the step-by-step logic of 1) setup connections, 2) delete ns,
3) check that the connections are still ok.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v13:
- remove tests that change the mode after socket creation (this is not
  supported behavior now and the immutability property is tested in other
  tests)
- remove "change_mode" behavior of
  check_ns_changes_dont_break_connection() and rename to
  check_ns_delete_doesnt_break_connection() because we only need to test
  namespace deletion (other tests confirm that the mode cannot change)

Changes in v11:
- remove pipefile (Stefano)

Changes in v9:
- more consistent shell style
- clarify -u usage comment for pipefile
---
 tools/testing/selftests/vsock/vmtest.sh | 84 +++++++++++++++++++++++++++++++++
 1 file changed, 84 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index a9eaf37bc31b..dc8dbe74a6d0 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -68,6 +68,9 @@ readonly TEST_NAMES=(
 	ns_same_local_loopback_ok
 	ns_same_local_host_connect_to_local_vm_ok
 	ns_same_local_vm_connect_to_local_host_ok
+	ns_delete_vm_ok
+	ns_delete_host_ok
+	ns_delete_both_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -135,6 +138,15 @@ readonly TEST_DESCS=(
 
 	# ns_same_local_vm_connect_to_local_host_ok
 	"Run vsock_test client in VM in a local ns with server in same ns."
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
@@ -1287,6 +1299,78 @@ test_vm_loopback() {
 	return "${KSFT_PASS}"
 }
 
+check_ns_delete_doesnt_break_connection() {
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
+	if [[ "$1" == "vm" ]]; then
+		ip netns del "${ns0}"
+	elif [[ "$1" == "host" ]]; then
+		ip netns del "${ns1}"
+	elif [[ "$1" == "both" ]]; then
+		ip netns del "${ns0}"
+		ip netns del "${ns1}"
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
+test_ns_delete_vm_ok() {
+	check_ns_delete_doesnt_break_connection "vm"
+}
+
+test_ns_delete_host_ok() {
+	check_ns_delete_doesnt_break_connection "host"
+}
+
+test_ns_delete_both_ok() {
+	check_ns_delete_doesnt_break_connection "both"
+}
+
 shared_vm_test() {
 	local tname
 

-- 
2.47.3


