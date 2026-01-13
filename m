Return-Path: <linux-hyperv+bounces-8270-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A194D19FC6
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 16:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8CCEB300DD98
	for <lists+linux-hyperv@lfdr.de>; Tue, 13 Jan 2026 15:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60F6393DCC;
	Tue, 13 Jan 2026 15:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TeMWiBIM";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="PiWvd68g"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FBB3939B4
	for <linux-hyperv@vger.kernel.org>; Tue, 13 Jan 2026 15:44:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768319089; cv=none; b=iY466FIZ+1LccY5uPB2og++YyNxiQUlPq91AcTVSrOeibw0xRcPkcMV89cJDe3GYRJtR8rMzMjC2Y2EvPT+7yzThCeSdGYuchtMMfYLjXvuB+ZhXOxdT4rs6G0KpjKYnzpYUJXNVOG52ULmZtS+LVXq9owOooLGhIHXDGR16uuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768319089; c=relaxed/simple;
	bh=JhyhgZnijw5QpfbaydtI94PP620au/36IgAqarY1YUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L1lvLIM8Yu4Hi3h5ySeCprgQ22N9Z/J5qMLyUKgAEVhhMrDLmX1nE1eP4Pn1HRb0YPa6LqUe42OcSqfjcf5JhGbBJKyBYtZyU9NC7r+4KWt8zoRvi/YgSvzj7lipGiC1goGIBGXDj/dPIXf1EMtkHkeCx3oVhRzOpiXrB/SEOFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TeMWiBIM; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=PiWvd68g; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768319087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=L7njAiBZmdfuy2kNwD9BjAHNOOhZ+/EXOjZOWxqIXHU=;
	b=TeMWiBIMXEHUq/QreNnA7/ioYpr30e+lksjQpF/Rq/D7r93S3sKkNSJhy8gd19JCYAF6xl
	XDvQ7ESJ2IRVrTitziJNUCQjeJLkmzCZXOXLb+wYWUmN1XZzMfkifDK8fhaCYedQFeotrU
	hT+NiOdYF8/ne973ayzz369J8dj9W98=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-N2Sv25WoN0admPFn_daW4g-1; Tue, 13 Jan 2026 10:44:44 -0500
X-MC-Unique: N2Sv25WoN0admPFn_daW4g-1
X-Mimecast-MFC-AGG-ID: N2Sv25WoN0admPFn_daW4g_1768319084
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-47a97b785bdso55511595e9.3
        for <linux-hyperv@vger.kernel.org>; Tue, 13 Jan 2026 07:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1768319083; x=1768923883; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=L7njAiBZmdfuy2kNwD9BjAHNOOhZ+/EXOjZOWxqIXHU=;
        b=PiWvd68gfa0m6UBoisTezMckQcjuYjQdc6PRvxiZgVXJZTnsA3r2iZvMOcBF5uJ4Ah
         Ki4En/71cvoqpmiwxHrXVW+9L3QcEJKB968+o4eOzTgh8HkNClttAHFJGnY7QJjUXx5t
         XhLnEM6WxuuiaRD1JiXT4e0ySsbJdVNZ18n6j8RGtzBnulaUjUpb0qGzgnOG0mRQ5ndO
         bil8OQKBbVyeWYoQSCtJjoVe29y8YWbDkNdcQWeB0zwFXZMzbItUhUJVlkWQ4QacEmby
         yoS+iAHwzoed8eRX3ewEai0eYgb5aQ9Fvqo51zsNjHhxv2ItQKFI7Je2WhZEFX5a081F
         OdDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768319083; x=1768923883;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7njAiBZmdfuy2kNwD9BjAHNOOhZ+/EXOjZOWxqIXHU=;
        b=HCYSnu0mzltSYGm0X1nZkAqz50jgfRdR989lqaV3izmN9aXlXfPfLnMBGXWJwCYwGA
         X4EIdFblixxf94+Ya6pYlLufIaMV5kJ9/xeswsvx8cIBGC3GKGZf4FlvapiVPlyz0gAd
         MsMMBRZL8iMx7Mv7Y4dcWSl/Vh3ssYjW5oZOFmCfoNT+2hmAFuequzCzp9JggyqJ5ZFK
         6P1Pijup6GMxBer0YHXxdGEBvY4Q6c4IKpELn8FR7QVrWUIwXc23FBOjA/kgVSlaEwXa
         AYxS2T9pE+s7CVd98vETAeHN/s7N2MCrIozyRPTE5ODpwhJABR+YxpeXE09Zl5MT5ueT
         WrSQ==
X-Forwarded-Encrypted: i=1; AJvYcCXx2zxqdikuxzDRKrRxU5qtmswyPpu/CPBiMTUpJwZg5qAWD4QI+pgQ71QCq9QPiRUvRzMEXwv/1spaAIA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXKaM5bMJN1ANeLxwFsVsGSXuNEP3DRoQnrs1dIYj+JDXQNWVi
	Bbg4hfYlv26lHMXDcRV5QSZJ38rrZ0YrFhKzphqfNfWxisMIiidfounpT2HvGxgD0naKAHT+PEr
	Wc3F2XHWADSknvY/18uPujFaDqQckQccXBeIIXM+zt+JjyHJxeqYwbjkSpp81aAaY+g==
