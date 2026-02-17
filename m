Return-Path: <linux-hyperv+bounces-8867-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKUsHN2ElGlBFQIAu9opvQ
	(envelope-from <linux-hyperv+bounces-8867-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 16:10:21 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC9014D712
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 16:10:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4E1A304C2EA
	for <lists+linux-hyperv@lfdr.de>; Tue, 17 Feb 2026 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAF0636CE16;
	Tue, 17 Feb 2026 15:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HQMgqyOL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2wmJ0DP"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64E7F36CDF8
	for <linux-hyperv@vger.kernel.org>; Tue, 17 Feb 2026 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771340927; cv=none; b=N44gNoSrF53LrZ/2vefC1mB3Z99lC6RPCQCPo+Z62+YutCoIMTG84/Mm+F2t8WueNWHYe/Omoqz/4f63W/kRloJocM1fNHs7p5ngs9ONtbbkoF41Lw6XIki9LNOJlTa4tCMxfr6XrXmQ3r4NgO58JET+XiMyGsv7SUFgju+6+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771340927; c=relaxed/simple;
	bh=FATg9XsSiPlYwAbae8L/USKuKRBil6Mn8gqbYCmEG2I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mhLsJV7avznMtY+8vb4h9WPsHAotFUF9qUK7tcGerZRl9JUGhfsuF5zNmxFwAB0FrGjGBaCHQj8X6h4BY+ECX3XjO9Wi7LREMVt75EJRJ7rhP73t2AHT3kQXBNjFBppLkBTU4ozaXDoK0IdOp61CBDhdLzYC2ksR5amsJvowiGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HQMgqyOL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2wmJ0DP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1771340925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jEc67c+eucBHPlMa8Z8GafQvzyfH5CJQ48/ZIvcQG9w=;
	b=HQMgqyOLCR0Kc8prihtCKCt5Ccd0OkMDpsJbF+9M4qJei12K18I39typGEWahftEpYluI8
	pnvgSZV+79/A2OXWUpy68e/80W+p2sWBiEfiSSARneJkWgN/O4KGJpReCibU7VMHzx8Ai2
	wuVJYiTglbArlSITF6kQt9NDiWzC2/s=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-DprQdGJ8MkGLoK6aSqq4_w-1; Tue, 17 Feb 2026 10:08:42 -0500
X-MC-Unique: DprQdGJ8MkGLoK6aSqq4_w-1
X-Mimecast-MFC-AGG-ID: DprQdGJ8MkGLoK6aSqq4_w_1771340921
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4806cfffca6so50580875e9.2
        for <linux-hyperv@vger.kernel.org>; Tue, 17 Feb 2026 07:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1771340921; x=1771945721; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jEc67c+eucBHPlMa8Z8GafQvzyfH5CJQ48/ZIvcQG9w=;
        b=Q2wmJ0DPwomE3lsee1BYstQjxqAnEoTsy5rJ+GWkPVk8D2TXrPTr+q9n8RfHUtq6SU
         QkMKme1nOLQPh3W91U2V+9xYt6kUNqX56HkI+vksqVJHb6CzSYBoBA04iEkLOkgvJfCN
         Ak9ZVvabnKDg1E6BW13xVNL6Sa8FLyHglfTZqy7QFyBj+p/48xxZCUIIJM4N+rEyGXRS
         fKIP2GV0s0i0ZcDAVrdZ+qjYM5Z0bSsjw5cdpD8bvUd3kH5FphEqA1D4QKB6MteiGUIV
         yfznMv6w5ra0fpKcDt+HWEkfAb+DPIZNnqqil2+Y7sk0/jNVnCXcsc9CyiIpOav8I+n5
         dBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771340921; x=1771945721;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEc67c+eucBHPlMa8Z8GafQvzyfH5CJQ48/ZIvcQG9w=;
        b=PKfHIPszUbZ7t0rfxoYzB4yUB0jfwIdYg8qQF+8ewVpX6hOXuHCSdYYRb9tnIZ9iGj
         TBsyY7NQBPlBfSwQ80Kf3EERWMtBiT//A2yCYWHER/pdDMDYbHN9Eo/0IZc9BX5Y9e2q
         32zRDC4H2JCO5IQTPX/oC0DDRJu/H1gPhYWloSIuzH8riNgXwr/OYx0RWCivlxrofMkR
         03f+1+T//tBim/StobpdGNosFGI01vjDP1RM8dSxjw2llEj+bhW8XDhn+84DJ7ubU7YB
         8aXWKay+OGzQr4g/ebHeufkKp0ckCxkTMLQgU0bN1vuWv6hgMRwSqqWD+IJmoEY3yczS
         Ym4A==
X-Forwarded-Encrypted: i=1; AJvYcCU734BcBtbt8Iq/tGx+hCpyr9dlP3mE9GImtsR7CluYuY13hfDh8OwBA1+4kx3YgeY+kkou3ZlomsxOSgw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXwzJyazVGSov/MpjxJWC2PFhVrDyvvS78QWqNcRhIUb9b1hT+
	uuexAoAXfyqnSVKwAcu17HYt1PEO7/2mk9fxW6myO99RTgQ3y+B02w9xb6f1vuuuZCQR8GIunIP
	KC1lKPSnXo+gsV3InFQEzXeSb6RqXJEUxcH6yLlwnjx3ucGbxulSlcGgl/kPMO5BxMg==
X-Gm-Gg: AZuq6aJ+TXaz9oMhPSUKQ9+frg7xJEijr+l5z2zK0uo9JCxi0l8TDjhzXWooZv4DR+K
	4UDw6FhBFOUNqO4D9vT+3YxYlhfrhuq87OpWBsIZMm2QLaqXq19mdRx0PS0YcB9HGTRDwWJJHmT
	U7CoZaaaiFk2HYlYQOdHWgb8jegE+44S7nHU2qVBgiSGn6rGSLh+hKOZxjcFn2nseVIQAqSnF0O
	ZysKqaVbi5pYpwi7lZdVndx3tA603p6/IlHXvjJ2GG1YI7MwV/7TGT/9FDVxHK1ndm83SeyGGzM
	alvEI06esKi6RV9YpUrnSu1NvYEbUemJvwTtbOs2C1uz7WMLWrHMYyqWkMgTrQnf8/E/4uqXofq
	GWICAxk1WgY9WRPhZ5sqNxfK48OZCf9Si1vUxZy/U2Dq5J2DzOcL5bZqGyWFEQi986dIRByw=
X-Received: by 2002:a05:600c:1c1c:b0:477:7b16:5fb1 with SMTP id 5b1f17b1804b1-483739ff8damr256414565e9.7.1771340920691;
        Tue, 17 Feb 2026 07:08:40 -0800 (PST)
X-Received: by 2002:a05:600c:1c1c:b0:477:7b16:5fb1 with SMTP id 5b1f17b1804b1-483739ff8damr256413865e9.7.1771340920135;
        Tue, 17 Feb 2026 07:08:40 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4837b64b08bsm102571985e9.6.2026.02.17.07.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 07:08:39 -0800 (PST)
Date: Tue, 17 Feb 2026 16:08:33 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>, 
	Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>, 
	Daan De Meyer <daan.j.demeyer@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	Bryan Tan <bryan-bt.tan@broadcom.com>, Vishnu Dasa <vishnu.dasa@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Shuah Khan <shuah@kernel.org>, Long Li <longli@microsoft.com>, 
	Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org, kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	linux-kselftest@vger.kernel.org, berrange@redhat.com, Sargun Dhillon <sargun@sargun.me>, 
	linux-doc@vger.kernel.org, Bobby Eshleman <bobbyeshleman@meta.com>
Subject: Re: [PATCH net-next v16 01/12] vsock: add netns to vsock core
Message-ID: <aZNNBc390y6V09qO@sgarzare-redhat>
References: <20260121-vsock-vmtest-v16-0-2859a7512097@meta.com>
 <20260121-vsock-vmtest-v16-1-2859a7512097@meta.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260121-vsock-vmtest-v16-1-2859a7512097@meta.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8867-lists,linux-hyperv=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[35];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sgarzare@redhat.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	TAGGED_RCPT(0.00)[linux-hyperv];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:email]
