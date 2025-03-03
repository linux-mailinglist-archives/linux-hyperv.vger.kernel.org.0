Return-Path: <linux-hyperv+bounces-4195-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A112A4BF2B
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Mar 2025 12:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F5E03BA6D0
	for <lists+linux-hyperv@lfdr.de>; Mon,  3 Mar 2025 11:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 959FB202C20;
	Mon,  3 Mar 2025 11:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="p3bK6d8D"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5E7201249
	for <linux-hyperv@vger.kernel.org>; Mon,  3 Mar 2025 11:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002021; cv=none; b=MZL8BUl9cga/JcNo01ba3Ro3CG58I3yb4FbFfEjH5OGhbAu44Bp5r/vSlo5ac5vq5RFGiHTqUAk+2kN3r1TxKUjTE6eg79U0+e5bI/vQAbLlAZCSWzieUuVB0Wxrj5M3jrTsouW3KZhRC4inDyKeLNdNjfXvY4URKjCkHnKEuDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002021; c=relaxed/simple;
	bh=32Qik+C6Gy82VbaZ+W9H7pBMHl/CZaXxobg9NI2Xga4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kjhAt4eIT/UH82nLxU/wWPzUqb23+l30FrVs2omLN0wkMgxJTd5yXc21OtRffyBVnbJfhwh83rpLFwDkI+edBQHjXbzVVLPVDNHhWja72YRIMuciHAm9UXCB2CdEmKOXFOeVUVHVnvl9zfSrpIuXIma0AyDKZJPfoJIEYRgVhNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=p3bK6d8D; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-439a1e8ba83so40955345e9.3
        for <linux-hyperv@vger.kernel.org>; Mon, 03 Mar 2025 03:40:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1741002017; x=1741606817; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4NtAA2UHYocmR2KbGMJPhzPhzOIPXF5Y+cD7gkzWW/A=;
        b=p3bK6d8DrjrhK0/qO2+o0XXclKbDdJbPyaEJqebJFnj6UftGu/Wlp0g0z460UuK8eQ
         jqP5dZiDvaf13EWZxYf429fumpQf+BuKXNtjjUA1NBj79GysscTVo0cg0j48fqmhX5NV
         9efVLZPrgc0Lj4xKJGCHbJmoh8/VB/GderaMZxkIzlOfM8yT/xfitEr/NJBqrSttwzsv
         D2S8SLnciUvPRACHbdtcIkpSchM5xwppp3eKPT9K2p2QOLfBtVwD7D66BHHzvMMQDhR3
         p5TyUVouF6jIyBsh7KwZIVWxs5mF+hJOLYmeHoxXDNdBYVQ5ilopY0Vx1AvSDV4gvTVv
         9zZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741002017; x=1741606817;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4NtAA2UHYocmR2KbGMJPhzPhzOIPXF5Y+cD7gkzWW/A=;
        b=T7oAzbQWpMgPDyBa3m2O34gD4Gcm3E1qypyZnr9UefisXi0Yk7qeMFPZNE/PVnuv2m
         A5g0k8ZAJibrozdvgZ8W9SgZzvXu6PBkrpUaow5dOGdgVinfCjnc48+XnFpcPQp/hhHE
         4ZG/ZQFZORVk+RJmKANNQFJfd7Bk4/lr8E1yYhC2FWO4cnel7/CYfxTLvXmVDvEKhKwj
         AXuLGFrjbUdFLjHTjsYiEM/SVSa2cnsJ4ZP3BPI88Nbu7c41CnQCX0KRAtuD/ZoxmC1w
         FEK1rVnwm9lj9OW4eZoe+L9HL8Lp7TxAnNAcUE6eoGPVrl43xu1Hc8Vw8tMx2/k3OxwF
         GWXQ==
X-Forwarded-Encrypted: i=1; AJvYcCWgf6rw2M+IUm3Ye/Rzk2JuUm6FAOSNVwSVkiMmbC7p06mhgpG6b5nsHP/IULFVPvlWHmKusq9fSfR/2WU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw61ef+fs9Yt8T8I30gUREzMRDFDPzjvMGqSU8nhd2NF6gHE5b2
	A1V6v762Q4F/21BZbZ1m1E3jpx6CQluTvZQFVRvYY6CULhKoovrzG+kdmZvUaBw=
