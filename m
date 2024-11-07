Return-Path: <linux-hyperv+bounces-3286-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D82DD9C1126
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 22:41:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAC6284275
	for <lists+linux-hyperv@lfdr.de>; Thu,  7 Nov 2024 21:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14CB4218321;
	Thu,  7 Nov 2024 21:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XRMuJD7x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA2E215F58
	for <linux-hyperv@vger.kernel.org>; Thu,  7 Nov 2024 21:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731015677; cv=none; b=pztzRrv+W9PCv1TQF7r75mt5tVcQEvksck+utm1gBD/F55LsMxs99X+YDf2858SmJWXOnY1AScDqUc2ZIppxNms/Ly1ShoMPOr6zMXQ8sobdHhNLEWXSwQlWk69QfGYbBwZyyEXN7uVsDL/2+vNCFzrLG/mF8Ijm8OHpNGnCTWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731015677; c=relaxed/simple;
	bh=fLdfZzo90PzNEL/By0BCWrAEgq+8ZAKgcUTa2z6seJo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ATfJ3bkZ8w/uA64iIvjcFibDIIW8krWyZFYqSlrKSwE4kEtjk3ZL2gn5E6ZYOkizT17BkKR3l5se+235EWAfH2649HG0hZPu3txwT8NhxmuuIPx48m6bYLWBVgpe9G9mHmzPrI0p21Cw2z3ja+LubKdzCLgvTNF0rmcPVdq+Mmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XRMuJD7x; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731015674;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wKXsXIJ6+wujZXZvZ8iEGuUegjY8zfalZM3UvgSSNaI=;
	b=XRMuJD7xnK/tR2DPdqKzbF4uC641a+tkyEyMA8eeWkBa0JzRp0QemdjlP4cJbtST9/pZaX
	/m78M7Hw1Wje0fYTX9lGY7Mp8z8fx8kdtFv8kTSBDyc4dNb8WZelVMk5EeKoT6ZDnvO244
	AsA8nInao9W25KliyR4NUODktITwxz8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-594-Er4HyNeUPRWQALMC2_Vgpw-1; Thu, 07 Nov 2024 16:41:13 -0500
X-MC-Unique: Er4HyNeUPRWQALMC2_Vgpw-1
X-Mimecast-MFC-AGG-ID: Er4HyNeUPRWQALMC2_Vgpw
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5c94a70a3f5so1235805a12.0
        for <linux-hyperv@vger.kernel.org>; Thu, 07 Nov 2024 13:41:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731015671; x=1731620471;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wKXsXIJ6+wujZXZvZ8iEGuUegjY8zfalZM3UvgSSNaI=;
        b=VksgP8FKlYOjZ1zWYEKEYfCwVMPYJRX1YnSVda5X+Gkr8Xj+JBOYhqkLmPfTOREk8W
         FYl40Mz5Wez+Cf4VxjuzmXCSzzN9xCON2mIeF6nD3DXOvMubJpx6tRstObjW2JrHsfQS
         LlRQ9kLWq7UTtctpV1rLuoLYIr4d3ncAuDqgHfE1SEyPdN2EpwaTzxlRf69Nuv6kMCv4
         nwYUrB9YRNYCPsZQt5VK1y5LQ0iHQ4Z2fvns+yUHjI1Fdpgi7QV/+Q2p2SL6zS1EN+gj
         aq/tf08hSKYnV940kEdQCVLvimVZ3YwHiypcuw6rONx86VHRWAduONFGZDB4m8IOcYZH
         +Ybw==
X-Forwarded-Encrypted: i=1; AJvYcCXv0CzN+HAf9T1uxQ/CQm8EzAr3knn68O7TrLDt9Sv1u97no9xkfg4KUeJ9dgruWux+JOT38NQNyL5l+xg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyHNCw9ibWTcRsRAbIsmKbBFT7wb+zm/csVu9QDp+tgIxDkID0H
	z3PDVWUc47AvnWIN4Sa3tCN1FWHs6RZUZeSXsa1IkaHekvxSHjwnlnuIKbgAiE04gDrzRQlR4+2
	T9lf5KiyrC0w18DyAYvXwN9mXw9Isk8UB39ueQ6ugfDAhjUsA7tG5SR7kpovjdw==
X-Received: by 2002:a05:6402:2790:b0:5cf:9ec:168e with SMTP id 4fb4d7f45d1cf-5cf0a30b0c1mr242465a12.2.1731015671453;
        Thu, 07 Nov 2024 13:41:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnySyRq03iGTzTmiBoPn4BtW/0y8BdTVR3G/Nk4eaBwgb/hSu3uiHSIE0b1E3DZtVksWsI4w==
X-Received: by 2002:a05:6402:2790:b0:5cf:9ec:168e with SMTP id 4fb4d7f45d1cf-5cf0a30b0c1mr242438a12.2.1731015671068;
        Thu, 07 Nov 2024 13:41:11 -0800 (PST)
Received: from redhat.com ([2a02:14f:179:39a6:9751:f8aa:307a:2952])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cf03bb6dc1sm1292372a12.42.2024.11.07.13.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Nov 2024 13:41:09 -0800 (PST)
Date: Thu, 7 Nov 2024 16:41:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Hyunwoo Kim <v4bel@theori.io>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, imv4bel@gmail.com
Subject: Re: [PATCH v2] hv_sock: Initializing vsk->trans to NULL to prevent a
 dangling pointer
Message-ID: <20241107163942-mutt-send-email-mst@kernel.org>
References: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
 <20241107112942.0921eb65@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241107112942.0921eb65@kernel.org>

On Thu, Nov 07, 2024 at 11:29:42AM -0800, Jakub Kicinski wrote:
> On Wed, 6 Nov 2024 04:36:04 -0500 Hyunwoo Kim wrote:
> > When hvs is released, there is a possibility that vsk->trans may not
> > be initialized to NULL, which could lead to a dangling pointer.
> > This issue is resolved by initializing vsk->trans to NULL.
> > 
> > Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
> > Cc: stable@vger.kernel.org
> 
> I don't see the v1 on netdev@, nor a link to it in the change log
> so I may be missing the context, but the commit message is a bit
> sparse.
> 
> The stable and Fixes tags indicate this is a fix. But the commit
> message reads like currently no such crash is observed, quote:
> 
>                           which could lead to a dangling pointer.
>                                 ^^^^^
>                                      ?
> 
> Could someone clarify?

I think it's just an accent, in certain languages/cultures expressing
uncertainty is considered polite. Should be "can".

-- 
MST


