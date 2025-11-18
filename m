Return-Path: <linux-hyperv+bounces-7691-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E14FC6B240
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 19:13:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 188B6362506
	for <lists+linux-hyperv@lfdr.de>; Tue, 18 Nov 2025 18:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4975335A12D;
	Tue, 18 Nov 2025 18:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LHoRL0W9";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aLwdneCf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7863730DD28
	for <linux-hyperv@vger.kernel.org>; Tue, 18 Nov 2025 18:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763489596; cv=none; b=mRGnlGr8Gs2Lm3MkhCNupeeDjwCiTltc3RAwFXp12ttnIfliMB+5uvdjuhdRNPjVdZJ62aFdCgc6iDpBHLhAyazgBfbZHLUMu3JiKzrVv3RwIqerj+wctLRbyR8JTALSQ1djrotOeRoMn4B3Oh9xMAFtXxwsqn4kcWKFtlfWdB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763489596; c=relaxed/simple;
	bh=ESkljyOopVtU50//2SKEaLXXjPSw66upROeHtwZHBTo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LWRtnRf0r44u1zjhMNKQUfO+0bKyF5EVk2+r0vfN2Oshn4lwCWLFzmnpRP/Rai7ob5MvANNJK03UwxtPLasg2A1pv1XAIJOkwAAxay/GYuAuFbkIGC/VOxqk/rtdMZZnduJeTN0Fz52kv4DHPN3I/2gbojgDPBBSCnW9xn3EjNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LHoRL0W9; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aLwdneCf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763489593;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=voAmjtngZH987SL0d1/xV0xBaRhoeK7O02B2C/SKO58=;
	b=LHoRL0W90uQfrkONRFJVVusN1nPdqkZL/rA18Q8YGdnESAm8eYezQcV0F7cFkAk08uiuG1
	bwpy4TKwIvGW4fgAz1WyykAGqUylyK0XeQNjJUdRHFCwClzBxO3hRvM0HWVKrElPVgTYg2
	z2pmi1vSD5iGtZF30laloS9gNVHbFzw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-364-MxpBqV9hNTWJ1Aw8-53hSQ-1; Tue, 18 Nov 2025 13:13:12 -0500
X-MC-Unique: MxpBqV9hNTWJ1Aw8-53hSQ-1
X-Mimecast-MFC-AGG-ID: MxpBqV9hNTWJ1Aw8-53hSQ_1763489591
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4779b3749a8so13273955e9.1
        for <linux-hyperv@vger.kernel.org>; Tue, 18 Nov 2025 10:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1763489591; x=1764094391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=voAmjtngZH987SL0d1/xV0xBaRhoeK7O02B2C/SKO58=;
        b=aLwdneCfEURxR7QwR+JA//XqUSuJiIbzyi+clLnD3IqgHujVMNwN2T2nrf/ukOJ409
         1j6NmZnROQ9GXRlYiQ2+VolkampsITJDQKVJEsL9ECMWBZyCttOK065SKm5fVHo9AKUZ
         XZfvocAUJVJNmqSWOp0wLY5SyFJnCYJ5b5A3x8A6GdwvSnHwAgWaLBtcRmeoLgCHDsV+
         Pg1Fr0EoSEu1mXF1GRiXY3E2YCnZxBbA3f/9NAfB4aOuBiP1QPS7xqy3GfA1rnR0oivM
         IeiRb2qiCj7z8/rnETcuBpwJYVzlkvPL4EV+Q3ABp1oc7Zv/pOz2+fA76NVhZ+0d+fao
         XUgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763489591; x=1764094391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=voAmjtngZH987SL0d1/xV0xBaRhoeK7O02B2C/SKO58=;
        b=mplUC8hp+CQSIb233oK6Ttr+Xxgx0tGfnRxZ94ZdNreyA8eQWQjoW7wH+IGDDkrOiH
         ovewhhiuc03bWarPvL3tycmAQUfnxqlVnOFKmSJ1MhIue0f3Emn3KvFAManmrHMXPB6f
         9hB7vLp1oGJ8djz5nCiaKxZTHlpYSt0tYIJfC/ghv4k1aXVAXpk3qti7+apBXzd4anKk
         w53eY6E+TF0bnhQb0YJzjTGfR7Pe+5PnvoKSzqjEoQ/OVJZbNOFIiZb3695g5NOBIAnS
         0jPi4X9sWY5HMOZ0k5fyAGPIoAUNx/6CWobgHHZco61sRxuNoLlim+OcW96BGR16+Np6
         y98g==
X-Forwarded-Encrypted: i=1; AJvYcCVsi2bNnfX4vvSjN0AS2XQMFvwK7ddpWWAeDGTWy+YLY5oNjPnhZE5cbUorFfEFJlGiLZo5QSEsU97qljk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yws0ge5MsYzyZhjDjElenWYDoKjzCSKTvTZp3A0FweTux8moYfx
	nlDjxM+bRsIoMPf2SIeNuxQUz1Zg3pT3RcSlyvIYBCU8bxOSOQWRbe0U84D/N9SORHBcKmN48uW
	/1qulzgcwFsVehjtksysgg1eZlHcZ11U+r2qHDydfmZyTjO4EhY5T7/Ia86pIdmlMxw==