X-Gm-Gg: ASbGncv4vXpVbHigKZ5o7tdDgXEVBTzbRHaVwYIJ4cx3nGUMfGOdz8zVNi0hH+pX2h5
	qJVq8fKRWx8roqHbQjvuEaIlGa8DKWQLx30VtlqUhGFIlfySHD7OH5qEnh81sbRcBeEQPX1SsgN
	d2JjnP/ppknNMTc18RIpsBQFUF41GDVJStVYzSEDPyj/Q/WHKB7ZK9/KHrL27m8qYJE3HJJg9l9
	CsSG7NhiWgXQpszaRdWBiDO7qz+vh1JdJG3PiqDIg9ZouIH8m+NhSwocW8f03u1mZp74YPZcIx1
	v3NQrh0vM/sBeGAsCyYqt9yOIdiGMbUHkNMG/rDj5cELmljPRut2ZmWoE1If8rlsbBgvPO0h
X-Google-Smtp-Source: AGHT+IFz1lKrp8HJjVJu85QHKOfDHRDkxYAgfR/PMWyeJaGKL7qzodzH7XjGqSVE9eCdgx8AE4rhHQ==
X-Received: by 2002:a05:6000:144c:b0:391:c3a:b8ae with SMTP id ffacd0b85a97d-3910c3aba7emr2411994f8f.23.1741002017110;
        Mon, 03 Mar 2025 03:40:17 -0800 (PST)
Received: from jiri-mlt.client.nvidia.com ([140.209.217.212])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e479596dsm14212516f8f.7.2025.03.03.03.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 03:40:16 -0800 (PST)
Date: Mon, 3 Mar 2025 12:40:13 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: longli@linuxonhyperv.com
Cc: "K. Y. Srinivasan" <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shradha Gupta <shradhagupta@linux.microsoft.com>, Simon Horman <horms@kernel.org>, 
	Konstantin Taranov <kotaranov@microsoft.com>, Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>, 
	Erick Archer <erick.archer@outlook.com>, linux-hyperv@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, Long Li <longli@microsoft.com>
Subject: Re: [PATCH] hv_netvsc: set device master/slave flags on bonding
Message-ID: <52aig2mkbfggjyar6euotbihowm6erv3wxxg5crimveg3gfjr2@pmlx6omwx2n2>
References: <1740781513-10090-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1740781513-10090-1-git-send-email-longli@linuxonhyperv.com>

Fri, Feb 28, 2025 at 11:25:13PM +0100, longli@linuxonhyperv.com wrote:
>From: Long Li <longli@microsoft.com>
>
>Currently netvsc only sets the SLAVE flag on VF netdev when it's bonded. It
>should also set the MASTER flag on itself and clear all those flags when
>the VF is unbonded.

I don't understand why you need this. Who looks at these flags?


>
>Signed-off-by: Long Li <longli@microsoft.com>
>---
> drivers/net/hyperv/netvsc_drv.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/net/hyperv/netvsc_drv.c b/drivers/net/hyperv/netvsc_drv.c
>index d6c4abfc3a28..7ac18fede2f3 100644
>--- a/drivers/net/hyperv/netvsc_drv.c
>+++ b/drivers/net/hyperv/netvsc_drv.c
>@@ -2204,6 +2204,7 @@ static int netvsc_vf_join(struct net_device *vf_netdev,
> 		goto rx_handler_failed;
> 	}
> 
>+	ndev->flags |= IFF_MASTER;
> 	ret = netdev_master_upper_dev_link(vf_netdev, ndev,
> 					   NULL, NULL, NULL);
> 	if (ret != 0) {
>@@ -2484,7 +2485,12 @@ static int netvsc_unregister_vf(struct net_device *vf_netdev)
> 
> 	reinit_completion(&net_device_ctx->vf_add);
> 	netdev_rx_handler_unregister(vf_netdev);
>+
>+	/* Unlink the slave device and clear flag */
>+	vf_netdev->flags &= ~IFF_SLAVE;
>+	ndev->flags &= ~IFF_MASTER;
> 	netdev_upper_dev_unlink(vf_netdev, ndev);
>+
> 	RCU_INIT_POINTER(net_device_ctx->vf_netdev, NULL);
> 	dev_put(vf_netdev);
> 
>-- 
>2.34.1
>
>

