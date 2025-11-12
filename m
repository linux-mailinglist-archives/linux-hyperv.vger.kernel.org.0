Return-Path: <linux-hyperv+bounces-7514-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A9C0BC50D30
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 08:00:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 443694F4F29
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 06:57:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915EB2F6583;
	Wed, 12 Nov 2025 06:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ut7NuIs0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB79E2F39A4
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Nov 2025 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930552; cv=none; b=rjr6crwgDc3U3rg6FneLPWKQ9F/EZPnfx7QtKP3L/Uq3J/zJHkrvAIJY1BXd3tyqlXXIDe84lzbYMTdDYmL37dVWqxMd4IYsEYRlLs88rLYGDzKvoBBjQD+tO/Uut2B8+DWp9ZqI48Hl3useG5FLv19zJZhYmOw8Oa9zPMxEEAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930552; c=relaxed/simple;
	bh=1H3EUWCH7xSBo5TO1aY6eWGm6uEkReSWSwsgMjSlU2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RA8IyMZ++ukUF93dE+DKXKLneXNZzmBqKyqIoowFEdkMrcYyoX5iskMrnsw1WF8mAflivJZWWVwz7Q7txyBZQWcUTtyf+SJv5AU/QhAJLxjoSvPxsjUNALVdiN2wvcdnsqXnz6l59LJ4YEeiQeQLocHqxxftbVsgwEY54BlQgac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ut7NuIs0; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b996c8db896so479434a12.3
        for <linux-hyperv@vger.kernel.org>; Tue, 11 Nov 2025 22:55:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762930546; x=1763535346; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPZC3vwzZRkI5HZ/q+i3flgAzmARVxeU5m73M6Jn+5M=;
        b=Ut7NuIs0oTlD4N+J7tgkRdCyR0Z5nlLLCW5ACRgikDGPdazc2G34RS2REAs1HUx0eL
         uLbr7THog9JGNxW0wCnk+oXmm0GG4O9hEuUbCGBHFZ+0LqCvi9v12PN8bMbQsDdQ+kn5
         78TM19yRoMqrHhKIovQKylgJksjqK1DmPToJ9pti6fX0dQ1jZRUBj/nDkjQM8K3hb7uJ
         hlYwdHGxe7HZsNTDgIsy5+Tm94ZcDnx0c8kq11o7RSreQrgcvcR9YVqpfq9GRUjkdfrU
         wJ/ltMZKP+9XqHPe9zA7oj8cLGw7KOFC8Y8zNfxmiJ3eIqESUClpK4K64yswtLcipz5e
         YJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762930546; x=1763535346;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JPZC3vwzZRkI5HZ/q+i3flgAzmARVxeU5m73M6Jn+5M=;
        b=H94u+kBuvO4HiIp1cErjGjxh/1SAjk6s+BjutMG/kyRvtYUSbzEvYnKgrV7Vi3sUke
         K9ye1aDIkj05G5rusKTi9R+oHkW4sO0fpPEJiWSkL9In5vhLrHg8oRe9sxM/xe8gHoIW
         POfPpWAGrdJ51t2kQTn2a2SZfCyZ+ChYNdboPoK+467xphZUqb2Oi63L4IR3Q4C7i44B
         7D00qNg0QAXQtWAIUeAubRWOPCneLujzio7i07uBBkz+FwZJxvBW95ShoMZXzIYSwWv8
         /h+sXunGaB4XhNIM3XYnFGI1UsByYh9lzKbBKZXPl7X/h6bnBmuLijB8jWqvmR0rXQbb
         NH9A==
X-Forwarded-Encrypted: i=1; AJvYcCXoz/tdBQVKKVpvXt55WN/2BuPvdoIRwiRVtCYY1vIf5Lpv0s3RHGzI6YkhEWIeskbxMVrRRTmzoG7evEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzip/0ePYgzTMb1Goi5PBvBYcI2sSLCLrGq296g8iAOVB2e7kN
	qgp7Bp1U24RF8TYsWNkiHilPJi+hnSufoY5TabCXMzXnj51dNwmtc2ED
X-Gm-Gg: ASbGncsrBZFNNCrh3Hw7kb+UJp2YkMGi3lJD9lVOYPwZzellBia6/qNVQHR8mGEg2Gi
	ZXVYti0FNd0FK8kQrCs2j01RCfa8dlehf7RgSml3kUZFuOzH6WSiuXvSf10lF+befKeoKH7uvOD
	zLxMXqm4OHcRaF7EmbHZe8dDqq5t26mOGvTS5TT8pW09GbOZ5x/2X2/2JFyrRQx3BwmHB3LX+IK
	7ZUtXiEH6Jq/ddPct27Jftqum0nNmfR/aw2aAp8qAZV2ES68WZUuNXaJL7dbhbuTZiskbrJPxI/
	E8jHNqva3D96+yLYk9j5F+9E+saKkX7aPLXwnRz3dQSG+Q7zuFfi1rEKzMKkzssAVv8DucnlWQE
	PavxFIMq+Tl7n4Vk6DxSPE/rd9m28Hi+SOV8JiVSy7lIe+xNyt9HJ+D6omIhLxFk5HjVjkKH0
X-Google-Smtp-Source: AGHT+IF63wc5PyBiuw3bp1ZcuTXR2K3zypie/OPBry1LcGiDsecEoImp4LY23rndvM78wnDiolZbBA==
X-Received: by 2002:a05:6a20:7d9b:b0:351:1cf3:7f20 with SMTP id adf61e73a8af0-3590bb184d2mr2455933637.59.1762930546212;
        Tue, 11 Nov 2025 22:55:46 -0800 (PST)
Received: from localhost ([2a03:2880:2ff:2::])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-bbf0fab0ef9sm1730860a12.9.2025.11.11.22.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Nov 2025 22:55:45 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 11 Nov 2025 22:54:54 -0800
Subject: [PATCH net-next v9 12/14] selftests/vsock: add namespace tests for
 CID collisions
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251111-vsock-vmtest-v9-12-852787a37bed@meta.com>
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
 tools/testing/selftests/vsock/vmtest.sh | 73 +++++++++++++++++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index ef5f1d954f8b..cc8dc280afdf 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -48,6 +48,10 @@ readonly TEST_NAMES=(
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
@@ -67,6 +71,17 @@ readonly TEST_DESCS=(
 
 	# ns_vm_local_mode_rejected
 	"Test that guest VM with G2H transport cannot set namespace mode to 'local'"
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
@@ -558,6 +573,64 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+namespaces_can_boot_same_cid() {
+	local ns0=$1
+	local ns1=$2
+	local pidfile1 pidfile2
+	local rc
+
+	pidfile1="$(create_pidfile)"
+	vm_start "${pidfile1}" "${ns0}"
+
+	pidfile2="$(create_pidfile)"
+	vm_start "${pidfile2}" "${ns1}"
+
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


