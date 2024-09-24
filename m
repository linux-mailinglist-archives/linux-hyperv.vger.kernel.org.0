Return-Path: <linux-hyperv+bounces-3063-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30FB6983B90
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Sep 2024 05:29:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E49DC1F23DB5
	for <lists+linux-hyperv@lfdr.de>; Tue, 24 Sep 2024 03:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E911802B;
	Tue, 24 Sep 2024 03:28:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b="GhqmpEaY"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from outgoing2021.csail.mit.edu (outgoing2021.csail.mit.edu [128.30.2.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFB1EAD7;
	Tue, 24 Sep 2024 03:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=128.30.2.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727148538; cv=none; b=CvvAke4Yokcrrukr2NzvacT4DoLpm1dxZa2Zb/vvlNL3S7ZA3tPcJsEL0PIuU6L4XnYUnY4sK8jWJ5Py6wZ6vgYcMF10CWHNvYNvReb/nVQvAVLSNzYSImhkX+4CBJ+Rk/XgO5CBJVGLU8S8iWqpXInvhaZ/VukD+hLwZOm9jOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727148538; c=relaxed/simple;
	bh=pREaKcLa5TgfY9p6+zZ9ETqjxyUPORjfHDn4TSONGW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r+qkrkzDiJRBN2+SmxHLxrF5R5hqeO07M7O5R3LnCAf5+xheqRFijUv8YYPUM7N+j3IsUM2iKsWV6N8MdeCHhoDd3Uzisdr8VE1pZwqRdS+Vu0duw9u41SsuoOlFTP8SiDbbKsgQdsOOoqXdIl101j/YKCdE5zVrD2ehp2zmwDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu; spf=pass smtp.mailfrom=csail.mit.edu; dkim=pass (2048-bit key) header.d=outgoing.csail.mit.edu header.i=@outgoing.csail.mit.edu header.b=GhqmpEaY; arc=none smtp.client-ip=128.30.2.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=csail.mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=csail.mit.edu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=outgoing.csail.mit.edu; s=test20231205; h=In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
	List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=w59KiR7ppHfPdvdNtRvdv55C4Y8jxSqLH2rNemhl/vE=; t=1727148537; x=1728012537; 
	b=GhqmpEaYGH0Gf52PqzdnShL2AnzXEbEsMpAecpJ/nEaEwmrpHeuyZcMJfGdhW28LNai6oTT1tJo
	SI+3yh868DOg+0XNylSy9PbjTrmSfkXqc6mrA3/2kNZTG9PDxEgEBVQI86u891Tf+c8cB11knOIzI
	Qm0kWfj+2VGBLvKBOQXiYt4sSxWiZ9zNEtU0N3CCaUQCjGUOaVLdQ7Caq9/qQC6S1vDl3DWXybw6p
	tUAfhRHH7k2xZWa1Bp/grmzx//uxSh+sOZMfVsDp4OaNXJlkKJTW7E64+uWwW7sz6Wc99QNR5XqAS
	L7KhKADileFl6sHPhqVav9lTkuAk3HOlFsnw==;
Received: from [172.179.10.40] (helo=csail.mit.edu)
	by outgoing2021.csail.mit.edu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.95)
	(envelope-from <srivatsa@csail.mit.edu>)
	id 1sswEQ-00EsVi-4K;
	Mon, 23 Sep 2024 23:28:54 -0400
Date: Tue, 24 Sep 2024 03:28:51 +0000
From: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, jikos@kernel.org, bentiss@kernel.org,
	dmitry.torokhov@gmail.com, linux-hyperv@vger.kernel.org,
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
	ernis@microsoft.com, rafael@kernel.org, pavel@ucw.cz,
	lenb@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/3] Revert "Input: hyperv-keyboard - register as a
 wakeup source"
Message-ID: <ZvIx85NmYB/HzKtI@csail.mit.edu>
References: <1726176470-13133-1-git-send-email-ernis@linux.microsoft.com>
 <1726176470-13133-3-git-send-email-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726176470-13133-3-git-send-email-ernis@linux.microsoft.com>

[+linux-pm, Rafael, Len, Pavel]

On Thu, Sep 12, 2024 at 02:27:49PM -0700, Erni Sri Satya Vennela wrote:
> This reverts commit 62238f3aadc9bc56da70100e19ec61b9f8d72a5f.
> 
> Remove keyboard as wakeup source since Suspend-to-Idle feature
> is disabled.
> 
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> ---
>  drivers/input/serio/hyperv-keyboard.c | 12 ------------
>  1 file changed, 12 deletions(-)
> 
> diff --git a/drivers/input/serio/hyperv-keyboard.c b/drivers/input/serio/hyperv-keyboard.c
> index 31d9dacd2fd1..b42c546636bf 100644
> --- a/drivers/input/serio/hyperv-keyboard.c
> +++ b/drivers/input/serio/hyperv-keyboard.c
> @@ -162,15 +162,6 @@ static void hv_kbd_on_receive(struct hv_device *hv_dev,
>  			serio_interrupt(kbd_dev->hv_serio, scan_code, 0);
>  		}
>  		spin_unlock_irqrestore(&kbd_dev->lock, flags);
> -
> -		/*
> -		 * Only trigger a wakeup on key down, otherwise
> -		 * "echo freeze > /sys/power/state" can't really enter the
> -		 * state because the Enter-UP can trigger a wakeup at once.
> -		 */
> -		if (!(info & IS_BREAK))
> -			pm_wakeup_hard_event(&hv_dev->device);
> -
>  		break;
>  
>  	default:
> @@ -356,9 +347,6 @@ static int hv_kbd_probe(struct hv_device *hv_dev,
>  		goto err_close_vmbus;
>  
>  	serio_register_port(kbd_dev->hv_serio);
> -
> -	device_init_wakeup(&hv_dev->device, true);
> -
>  	return 0;
>  
>  err_close_vmbus:
> -- 
> 2.34.1
> 
> 

