Return-Path: <linux-hyperv+bounces-7265-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99A4EBEBF93
	for <lists+linux-hyperv@lfdr.de>; Sat, 18 Oct 2025 01:05:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F6EF3BEE74
	for <lists+linux-hyperv@lfdr.de>; Fri, 17 Oct 2025 23:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5F862FD1AD;
	Fri, 17 Oct 2025 23:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBOVIDui"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CA73261595;
	Fri, 17 Oct 2025 23:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760742345; cv=none; b=VzYKjYojZNlHAklOeaO0lWz8Mm+EYEsrKx501Kf722I6cFf0XX26qVHIVO3GpOpDBh0dv4hmzWUytyelL73WzT6vv2a4sRMOpvg9XLxCgzroIXjKwXrcfnp8SnoY+4edwd2fZ01CDdAxlAc236N/t6aB3WpP77NkzOo0hVH9HfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760742345; c=relaxed/simple;
	bh=0T6PCrIx5PIrUnv+CWLbaIONL9/XwpaNQYrJ1zpHK3g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OpaTu3M7c5T81c3BfPvdKFyHr9Ew7A7OvImgD7Knb4zw7h5sTFK5tJb0YcxsT7SUCRQWxnvJPkmqEZqKJfb9kdnhxfGiDgNKeQQPorB/YGgH/bn67iphfxBTq24fTKHan8EmXb3rutqMbk4uw9Hy1oPonME1uvLXtB0jwhvkbx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GBOVIDui; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B356C4CEE7;
	Fri, 17 Oct 2025 23:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760742342;
	bh=0T6PCrIx5PIrUnv+CWLbaIONL9/XwpaNQYrJ1zpHK3g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GBOVIDui/5oz0HR2hPGD7sWPRgH9MBWBhKkCAbokw/BJJfde7PeG1x7F+hEIJrJqc
	 YJVrAZ9Y8vQDusCxDEVCWR9Gz2KySre0yP3XMFhmhEKVquAOhb5GBuK20GCQksLYxe
	 jmANiM2yU7LT48mCY99N+duEnayPGB52GKOPNeDclow0pfVG7cNuBZzbI6auBSdk7W
	 IZucgr/M4DLBhUOT8ShN+jf83gGQ7Ggt7XUJ3f1cXSKkbtVPtgQOWter15UcIo3rwk
	 m9X1I9PXNuuZy1IX6I7oys0wPCFiXv60bP5BSCWwaZLj9wEkNe9iEHTIBqrH4T8p0+
	 0ZVT2ni2SMrKA==
Date: Fri, 17 Oct 2025 16:05:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Haiyang Zhang <haiyangz@linux.microsoft.com>
Cc: linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
 haiyangz@microsoft.com, paulros@microsoft.com, decui@microsoft.com,
 kys@microsoft.com, wei.liu@kernel.org, edumazet@google.com,
 davem@davemloft.net, pabeni@redhat.com, longli@microsoft.com,
 ssengar@linux.microsoft.com, ernis@linux.microsoft.com,
 dipayanroy@linux.microsoft.com, kotaranov@microsoft.com, horms@kernel.org,
 shradhagupta@linux.microsoft.com, leon@kernel.org, mlevitsk@redhat.com,
 yury.norov@gmail.com, shirazsaleem@microsoft.com, andrew+netdev@lunn.ch,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next,v2] net: mana: Support HW link state events
Message-ID: <20251017160541.4ce65ede@kernel.org>
In-Reply-To: <1760477209-9026-1-git-send-email-haiyangz@linux.microsoft.com>
References: <1760477209-9026-1-git-send-email-haiyangz@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 14 Oct 2025 14:26:49 -0700 Haiyang Zhang wrote:
> From: Haiyang Zhang <haiyangz@microsoft.com>
> 
> Handle the HW link state events received from HW channel, and
> set the proper link state, also stop/wake queues accordingly.

Why do you have to stop / start the queues? I think it's unusual.
Let the packets get dropped, sending out potentially old packets
when link comes back is not going to make anyone happier.

> +static void mana_link_state_handle(struct work_struct *w)
> +{
> +	struct mana_port_context *apc;
> +	struct mana_context *ac;
> +	struct net_device *ndev;
> +	bool link_up;
> +	int i;
> +
> +	ac = container_of(w, struct mana_context, link_change_work);
> +
> +	if (ac->mana_removing)
> +		return;
> +
> +	rtnl_lock();
> +

> @@ -3500,6 +3556,10 @@ void mana_remove(struct gdma_dev *gd, bool suspending)
>  	int err;
>  	int i;
>  
> +	ac->mana_removing = true;
> +
> +	cancel_work_sync(&ac->link_change_work);

Looks racy, the work needs @ac to check the ->mana_removing but
mana_remove() frees @ac. Just use disable_work_sync() please.
-- 
pw-bot: cr

