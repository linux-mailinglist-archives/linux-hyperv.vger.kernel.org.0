Return-Path: <linux-hyperv+bounces-8072-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 68572CDAFEE
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Dec 2025 01:54:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0B0443073429
	for <lists+linux-hyperv@lfdr.de>; Wed, 24 Dec 2025 00:51:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E25225FA29;
	Wed, 24 Dec 2025 00:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LI7djxw2"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B232C231A30
	for <linux-hyperv@vger.kernel.org>; Wed, 24 Dec 2025 00:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766536145; cv=none; b=WYkEhl/9GUBiE/9kvWRBsm4UjJeSHg9fZmGIb4xUCztMyAH3gBFCG+X0r7vfd+BNdjHRqT5LoIyXq/BmGDChikpsqi0hVG6/AadaKAbN7G2GkhxNSiUCHhVWRm1C9XK84umOqOfH0ryFt+wNugIXSbq/8c6adwRtMS1+ZBWCVJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766536145; c=relaxed/simple;
	bh=A/Re4uBOGGe0FAXjhpo7AUAS6ISO6mznmR48rNydg0I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G10OTnlkBWeVdVc3WFHooX3Vo1/HvjaEA86pcXm6clvNrFm8jBoFbu3hZCSROIf5+qg1HBtUqxwD12lfO2r7iEiL4/4/MrxxzX87qES9kHZ7E7MJlP5F10p6rmTsr8082Lo7WtCFRAy1GXvn4O9A775f0K6M5YMdjVR6Hrob3aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LI7djxw2; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-29efd139227so73381465ad.1
        for <linux-hyperv@vger.kernel.org>; Tue, 23 Dec 2025 16:29:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766536142; x=1767140942; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bMAS5pTBRt+D+YQ3hZNF0StDlF0aWH+C/CFg55tOZdw=;
        b=LI7djxw2SmbC7GAb2AzCJnlQBmGO0eXeEqgStf9bN+I4jrDTU/oE6tWx6YTV2FkGbL
         Em5CwYkq7sYmK9K29/5Miz663ffMPAQI/byO13LCStjUkK8B9uF+fV5QyK2CHoOKYSzt
         lGXu5R9UCkmUTfwgFy4i7pZeovHIx1Uffih+LouEpY4Iu/PdXOZQTcONUyr2Mzda5OVz
         V+D3v9pmsLkDSrUfYNOpBGGWh4XMvXEwIJJTw6q/XK7erS5N0Dtdo9DAQ/C5QqvekCBt
         9fE1wK5BfE7iLk8xzodLITz/PgHNqHDq/m48oayuoXCt2XP+pj7WOqO6rgkt7umZ/uJZ
         6/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766536142; x=1767140942;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bMAS5pTBRt+D+YQ3hZNF0StDlF0aWH+C/CFg55tOZdw=;
        b=Yj0lXgDXmyHHgT+cWo3/o1Sv8QS0x/ixd/9tWpaEM+TgiIqSgocPT+kNFI1ooSxQHm
         O+pooshFzUGpwY7DPAgvWPmuHTcsiK5AnA+K4Zxt0+eYBKnpoWbKSfo+x7LJigz6r2s/
         aImCs1p6zoigyEki3wE6Bf9i8ouVSJ9/2TAFnjIUwNIjxbEVMzZrSYzKYNq7/wJItUr1
         9JmilYLgQns9bHtDKyg71JWXhkNHXggkx2KbVj9SGkmaws47BrhPJ97iHhBR0QDgK6qf
         9YwKDD8tknjzB0J/cYhNIqdsaAS76b7Y5RaxgoWOkUpLfAMpZJBgwCiHnjLaZfD80APx
         Z4aQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw28djGHGlpP0uKf8QXrUjXHEU3Ig800tVw+QBz8z2fUvXS5iTnQS95SrPLWc1/l+h/7QSZOrGQ+DNnqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdLPU2/G4tO3oz8mbldtDr+IUCA1vJuXYihuDG/rZTfRnVWszN
	81ALvULjuv2qTHpQHfg/GMnDCYfps24PRfbYnA/0vQS8Q1kSvZ4Ru4Igz7IBgw==
X-Gm-Gg: AY/fxX7dHeZDAOPAIzc1Lb5w9pdaieLTkH4EWuXu4awTGU91+NNm/RV2jnau1wHDfS/
	QdwvRq51p+/XgcbbER80zVlga6gVc254IICb5REuMONVJ+LSMabAihli++iVIuA2F++W4uSyjXN
	HqD0bLFbELHwZWuprAJrSHpfNg4PIO39Vi88z6wVa3Dddvv/8aWbxmq2sjtdwHGWLhwEePLEWIa
	9hfTQsrVIBQcy5Zyt91IAiLEi7zeYAXu7n9ueW7XMnSKP85XTh/8fd/jQZ7K60l26cYAKAAyHAc
	Y02ymtpAfdtRWz/mGJT6f1ip9svz69zT0bbkhLVKFxyaMJSvXOh1T7ncgEWP1tUOr7zHyQId/hf
	iqUL4zO7u36ut0NakvdlHGLrKTtEW4xHdvINp0GnGS2oRyd808lxfvS7jbhDb/4f+YUzYg6uw9S
	pYc6FnUK6qEBHVgm2S+x23
X-Google-Smtp-Source: AGHT+IGk5LVdk+TERc/fw8l5nIc94qgaWAolimWSUPj2FUxbokwJ6dSPaiM4BcignHXWPYwD+sNmTw==
X-Received: by 2002:a17:903:b8b:b0:297:df4e:fdd5 with SMTP id d9443c01a7336-2a2f2327264mr159417125ad.23.1766536141803;
        Tue, 23 Dec 2025 16:29:01 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:71::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a2f3c828dbsm135979755ad.22.2025.12.23.16.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 16:29:01 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 23 Dec 2025 16:28:40 -0800
Subject: [PATCH RFC net-next v13 06/13] selftests/vsock: add namespace
 helpers to vmtest.sh
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251223-vsock-vmtest-v13-6-9d6db8e7c80b@meta.com>
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


