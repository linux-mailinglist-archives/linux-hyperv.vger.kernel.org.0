Return-Path: <linux-hyperv+bounces-3296-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E70989C18C2
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Nov 2024 10:07:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC87E283061
	for <lists+linux-hyperv@lfdr.de>; Fri,  8 Nov 2024 09:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA091E0DB8;
	Fri,  8 Nov 2024 09:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b="MlPkkLpg"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CF61E0B9C
	for <linux-hyperv@vger.kernel.org>; Fri,  8 Nov 2024 09:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731056827; cv=none; b=bH/wF0VlNI9m3OZEOAy88CF52tyVdzVYN6qNquZYjmfyo3HLHnOM6jxtL3gu7AvM0/xkXB3Nj4gV+eWAUQjcANdeg4cdFSlgeE9yG3hkwSkcBni/TmtEkAfwxe92E1ckGwTS7QsgMx5x2KFSEH7kMqUVIjyUUFpKM9Kyhw0Y1jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731056827; c=relaxed/simple;
	bh=tCRTECuS56PuG0XEhbPkWcB/4w7m3WsRYVRHywqp/mM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOMRRFubacb95jtNYLWrJlZJwIJj2gAsmgIrICsRjNHLcDvlp0QkRmEP7k/qEcVB6uYNEiHXy1H4mIFvHLrULNQgk8DFIgNnED+OzSbdJjreXl7eewZQkJfk0uyU58ALP9SVB/BmhQuU3mMludlce6urhhG8D7uRBoox1M+YuKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io; spf=pass smtp.mailfrom=theori.io; dkim=pass (1024-bit key) header.d=theori.io header.i=@theori.io header.b=MlPkkLpg; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=theori.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=theori.io
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-7ee11ff7210so1407994a12.1
        for <linux-hyperv@vger.kernel.org>; Fri, 08 Nov 2024 01:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=theori.io; s=google; t=1731056825; x=1731661625; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=44W+od+4Yj44lPCffhrCXmOWnGyYVQpu4XgVvCES24c=;
        b=MlPkkLpgSosJb6IgmfmHVjZzGWpWDjipU3ZqOkQNMKaboMaZQYfEUVKBGcZLY972/V
         ox5J5mxyjAV8AdD49lOkGaW7YaCz+UGcGvaAb+mUG75k42vZygRFF2r1GwdKSm0Ju45/
         Two6B1eGRrFtzZJUkuwKYrSyp2CaPcnawHHq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731056825; x=1731661625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44W+od+4Yj44lPCffhrCXmOWnGyYVQpu4XgVvCES24c=;
        b=ioevzUPNNiaK+unzmmDyvEzc9teLCrFKlITArs9LsED2nogNoWtES2QhpPPEiWJcZy
         8gkBrsBnEPOTsjDzE9alH1o6obUQXd1CpymqU2IYoigMz3RpJzlN15Ydd2pjrwj0sbte
         BByWl8DIphJIp6B1AKDE0rt9HhATKnYsQ8GHMeAj+VuWBfub+NwBeFMLm/I0dYIBV7ou
         LmO5FSR68ReCkIAbQQ/JmnmnK+5kxHzPdKbe0PbduLHdpz/CRsm6xgv+CR2Qj6rmn5fL
         GkZ1PmD5cuFg9yfr2sH/RVpkoWRBNcIagmIezVvFWuKlbEqgrTyBouBX6cha4z1eGREQ
         17zg==
X-Forwarded-Encrypted: i=1; AJvYcCVqztRrOdB2X7c1jTJ05gpiNN1GRPN9FCfhMFWlexzkII943piOfMghu69aqiJIqlfh8Y+bGTvteL7q+ak=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCqYjquZrFvljVoOcpwpuwkyPMOgDTHly2Wp7WFGC9RuJluXTp
	LGL+2O7G7r05JU3FQQkmZo92hT6zYbRq7wxC/UhrH3CTsLH2a/NQ3pjA2gJl4U4=
