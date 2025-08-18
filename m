Return-Path: <linux-hyperv+bounces-6548-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ABDBB29ABF
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Aug 2025 09:25:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EAAE77A388B
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Aug 2025 07:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2430E26B0BE;
	Mon, 18 Aug 2025 07:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ot4RcoWT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C1E5FDA7;
	Mon, 18 Aug 2025 07:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755501926; cv=none; b=mRKs8TM6Zwu8YPSzHzP8IErMnCRX78XdnHFZOe6ql6R/8TzsQ4kiNjYZGuMRvGkc5f1P/mph+p2a0yJ7BEWpxX0SGdTVzqIsAUS9bqdC681iNfMj5g64HRDb+5AoPl5fWQM3xTMtR/FCqP+j7b279cR5QhYuQz55coTT3Z5RK+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755501926; c=relaxed/simple;
	bh=an8fzySHQ+29hLI4jlqJTGNGHYxW6rPyWv1ejxz3KzY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n4KOgqpRMYWnuMWPjKZuygA9oHpK4Km8K/tl3rDTTxv1NlsjLgmnA5+7u95nPdIOgvayNpcbuqwjnWGtQiUJg4yCEpVsswdk+5GRLQUyAeTpTCEpj/gywgFwY/GzErGNEIKKkNOAa8wa9ZnEz8NJ0DA2pXkfDHVhEkR6A1WM1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ot4RcoWT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD14AC4CEEB;
	Mon, 18 Aug 2025 07:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755501925;
	bh=an8fzySHQ+29hLI4jlqJTGNGHYxW6rPyWv1ejxz3KzY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ot4RcoWTm1SOin3/EXNYnvCbdzLPLRDLzobQdhHorbkXvmDz5gDzAmKIroD57mKbg
	 mDMyfVdR6BwzxNd2iqArFPS41N/wdt97Ll660cLA2YMS4TUbgnJYezVGPbQMin1PCV
	 XhHA47JwsXHZM3RksPYiZF60YYE2I8uqBvSVB+a0=
Date: Mon, 18 Aug 2025 09:25:22 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Naman Jain <namjain@linux.microsoft.com>
Cc: "K . Y . Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, John Starks <jostarks@microsoft.com>
Subject: Re: [PATCH] uio_hv_generic: Let userspace take care of interrupt mask
Message-ID: <2025081810-faculty-ceramics-42eb@gregkh>
References: <20250818064846.271294-1-namjain@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250818064846.271294-1-namjain@linux.microsoft.com>

On Mon, Aug 18, 2025 at 12:18:46PM +0530, Naman Jain wrote:
> Remove the logic to set interrupt mask by default in uio_hv_generic
> driver as the interrupt mask value is supposed to be controlled
> completely by the user space. If the mask bit gets changed
> by the driver, concurrently with user mode operating on the ring,
> the mask bit may be set when it is supposed to be clear, and the
> user-mode driver will miss an interrupt which will cause a hang.
> 
> For eg- when the driver sets inbound ring buffer interrupt mask to 1,
> the host does not interrupt the guest on the UIO VMBus channel.
> However, setting the mask does not prevent the host from putting a
> message in the inbound ring buffer. So let’s assume that happens,
> the host puts a message into the ring buffer but does not interrupt.
> 
> Subsequently, the user space code in the guest sets the inbound ring
> buffer interrupt mask to 0, saying “Hey, I’m ready for interrupts”.
> User space code then calls pread() to wait for an interrupt.
> Then one of two things happens:
> 
> * The host never sends another message. So the pread() waits forever.
> * The host does send another message. But because there’s already a
>   message in the ring buffer, it doesn’t generate an interrupt.
>   This is the correct behavior, because the host should only send an
>   interrupt when the inbound ring buffer transitions from empty to
>   not-empty. Adding an additional message to a ring buffer that is not
>   empty is not supposed to generate an interrupt on the guest.
>   Since the guest is waiting in pread() and not removing messages from
>   the ring buffer, the pread() waits forever.
> 
> This could be easily reproduced in hv_fcopy_uio_daemon if we delay
> setting interrupt mask to 0.
> 
> Similarly if hv_uio_channel_cb() sets the interrupt_mask to 1,
> there’s a race condition. Once user space empties the inbound ring
> buffer, but before user space sets interrupt_mask to 0, the host could
> put another message in the ring buffer but it wouldn’t interrupt.
> Then the next pread() would hang.
> 
> Fix these by removing all instances where interrupt_mask is changed,
> while keeping the one in set_event() unchanged to enable userspace
> control the interrupt mask by writing 0/1 to /dev/uioX.
> 
> Suggested-by: John Starks <jostarks@microsoft.com>
> Signed-off-by: Naman Jain <namjain@linux.microsoft.com>
> ---
>  drivers/uio/uio_hv_generic.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)

What commit id does this fix?

