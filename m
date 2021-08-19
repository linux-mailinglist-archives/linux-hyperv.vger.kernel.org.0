Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0BEE3F1D87
	for <lists+linux-hyperv@lfdr.de>; Thu, 19 Aug 2021 18:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhHSQOg (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 19 Aug 2021 12:14:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhHSQOf (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 19 Aug 2021 12:14:35 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5F5C061575;
        Thu, 19 Aug 2021 09:13:59 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d11so8338657ioo.9;
        Thu, 19 Aug 2021 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ySNm5Bk9COcoCTlxBoNx2xtiQU2siDNi9QvD6Fw2LHY=;
        b=eT3kT21+h9KmKJuMtIfZt2j7b7Gh71x95InJl9NmoGC3d65urtKYQ2ivzWhXTyt3N9
         cwRgMANy01hRZGHK3WbR3Fofy9qgV1oJJaO2GGLQwruCzjeQlg2p3D9E7XRZjPKWX9Nr
         Q+MRAcb0Bx21kyY6DOsYhhrioYovi5H3VL3sjSqJn1BnojOIkrpw7Tavm3ivfGlw/lqB
         CrfgGT4/tgxJh5QMPvilbOYYUk5lDcGVZ2OgkuqHJiq8XI4SAh4ojpnGsowxu5KfqMyw
         uXKlqn57l3QvRCIFlJ+rowU8hB+XfYMFt/Yp23HLrjzMAqiulI1K/WJBkk+C2lrawz16
         95zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ySNm5Bk9COcoCTlxBoNx2xtiQU2siDNi9QvD6Fw2LHY=;
        b=GW+zQORybY7iVMkjop7WcI6+zFBBZWY8m+C+dKSu6xe3qQtxhb6zKSaJNSbuLc3CmI
         e86Lm6HguBCWyKutrPY2erAmbUGIejFsOO1hBqALDCShd5PRV8ll3u1dBYxNJw5PeX4m
         NNH2mWeBGrObLCtI6Uj6/zmUjY2qKb+ZdWEHzw5gq0dv9wSJvICx2EVewkDdILUzmoe6
         03NJkFM6KyjB0NuWycuzPfSFgWerv/MTbJHyp3i/GBH46sNgQuwgmAtkg4EIJcPXM4Z6
         LwhnKQhqp6W5DJVRAYB0kyLrNth7VNEv3amulM0S1mMwlHdgIr5TKHj0Xl9QcLiOFO5d
         V1lg==
X-Gm-Message-State: AOAM5327l3Gd59z493C7mdlVvVRCytVJGpUCjSZzrYz8nk9egBhxkKUp
        hTN60iBstes62fvpTyZ4yxM=
X-Google-Smtp-Source: ABdhPJxrl82ZSwavV3V8BmvBTWnuI3ManBU9zK9oiUPO/16jM4jSUXw3hhNmmOgZXhh4QQFB1OWyVA==
X-Received: by 2002:a5e:df0d:: with SMTP id f13mr12029301ioq.108.1629389638574;
        Thu, 19 Aug 2021 09:13:58 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id k2sm1733779ior.40.2021.08.19.09.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 09:13:58 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailauth.nyi.internal (Postfix) with ESMTP id 260F027C005A;
        Thu, 19 Aug 2021 12:13:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 19 Aug 2021 12:13:57 -0400
X-ME-Sender: <xms:Q4MeYe6GJ5Jqs06KbLQruWwZ2wUczV9D74ovcc8FLpJDrDC241DcKw>
    <xme:Q4MeYX5jbM2wlxTKGyBcD_gOdyDKCZr5c8bWEzkg4N_fdTLVi0uX5ViVc4ZmJUL16
    RULq5zH2Ue9-P01Wg>
X-ME-Received: <xmr:Q4MeYdfoEcygWdYozmbyQonswj1Y9PZN2pz150qjDoVklngxoSzANxDm79DPxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrleejgdeliecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrghtth
    gvrhhnpeevieejtdfhieejfeduheehvdevgedugeethefggfdtvdeutdevgeetvddvfeeg
    tdenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:Q4MeYbK56FdSUVPfJCoqh2cOHh92tGrQF4B0Meku3YU2xCusj3HB1Q>
    <xmx:Q4MeYSLBSE2rYAZhzytuzpFAyjv5cGNyTAymGLWFNTM_kPPBn9jacQ>
    <xmx:Q4MeYcxjvU3ootAoqztkiKkocQM1UvzBRO4k2gBay9n9tU7KKyhL6g>
    <xmx:RYMeYSLP3cPseTJ7zr74cs9oU51pDQjxgjSQb9vmOrE1-SZwr_vratHjBHs>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 19 Aug 2021 12:13:55 -0400 (EDT)
Date:   Fri, 20 Aug 2021 00:13:22 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Mike Rapoport <rppt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Arnd Bergmann <arnd@arndb.de>, Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH v6 4/8] arm64: PCI: Support root bridge preparation for
 Hyper-V
Message-ID: <YR6DIkdkblL8NUP2@boqun-archlinux>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
 <20210726180657.142727-5-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210726180657.142727-5-boqun.feng@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Catalin and Will,

Appreciate it that you can have a look at this one and patch #4, note
that there exists an alternative solution at[1].

The difference is the way used to pass the corresponding ACPI device
pointers for PCI host bridges: currently pci_config_window->parent is
used, and this patch and patch #4 allow the field to be NULL, because
Hyper-V's PCI host bridges don't have ACPI devices, while [1] changes to
use pci_host_bridge->private. And I'm OK with either way, I don't have a
strong opinion here ;-)

Looking forwards to your suggestion, Thanks!

Regards,
Boqun

[1]: https://lore.kernel.org/lkml/20210811153619.88922-1-boqun.feng@gmail.com/

On Tue, Jul 27, 2021 at 02:06:53AM +0800, Boqun Feng wrote:
> Currently at root bridge preparation, the corresponding ACPI device will
> be set as the companion, however for a Hyper-V virtual PCI root bridge,
> there is no corresponding ACPI device, because a Hyper-V virtual PCI
> root bridge is discovered via VMBus rather than ACPI table. In order to
> support this, we need to make pcibios_root_bridge_prepare() work with
> cfg->parent being NULL.
> 
> Use a NULL pointer as the ACPI device if there is no corresponding ACPI
> device, and this is fine because: 1) ACPI_COMPANION_SET() can work with
> the second parameter being NULL, 2) semantically, if a NULL pointer is
> set via ACPI_COMPANION_SET(), ACPI_COMPANION() (the read API for this
> field) will return NULL, and since ACPI_COMPANION() may return NULL, so
> users must have handled the cases where it returns NULL, and 3) since
> there is no corresponding ACPI device, it would be wrong to use any
> other value here.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  arch/arm64/kernel/pci.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 5148ae242780..2276689b5411 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -90,7 +90,17 @@ int pcibios_root_bridge_prepare(struct pci_host_bridge *bridge)
>  		return 0;
>  
>  	cfg = bridge->bus->sysdata;
> -	adev = to_acpi_device(cfg->parent);
> +
> +	/*
> +	 * On Hyper-V there is no corresponding ACPI device for a root bridge,
> +	 * therefore ->parent is set as NULL by the driver. And set 'adev' as
> +	 * NULL in this case because there is no proper ACPI device.
> +	 */
> +	if (!cfg->parent)
> +		adev = NULL;
> +	else
> +		adev = to_acpi_device(cfg->parent);
> +
>  	bus_dev = &bridge->bus->dev;
>  
>  	ACPI_COMPANION_SET(&bridge->dev, adev);
> -- 
> 2.32.0
> 
