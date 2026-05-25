Return-Path: <linux-hyperv+bounces-11185-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE0HFUM0FGpaKwcAu9opvQ
	(envelope-from <linux-hyperv+bounces-11185-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 13:36:35 +0200
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E7015C9F9E
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 13:36:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65EF13007E24
	for <lists+linux-hyperv@lfdr.de>; Mon, 25 May 2026 11:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E14B937E2EB;
	Mon, 25 May 2026 11:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="l6Teo2dm"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 777AE1E3DDE;
	Mon, 25 May 2026 11:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779708992; cv=none; b=XT/0rx6+vsX/jDb9oeZVdilAsu7eYiZmfpj3TN0T8I/u7Gbsj37c/LDA7AHV/eobOuIhUn0IdKHfLk/R3gyfjf7tl0pSGOZXrjkpL96zhV40O053mPBSAWJOeQo/MsWHj3g07XSYgiyuiYUiWkTcyfKZoXa6nj5IWk2Z4rqEVPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779708992; c=relaxed/simple;
	bh=behRvOx40jYRwwf/YqgI63J6Dt1xAnRxj1V9OWEf8mU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lmaUEeIpndxFeFokocgYWEZsZVzBWZmSyQrzzBK1CNWf0sEN8V4E9cSVpO+3b3d1AvAv/TzuYwWCgCTuI4eeaSJu9C/ADfMXxB8wmheT9bPxv1dhYp0lMH1Pnk33gvDDntEmlDIBnYtEjH1sgDg0SdvKsXZ9TUefnMsv61xa+AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=l6Teo2dm; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id E6FD120B7166; Mon, 25 May 2026 04:36:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com E6FD120B7166
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1779708981;
	bh=zN4QWGWlr5StOwKAFlE8xNBGaQRFU1nlK14WTHcvb7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=l6Teo2dmgEEr1SAeRiyWbkSc2zFMtW1ZfDccj4f5GjjCETqNAvKu9fwh9DdFJ2P+r
	 pi0XSHPCxP8u5V6rz+wyr3cu8YbHT89YE8ayfalFGm6nBmOXT5TcttXXs+Xe1uBAs8
	 WztOD0oPDP0SyTrJ+XfZcoWuZl+Z2NyMhdOHQhls=
Date: Mon, 25 May 2026 07:36:21 -0400
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: Berkant Koc <me@berkoc.com>
Cc: Saurabh Sengar <ssengar@linux.microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
	linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Michael Kelley <mhklinux@outlook.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Deepak Rawat <drawat.floss@gmail.com>
Subject: Re: [PATCH v5 0/2] drm/hyperv: harden host message parsing
Message-ID: <ahQ0NS1jrfU8ms1U@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <cover.1779542874.git.me@berkoc.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779542874.git.me@berkoc.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-11185-lists,linux-hyperv=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linux.microsoft.com,microsoft.com,vger.kernel.org,lists.freedesktop.org,kernel.org,outlook.com,suse.de,linux.intel.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,linux-hyperv@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-hyperv];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 9E7015C9F9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, May 23, 2026 at 03:27:54PM +0200, Berkant Koc wrote:
> Two independent issues in the synthetic video driver that both stem
> from trusting unvalidated host data.
> 
> 1/2 bounds resolution_count from SYNTHVID_RESOLUTION_RESPONSE against
> the supported_resolution[] array, and populates WIN8 defaults for
> hv->screen_*_max / hv->preferred_* in both the WIN10-probe-failure
> path and the pre-WIN10 path, so a failed or pre-WIN10 probe yields a
> usable display instead of having drm_internal_framebuffer_create()
> reject every userspace framebuffer with -EINVAL.
> 
> 2/2 forwards bytes_recvd from vmbus_recvpacket() into the sub-handler,
> rejects packets that do not cover the synthvid header, and requires
> the type-specific payload size before memcpy/complete or before
> reading the feature-change byte. Rejected packets are logged via
> drm_err_ratelimited() instead of being silently dropped, matching the
> CoCo-hardened pattern in hv_kvp_onchannelcallback().
> 
> 1/2 is unchanged from v3/v4 and carries Michael Kelley's Reviewed-by.
> 
> Changes since v4 (per review by Michael Kelley):
> 
>   2/2: collapsed the leading "if (type == ... ) { ... switch ... }"
>        plus the separate "if (type == FEATURE_CHANGE)" into a single
>        switch on msg->vid_hdr.type. The three completion-driving cases
>        compute their per-type size and break to a shared exit that does
>        the size check + memcpy(init_buf) + complete(); FEATURE_CHANGE is
>        its own case that validates its payload and returns without
>        falling through; unknown types hit default and return. No
>        functional change, fewer lines.
> 
>   2/2: the vmbus_recvpacket() nonzero-return path (e.g. -ENOBUFS for a
>        too-big packet) is itself a malformed-message case. It is now
>        logged via drm_err_ratelimited(), consistent with the
>        sub-handler's other reject paths, instead of being silently
>        skipped. No channel recovery is attempted, as that is not worth
>        the added code for this rare host-side condition.
> 
> Changes since v3 (per review by Michael Kelley):
> 
>   2/2: validate SYNTHVID_RESOLUTION_RESPONSE against its actual
>        variable length. The response carries resolution_count entries,
>        not the full SYNTHVID_MAX_RESOLUTION_COUNT array, so requiring
>        sizeof(struct synthvid_supported_resolution_resp) rejected the
>        shorter responses the host legitimately sends and broke
>        resolution probing. Require the fixed prefix, read and bound
>        resolution_count, then require only the count-sized array.
> 
>   2/2: only run hyperv_receive_sub() when vmbus_recvpacket() returned
>        success. v3 dropped the bytes_recvd upper bound as redundant,
>        which holds only on a successful receive: on -ENOBUFS
>        vmbus_recvpacket() reports the required length in bytes_recvd,
>        which can exceed the 16 KiB hv->recv_buf, and the subsequent
>        memcpy(hv->init_buf, msg, bytes_recvd) would read and write
>        past both buffers. Gating on the success return restores the
>        invariant that made the bound redundant, so an oversized host
>        packet is dropped rather than copied.
> 
> Changes since v2 (per review by Michael Kelley):
> 
>   1/2: dropped the reinit_completion() change; the stale completion can
>        only outlive its request in hyperv_vmbus_resume() after a
>        get_supported_resolution() timeout, which is a narrower fix that
>        belongs in a separate patch against the resume path. Pre-WIN10
>        branch now also populates hv->preferred_*. The else branch is
>        gone; a single screen_width_max == 0 check covers both the
>        pre-WIN10 case and a failed WIN10 probe.
> 
>   2/2: added a per-type switch for the three completion-driving message
>        types so the wait-completion path validates payload size before
>        memcpy/complete. Every reject path emits drm_err_ratelimited()
>        rather than returning silently.
> 
> Changes since v1:
> 
>   1/2: bound resolution_count check folded into the existing zero check;
>        populate WIN8 defaults when hyperv_get_supported_resolution()
>        fails.
>   2/2: forward bytes_recvd into hyperv_receive_sub(); enforce the pipe +
>        synthvid header minimum; check synthvid_feature_change payload
>        size before reading is_dirt_needed.
> 
> The shared init_buf reuse (a duplicate or late host response can
> overwrite init_buf between successive request/response cycles) and the
> related completion reinit are real but orthogonal to this size
> validation. As discussed on v2, they are queued as a separate follow-up
> against the resume/expected-type path once this series lands.
> 
> This series is verified by static analysis and code inspection against
> the synthvid protocol structures and the vmbus_recvpacket() contract. I
> do not currently have a Hyper-V test environment to exercise the receive
> and resolution-probe paths at runtime, so confirmation from someone who
> can run it in a Hyper-V VM would be welcome.
> 
> Both patches carry an Assisted-by: Claude:claude-opus-4-7 berkoc-pipeline
> trailer per the kernel coding-assistants policy. Code, analysis and
> review responses are mine; the model is used as a structured reviewer
> under human verification.
> 
> Berkant Koc (2):
>   drm/hyperv: validate resolution_count and fix WIN8 fallback
>   drm/hyperv: validate VMBus packet size in receive callback
> 
>  drivers/gpu/drm/hyperv/hyperv_drm_proto.c | 113 +++++++++++++++++++---
>  1 file changed, 97 insertions(+), 16 deletions(-)
> 
> 

Applied, thanks!

> base-commit: 4bf5d3da79c48e1df4bab82c9680c53adeff7820
> -- 
> 2.47.3
> 