X-Rspamd-Queue-Id: DBC9014D712
X-Rspamd-Action: no action

Hi,

On Wed, Jan 21, 2026 at 02:11:41PM -0800, Bobby Eshleman wrote:
>From: Bobby Eshleman <bobbyeshleman@meta.com>
>
>Add netns logic to vsock core. Additionally, modify transport hook
>prototypes to be used by later transport-specific patches (e.g.,
>*_seqpacket_allow()).
>
>Namespaces are supported primarily by changing socket lookup functions
>(e.g., vsock_find_connected_socket()) to take into account the socket
>namespace and the namespace mode before considering a candidate socket a
>"match".
>
>This patch also introduces the sysctl /proc/sys/net/vsock/ns_mode to
>report the mode and /proc/sys/net/vsock/child_ns_mode to set the mode
>for new namespaces.

talking about this new feature with Daan (in CC) we were discussing a 
possible change to `child_ns_mode`.

Currently, if two or more administrator processes in the same namespace 
set `child_ns_mode`, they compete. Obviously, after unshare()/clone(), 
the process can always access `ns_mode` to check if everything went well 
and eventually retry.

Daan suggested a more conservative approach, allowing `child_ns_mode` to 
be written only once (a bit like we did in the old version when the 
child could change the mode only once). This way, most users who want 
isolation write `local` in `child_ns_mode` at startup in the init_ns. At 
that point the user  and can be sure that no other process (including 
administrators, e.g., container managers) can change it, so all new 
namespaces will have `local` mode.

I think we should support this option in some way, because it seems to 
simplify the user space in most common cases (ensure isolation). I see 
few options for doing this:

1. Change the behavior of `child_ns_mode` to be written only once, but 
this would limit other possible use cases where `child_ns_mode` can be 
changed more than once (I don't know if Bobby had any in mind).

2. Add a new sysctl `child_ns_mode_lockin` (or something similar), which 
can only be written once with a mode (local or global). A write on this 
will also locks `child_ns_mode`, of course.

3. Add a new `local-locked` mode, reusing the same sysctl.


If we go for 1, maybe we can do it in 7.0, or not?

2 and 3, on the other hand, may have to wait until the next release.

What do you think? Any comments?

Thanks,
Stefano


