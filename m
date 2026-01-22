Return-Path: <linux-hyperv+bounces-8457-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QBGKGm5XcmkpiwAAu9opvQ
	(envelope-from <linux-hyperv+bounces-8457-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 17:59:26 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DA166A8EC
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 17:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0F48C301A7CA
	for <lists+linux-hyperv@lfdr.de>; Thu, 22 Jan 2026 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFC34508F4;
	Thu, 22 Jan 2026 16:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l2Rj+KiD"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F87A360726
	for <linux-hyperv@vger.kernel.org>; Thu, 22 Jan 2026 16:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769097695; cv=none; b=JnZpx93gSVIjnEQyMFCvNHHPrCl6TNlXbHPV4v2kOGkpDQzB3Rw07cDHv3bprvqcZTV/tH4yXgjH9ExetIAJRhZ+qR//dzdZBA0llQIR+GQXmhwo0TaA/L6bSF46ICtixeYypvIzXqLOU2YQolLav63PoHbNWNwTnEa8vB1Bsg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769097695; c=relaxed/simple;
	bh=9JzOfqiTFO39kgxFQWVLYY5umNJRQRPCw/NtCy7HzoI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9L/2IJG0oNcW8K1GLUP+zTLH5kQMVpha+rpg8W9CuMCARbK2gJW4Eit7FihLBXH/9FQzkYyrRDITKnBvcdh47unfaURsifasB6aqyix1W6hAK+q0I6SsCdk8jYhi7bwMs9UowzLgcFGoG3NqJIjGcCs/prAggZOKgMhUltB5JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l2Rj+KiD; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-646d9eb45afso1164058d50.2
        for <linux-hyperv@vger.kernel.org>; Thu, 22 Jan 2026 08:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769097688; x=1769702488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4nNXaOW8SsH8VsbBiV479RmC0+eq7tMcFo5rcunlQoQ=;
        b=l2Rj+KiDdtD2q2NtiGMA5033btXx9v484iJj7k8xvoYFUvON0uWN//Nj0B5cEZyYul
         k8z+xwAcG4QnP/VahCqMOrvr3kNZJu14BB2o8opiF+eHpFAxpgElXJ6ycHbEVZkbIRD7
         rpdBZZfPcAObZ4iovLDSomfuB/s4pjTq2lFUqlmgqWdE6oJy5RUYj5cZe9uGJHN0M494
         llfIRIqnvzfZwBz14cODqAs3+Sa9Ytcpw6atLylFbOKCh0RbvLu7V39tzPsAij/QIppG
         Kn19Zf7i/MnoUjTB2+4IWB1BZUNurieL8640i6M9ASZR7pjIn3vnLTbALhflJdeG896f
         VXFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769097688; x=1769702488;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4nNXaOW8SsH8VsbBiV479RmC0+eq7tMcFo5rcunlQoQ=;
        b=atZzoj5B4KDON82+J3MfuQZEol3HxmLQFNZu+07YyDkTaD7uewaFuDQaMaYH4lvGot
         lYshncQuBw0wXFx9ffMXu/SjtYAEsM2MvIzKkRuc+q3ZJ6Tufzz++j+3m35TufrlCsXS
         oZeZ2aVbmYGfCg7JFAnRIgqHSWRD0iEHdl9IPQ8paM/fyLaZ/w/i/1aV0jTvsAd+aK+r
         elwE+0ci7KTPleInpZtNlqFcCqxf1blEEC1+eJEed8iR+J7izD2EfIQtwz+Wc/SKaw07
         /z6CD8/FaO9ER0ZB+ST8bTnR0NMVJUCPrJRsSvjr0oKsrif3uVN7Ei1u6L91pUSChpmo
         /Nmw==
X-Forwarded-Encrypted: i=1; AJvYcCU3banbudwK09GrWcFtFOPcfpULP2gDwP96jGEojYG3YxxW8+LnsgOGVE0UHynfNqU54sJoyzzBzqJS0GE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyvxL5qFkmToIm8K2S7D/+ZNmBAtXkAp5eqxzZUhmOwACeqLdAL
	AdqKXwbOhYyh2HQnHvyj310pRLU4DjUISsevhFNFxlZVdXBFvWDsJ0vn
X-Gm-Gg: AZuq6aI8J+/ZFdkIBf4pTknsp9Qq30z2NfUY+cnuZ8p6ZkbGOKaEd6zRV5Jq0V7Gnh5
	CZyQyuUu8dkbpFhTRMJAOlsJXFrIKzRBE96ztxGSLRcNNfyPON3vHyP9VKTy6TtWHXTY0OkW9NB
	7BjeOejadsipLLW8LbgLlltQLQeHr72q+kiDJjJiraIEVjFw4xGMLcZ0/5zi0+RNndcX50QGtMf
	jOfW2KEkuZiiCqkolQJv8CV1Od3cgdCsgXJshn9MrEjdXd45gyns03YW+lFoJBeFyqe7RiNc9J7
	U4c5YMAkFuhlmzszqKtzdiVX3a1CR7lGoImrhIELDrjcenQd9Zgzb7Fqvy+uKWc0SJcN+KJSnaV
	1ebRBavrcSEAEPKjjNrfp1v3oHf2s+07jOd7WTHhyBbiNpHQ76XpZHn+ZPt4YL7kyTWhgf7CehO
	zfIF7a0Wneb+BeZrbLpcR4jikPYSRcLPYrFg==
X-Received: by 2002:a05:690e:d8b:b0:649:4689:c4a9 with SMTP id 956f58d0204a3-6494689c534mr4815658d50.89.1769097685513;
        Thu, 22 Jan 2026 08:01:25 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:7::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649170acbdbsm9523979d50.13.2026.01.22.08.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 08:01:24 -0800 (PST)
Date: Thu, 22 Jan 2026 08:01:23 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>,
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org,
	linux-kselftest@vger.kernel.org, berrange@redhat.com,
	Sargun Dhillon <sargun@sargun.me>, linux-doc@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v16 00/12] vsock: add namespace support to
 vhost-vsock and loopback