X-Gm-Gg: AY/fxX7ymKenFSK7dq47p7irG/j9oDLxFRp08TwSPR0nBkxnqLPNupCX6NPn5ajU3EQ
	1x3w66qc+yH0kXJ4k5fM9i1GGiMD1upgw5OGtE6Gx9ngO2GRurfMzr6UVIHIZxCTWTW4fJexgt/
	bsFdwVPohwOhqowD3EkrggYhBPANgsWyxNr/jrq42kUDIq4b5HdQyXuGJHBbxQpHSL4tc64fHMw
	Y/FdzaazMm40ySjEW2L9KPzVVLvbnJkumLAyscr97vcc/qwS1hkfF3BHU8712hIZ7rt955Rn09Y
	anRifpDWnVIWk0xxWhDtPlhZxLjk8D/76z9F0kHC4QdpPA1MoZ8ykhyJ9RsR2IMKD5GSGR76W7m
	uVycuKbbwCyWgI50RjZ9IIwg5yNaV8wZJXz5ZraXLwS15KWHBeuwiiKWu1klI7g==
X-Received: by 2002:a05:600c:4fd0:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47d84b17e75mr251938115e9.11.1768319083564;
        Tue, 13 Jan 2026 07:44:43 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdMqU/UT6yusYgmo7wLLK1QpcbQzRIghkGQravCSZ1TVNgzar9pv/6xyu/8mM8bGjn/QJ4Cg==
X-Received: by 2002:a05:600c:4fd0:b0:477:8a2a:1244 with SMTP id 5b1f17b1804b1-47d84b17e75mr251937595e9.11.1768319083140;
        Tue, 13 Jan 2026 07:44:43 -0800 (PST)
Received: from sgarzare-redhat (host-87-12-25-233.business.telecomitalia.it. [87.12.25.233])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47d7f620ac8sm402645575e9.0.2026.01.13.07.44.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 07:44:42 -0800 (PST)
Date: Tue, 13 Jan 2026 16:44:39 +0100
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
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v14 05/12] selftests/vsock: add namespace
 helpers to vmtest.sh
Message-ID: <aWZoXUGyoMjKCm2u@sgarzare-redhat>
References: <20260112-vsock-vmtest-v14-0-a5c332db3e2b@meta.com>
 <20260112-vsock-vmtest-v14-5-a5c332db3e2b@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260112-vsock-vmtest-v14-5-a5c332db3e2b@meta.com>

On Mon, Jan 12, 2026 at 07:11:14PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add functions for initializing namespaces with the different vsock NS
>modes. Callers can use add_namespaces() and del_namespaces() to create
>namespaces global0, global1, local0, and local1.
>
>The add_namespaces() function initializes global0, local0, etc... with
>their respective vsock NS mode by toggling child_ns_mode before creating
>the namespace.
>
>Remove namespaces upon exiting the program in cleanup(). This is
>unlikely to be needed for a healthy run, but it is useful for tests that
>are manually killed mid-test.
>
>This patch is in preparation for later namespace tests.
>
>Signed-off-by: Bobby Eshleman <bobbyeshleman@meta.com>
>---
>Changes in v13:
>- intialize namespaces to use the child_ns_mode mechanism
>- remove setting modes from init_namespaces() function (this function
>  only sets up the lo device now)
>- remove ns_set_mode(ns) because ns_mode is no longer mutable
>---
> tools/testing/selftests/vsock/vmtest.sh | 32 ++++++++++++++++++++++++++++++++
> 1 file changed, 32 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/tools/testing/selftests/vsock/vmtest.sh b/tools/testing/selftests/vsock/vmtest.sh
>index c7b270dd77a9..c2bdc293b94c 100755
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
>@@ -103,6 +104,36 @@ check_result() {
> 	fi
> }
>
>+add_namespaces() {
>+	local orig_mode
>+	orig_mode=$(cat /proc/sys/net/vsock/child_ns_mode)
>+
>+	for mode in "${NS_MODES[@]}"; do
>+		echo "${mode}" > /proc/sys/net/vsock/child_ns_mode
>+		ip netns add "${mode}0" 2>/dev/null
>+		ip netns add "${mode}1" 2>/dev/null
>+	done
>+
>+	echo "${orig_mode}" > /proc/sys/net/vsock/child_ns_mode
>+}
>+
>+init_namespaces() {
>+	for mode in "${NS_MODES[@]}"; do
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
> vm_ssh() {
> 	ssh -q -o UserKnownHostsFile=/dev/null -p ${SSH_HOST_PORT} localhost "$@"
> 	return $?
>@@ -110,6 +141,7 @@ vm_ssh() {
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


