Return-Path: <linux-hyperv+bounces-8438-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMQtB41QcWkvCAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8438-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:17:49 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EE055EAA6
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DCCBE4F478A
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 22:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E1E43E9D4;
	Wed, 21 Jan 2026 22:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Dc9Oa/dK"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842244103F
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 22:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033549; cv=none; b=cdcGy4kiiPF1sJedoTBRrgfzWRdho00R6KUq/mUIBlG+OhNI8AkeRdxNmwkiToU8h4djHt3zhUmjff3xTtm8rrFNGlDL9X8zAcb5R9duAMpImibYuO5W73qzoy7FEf2BtG6QE1n/EeadkoY52l71JL3/cKMrTetDuXbdIYnkOxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033549; c=relaxed/simple;
	bh=43YZlXDQmW65hszyjr5m3UtpfpB8+72+oSXEtxR8B+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=irXMfuex6gL3YBYDKnL8lPtI4UQYWoZi18076CSN3b9v4YW3hudG2jRG7r3SnQIzyzYW9h9uA5Q9QNX1Re8XarAqvMirAxnIlDqMU5tPB056fNXZOt/Or0nSybcEZ5VwaE17+6GhpdAo2kp7PKk3bXRs6Uo7YZ7RaUrYXrgmfgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Dc9Oa/dK; arc=none smtp.client-ip=74.125.224.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-64938fce805so447951d50.1
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 14:12:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033528; x=1769638328; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3I8QcIsIeOrh9cIrz38ZjjL+G5z3ujRC9KA0ugGud8=;
        b=Dc9Oa/dK474AK/J1sokviXcv8eJSFE4pPf5/G+DevjWBG93ky/wb3ViOV1OQ14dV4J
         ieioWkyh7NgUeINzpDNPMoGlTdpDGXJMTpzvC3Wzr+IK37FiULLAxXhAmq5wfOqMB7Ri
         o4ibr4Kgbip0rGfdEjuypC9e7cv6838XEFn9Z21KFaZJXj8krfF8vufTthSdUgh/UsMz
         rsZu1TOirsQqhe8EJGOOkaCXM9ApDKAa10F9eM2Rb17Zp25He0YuwWUI+Onkb+6ineji
         0IvH4vkvO4HBFjWamSEmZIi/YI7QFSMQ9CifTEBGpjOZK1Hlv/NdzdPoSsxwYmnTexKS
         u8xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033528; x=1769638328;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Y3I8QcIsIeOrh9cIrz38ZjjL+G5z3ujRC9KA0ugGud8=;
        b=oZFibUxJO5GHIhwViCKKLLdSUGrBmeNRneN3sPDrhpMTHe5F0n36gSn3yPMAv+dV/T
         76q0QsU5HUWLkB7t+Rlfmj7AAMSY5ag9ZDs1Sm/dH6tCCoy2Z7BW2pXHFZsVgDnvGTzX
         +Hy9uQVKvMHltG79hArKYhlS4OYup9/tsGWkiRes0V+kESw82/p4MWtcu3cEQcz/CNn1
         6BjKIky5OS9UvgctsLvsHJTVkxRF3SC5+LmUzyajBy5if2fk+uZr8SBzaXVbwBbIjUiK
         qfz+p+2RMiSayRQF6Q+YOzMI8XOuxBe2v+s07zqd11o/kt0B1U56lU8JMx7WhaucR6jv
         XTtg==
X-Forwarded-Encrypted: i=1; AJvYcCWP6jzrS5/wmtPnBM/i4glpUm2JjZLVyjtYBcjUXca6ZJPFkprE4QN1+Qk5+cVipwHuXyhu+gAD5vqjUmw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQ4vkBEJW8uP9ulRZcin5zsLSEjWQJ4QsqtiRbKQPuXJOetD4+
	BxVDv6NG3Sd6/aAWHIFbqdWeFDsWr1oc4iLHEOQrDUPKbeYMBOqltD9O
