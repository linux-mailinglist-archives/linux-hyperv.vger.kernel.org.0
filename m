Return-Path: <linux-hyperv+bounces-7762-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 201E8C7A480
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 15:49:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 8F5E0293DC
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Nov 2025 14:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79102299950;
	Fri, 21 Nov 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI+zDcBr";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="GRtP+FRY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3E428850B
	for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763736541; cv=none; b=IPR7Od6wSFJ2MW8Ee7cIRvKpV0OU4kyPiILCtS3iXE8Y7QVkkGo3r0lTKexhW1f4xrX17wSvaJC4M+hXw1q0W6hL+FN65NdB6tdEEMQQTUjO0KNjeJIJGgTgVXlQGAC4Ca7g0hiNA310vw6OeWkzPkQa8mjM+6B3gQq2WxP2IXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763736541; c=relaxed/simple;
	bh=9ksRgIEpFArrDBwuWTU+fH3xIEsF+1N4YpMi7lIilCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bw+v73xjn6UZ34e7TJMXPh5v7/NWPY59FR2tXqrvoEwkDA+gwriVsqzPN994AhbRpV/bFGy+svomf/Kbmt18BXr2yP1Lob66+ogqHmiljD9Fc9M67yrlrzOO9DPl2M/6EJwD5LtYxN+/fTOGvQw2EuL5URU13f8k5RtGZb5O5hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gI+zDcBr; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=GRtP+FRY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763736536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qElSsFo0aW6CHPj9+eW97E36THKCE3lxiDkjHrXDAbA=;
	b=gI+zDcBrL0BYvbgBdnXE2wtuC1JpyO3QSlCnPDf1PL/wVMloK1+WKiL6Ib0gI/dBvS3sMr
	wACfOlksVOwHXjzWhEN38/Njv7NO30PkGcASbxIMs1ZvVlIZ51BnfTIGcwjlOJ7Rrbc5TT
	BmYVNa5EJth1+Ny5w1Z9w7+YhvY+2d0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-HgkjG1d4PHuaCngiqX6Zag-1; Fri, 21 Nov 2025 09:48:55 -0500
X-MC-Unique: HgkjG1d4PHuaCngiqX6Zag-1
X-Mimecast-MFC-AGG-ID: HgkjG1d4PHuaCngiqX6Zag_1763736534
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-6416581521eso2058499a12.2
        for <linux-hyperv@vger.kernel.org>; Fri, 21 Nov 2025 06:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763736534; x=1764341334; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qElSsFo0aW6CHPj9+eW97E36THKCE3lxiDkjHrXDAbA=;
        b=GRtP+FRYWH+cKEmhFTxSrAp+qgb02DIzaRMXa/S3rumesM16JfDg1+mURMWjyHMJBr
         EaVlXM6palPZApdwQsxzgTF/IoV+As2Rwad0A4WPaGLlqVwpPVzQqqfeOLiUpN9ez84h
         /myMEfm8VQ2Ba5TjEzg29laaoAdWhBA6/B0Vx71PkMvPelIueqRzgkWbPzAdf+Pp9h9t
         2/dI8y6s9Gds8ObQHGoU1MSMSq9zQ/uyqodz21xOs3ffhQR/3ruFUeNGBa1P2nUp8JwO
         EOBcuh0tGv4TXQcx+4iZ/o+yJ3cf+sdTxSIpXFkrhQVri3wTiFyEu9/l+/6eIqB5XNME
         /aAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763736534; x=1764341334;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qElSsFo0aW6CHPj9+eW97E36THKCE3lxiDkjHrXDAbA=;
        b=lgXpBdVAugOVTAbGvyklG8CF2ZSgDftFKJ6FF+RXIoRsKpvIhJRHgodUcJh2tUybmD
         nRyLeHwe3iK1ur+tOb8Tnf8O5k3myNlkUibL8jyt6c5h7MdBmCE8i2cZDaZr2qPRfSjd
         OIUGhPWamsFjV5DOJ/Rl3mKr8BzLrNNGmifwuD1eszL1/+VldkT76TUSK2zFzO6w57Sp
         Jgt7GnwsSBkC6n5W9HhsBE/X2POYIRAVhbMg2LmlFCqjHQQKSW6wIMhAF/afKhf7tD2e
         LyDCHcIki7v4bacJn0nKLJFfutbrvMVxftX+gPuGdJJTyNXjTz+EX0r15TTvoeAYRxe0
         oRog==
