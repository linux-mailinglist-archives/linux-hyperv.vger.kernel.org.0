Return-Path: <linux-hyperv+bounces-8435-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFyUE2BQcWkvCAAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8435-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:17:04 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E53A55EA67
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 23:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A632858B447
	for <lists+linux-hyperv@lfdr.de>; Wed, 21 Jan 2026 22:13:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7541244CAF8;
	Wed, 21 Jan 2026 22:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EHjsEK28"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07E8D449ED5
	for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 22:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769033537; cv=none; b=ZA2lwVk7Qj+NXGPdb4brSmIyvQ8+R6KohysAsVbSWrlxo2RXGOJU1Qj+g/8NLBUR7IWzpJFRqA2UGsvARAC6VRl5AtozYg0r7LzKMV3m5e1uxPZ8BHlVzo1tHcfKVTrfLax9GbvZxJ7OGFJQpyWlviJK7pM3H5jfbCITLPJmmB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769033537; c=relaxed/simple;
	bh=JAQQN7P77tr97fU7vyuVMrvCiNP4sSFAq43cZhTlmi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nor4EffBwbDXW/zzyTWTnwHh1OumKkML5yBZ5atNL6LjFd5YP+pnzdjrG7Eh+FhDmP/ufNju2qDgqDi5NQhQmiCoigzrYO2uc3AhNpUHvo3oeO/JnLw1SDmPRm0AHHuueBzeVCGYAhADLBqQLNIZQDNZhsKbq/2Pc2egPsxnd9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EHjsEK28; arc=none smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-6494a3d92f5so464452d50.2
        for <linux-hyperv@vger.kernel.org>; Wed, 21 Jan 2026 14:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769033530; x=1769638330; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2mpdsMRuLW1cRrssyJH9GNY+tfbuaJ3H6voxC/Fdtqg=;
        b=EHjsEK28MO6BZ3JsqhVJmLDyEWLSWbkF9pNAa34jS5BeY9tLpZcpMEeX279xsvLjhw
         e7e527ca9P3bStmp5w40AHBT5GTOyRY8eyHMQWDXr/GrKiqcnzI0/CtT7tf9PCIQW586
         3XNnihqOCXsd+Z3PMFWnvh76nMQfVEm1tDdZdOIwCmJB9MCDfGXEpqYkAkp3edZbjArs
         jBRej2Ac5y6gIheucYSdMpBIFToHvgAQkCfTZUeh4QaWCKG9nPKyyMFxbAgpnCEbfmXD
         z7E1c8FIQEf2Hn1FyRU0ALXCaesSwSQ9Bakjm75EWXV9gA5hpjd1BB84YozeV5uc1oel
         RBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769033530; x=1769638330;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=2mpdsMRuLW1cRrssyJH9GNY+tfbuaJ3H6voxC/Fdtqg=;
        b=EkiUhDXuNT8aAgpEmp/d8hWOUo4YYUsxyQhyFa6LYcX8/9Ehv0N86GWyB3rhFeULQU
         dX6NzFEY9lIwPjY2EpMeu4rwsEKVRhTQo8K99dvNQlNlPJvPpSN9g14gx207HaZy2lSk
         qpuEhir+w0/5GM1P2eV0B2hPEW5EvqR11wWcG02qlScmFRx/psP4u22KkrVsYyfgNCOT
         0zAHsQrLwf6LnnwIIs1cvOQyI83bNxBPG0pFyhpIUi7NMGrJWdMveWpiPZYIPXR/0Ner
         nLgkwTeXf2cuaQxW/OxnzTnCpc4ZNffc045RWKIM5R+GW+xcfOT/H/oJyOpDOQpfPpgl
         L0sA==
X-Forwarded-Encrypted: i=1; AJvYcCX6cqBWfVTu3fmzfDWd2/+mcdLtnMuDE6+NbBxQZSQrr1X5joqPg/NC+5BaC1J8nYt7DQhHV6HYhNAbBCk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyFMniWRKuS8nKg9SLBeJ+IP2LCwbKtREVquTM6NKKYFNsYlUP
	/QIOEt91LyfdsKPUYYNNh4BM+I70SjZwVkVww3fuCAmmZUqduGCv7AMw
X-Gm-Gg: AZuq6aKUx6i4eQZPfw00dSKP0ZaQbPWd+XvotdM/bkXEoREBQT6dY6kZ+DCwU+hqWGX
	nEVNO/InEss2ZXN394OcdYLb7UgHzepEAxb0vhExdfbLSFMNTcxENw2uxHPhU2CC4nQ+fyLC6MY
	JHP+NHU2nPGUYmXmLrZUcnJDWeBp3xe8hEcBjFJ54Izl7dwrBt8TqAyizDeltOhwdFoLcckoLAy
	ArnWF6R8fwQYGtqwHWSGYcrdj3Ab2GFeT2Niscp3b5bsXhNYQZRxiSuoNJSSTMvl+2ab9ZByI73
	5KBqN1tyyk4o12fqZk1IwA+zu9OHatKSnnwfUNny5fmtlJQk+3puIjsk8VvmqcGnDWLWps1Qgxt
	yzgPz4DY9XWgaqCB7lazk/I9umO+PjJcHIQnMjNG+hzBjo/ABTrF4dIjEYT/naakJdaRwwEadlY
	UjoEqzS53D
X-Received: by 2002:a53:d013:0:b0:644:472d:db04 with SMTP id 956f58d0204a3-6493c84922emr5253487d50.55.1769033529707;
        Wed, 21 Jan 2026 14:12:09 -0800 (PST)
Received: from localhost ([2a03:2880:25ff:2::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6494080138fsm2463523d50.20.2026.01.21.14.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 14:12:09 -0800 (PST)
From: Bobby Eshleman <bobbyeshleman@gmail.com>
Date: Wed, 21 Jan 2026 14:11:52 -0800
Subject: [PATCH net-next v16 12/12] selftests/vsock: add tests for
 namespace deletion
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260121-vsock-vmtest-v16-12-2859a7512097@meta.com>
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
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,redhat.com,sargun.me,gmail.com,meta.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8435-lists,linux-hyperv=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[32];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E53A55EA67
X-Rspamd-Action: no action

From: Bobby Eshleman <bobbyeshleman@meta.com>

Add tests that validate vsock sockets are resilient to deleting
namespaces. The vsock sockets should still function normally.

The function check_ns_delete_doesnt_break_connection() is added to
re-use the step-by-step logic of 1) setup connections, 2) delete ns,
3) check that the connections are still ok.

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
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