X-Gm-Gg: ASbGnct++GrLkxd0EWPq12f/cTju43UFCybgtj1hK0UNxnZGYDFEnup0/gkpHn207F/
	ion3VSIcpmdo341P/7Grt3DsX8R1rfaAmdiCJCBP50tL/eMdSqnKxAeupLOWeCKUVWKoLVHTaje
	dULNmHS1INkVU6JhsRQdxne/dOTUcj4KeLv8WWmfqCHb2QGvljDxxevSWZxsU+poWmBXrDz/p6j
	wuQQrbCi25mkuYlWE8WpLHb7sSY13sY1ZkomNUDH9gqMiaNy+4Imm5m4OHb7vu713LQll0xxYVK
	g2kkZrKsIp7MHKpZyP5t+z9DgoTQTs5S1FX4Jm+kNfrgbDgegMc62C7fpkLMjNDxMNT0R64cQv3
	6bOpIrA5hyzZCM6cM68ycvHXw9I14YrSKcQToPRS2uSp7pxwYekNqnzrTNN8=
X-Received: by 2002:a05:600c:4752:b0:477:7b9a:bb0a with SMTP id 5b1f17b1804b1-4778feaa7cdmr147586105e9.21.1763489590817;
        Tue, 18 Nov 2025 10:13:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHIT8ng0CUWbvzfqjNxNNDfLjFNDwG4+rLmN0Xj3SFNTvDx9hI+oXmEXYHOMQFCNSDvZBqLmQ==
X-Received: by 2002:a05:600c:4752:b0:477:7b9a:bb0a with SMTP id 5b1f17b1804b1-4778feaa7cdmr147585685e9.21.1763489590295;
        Tue, 18 Nov 2025 10:13:10 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-250.retail.telecomitalia.it. [82.57.51.250])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9e19875sm21423225e9.16.2025.11.18.10.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 10:13:09 -0800 (PST)
Date: Tue, 18 Nov 2025 19:12:58 +0100
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
	linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	Sargun Dhillon <sargun@sargun.me>, berrange@redhat.com, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v10 06/11] selftests/vsock: add namespace
 helpers to vmtest.sh
Message-ID: <643ayuucvcaet3v47uwh22mahncfbm3arjqf7szs4apa7gsklq@clggma36o37s>
References: <20251117-vsock-vmtest-v10-0-df08f165bf3e@meta.com>
 <20251117-vsock-vmtest-v10-6-df08f165bf3e@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20251117-vsock-vmtest-v10-6-df08f165bf3e@meta.com>

On Mon, Nov 17, 2025 at 06:00:29PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add functions for initializing namespaces with the different vsock NS
>modes. Callers can use add_namespaces() and del_namespaces() to create
>namespaces global0, global1, local0, and local1.
>
>The init_namespaces() function initializes global0, local0, etc...  with
>their respective vsock NS mode. This function is separate so that tests
>that depend on this initialization can use it, while other tests that
>want to test the initialization interface itself can start with a clean
>slate by omitting this call.
>
>Remove namespaces upon exiting the program in cleanup().  This is
>unlikely to be needed for a healthy run, but it is useful for tests that
>are manually killed mid-test. In that case, this patch prevents the
>subsequent test run from finding stale namespaces with
>already-write-once-locked vsock ns modes.
>
>This patch is in preparation for later namespace tests.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
> tools/testing/selftests/vsock/vmtest.sh | 41 +++++++++++++++++++++++++++++++++
> 1 file changed, 41 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index c7b270dd77a9..f78cc574c274 100755
>--- a/tools/testing/selftests/vsock/vmtest.sh
>+++ b/tools/testing/selftests/vsock/vmtest.sh
>@@ -49,6 +49,7 @@ readonly TEST_DESCS=(
> )
>
> readonly USE_SHARED_VM=(vm_server_host_client vm_client_host_server vm_loopback)
>+readonly NS_MODES=("local" "global")
>
> VERBOSE=0
>
>@@ -103,6 +104,45 @@ check_result() {
> 	fi
> }
>
>+add_namespaces() {
>+	# add namespaces local0, local1, global0, and global1
>+	for mode in "${NS_MODES[@]}"; do
>+		ip netns add "${mode}0" 2>/dev/null
>+		ip netns add "${mode}1" 2>/dev/null
>+	done
>+}
>+
>+init_namespaces() {
>+	for mode in "${NS_MODES[@]}"; do
>+		ns_set_mode "${mode}0" "${mode}"
>+		ns_set_mode "${mode}1" "${mode}"
>+
>+		log_host "set ns ${mode}0 to mode ${mode}"
>+		log_host "set ns ${mode}1 to mode ${mode}"
>+
>+		# we need lo for qemu port forwarding
>+		ip netns exec "${mode}0" ip link set dev lo up
>+		ip netns exec "${mode}1" ip link set dev lo up
>+	done
>+}
>+
>+del_namespaces() {
>+	for mode in "${NS_MODES[@]}"; do
>+		ip netns del "${mode}0" &>/dev/null
>+		ip netns del "${mode}1" &>/dev/null
>+		log_host "removed ns ${mode}0"
>+		log_host "removed ns ${mode}1"
>+	done
>+}
>+
>+ns_set_mode() {
>+	local ns=$1
>+	local mode=$2
>+
>+	echo "${mode}" | ip netns exec "${ns}" \
>+		tee /proc/sys/net/vsock/ns_mode &>/dev/null
>+}
>+
> vm_ssh() {
> 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> 	return $?
>@@ -110,6 +150,7 @@ vm_ssh() {
>
> cleanup() {
> 	terminate_pidfiles "${!PIDFILES[@]}"
>+	del_namespaces
> }
>
> check_args() {
>
>-- 
>2.47.3
>


