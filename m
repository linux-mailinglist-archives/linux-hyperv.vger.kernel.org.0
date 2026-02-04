Return-Path: <linux-hyperv+bounces-8694-lists+linux-hyperv=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gF26MH3igmlbeAMAu9opvQ
	(envelope-from <linux-hyperv+bounces-8694-lists+linux-hyperv=lfdr.de@vger.kernel.org>)
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:09:01 +0100
X-Original-To: lists+linux-hyperv@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6A0E2328
	for <lists+linux-hyperv@lfdr.de>; Wed, 04 Feb 2026 07:09:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 98A21301FFAC
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Feb 2026 06:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4168536D51E;
	Wed,  4 Feb 2026 06:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g8NQeY6d"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3B73254AE;
	Wed,  4 Feb 2026 06:08:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770185314; cv=none; b=UUEiqvDsMzi0v8oexRxo7s5wr7i5GquFKGSg7wG5ZCVtrpdtLxWUll39fgFx9gxKZbrQVGo0f/KFkKkCz/UphyHFChvx7/nb8s037HBVd4LFV8apmr0Q9srny1ucP5a2QB17wJ4gs1S9abjUKskKZrfYFwduCadLi6FKRik2fKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770185314; c=relaxed/simple;
	bh=3g4zreKzLEVFS0Rk2xU2apUy0ohGyiL5HI5GLAm/S6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZW0NjV1u43DuBmCJvVb1GVJPZBPf7Dp3fBEOu2Ze11YBq2DVhJX6s3s2BIoqCb6NXKSiIJZShBfPAk28dwBQ5cH17MWRdTFaxY825uWiG94UV27+EmpoqRNgcGSu3Aqqed9aivz/ClJFGsSy4rInDHh3/vskMGlJa5hj5WLeb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g8NQeY6d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F672C4CEF7;
	Wed,  4 Feb 2026 06:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770185313;
	bh=3g4zreKzLEVFS0Rk2xU2apUy0ohGyiL5HI5GLAm/S6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g8NQeY6dZBIodIPpJpvHgyoQ/sAs2XlB9501ygVSj7Ab5CP3X/CWNJioEUe9BVrXt
	 bRYNOVsY71mftxCtoegkPzx6/w7I1U4UWlvyoaHX79eleuv0rIAudIONY2h1m8ykmT
	 k3rZXK0qKwFF34TdpB5cHITP+ujW78LWi3dOVkprhH8ZQLxc1hgtRDc7oLcVtu8f9o
	 DCo/QB07dCaQwpmhOnNDnrqyge4ebCcwgeBSEX8Ag97N1jRslNaIEBHrWPbftKWX0I
	 sHqyDUWY/JI0Y93i2w8lbU3cw520CmWSc+MNDZ2S72tdkMziCdtPNYZU/f4y3uF8z1
	 tG790LXvgvLPg==
Date: Wed, 4 Feb 2026 06:08:32 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: mhklinux@outlook.com, kys@microsoft.com, haiyangz@microsoft.com,
	wei.liu@kernel.org, decui@microsoft.com, longli@microsoft.com,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] mshv: Fix compiler warning about cast converting
 incompatible function type
Message-ID: <20260204060832.GC79272@liuwe-devbox-debian-v2.local>
References: <20260118170245.160050-1-mhklinux@outlook.com>
 <e99513ac-a790-424b-9b80-4a91fd87cba2@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e99513ac-a790-424b-9b80-4a91fd87cba2@linux.microsoft.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8694-lists,linux-hyperv=lfdr.de];
	FREEMAIL_CC(0.00)[outlook.com,microsoft.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.liu@kernel.org,linux-hyperv@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-hyperv];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[outlook.com:email,intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,liuwe-devbox-debian-v2.local:mid]
X-Rspamd-Queue-Id: 2A6A0E2328
X-Rspamd-Action: no action

On Mon, Jan 19, 2026 at 11:02:01AM +0530, Naman Jain wrote:
> 
> 
> On 1/18/2026 10:32 PM, mhkelley58@gmail.com wrote:
> > From: Michael Kelley <mhklinux@outlook.com>
> > 
> > In mshv_vtl_sint_ioctl_pause_msg_stream(), the reference to function
> > mshv_vtl_synic_mask_vmbus_sint() is cast to type smp_call_func_t. The
> > cast generates a compiler warning because the function signature of
> > mshv_vtl_synic_mask_vmbus_sint() doesn't match smp_call_func_t.
> > 
> > There's no actual bug here because the mis-matched function signatures
> > are compatible at runtime. Nonetheless, eliminate the compiler warning
> > by changing the function signature of mshv_vtl_synic_mask_vmbus_sint()
> > to match what on_each_cpu() expects. Remove the cast because it is then
> > no longer necessary.
> > 
> > No functional change.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202601170352.qbh3EKH5-lkp@intel.com/
> > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
[...]
> 
> Reviewed-by: Naman Jain <namjain@linux.microsoft.com>
> 

Queued.