X-Forwarded-Encrypted: i=1; AJvYcCVMf/8w+Iy5kh7umWxr+pQFf5sji7a8ICU3JI1XU/Moaks1scOaZoLW96z+/rV+mgfKlG/YL3Vlh8RWcVI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaoYMLT8m9gAAOnk8qWzkVx1yg9g063qhX8wdZ+VoXUJV7S4Rr
	WT5/7aM9UesvEukTtjRluQ1coOiJbvxkHXXCmtw1Jpr0RKxjMkPi65ySxC4D0qPfW/12yLhXHQZ
	Ftr5gwNc19Pybe8VMTVcKM8WnWS9RgIK+qa9DvOpLwfjmWIoFlkDK6vsU8KyeiIJ2IQ==
X-Gm-Gg: ASbGncsXw1DeRfaLk2ZujoVpCA2zdziNdn+cmfJTcUJqVDUHkAcpmQcUegUTJ9nA7R8
	8IWo+aLv1fS+R3kbRxqMa0qEQUJ3HcFnT3El+0KkSXIi4m4r7E2gkVE6h22Z78NhXtW6MTAq+Qw
	UyvPGYqrfDMHWohXzMgzTviPcuqbsfZOAhZpseoIqUQiSL32MXDBSh9hs9NqTm/JXRKxwFE/DX/
	IRxfdFTuqd8tRsTl7CWtni06u8lpBXbvjC26BVxuJfduMIz6AmKWgF2pRRLWQztR53/Kujrr46H
	Ct1eW5dJj7ht2iyiNq2tonZxQvRBP8GShRGXbiFlxPy/xCVj19vybYknNzLsy2ZyLrnfEj+qGqt
	y/SfTi3n9KFZygpuIKYlmXu7t1j5Du5Z5s54UDm6nPvmo7ujyFSPvBeYOB5lhnQ==
X-Received: by 2002:a05:6402:50d0:b0:643:804a:fb54 with SMTP id 4fb4d7f45d1cf-64554335d3emr2541669a12.13.1763736534240;
        Fri, 21 Nov 2025 06:48:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFYJ6NYmSLizuNfGJGB7tJ5ZuOQzhRvgxOwNrAKBcDD7p9ENJ1FC64SfddE4bzlIpGVmVbelg==
X-Received: by 2002:a05:6402:50d0:b0:643:804a:fb54 with SMTP id 4fb4d7f45d1cf-64554335d3emr2541631a12.13.1763736533716;
        Fri, 21 Nov 2025 06:48:53 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-139-91.business.telecomitalia.it. [87.12.139.91])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6453645f2easm4585052a12.33.2025.11.21.06.48.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 06:48:53 -0800 (PST)
Date: Fri, 21 Nov 2025 15:48:41 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, 
	virtualization@lists.linux.dev, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, berrange@redhat.com, 
	Sargun Dhillon <sargun@sargun.me>, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v11 11/13] selftests/vsock: add namespace tests
 for CID collisions
Message-ID: <zpfacrsl6dxmo3ltwiovrcj4rtbqgnms4z6rwnw7o2jncgjw5c@hrorb4elx6mm>
References: <20251120-vsock-vmtest-v11-0-55cbc80249a7@meta.com>
 <20251120-vsock-vmtest-v11-11-55cbc80249a7@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251120-vsock-vmtest-v11-11-55cbc80249a7@meta.com>

