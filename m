Return-Path: <linux-hyperv+bounces-7301-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DEDA8BF95C8
	for <lists+linux-hyperv@lfdr.de>; Wed, 22 Oct 2025 01:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF50E19C27BF
	for <lists+linux-hyperv@lfdr.de>; Tue, 21 Oct 2025 23:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96D4B2F7AAB;
	Tue, 21 Oct 2025 23:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBqioFts"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A7A224DCF9
	for <linux-hyperv@vger.kernel.org>; Tue, 21 Oct 2025 23:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761090446; cv=none; b=smS62c1WKTA1ZwxMGjFplihJZeY9Zo0Ch8cZP3ACVPAYs92ODT8jkf9hwR9+SstWFriOQOwYQshLyWAtiihJe5z9Op1gsY+L1oLob4xODdLDNQeGNrvt90qw3ceGdziG9m/F1L8K6f3xTyfakCoP/mGQonzoebiHhg3cNwOrbJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761090446; c=relaxed/simple;
	bh=5WTKWKiUk8Dj2RvkxdNnCT58i8QpYZiL92GnKNlZW6Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SXRgONyr0gWLUWOSEvfmM0NxP+Wzm/qlTb7QHBWRexf2RL5sN1uF2SO3DToCP12H1fgmv2L2oY0TP62dGhmSVLjfy1C7APq4aOpmXCvUAY76JG2XzgeA0+XusO6LyUzpnPwUtPF8RPquiehYVMPOJZK/h74kSyrDHgHHZxGSMSc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBqioFts; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-290dc63fabbso47550615ad.0
        for <linux-hyperv@vger.kernel.org>; Tue, 21 Oct 2025 16:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761090440; x=1761695240; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TV8626iy6qZJteqWMHB3Fb4Ctz0bR6NM9tHbIBJXOjs=;
        b=OBqioFtsCFj4zYM7FWkkTYwuPC1RqG8UQ1/NTlDPRV9FY3WVb7xphwfFlH1BdR+AnV
         GeqoMirbsYDWTmFdtKOXW2nH/pELsHLmD06vKQDdBvvCt/ShuGKcg5IECGJtKQleOv33
         UTRYGFt9iiDQXdazj17uuEN239KbjKe2iyWXOcruZuANVD/p6t8w1wdQimCUuSRv6yUx
         U59AtdQMEyTsb2XxFD8EuNL9oopimrrgmB3wHUi0mZrgZAOF1rjsm6Ojd12tsCH+Tpqh
         QlyWWpNO2ZK6vhA1/mOGO+GxpRLSycvl0Th0Pq3nXUYG9psmpkrLi3VfhU3jbFVJSMyd
         1qWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761090440; x=1761695240;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TV8626iy6qZJteqWMHB3Fb4Ctz0bR6NM9tHbIBJXOjs=;
        b=EzHd2OOO/uetD1V4dIvedExayJAAJweMMZ/B60AQYQ3HKFFm3iefNsYRj4Ec96mDdd
         553fwHnYIPGMt9Mc3hTZ+JoSUxXYeBtH9iTlpwIspvQaStUJjXSNHbyuG+E9CgmFF16W
         gUAJIBEhwcMV6Mxn5DqSqLbZa1bVSRLNyXERofraEtB+zke9TgHNaFTEPL2NQ3plRVTS
         frITTqB1jzOxWoL+6VZ/e9heRWuVpLynjkj9kxv8Odm8mii29Bcd7ojrahHO3Deh3Icu
         6gfPj9cYRQgSN9ZOcDxc3MDsYpt7VXP+hnL6lz1q1z0lVmo2KjafMwGcZbnCyjbjrqs6
         7QbA==
X-Forwarded-Encrypted: i=1; AJvYcCW8Ep/ZHjctpV09dZud2JpSz/Nu5+ND6nYJ811jGViV/bOqlSRjIgw8HsZwHaHr5E8KRGr6HkXCIL+YSl4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYgyRCtTiZj6cBR2ePGGxdofVkj1EoTwuxmOgtj9VuWgN1wp/o
	qS/5aVftgXnP2p0q92edBj7po1ebo9A3qJPB3o3X1S/B1ZSKtMvo8N4a
X-Gm-Gg: ASbGncu8xvKNNB9lsjkKEK7rviLVDCfifMghg2jjcHSOJ4d5jWrC/sX5sAXvdOdGHWw
	MaRKq1wDA3oBU0aTqZu+91MMspMLFp4RqhrAEvVxG1NGZXuy92euWDkp3nVmwIEuGgZd/njpgQA
	bDUvr/pW6nSgdUROFZTScdPZHjqH3xE+JLqWbJX6YCk0h3Gk2z0RFCL19S/mxu9qWta/s8qNOpa
	VJgml6wKWU+3qTyOUEic4H22VuPFpI9FDj+01aQnXIO291cmtgQwX7C+MryvYRqr2xBS7pQPFDl
	DJe2eFmm9CRfEBdxFHqDnC11pgBFQr6OFvoYUA5lJdhvX01G6HZjTK5GIm0C09vt60GcX0Da2bG
	280jGo/PcwCe86/Uks7te88vZ+woGc4AlWyhErjflIhWyGnOOVggCkK9mKG5hqAKP9ZvcOXmeGl
	cPtA7b
X-Google-Smtp-Source: AGHT+IF3YtiPWvZebVNqksLPddW34hdGMs6SWVpzynIffF/Cg3VXxCHnVj5pafWbxKnLw/A6JvakJA==
X-Received: by 2002:a17:903:11cd:b0:290:9a31:26d6 with SMTP id d9443c01a7336-290cba4ec04mr234640025ad.57.1761090439594;
        Tue, 21 Oct 2025 16:47:19 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29247223a3csm120532795ad.112.2025.10.21.16.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Oct 2025 16:47:19 -0700 (PDT)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Tue, 21 Oct 2025 16:47:05 -0700
Subject: [PATCH net-next v7 22/26] selftests/vsock: add namespace tests for
 CID collisions
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-vsock-vmtest-v7-22-0661b7b6f081@meta.com>
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

Add new namespace tests that validate the CID collision namespace rules.
There are tests to ensure that global namespaces collide on the same
CID, while local+local and local+global namespace combinations do not
collide.

Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
 tools/testing/selftests/vsock/vmtest.sh | 74 +++++++++++++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 4defadad5701..69ec6ec82b0c 100755
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
@@ -546,6 +562,64 @@ test_ns_host_vsock_ns_mode_ok() {
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


