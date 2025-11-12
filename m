Return-Path: <linux-hyperv+bounces-7534-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C7CC52DAA
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 15:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF55150133D
	for <lists+linux-hyperv@lfdr.de>; Wed, 12 Nov 2025 14:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF7E33B6D1;
	Wed, 12 Nov 2025 14:39:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="e87exKAE";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="hVPn9Hep"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD462C234B
	for <linux-hyperv@vger.kernel.org>; Wed, 12 Nov 2025 14:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762958361; cv=none; b=VGtonJpl1m+zHlUYg43vb5nAJzMCAQcwp6+AMN8SsXfFB2fG2mrIvBnWcviJCyVZFefeyP9xYEkWNTXsuKwp7WYvRyiUqr8KX+FzylKMZJsvWJGUKzzChA8nQR8V/VFYMKDmm22tmlyf4GFnWdsv4TY1aunlPxACTQF9+o8Walk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762958361; c=relaxed/simple;
	bh=3Y5Rek476DRnICcL59SdhHJobO3Alq+z2QEv4tspv/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gM2XXsGJcEzJr1jPLKb3od/NjAr1dmxUP7sXhdjf7izG6iastCoFV8Pp/aTB3iYWoLhqTWJkaFGDfLd1uqUJa8XKdDS72XTagng95f65Mz1FlmT+82Cw7Rv6VjOqxbHLZ68tYRKbxpK9/g5jpU2RKjN1Q9kVEptifkHfMv4FTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=e87exKAE; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=hVPn9Hep; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762958359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yy3Ep09902zeh1G5H25RD9UCrYtK867aTMu4aMrvufE=;
	b=e87exKAEDkuznwKFMIbe2lChvxtPX8Tue8EZM9IFwe71zGw9V63fd/P96ojlkpBvaHbdIO
	QkibABOI0z9ecsqJXCnJ5ISYbejnNoZoT+lfmAPgeuM15joACoo7Ym2HjTZ3ll8nZIkkaY
	QW0pV7r55t0Nuy7uLSme8KO9aCEtMm0=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-493-MnKgWHblNQebdWVisuPF7g-1; Wed, 12 Nov 2025 09:39:11 -0500
X-MC-Unique: MnKgWHblNQebdWVisuPF7g-1
X-Mimecast-MFC-AGG-ID: MnKgWHblNQebdWVisuPF7g_1762958351
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8a5b03118f4so216517085a.1
        for <linux-hyperv@vger.kernel.org>; Wed, 12 Nov 2025 06:39:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1762958351; x=1763563151; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=yy3Ep09902zeh1G5H25RD9UCrYtK867aTMu4aMrvufE=;
        b=hVPn9HepDfqsqhTlbfBy5D7bjgHcf1u73BPjB2PLDIgOgf178Tc4w0eX1WFrtRuYBR
         Hf0yGZ9iWBP1mIhdtIgrhfAjpPknwN49joNjfSprBVaNPQRidUbV8Au1dJOAwr3GbblV
         HJV09JeHyhGx1l3NOVH2b0youXquGJOTaMt1sxd/LH5lhb2jmBUcH5mw3DzwiaxF2FiA
         epSNDz7pFVgwP9dlcJhpfZ3Xrusbm9mF1tHYxHwZqc7HuF4ci+V6QPsp2w0wJmk0SAUN
         SkNs+157/Nd7iWRXs/9jydIcG1dBtgeZ0ku+1qviExEymZ8r1rmiEm92K4/lGTLjjVE/
         sbzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762958351; x=1763563151;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yy3Ep09902zeh1G5H25RD9UCrYtK867aTMu4aMrvufE=;
        b=hQqlXDvbVEBaolW3kNaOZ43Skb6C/YHoCGbpSGthtk+fd4TBUzhgyqHZILyHh/onOg
         ZDLpAXk7LDqYR3y6oerjv3HFBLWPp50VofW9BxgJ3LcoUgeLUi2AMnGC3Qhw+wGry7Oc
         XoAJ6elZyKfX0JTNCDQsAvgh0S0ALpn13oD7tNcEZuPIcNIIuapgdwLan/fN5vjdjDFG
         lnFVbsL1LjzCmXnXibIqcLZeTH4al4oAcZZCnhQHsTWko8XQ88eggWQw6UtIoqOUQ5dX
         7A3/XLYjWikGAmXjZ8DQxj6GhG4cjlGipr02MPqTLXCgvutnt3aDbvlbCzcqqBk4TMFz
         qF8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWdFOaNdsNqrHtw4uDaAeaz8yd6QYIF2YW4j69O3QYITf14vM75W6m5epAWcRfauHYDJJnjgawM9Fw7y60=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF6plNCKARvHoNuW+rF9PfJZbWsyPbhNcNgUPyGpmk5vlQZ45D
	3nU/249N3kV7i3Iegako51Z9b2XjPMdqCPRk+tJuVBUAKStCSmM/J82kP0nFTchMO3s2sUxgMN2
	t12i8ofJ102bjMu5WkHqIqurePI6rlOuj6ZQtkM99GnlYClrOCnG9vftCLu4e/rDIQg==