X-Gm-Gg: AZuq6aLgloael8M4agxQjuWF+9tIpw/uJhrCn9kVJnnTtplxrzy3Sa3HozYqZQQ61lh
	5MqMz9AuynuTrJFBXAJCi8KWWoNzBLSVZ/kCxCGIIcZnbH1/vwoNE8sxS0MJT1xQ5oAG3cxAhHa
	daH9wmFnkPJj1SMsDBxDlkaTmtjhHWz8NzmblKPWzgbWhivOKd2BijaIN22zm5c20TuQk0TbWOG
	qXuIycAtDCRseLadyWfvMkvUPuQobIpKDProVCEbiOy5f90oi2cQev/wIu4WDBhY8FT7yBpIA2N
	OvpNSgpkIM9sYa7IcDjWWN2TtKvQqnAz5NxQjufkFiRxwFF6KZNokubL9E9rIeDXW4zpjg69EBn
	Y4QUKHHOt0fSe2UDRGNmrXOIGiqJZuUWkKOmVfPFYwLyq+VZlCMqlVZO6Po13B2zzM+uAd/RKVV
	0c8kGsVvRglA==
X-Received: by 2002:a05:690e:134c:b0:649:328b:66c1 with SMTP id 956f58d0204a3-6493c85636fmr4655728d50.71.1769033527964;
        Wed, 21 Jan 2026 14:12:07 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:42::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6494686dd20sm1661755d50.22.2026.01.21.14.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:07 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:50 -0800
Subject: [PATCH net-next v16 10/12] selftests/vsock: add namespace tests
 for CID collisions
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-10-2859a7512097@meta.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
In-Reply-To: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8438-lists,linux-hyperv=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,sargun.me,gmail.com,meta.com];
	RCPT_COUNT_TWELVE(0.00)[32];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,meta.com:mid,meta.com:email]
X-Rspamd-Queue-Id: 2EE055EAA6
X-Rspamd-Action: no action

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

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
---
Changes in v11:
- check vm_start() rc in namespaces_can_boot_same_cid() (Stefano)
- fix ns_local_same_cid_ok() to use local0 and local1 instead of reusing
  local0 twice. This check should pass, ensuring local namespaces do not
  collide (Stefano)
---
 tools/testing/selftests/vsock/vmtest.sh | 78 +++++++++++++++++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
index 38785a102236..1bf537410ea6 100755
--- a/tools/testing/selftests/vsock/vmtest.sh
+++ b/tools/testing/selftests/vsock/vmtest.sh
@@ -50,6 +50,10 @@ readonly TEST_NAMES=(
 	vm_loopback
 	ns_host_vsock_ns_mode_ok
 	ns_host_vsock_child_ns_mode_ok
+	ns_global_same_cid_fails
+	ns_local_same_cid_ok
+	ns_global_local_same_cid_ok
+	ns_local_global_same_cid_ok
 )
 readonly TEST_DESCS=(
 	# vm_server_host_client
@@ -66,6 +70,18 @@ readonly TEST_DESCS=(
 
 	# ns_host_vsock_child_ns_mode_ok
 	"Check /proc/sys/net/vsock/ns_mode is read-only and child_ns_mode is writable."
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
 
 readonly USE_SHARED_VM=(
@@ -577,6 +593,68 @@ test_ns_host_vsock_ns_mode_ok() {
 	return "${KSFT_PASS}"
 }
 
+namespaces_can_boot_same_cid() {
+	local ns0=$1
+	local ns1=$2
+	local pidfile1 pidfile2
+	local rc
+
+	pidfile1="$(create_pidfile)"
+
+	# The first VM should be able to start. If it can't then we have
+	# problems and need to return non-zero.
+	if ! vm_start "${pidfile1}" "${ns0}"; then
+		return 1
+	fi
+
+	pidfile2="$(create_pidfile)"
+	vm_start "${pidfile2}" "${ns1}"
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
+	if namespaces_can_boot_same_cid "local0" "local1"; then
+		return "${KSFT_PASS}"
+	fi
+
+	return "${KSFT_FAIL}"
+}
+
 test_ns_host_vsock_child_ns_mode_ok() {
 	local orig_mode
 	local rc

-- 
2.47.3


