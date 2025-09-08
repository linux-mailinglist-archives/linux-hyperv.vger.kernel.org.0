Return-Path: <linux-hyperv+bounces-6777-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4720B48944
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Sep 2025 11:59:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 79F583AB127
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Sep 2025 09:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85AB2F1FED;
	Mon,  8 Sep 2025 09:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BWrTDF1H"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33E052EBBBC
	for <linux-hyperv@vger.kernel.org>; Mon,  8 Sep 2025 09:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757325536; cv=none; b=iauOQ+bKSwBH+75+4DcaQuWKVeJvmNRZRzWzwsgzvGFatQThSAmUsrzixQ6aIrc728c9WoBKU2Ssdl3D4UXJrk8qZ1tGfuF2XyDdjZ/tOp6DNuKd9cfipbPGpDN+N5KcV0ovh6HpmxMzlRLHHGhDXCf4p9C6V5LV6TPY9PN/Cfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757325536; c=relaxed/simple;
	bh=a6bVpnE3HRsYuWmdgLXEHl1NWYRsqoRCh2FcSf2L0/g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=laKLY4t5HTDpCz0H8mHHz/hnJuP4Pb7zIb9WaFMLXQiZuqH1HYZC/AFKQHGHytg9tZSh0iq4UyNSTIrrxkpVlV++wu1A+eXeIN5LPaKHTjNY1EQT41riNiqrvGstzjdxYO2gMJon5P37+0s3BcNHUYW7UuipoA12XapaKjGeTLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BWrTDF1H; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757325534;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=AS5TbPMoScatpfJs9X+pTZZBekuU2gBD3oRFuTdu1Fo=;
	b=BWrTDF1HKMprJ6M6Z4O7FkeVFZSWPG2rnQxC2TEhKYxFnYkvXdWURFcEEnkq9P2v+gPOki
	88lScYdOcUzk+IXG/nNc+jK0IOe3lCHs4QxuXfgl4trqPxk224WQbedS7pJQQFWlhPgNCY
	FSs0VHLzRFgda+3zVmkHBohCtStBKno=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-2IEe67k0P7eGXF40VIniwg-1; Mon, 08 Sep 2025 05:58:52 -0400
X-MC-Unique: 2IEe67k0P7eGXF40VIniwg-1
X-Mimecast-MFC-AGG-ID: 2IEe67k0P7eGXF40VIniwg_1757325531
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3e424a186fcso1198263f8f.0
        for <linux-hyperv@vger.kernel.org>; Mon, 08 Sep 2025 02:58:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757325531; x=1757930331;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AS5TbPMoScatpfJs9X+pTZZBekuU2gBD3oRFuTdu1Fo=;
        b=g+HlgSgq7NFPFUtuC1Rd74hVzjHXqAjn/SE489YkwBhhh90wl4L5SyPBduDrjV+Bh7
         VodUJhHFa8+Et5ioZqxfAghaP87ny/Ge0Z72SCGGaJPITYOtqDSNaADl52STKTga+ZSy
         jJBbwS/GABhEFJ0D4aVaJ610QnuIqgDyLm0iHROjosth2bWvMUkrq6j4H6ZvR6zUrJfj
         QASGXViLXYtxPBYEivRh6XG6IXxHm1Ui0atbgS9j4Kk9eN3njqjlxS1QGhtdXPWuz0xp
         VL6ZI3j0huTfBlkertAGGUWiKIGqp+lJyiULAiHvhRcg/KiCCFcbWsr2fupHpsGR8nMv
         P90g==
X-Forwarded-Encrypted: i=1; AJvYcCW0/pIm4bXN9i5yMeM78VXgzrpJU7j6qmUAuIGvPZsyOOQVFk2qghD6lcO/ZCbvzERdcBG/mtqfWkZejC0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxmls08ahbc6BsBwam1HDmYqCNKs7oTsA0TWw2fJg8wIS8MJPci
	vkn5GwpgKHcFokL24hP6X3ZaDTvhp33h0/8fngK9Mvv9Xl6ElBenXW73XOyfoFxZtUOCd14PB+n
	VX3Qf7419ZkyyzGTqMv4x8bxojMx6UsYbVK72J4usd+aOHRATSF+JgvHaV/KLG7V8qg==
