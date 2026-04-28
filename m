Return-Path: <linux-hyperv+bounces-10439-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EJgGKZjs8GmBbAEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10439-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:21:28 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0899D489D14
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 19:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD96F3050225
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 17:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C8E3B38A6;
	Tue, 28 Apr 2026 17:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="Xkl1tbXy"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61FA53A169D;
	Tue, 28 Apr 2026 17:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777396546; cv=none; b=XxknNG0KP728WsRnDYCAyan4AwXsbDJtDIFr/hinqWQ2KenaO6FRFRSCy1NS3CP3eDBTDe4Qw5ZXrNQgRRu9xSrTQSRJvA8K5VS0BgM6W++xRp52YcW/djswo2UE5bTJiG7q3WYhpFrePbTjoMSbgMCTQ0cI09s+ZlISWGWd83o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777396546; c=relaxed/simple;
	bh=vjgyp9tJ4/Wf+X9huTEytK73DtIFpIiWSMRlvtfQD+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HF3w/yQpV/Y9DHnJ8wwDmUARnolEc4o33BjFfXKLvbAmU6KORhfky7NgropMR4AuyCMkeS/ICRipk6Thv/4LA74s7dJIwc7UQK2zUn4BWAhaJXNpBlNkK2KMF3UPeSDwnZHG/dIjDSECvfbPzbjaGs6QM2GCPKbT1JStfrOi+z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=Xkl1tbXy; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 7EDB720B716C; Tue, 28 Apr 2026 10:15:43 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7EDB720B716C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777396543;
	bh=fxu5AHc/WELco1y9bFcic9XUbLEgfysFbf90mc8R8uk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Xkl1tbXyHcnTOjE55XiNwGbSK5elXZdcXUqIrCCtj48iQZ+MB1JJjlpg0+9S4jN4K
	 Tnk9qaoe5m5ASGkLrBkGqA+Bb9Jo+U3uwKILIt6O9lRJAxJqM2F/ta0Zz5Z8BUxL0q
	 mfHr2oQzuzN0bVf2rojPuAdBvP/OuCBq/sIr+ipE=
Date: Tue, 28 Apr 2026 13:15:43 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: netdev@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Long Li <longli@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Michael Kelley <mhklinux@outlook.com>,
	Himadri Pandya <himadrispandya@gmail.com>,
	linux-hyperv@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hv_sock: fix ARM64 support
Message-ID: <afDrPyWVw2IY6AuF@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260428125339.13963-1-hamzamahfooz@linux.microsoft.com>
 <afCxfHKA7hJilGM3@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <afCxfHKA7hJilGM3@sgarzare-redhat>
X-Rspamd-Queue-Id: 0899D489D14
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10439-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,outlook.com,gmail.com,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

On Tue, Apr 28, 2026 at 03:12:40PM +0200, Stefano Garzarella wrote:
> No version number in the subject?

I generally on increment the version number if I make changes to the code
itself I did try to change the subject prefix to "PATCH RESEND" but it
appears something is off about my config that prevented from going
through.

> 
> Please next time follow
> https://docs.kernel.org/process/submitting-patches.html#subject-line
> 
>   Common tags might include a version descriptor if the multiple   versions
> of the patch have been sent out in response to comments   (i.e., “v1, v2,
> v3”), or “RFC” to indicate a request for comments.
> 
> On Tue, Apr 28, 2026 at 08:53:39AM -0400, Hamza Mahfooz wrote:
> > VMBUS ring buffers must be page aligned. Therefore, the current value of
> > 24K presents a challenge on ARM64 kernels (with 64K pages). So, use
> > VMBUS_RING_SIZE() to ensure they are always aligned and large enough to
> > hold all of the relevant data.
> > 
> > Cc: stable@vger.kernel.org
> > Fixes: 77ffe33363c0 ("hv_sock: use HV_HYP_PAGE_SIZE for Hyper-V communication")
> > Tested-by: Dexuan Cui <decui@microsoft.com>
> > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > ---
> > net/vmw_vsock/hyperv_transport.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
> 
> Acked-by: Stefano Garzarella <sgarzare@redhat.com>
> 
> > 
> > diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
> > index 069386a74557..40f09b23efa3 100644
> > --- a/net/vmw_vsock/hyperv_transport.c
> > +++ b/net/vmw_vsock/hyperv_transport.c
> > @@ -375,10 +375,10 @@ static void hvs_open_connection(struct vmbus_channel *chan)
> > 	} else {
> > 		sndbuf = max_t(int, sk->sk_sndbuf, RINGBUFFER_HVS_SND_SIZE);
> > 		sndbuf = min_t(int, sndbuf, RINGBUFFER_HVS_MAX_SIZE);
> > -		sndbuf = ALIGN(sndbuf, HV_HYP_PAGE_SIZE);
> > +		sndbuf = VMBUS_RING_SIZE(sndbuf);
> > 		rcvbuf = max_t(int, sk->sk_rcvbuf, RINGBUFFER_HVS_RCV_SIZE);
> > 		rcvbuf = min_t(int, rcvbuf, RINGBUFFER_HVS_MAX_SIZE);
> > -		rcvbuf = ALIGN(rcvbuf, HV_HYP_PAGE_SIZE);
> > +		rcvbuf = VMBUS_RING_SIZE(rcvbuf);
> > 	}
> > 
> > 	chan->max_pkt_size = HVS_MAX_PKT_SIZE;
> > -- 
> > 2.54.0
> > 
> 