X-Google-Smtp-Source: AGHT+IGs2h9aoaNLPBgS2eNHAD6WOasiHa5cVuBEaFX3KEKt97iNL+blz8xVKFhfPMU3uRT2FvPq3Q==
X-Received: by 2002:a05:6a20:9146:b0:1db:eb82:b22f with SMTP id adf61e73a8af0-1dc2289cf20mr2498608637.5.1731056825165;
        Fri, 08 Nov 2024 01:07:05 -0800 (PST)
Received: from v4bel-B760M-AORUS-ELITE-AX ([211.219.71.65])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407a151ddsm3224445b3a.146.2024.11.08.01.07.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 01:07:04 -0800 (PST)
Date: Fri, 8 Nov 2024 04:06:59 -0500
From: Hyunwoo Kim <v4bel@theori.io>
To: Jakub Kicinski <kuba@kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, linux-hyperv@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	gregkh@linuxfoundation.org, imv4bel@gmail.com, v4bel@theori.io
Subject: Re: [PATCH v2] hv_sock: Initializing vsk->trans to NULL to prevent a
 dangling pointer
Message-ID: <Zy3Us4AV9DsgWAQO@v4bel-B760M-AORUS-ELITE-AX>
References: <Zys4hCj61V+mQfX2@v4bel-B760M-AORUS-ELITE-AX>
 <20241107112942.0921eb65@kernel.org>
 <20241107163942-mutt-send-email-mst@kernel.org>
 <20241107135233.225de6d6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241107135233.225de6d6@kernel.org>

Dear,

On Thu, Nov 07, 2024 at 01:52:33PM -0800, Jakub Kicinski wrote:
> On Thu, 7 Nov 2024 16:41:02 -0500 Michael S. Tsirkin wrote:
> > On Thu, Nov 07, 2024 at 11:29:42AM -0800, Jakub Kicinski wrote:
> > > On Wed, 6 Nov 2024 04:36:04 -0500 Hyunwoo Kim wrote:  
> > > > When hvs is released, there is a possibility that vsk->trans may not
> > > > be initialized to NULL, which could lead to a dangling pointer.
> > > > This issue is resolved by initializing vsk->trans to NULL.
> > > > 
> > > > Fixes: ae0078fcf0a5 ("hv_sock: implements Hyper-V transport for Virtual Sockets (AF_VSOCK)")
> > > > Cc: stable@vger.kernel.org  
> > > 
> > > I don't see the v1 on netdev@, nor a link to it in the change log
> > > so I may be missing the context, but the commit message is a bit
> > > sparse.
> > > 
> > > The stable and Fixes tags indicate this is a fix. But the commit
> > > message reads like currently no such crash is observed, quote:
> > > 
> > >                           which could lead to a dangling pointer.
> > >                                 ^^^^^
> > >                                      ?
> > > 
> > > Could someone clarify?  
> > 
> > I think it's just an accent, in certain languages/cultures expressing
> > uncertainty is considered polite. Should be "can".
> 
> You're probably right, the issue perhaps isn't the phrasing as much 
> as the lack of pointing out the code path in which the dangling pointer
> would be deferenced.  Hyunwoo Kim, can you provide one?

This is a potential issue.

Initially, I reported a patch for a dangling pointer in 
virtio_transport_destruct() within virtio_transport_common.c to the security team.
The vulnerability in virtio_transport_destruct() was actually exploited for 
root privilege escalation, and its exploitability was confirmed (Google kernelCTF). 
Afterward, the maintainers recommended patching the hvs_destruct() function, which 
has a similar form to virtio_transport_destruct(), so I created and submitted this patch. 
Unlike virtio_transport_destruct(), this has not been actually triggered, so there 
is no call stack available.

However, I still believe it’s good to patch it since it is a potential issue.
Additionally, the v1 patch only exists in the security mailing list, which is why it might not be visible.

Best Regards,
Hyunwoo Kim

