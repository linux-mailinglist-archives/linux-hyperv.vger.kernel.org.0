Return-Path: <linux-hyperv+bounces-7513-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 011E4C50D13
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 08:00:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B246E3ADC03
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 06:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2C32F5A34;
	Wed, 12 Nov 2025 06:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8FpJ83o"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B77192ED853
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Nov 2025 06:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930548; cv=none; b=s7PlgJDTcDFAGz0Ol32dJ7T181faoOnf/93IzS+3mqzGXxdP4G85VcD2PkF4UscRbt9UAKubMgg9TqsLP5cc87ES8RpjYK/LHXcPVfAofbEj7VCiVXRduBPE6x18pOeo5HrgumvrOI8Y5xS6uS8RpotfoIVB2CRcvSni5EwlO1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930548; c=relaxed/simple;
	bh=C74tPtLEcFlxKPQiq+20Ok+iNGw0X0cvYTmDWlPCWgM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=R+r8wqSjId2zliGYba8FzjSuYouvaYotXCVm3AHv7iwnQ7F1laN7CD+DnTasjVLO4fWxmxJwGvZFZ6/0DjOvTYbs/y4dNKb98ORO82spOrRMknRjY6KwY7tj+s+5tX3vMj2L8AzFjkKPqyRENJHrjI5c7kydBx6DDjzyfTNTKmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8FpJ83o; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7acd9a03ba9so423024b3a.1
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Nov 2025 22:55:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930543; x=1763535343; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p28zEBQeBUk36AvYw3frZ4faKmOpLSnPo9g0yADkH2g=;
        b=H8FpJ83oCTjDCtUaw+fmE8WHeuhylz2VYw4N4J+VORPN1FDWxMFnFnXyCHGolV7a8W
         mOZKDkqdaOah8gGxs9o8NVGOC+vsmbSKaey7M9tgTC5dysVgwCf3659YCEdQDbngAQkK
         bKgyteTVUrgQzjSFEBUzzwtLhJGKeQ7n6HbHAMhC8uaQJIOK0I968xMA4NOydOBupgZS
         ut4lUAABAZGV6NLXRVL0hsunKhHU/1mZrT6DiNr/wemxD5DusLAJrInrDj5ZPssQ7v0e
         523TMllidl0rBwuMNfAmwIbLch6REZ2vaW+WScAwg+L45PSGfuBwAD07Or9Oq6qc8XoI
         HvmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930543; x=1763535343;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p28zEBQeBUk36AvYw3frZ4faKmOpLSnPo9g0yADkH2g=;
        b=G2K5h6eK6rWoqzLkb/j7BFfhUfrGPgvo39jLAjgw29GF/D7BsxH1RjBjNtiZK+y3Jt
         Ra0mK7zryEgw58TWZdfSvaUn2nLy3GVVl9//c1wFYskA91uiJTf/Yf6wSgNU45KngOt7
         eBXxeLPKtD18Smj4RJsdsDIi6HveefgB4u24IoWLgj9+eCELvOEXi2woZ3dg/clLRPDg
         0WZRTvvz29ybjBacRHqYCm0aJJZdpvopRMQkdb2m5M371Qlhwc5+Abq55OMAEayasDRM
         caJ3Xk2hxX98QjE7TexPTdQgva9wM6F/BBc8lVIODm2MISJPFttxqHpVg+BpJByAq2dM
         EmYw==
X-Forwarded-Encrypted: i=1; AJvYcCUCA1jLw+F1W1gA5ZTcDXgHviniKG2t/PizDyMaHsgBh8wYJiMA3Gsbm/Ls+6sLDn04wpnRRt5bhv8w6Ww=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZS7kswUCy3smnKSl2gqIPHfml1BfCKvgrdTODil/jsggmpLs2
	tnT9OYALT8kYaLFqYZivLxjG7/SxM+wJ29z/kErx2QZAXYYQDsgN8H2U
