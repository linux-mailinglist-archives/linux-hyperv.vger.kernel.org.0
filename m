Return-Path: <linux-hyperv+bounces-8341-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B04F4D38878
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 22:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2603C309358D
	for <lists+linux-hyperv@lfdr.de>; Fri, 16 Jan 2026 21:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D16AB3112D5;
	Fri, 16 Jan 2026 21:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Osn+NoiR"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5EDD30F522
	for <linux-hyperv@vger.kernel.org>; Fri, 16 Jan 2026 21:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768598952; cv=none; b=OrtBo7pdMNGFy4DoW36GGFCJilYC4bdignFh9kzauoHq9Y43dCHHp2AIvkYrkk3z+l5vTQHMwDov0kWLFptfDX897XRGbwi/gU6PqtUr2MqQhbMhYvoB0v4Sn4lRzCQYgAuoPkvkkYTIIEdIFhTCSWys/O3ox+CsjbTeB6+l17o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768598952; c=relaxed/simple;
	bh=FRcd1avd4PB9PmO5dQgmUicVEjm2xp4QOwjVLS7lcRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=XmEEwjKkP5m5fE+gKOhG7XxulPoYzAW+9mhmdoi0dxHeLpPgpLhLe8/vaDewqG9+djawN/01w2qTeEscHHEU1B89BHh5UYtDEr1+ehJtDG8SfJfRs/lw5WPNR7+n9R2cKzBs5xhKIrrNngKuj/TinxeQ/2+05YYA352IP2klUhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Osn+NoiR; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-79028cb7f92so20362517b3.2
        for <linux-hyperv@vger.kernel.org>; Fri, 16 Jan 2026 13:29:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768598947; x=1769203747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I07oD5ozWqHJLvu76IbvCT33HoDsgDmgjc920I58eyc=;
        b=Osn+NoiRUJBgwuOv7pxlurjOBPbLXJUuE+lcy93gFLwXujgUYLZWhSR829JhVurRYi
         65SnBwiPcePiJ6/Q1GeCz3WyhdqZid6C0LpwAaBVs8cvBPIBPRVWCL06lr4JJrYdhlaN
         +Bmi196Hn1wxBgayhyEe/RFnhlfaks0dd3uq8cDCiHRQUlVGWaTb6HdvJ6JUU8BYyBlP
         aWotOM535PYs9+rDG3Ug/Y6Nf/RIXdWfZeHaSKJ4Iki9UF6PM/TWLfHGSLi3/GJEXQTi
         g5u9/eN1topAcLapSF1R0sEA26rFoFKgEyx2G9ThwN351Nuag8oZ75WAD28NBlAFqS0K
         e9mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768598947; x=1769203747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=I07oD5ozWqHJLvu76IbvCT33HoDsgDmgjc920I58eyc=;
        b=hH6P1TRbPqInt7ppJfc5hapOdBNmJWBWK6RIH5TLGvRQhaT/qy78v2mTdzm7lvRhCa
         6e9vRbMe6ILnuTQOHvAbRimK5vd6c+ZdhWOqzELPzb+Y0Zcn64qiXJC8XAJVQVFwnceJ
         306BCgp6wM9ajYlwYKyPPJgMsk1QVmRFCXCFRJLWySxfck4Bv31oUffTQQpzaQlzUg40
         aaDuSZ3VsyRszgonRzecyEo0XwLIAxIRwtOjiRXb5ohMeq7/51QjMkX3WRdNlrN2e48g
         e6DDkheXZi+uZaaa67U0QIuIw64ysWIW/cbEqaUUAv4sVjvAFVfomMsBzScxTvYKcmAH
         OipA==
X-Forwarded-Encrypted: i=1; AJvYcCUqYw7XbvjtbV8SeSH4+tSkx1igmRGfrR1Hw5SxTxm5KGbPDFMIpWSkOX3hqrTZ8Xg/l9iC+GS3Dfw3DS4=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxvkXCWSUPdFTthOoVbG0xZ0sm+3/ZWuormd5YdMXe7tgkjNu1
	ME0L6Uro84gBjtk4/mrNGW8t9KrYGeU9kLTWpOaczs+Z3xvmEKl29oGV
X-Gm-Gg: AY/fxX7fkIwnPyk0S1KOXSSW3EE4oe2i8iyiUfotZ0fxEHJEWrohvSmu769zgFPBaU5
	KvIzEjVtjbqBmgmCODvfd5CqypKYAL6HTfqKoOVmPIvk056wD4JrHo162Vj7STEVyCgOS91K5Dd
	4Emy+mQpqfb7kZOKhLuVfMybeKSraJoShsoM+MEh7vk07ZLwqyPXfqdp2l2gk4q2etl3ZkMK10Z
	D/Dikt/YC1C68uqSxtW+y2rzTHMm0fo4wJngKzkTuBHrKUSRboynOy/MEOnj7/HtmOeuTmLwi3L
	CLO6nFqNn/4/VJzNk2qsBMHidC5KdqJIqdj5PZZR3QNYrbNnIQoTecEjf88nxaBMVNbfGUB5/kd
	5u3DL1vsXtQipbToRTSDrndkf9x47rU/WC11LwjARotnZ2bvsrQ5UUYVfLjQjgKGveXBVfzDBZi
	2k/r+bRjOEsA==
X-Received: by 2002:a05:690c:b15:b0:792:6c16:110c with SMTP id 00721157ae682-793c6878c95mr28874267b3.61.1768598947252;
        Fri, 16 Jan 2026 13:29:07 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:53::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-793c66f3284sm13566387b3.17.2026.01.16.13.29.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 13:29:06 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Fri, 16 Jan 2026 13:28:45 -0800
Subject: [PATCH net-next v15 05/12] selftests/vsock: add namespace helpers
 to vmtest.sh
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260116-vsock-vmtest-v15-5-bbfd1a668548@meta.com>
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

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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