Message-ID: <aXJJ0yjZB5mT162B@devvm11784.nha0.facebook.com>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
 <aXH7YCgl0qI2dF1T@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aXH7YCgl0qI2dF1T@sgarzare-redhat>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8457-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Queue-Id: 1DA166A8EC
X-Rspamd-Action: no action

On Thu, Jan 22, 2026 at 02:55:36PM +0100, Stefano Garzarella wrote:
> On Wed, Jan 21, 2026 at 02:11:40PM -0800, Bobby Eshleman wrote:
> > This series adds namespace support to vhost-vsock and loopback. It does
> > not add namespaces to any of the other guest transports (virtio-vsock,
> > hyperv, or vmci).
> > 
> > The current revision supports two modes: local and global. Local
> > mode is complete isolation of namespaces, while global mode is complete
> > sharing between namespaces of CIDs (the original behavior).
> > 
> > The mode is set using the parent namespace's
> > /proc/sys/net/vsock/child_ns_mode and inherited when a new namespace is
> > created. The mode of the current namespace can be queried by reading
> > /proc/sys/net/vsock/ns_mode. The mode can not change after the namespace
> > has been created.
> > 
> > Modes are per-netns. This allows a system to configure namespaces
> > independently (some may share CIDs, others are completely isolated).
> > This also supports future possible mixed use cases, where there may be
> > namespaces in global mode spinning up VMs while there are mixed mode
> > namespaces that provide services to the VMs, but are not allowed to
> > allocate from the global CID pool (this mode is not implemented in this
> > series).
> > 
> > Additionally, added tests for the new namespace features:
> > 
> > tools/testing/selftests/vsock/vmtest.sh
> > 1..25
> > ok 1 vm_server_host_client
> > ok 2 vm_client_host_server
> > ok 3 vm_loopback
> > ok 4 ns_host_vsock_ns_mode_ok
> > ok 5 ns_host_vsock_child_ns_mode_ok
> > ok 6 ns_global_same_cid_fails
> > ok 7 ns_local_same_cid_ok
> > ok 8 ns_global_local_same_cid_ok
> > ok 9 ns_local_global_same_cid_ok
> > ok 10 ns_diff_global_host_connect_to_global_vm_ok
> > ok 11 ns_diff_global_host_connect_to_local_vm_fails
> > ok 12 ns_diff_global_vm_connect_to_global_host_ok
> > ok 13 ns_diff_global_vm_connect_to_local_host_fails
> > ok 14 ns_diff_local_host_connect_to_local_vm_fails
> > ok 15 ns_diff_local_vm_connect_to_local_host_fails
> > ok 16 ns_diff_global_to_local_loopback_local_fails
> > ok 17 ns_diff_local_to_global_loopback_fails
> > ok 18 ns_diff_local_to_local_loopback_fails
> > ok 19 ns_diff_global_to_global_loopback_ok
> > ok 20 ns_same_local_loopback_ok
> > ok 21 ns_same_local_host_connect_to_local_vm_ok
> > ok 22 ns_same_local_vm_connect_to_local_host_ok
> > ok 23 ns_delete_vm_ok
> > ok 24 ns_delete_host_ok
> > ok 25 ns_delete_both_ok
> > SUMMARY: PASS=25 SKIP=0 FAIL=0
> > 
> > Thanks again for everyone's help and reviews!
> 
> Thank you for your hard work and patience!
> 
> I think we've come up with an excellent solution that's also not too
> invasive.

Thanks, and I appreciate all of the work you and other maintainers put
into this as well! I think we honed in on a great solution too.
> 
> All the patches have my R-b, I've double-checked and tested this v16.
> Everything seems to be working fine (famous last words xD).
> 
> So this series is good to go IMO!
> 
> Next step should be to update the vsock(7) namespace.

Sounds good, I'll follow up with that and CC you + other reviewers that
participated here.

Thanks again,
Bobby