X-Gm-Gg: ASbGncu7cBuLZbdGYJP0e5hXL2EPUtcdTWzWz48vNap6WCA3nQR+YYGfUdnkZ2hxvbX
	JCw5p3xgbD2EmhNyijiXPv7ETAtSgOKr8xeNDdJopirB0aycd467BNp1qhlNzYI7fWGmscNDWc2
	frjnE44vyv8fdXNMsPuGA686CmpmjG67pZgSPtBLQv+ejo/Q0gF2tEfA1Q6vhiko99a02XMOnx8
	vF8qtSovdF4NwMhRbQoRHzTz8MkaUG8PIEq7HUWvFXtOOlDpCFpOKSWm1jLkV6EEwc/l5Qi7z+T
	FGQeJZ3jdhq8XmZXnk4SZ4oJjebB3qzhbhJaZWou8vgoKK9tIgT/h470Vv66XRr0KEZsX7Smc2v
	dk99qJnEdD2Jh1tI1QLee80jiCHnVGl/7EtuLY3keC9l+pV3zoiZHY/TcBRulMRC61e5DmmEX
X-Google-Smtp-Source: AGHT+IFrcYVq4LOZXvV70I3sEePi3UmNsOLwpVBty9xgqUole9nqmJJSBTG6gPimY2LrfYFWsxLRzg==
X-Received: by 2002:a05:6a00:1896:b0:7a2:7cc3:c4f0 with SMTP id d2e1a72fcca58-7b7a2a96c07mr2022312b3a.1.1762930543350;
        Tue, 11 Nov 2025 22:55:43 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:7::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7b783087c6csm1699020b3a.12.2025.11.11.22.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:43 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:51 -0800
Subject: [PATCH net-next v9 09/14] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-9-852787a37bed@meta.com>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
In-Reply-To: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
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
 kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
 Bobby Eshleman <bobbyeshleman@meta.com>
X-Mailer: b4 0.14.3

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add functions for initializing namespaces with the different vsock NS
modes. Callers can use add_namespaces() and del_namespaces() to create
namespaces global0, global1, local0, and local1.

The init_namespaces() function initializes global0, local0, etc...  with
their respective vsock NS mode. This function is separate so that tests
that depend on this initialization can use it, while other tests that
want to test the initialization interface itself can start with a clean
slate by omitting this call.

Remove namespaces upon exiting the program in cleanup().  This is
unlikely to be needed for a healthy run, but it is useful for tests that
are manually killed mid-test. In that case, this patch prevents the
subsequent test run from finding stale namespaces with
already-write-once-locked vsock ns modes.

This patch is in preparation for later namespace tests.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 41 +++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index c7b270dd77a9..f78cc574c274 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -49,6 +49,7 @@ readonly TEST_DESCS=(
 )
 
 readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
+readonly NS_MODES=("local" "global")
 
 VERBOSE=0
 
@@ -103,6 +104,45 @@ check_result() {
 	fi
 }
 
+add_namespaces() {
+	# add namespaces local0, local1, global0, and global1
+	for mode in "${NS_MODES[@]}"; do
+		ip netns add "${mode}0" 2>/dev/null
+		ip netns add "${mode}1" 2>/dev/null
+	done
+}
+
+init_namespaces() {
+	for mode in "${NS_MODES[@]}"; do
+		ns_set_mode "${mode}0" "${mode}"
+		ns_set_mode "${mode}1" "${mode}"
+
+		log_host "set ns ${mode}0 to mode ${mode}"
+		log_host "set ns ${mode}1 to mode ${mode}"
+
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
+ns_set_mode() {
+	local ns=$1
+	local mode=$2
+
+	echo "${mode}" | ip netns exec "${ns}" \
+		tee /proc/sys/net/vsock/ns_mode &>/dev/null
+}
+
 vm_ssh() {
 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
 	return $?
@@ -110,6 +150,7 @@ vm_ssh() {
 
 cleanup() {
 	terminate_pidfiles "${!PIDFILES[@]}"
+	del_namespaces
 }
 
 check_args() {

-- 
2.47.3