X-Gm-Gg: ASbGnct13WPVsLcPtemyf+kEcVOeCusoAaRnn4NRUhx9gZnVHGumjqzZLQDm6JGW9cH
	cmbgek+4+gq5XUh+f+Q8ikHchT8+j40YDIEF5HExntVUZ6ghQ665C/H6+GlYUH6MjlIpvAOCqn0
	kZl0m+SexfnrT8VE+b5/on8tAY6t+nRDQJfeUbnxTozJ3IkIBAYp6pyscHJ8tln9UIBiVEBxF5x
	9hzExuiaexxEZM8+tKU441Qwg7TiE7M9dtvxFMjH4ks1GYz2joRlhsXfh+e1Su9B+ibLKAM26O/
	EfI2sv+v4ylLz6hdW/U68J/SfttY3cKbUw0AFVm5Z59Cven0F9RtUJd1eS6DJKyPhuGD5Mvd31J
	H8koQZAb7BU1kjrrORX4GVDJg/WtEEG0ahg2FO5JRRvg05yh/vlI=
X-Received: by 2002:a05:6214:19cf:b0:70f:b03d:2e85 with SMTP id 6a1803df08f44-88271a77b0amr42481016d6.24.1762958351025;
        Wed, 12 Nov 2025 06:39:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHctylFyio0HE5+Hg7DsmBnegThy0KC1BdJqrtWBWtEAWsKrqKceBN82VEaRySzeuLB/exTQA==
X-Received: by 2002:a05:6214:19cf:b0:70f:b03d:2e85 with SMTP id 6a1803df08f44-88271a77b0amr42480586d6.24.1762958350535;
        Wed, 12 Nov 2025 06:39:10 -0800 (PST)
Received: from sgarzare-redhat (host-79-46-200-153.retail.telecomitalia.it. [79.46.200.153])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882637f7035sm31482596d6.44.2025.11.12.06.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Nov 2025 06:39:10 -0800 (PST)
Date: Wed, 12 Nov 2025 15:38:59 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: Shuah Khan <shuah@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v9 11/14] selftests/vsock: add tests for proc
 sys vsock ns_mode
Message-ID: <533m3curqlyyqgyrqw3owpzijj2bnvqipahpz7tjdld3j2jfmg@mo5tvqoju7xt>
References: <20251111-vsock-vmtest-v9-0-852787a37bed@meta.com>
 <20251111-vsock-vmtest-v9-11-852787a37bed@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251111-vsock-vmtest-v9-11-852787a37bed@meta.com>

