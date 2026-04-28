Return-Path: <linux-hyperv+bounces-10416-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8BaiBl658GkyXwEAu9opvQ
	(envelope-from <linux-hyperv+bounces-10416-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 15:42:54 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A184861F8
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 15:42:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E1233305CB8B
	for <lists+linux-hyperv@lfdr.de>; Tue, 28 Apr 2026 12:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE377436341;
	Tue, 28 Apr 2026 12:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="sud7M9wf"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D29A41B362;
	Tue, 28 Apr 2026 12:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777379722; cv=none; b=hASWqwhxqoTh3R41IppJlZrmthwCDB5lt4sBtlqb+drFEQjwXj2G9A4szL2JJ6pF2ji+fMv8+qCn92nu4oakOhnDSQQL7C6x9+2iA/aVTJWrZVgRN9dHZZcPI89LlwZeKX8Wlpe2WUV+m1ol3v0ggzX9qYnHKbys1GYj18rxMCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777379722; c=relaxed/simple;
	bh=/1Aa3YV7jGyvJiSjbSRKET5lurOfN05vMVaOQX7irao=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EuHqTNNtqJ/4Lb+AdPodM/6jmk9OtDYhJPNHhgIvGe/iqj+RZDM5mSeiJawZ+Jm656B0CfGn4UwWSN8hsJQeq5BWCKTaI9yMiuXanHuw8Fzh5+PAhSPt7V/dTjkxkcBbjepmE6HNVesxG+if9+Z2Ji9mizcQY0+pQJe5Mt0PNDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=sud7M9wf; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id EDDD720B716B; Tue, 28 Apr 2026 05:35:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com EDDD720B716B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777379710;
	bh=xMDR+D6KZVI0CfxxUbnEILB2nDtEWqqH5b+02w9hVWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sud7M9wfiQ5M1mI8n44O2pcZDIpy1Vw43hAL7372nPeCAlsE4yp4V4iQgkqDY3BRQ
	 wYKxdpqG6cz7YphPp5+TnYAzDj0i+vz7y4vGRPEPKPVC7CEjSWOiPRe3gnKNaQb7md
	 iGnm1tPhtcHnLzaJgAgM5vCchpIGtgHphspkU+Xg=
Date: Tue, 28 Apr 2026 08:35:10 -0400
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
	linux-kernel@vger.kernel.org, stable@kernel.vger.org
Subject: Re: [PATCH] hv_sock: fix ARM64 support
Message-ID: <afCpfjsi+arcqjJx@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20260428110530.1717647-1-hamzamahfooz@linux.microsoft.com>
 <afCjpGa4Xm4hIPj6@sgarzare-redhat>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afCjpGa4Xm4hIPj6@sgarzare-redhat>
X-Rspamd-Queue-Id: 15A184861F8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10416-lists,linux-hyperv=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microsoft.com,kernel.org,davemloft.net,google.com,redhat.com,outlook.com,gmail.com,lists.linux.dev,kernel.vger.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.org:email]

On Tue, Apr 28, 2026 at 02:15:26PM +0200, Stefano Garzarella wrote:
> On Tue, Apr 28, 2026 at 07:05:30AM -0400, Hamza Mahfooz wrote:
> > VMBUS ring buffers must be page aligned. Therefore, the current value of
> > 24K presents a challenge on ARM64 kernels (with 64K pages). So, use
> > VMBUS_RING_SIZE() to ensure they are always aligned and large enough to
> > hold all of the relevant data.
> > 
> > Cc: stable@kernel.vger.org
> 
> mmm, this is the first time I've seen this address used for stable. Even
> after searching in the log, I don't see anyone else who's used it.
> Where did you get it from?
> 
> From Documentation/process/stable-kernel-rules.rst :
> 
>   To have a patch you submit for mainline inclusion later automatically
> picked up for stable trees, add this tag in the sign-off area::
> 
>     Cc: stable@vger.kernel.org

Ya, that is the address I intended to Cc, not sure how I ended up
mangling it though.

> 
> 
> The patch LGTM.
> 
> Thanks,
> Stefano
> 
> > Fixes: 77ffe33363c0 ("hv_sock: use HV_HYP_PAGE_SIZE for Hyper-V communication")
> > Tested-by: Dexuan Cui <decui@microsoft.com>
> > Reviewed-by: Dexuan Cui <decui@microsoft.com>
> > Signed-off-by: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
> > ---
> > net/vmw_vsock/hyperv_transport.c | 4 ++--
> > 1 file changed, 2 insertions(+), 2 deletions(-)
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