On Thu, Nov 20, 2025 at 09:44:43PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add tests to verify CID collision rules across different vsock namespace
>modes.
>
>1. Two VMs with the same CID cannot start in different global namespaces
>   (ns_global_same_cid_fails)
>2. Two VMs with the same CID can start in different local namespaces
>   (ns_local_same_cid_ok)
>3. VMs with the same CID can coexist when one is in a global namespace
>   and another is in a local namespace (ns_global_local_same_cid_ok and
>   ns_local_global_same_cid_ok)
>
>The tests ns_global_local_same_cid_ok and ns_local_global_same_cid_ok
>make sure that ordering does not matter.
>
>The tests use a shared helper function namespaces_can_boot_same_cid()
>that attempts to start two VMs with identical CIDs in the specified
>namespaces and verifies whether VM initialization failed or succeeded.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v11:
>- check vm_start() rc in namespaces_can_boot_same_cid() (Stefano)
>- fix ns_local_same_cid_ok() to use local0 and local1 instead of reusing
>  local0 twice. This check should pass, ensuring local namespaces do not
>  collide (Stefano)
>---
> tools/testing/selftests/vsock/vmtest.sh | 78 +++++++++++++++++++++++++++++++++
> 1 file changed, 78 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index 2e077e8a1777..f84da1e8ad14 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -51,6 +51,10 @@ readonly TEST_NAMES=(
> 	ns_host_vsock_ns_mode_ok
> 	ns_host_vsock_ns_mode_write_once_ok
> 	ns_vm_local_mode_rejected
>+	ns_global_same_cid_fails
>+	ns_local_same_cid_ok
>+	ns_global_local_same_cid_ok
>+	ns_local_global_same_cid_ok
> )
> readonly TEST_DESCS=(
> 	# vm_server_host_client
>@@ -70,6 +74,18 @@ readonly TEST_DESCS=(
>
> 	# ns_vm_local_mode_rejected
> 	"Test that guest VM with G2H transport cannot set namespace mode to 'local'"
>+
>+	# ns_global_same_cid_fails
>+	"Check QEMU fails to start two VMs with same CID in two different global namespaces."
>+
>+	# ns_local_same_cid_ok
>+	"Check QEMU successfully starts two VMs with same CID in two different local namespaces."
>+
>+	# ns_global_local_same_cid_ok
>+	"Check QEMU successfully starts one VM in a global ns and then another VM in a local ns with the same CID."
>+
>+	# ns_local_global_same_cid_ok
>+	"Check QEMU successfully starts one VM in a local ns and then another VM in a global ns with the same CID."
> )
>
> readonly USE_SHARED_VM=(
>@@ -581,6 +597,68 @@ test_ns_host_vsock_ns_mode_ok() {
> 	return "${KSFT_PASS}"
> }
>
>+namespaces_can_boot_same_cid() {
>+	local ns0=$1
>+	local ns1=$2
>+	local pidfile1 pidfile2
>+	local rc
>+
>+	pidfile1="$(create_pidfile)"
>+
>+	# The first VM should be able to start. If it can't then we have
>+	# problems and need to return non-zero.
>+	if ! vm_start "${pidfile1}" "${ns0}"; then
>+		return 1
>+	fi
>+
>+	pidfile2="$(create_pidfile)"
>+	vm_start "${pidfile2}" "${ns1}"
>+	rc=$?
>+	terminate_pidfiles "${pidfile1}" "${pidfile2}"
>+
>+	return "${rc}"
>+}
>+
>+test_ns_global_same_cid_fails() {
>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "global0" "global1"; then
>+		return "${KSFT_FAIL}"
>+	fi
>+
>+	return "${KSFT_PASS}"
>+}
>+
>+test_ns_local_global_same_cid_ok() {
>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "local0" "global0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_global_local_same_cid_ok() {
>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "global0" "local0"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
>+test_ns_local_same_cid_ok() {
>+	init_namespaces
>+
>+	if namespaces_can_boot_same_cid "local0" "local1"; then
>+		return "${KSFT_PASS}"
>+	fi
>+
>+	return "${KSFT_FAIL}"
>+}
>+
> test_ns_host_vsock_ns_mode_write_once_ok() {
> 	for mode in "${NS_MODES[@]}"; do
> 		local ns="${mode}0"
>
>-- 
>2.47.3
>