On Tue, Nov 11, 2025 at 10:54:53PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add tests for the /proc/sys/net/vsock/ns_mode interface.  Namely,
>that it accepts "global" and "local" strings and enforces a write-once
>policy.
>
>Start a convention of commenting the test name over the test
>description. Add test name comments over test descriptions that existed
>before this convention.
>
>Add a check_netns() function that checks if the test requires namespaces
>and if the current kernel supports namespaces. Skip tests that require
>namespaces if the system does not have namespace support.
>
>Add a test to verify that guest VMs with an active G2H transport
>(virtio-vsock) cannot set namespace mode to 'local'. This validates
>the mutual exclusion between G2H transports and LOCAL mode.
>
>This patch is the first to add tests that do *not* re-use the same
>shared VM. For that reason, it adds a run_tests() function to run these
>tests and filter out the shared VM tests.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v9:
>- add test ns_vm_local_mode_rejected to check that guests cannot use
>  local mode
>---
> tools/testing/selftests/vsock/vmtest.sh | 130 +++++++++++++++++++++++++++++++-
> 1 file changed, 128 insertions(+), 2 deletions(-)
>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 663be2da4e22..ef5f1d954f8b 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -41,14 +41,40 @@ readonly KERNEL_CMDLINE="\
> 	virtme.ssh virtme_ssh_channel=tcp virtme_ssh_user=$USER \
> "
> readonly LOG=$(mktemp /tmp/vsock_vmtest_XXXX.log)
>-readonly TEST_NAMES=(vm_server_host_client vm_client_host_server vm_loopback)
>+readonly TEST_NAMES=(
>+	vm_server_host_client
>+	vm_client_host_server
>+	vm_loopback
>+	ns_host_vsock_ns_mode_ok
>+	ns_host_vsock_ns_mode_write_once_ok
>+	ns_vm_local_mode_rejected
>+)
> readonly TEST_DESCS=(
>+	# vm_server_host_client
> 	"Run vsock_test in server mode on the VM and in client mode on the host."
>+
>+	# vm_client_host_server
> 	"Run vsock_test in client mode on the VM and in server mode on the host."
>+
>+	# vm_loopback
> 	"Run vsock_test using the loopback transport in the VM."
>+
>+	# ns_host_vsock_ns_mode_ok
>+	"Check /proc/sys/net/vsock/ns_mode strings on the host."
>+
>+	# ns_host_vsock_ns_mode_write_once_ok
>+	"Check /proc/sys/net/vsock/ns_mode is write-once on the host."
>+
>+	# ns_vm_local_mode_rejected
>+	"Test that guest VM with G2H transport cannot set namespace mode to 'local'"
> )
>
>-readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+readonly USE_SHARED_VM=(
>+	vm_server_host_client
>+	vm_client_host_server
>+	vm_loopback
>+	ns_vm_local_mode_rejected
>+)
> readonly NS_MODES=("local" "global")
>
> VERBOSE=0
>@@ -205,6 +231,20 @@ check_deps() {
> 	fi
> }
>
>+check_netns() {
>+	local tname=$1
>+
>+	# If the test requires NS support, check if NS support exists
>+	# using /proc/self/ns
>+	if [[ "${tname}" =~ ^ns_ ]] &&
>+	   [[ ! -e /proc/self/ns ]]; then
>+		log_host "No NS support detected for test ${tname}"
>+		return 1
>+	fi
>+
>+	return 0
>+}
>+
> check_vng() {
> 	local tested_versions
> 	local version
>@@ -503,6 +543,43 @@ log_guest() {
> 	LOG_PREFIX=guest log "$@"
> }
>
>+test_ns_host_vsock_ns_mode_ok() {
>+	add_namespaces
>+
>+	for mode in "${NS_MODES[@]}"; do
>+		if ! ns_set_mode "${mode}0" "${mode}"; then
>+			del_namespaces
>+			return "${KSFT_FAIL}"
>+		fi
>+	done
>+
>+	del_namespaces
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_host_vsock_ns_mode_write_once_ok() {
>+	add_namespaces
>+
>+	for mode in "${NS_MODES[@]}"; do
>+		local ns="${mode}0"
>+		if ! ns_set_mode "${ns}" "${mode}"; then
>+			del_namespaces
>+			return "${KSFT_FAIL}"
>+		fi
>+
>+		# try writing again and expect failure
>+		if ns_set_mode "${ns}" "${mode}"; then
>+			del_namespaces
>+			return "${KSFT_FAIL}"
>+		fi
>+	done
>+
>+	del_namespaces
>+
>+	return "${KSFT_PASS}"
>+}
>+
> test_vm_server_host_client() {
> 	if ! vm_vsock_test "init_ns" "server" 2 "${TEST_GUEST_PORT}"; then
> 		return "${KSFT_FAIL}"
>@@ -544,6 +621,26 @@ test_vm_loopback() {
> 	return "${KSFT_PASS}"
> }
>
>+test_ns_vm_local_mode_rejected() {
>+	# Guest VMs have a G2H transport (virtio-vsock) active, so they
>+	# should not be able to set namespace mode to 'local'.
>+	# This test verifies that the sysctl write fails as expected.
>+
>+	# Try to set local mode in the guest's init_ns
>+	if vm_ssh init_ns "echo local | tee /proc/sys/net/vsock/ns_mode &>/dev/null"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	# Verify mode is still 'global'
>+	local mode
>+	mode=$(vm_ssh init_ns "cat /proc/sys/net/vsock/ns_mode")
>+	if [[ "${mode}" != "global" ]]; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
> shared_vm_test() {
> 	local tname
>
>@@ -576,6 +673,11 @@ run_shared_vm_tests() {
> 			continue
> 		fi
>
>+		if ! check_netns "${arg}"; then
>+			check_result "${KSFT_SKIP}" "${arg}"
>+			continue
>+		fi
>+
> 		run_shared_vm_test "${arg}"
> 		check_result "$?" "${arg}"
> 	done
>@@ -629,6 +731,28 @@ run_shared_vm_test() {
> 	return "${rc}"
> }
>
>+run_tests() {
>+	for arg in "${ARGS[@]}"; do
>+		if shared_vm_test "${arg}"; then
>+			continue
>+		fi
>+
>+		if ! check_netns "${arg}"; then
>+			check_result "${KSFT_SKIP}" "${arg}"
>+			continue
>+		fi
>+
>+		add_namespaces

Some tests call this in the test function, some not, but we call here 
for all test. I'm a bit confused.

Also, are we supposed to use this run_tests() only for namespace tests?

Thanks,
Stefano

>+
>+		name=$(echo "${arg}" | awk '{ print $1 }')
>+		log_host "Executing test_${name}"
>+		eval test_"${name}"
>+		check_result $? "${name}"
>+
>+		del_namespaces
>+	done
>+}
>+
> BUILD=0
> QEMU="qemu-system-$(uname -m)"
>
>@@ -674,6 +798,8 @@ if shared_vm_tests_requested "${ARGS[@]}"; then
> 	terminate_pidfiles "${pidfile}"
> fi
>
>+run_tests "${ARGS[@]}"
>+
> echo "SUMMARY: PASS=${cnt_pass} SKIP=${cnt_skip} FAIL=${cnt_fail}"
> echo "Log: ${LOG}"
>
>
>-- 
>2.47.3
>