X-Gm-Gg: ASbGncuHgh3SxuPNvs6KOFwmOQNG/h6shajOuq3S22nMgUfsUIhMycTiUouhgDAb0rm
	Gi6z91yGqbaTPUidfo0ytLw00WgYm7sElBx4EBUl/RNFOeHvtsHrwc/gTDJX1laR2c9yASuTWEm
	dFi+7dwhHFG0Y7hKhhMBIUmA0JOd55o+29tOmDwivjYrFgz6s/vEjDpVNmCaSy909EuP0IBch/h
	Ukh3A1borIJ9j8YBHPDgMEmPtBBahX014FMOKtZPQ/UDprEQrFX0E/xUV45QjG+FUuEfN/XhIEa
	Hr56j3B88OSs+EOyXFyXfx15sMZ46q7Ovbk=
X-Received: by 2002:a05:6000:2285:b0:3db:c7aa:2c19 with SMTP id ffacd0b85a97d-3e6428d7ccbmr5339174f8f.26.1757325531438;
        Mon, 08 Sep 2025 02:58:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEzqDPXEG9KjjfatQRgfi7m9NqzdpNSgqCOLY881KppF3Xzcuz+JdS4DCAcNL2JTIUUxUGQog==
X-Received: by 2002:a05:6000:2285:b0:3db:c7aa:2c19 with SMTP id ffacd0b85a97d-3e6428d7ccbmr5339150f8f.26.1757325530995;
        Mon, 08 Sep 2025 02:58:50 -0700 (PDT)
Received: from fedora (g3.ign.cz. [91.219.240.17])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45cb5693921sm240950065e9.0.2025.09.08.02.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Sep 2025 02:58:50 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Li Tian <litian@redhat.com>, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, Haiyang
 Zhang <haiyangz@microsoft.com>, Benjamin Poirier <bpoirier@redhat.com>
Subject: Re: [PATCH net] net/mlx5: Not returning mlx5_link_info table when
 speed is unknown
In-Reply-To: <20250908085313.18768-1-litian@redhat.com>
References: <20250908085313.18768-1-litian@redhat.com>
Date: Mon, 08 Sep 2025 12:58:49 +0300
Message-ID: <877by9fep2.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Li Tian <litian@redhat.com> writes:

> Because mlx5e_link_mode is sparse e.g. Azure mlx5 reports PTYS 19.
> Do not return it when speed unless retrieved successfully.
>
> Fixes: 65a5d35571849 ("net/mlx5: Refactor link speed handling with mlx5_link_info struct")
> Suggested-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Li Tian <litian@redhat.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/port.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/port.c b/drivers/net/ethernet/mellanox/mlx5/core/port.c
> index 2d7adf7444ba..a69c83da2542 100644
> --- a/drivers/net/ethernet/mellanox/mlx5/core/port.c
> +++ b/drivers/net/ethernet/mellanox/mlx5/core/port.c
> @@ -1170,7 +1170,11 @@ const struct mlx5_link_info *mlx5_port_ptys2info(struct mlx5_core_dev *mdev,
>  	mlx5e_port_get_link_mode_info_arr(mdev, &table, &max_size,
>  					  force_legacy);
>  	i = find_first_bit(&temp, max_size);
> -	if (i < max_size)
> +	/*
> +	 * mlx5e_link_mode is sparse. Check speed

The array is either 'mlx5e_link_mode' or 'mlx5e_ext_link_info' but both
have holes in them.

> +	 * is non-zero as indication of a hole.
> +	 */
> +	if (i < max_size && table[i].speed)
>  		return &table[i];
>  
>  	return NULL;

-- 
Vitaly


