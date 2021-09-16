Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 493A840D161
	for <lists+linux-hyperv@lfdr.de>; Thu, 16 Sep 2021 03:48:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233569AbhIPBt2 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 15 Sep 2021 21:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbhIPBt2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 15 Sep 2021 21:49:28 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EE57C061574;
        Wed, 15 Sep 2021 18:48:08 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id t190so5777474qke.7;
        Wed, 15 Sep 2021 18:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=S5F/7mjVj19VhN5UayFkb0ojfwArPd1OGau/OzEMQK8=;
        b=AfM+bL5kGDU93dq+t5Fpx0WuIXoIkp+VaA79arh/hd8VxjZGJHaCHNs0qJI/2FAH9k
         3OtpMvq+9Vzl6JPyeNb4NXwLYFsKIRNs4sZ77iB4FmG5FfstNnC4jZ5/qXbEvGRrK8N9
         eWHDEkLmzNMcug9dq8fAGdPPtQdFTYPvat3N/NsFKIp2II7p2BBH5XsxNC92q5Zii1Dk
         ljUQqYZXzNWHj2UR5vSPLrPBeiNIDYY9yu9dh+AIUQqihvO1cjdtor5PsWEz70BXt6BU
         iYEF+RF5mVKXIk51FWkYfMGZks0NaGSXna0OZMsJiCR99yFSpf1cumodv7ggt1pGz3zr
         VTgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=S5F/7mjVj19VhN5UayFkb0ojfwArPd1OGau/OzEMQK8=;
        b=3fFcVxb7JoOVpLJ381BELZ3hy0UBm8kl1N9FyV5o81CgCVdhSI4yDfVPhmU3PY6DTW
         SGwkRdxO0EvixdRDwmrnMzH13YXU7zd96ZjnJaSNMxyPqceXmLt4RLKcmKEHBr8hsWAx
         L/BSDJOnnsByzx5X+AmNEaYuEw8Ht/bIYV9o8ixVVT2yp2moacb7FJ2q7FH8i5GYkx5f
         PpRNjErEGjsBkiUUk6G8LYvo77Myo4ZohV2JV6fNYRwCrTdEmFkjt63VZtFNgy78S4+d
         ey531BTJtZI+++1TPXRRI7+owXE6QBlHHH+MeYwQi4fWuShbV7Xof4MYPX/j0pKPlL3c
         x7/Q==
X-Gm-Message-State: AOAM53263zdOjXCZiI+oXHl9QyDzLd7Dd2Jlvy944j1njmCPjP3GqNqV
        vMe/4/v5+KODVPh9S2wqTwMwAL8QHrs=
X-Google-Smtp-Source: ABdhPJzaTBQ7Y+4BeSYYgvQmkcWWMbTi516YrVgbwIKAWdxUoIERJ2DP7HLiCBEjXijanSyO2dSk1A==
X-Received: by 2002:a05:620a:2094:: with SMTP id e20mr2920736qka.171.1631756887785;
        Wed, 15 Sep 2021 18:48:07 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id q10sm1392867qke.108.2021.09.15.18.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Sep 2021 18:48:07 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id F0AE227C0054;
        Wed, 15 Sep 2021 21:48:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 15 Sep 2021 21:48:06 -0400
X-ME-Sender: <xms:VqJCYe0ydqv2MwvbzyDPSGK7HlmsVr-oT3T-R8f7M11R4IMWnVn13A>
    <xme:VqJCYRG5hvPxVRgRmHJnAmt3LFN9yz_usoqLcWSpQD720UnO56Oq4SHF1HAE2FTc3
    8a-pooNJvpOzi5AUA>
X-ME-Received: <xmr:VqJCYW5qrgv5nmiGMO4XWcbm3YdlDNCcE7_EdH78kKVkG-iZot3_7QOLeNs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrudehfedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepvdelieegudfggeevjefhjeevueevieetjeeikedvgfejfeduheefhffggedv
    geejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:VqJCYf2QLXMvJALRrV-9b6RPDpOTA0dRmwJQKpARShSDfRhQUPdFVg>
    <xmx:VqJCYRHOKUYfl0TOIRvdL9eBHcgiSMR5e8BaKtPkMN9Wa0XrG0ElEw>
    <xmx:VqJCYY-fgqX8sz1EvjjoVd2tpkzSUz3lRh0bMDVGekzrfsJj47swfg>
    <xmx:VqJCYecUkM7GjKpaneehSSZosmVIplHA6rtGsCo6EUKbhg77z6ymyI4HWMM>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Sep 2021 21:48:06 -0400 (EDT)
Date:   Thu, 16 Sep 2021 09:48:02 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Sunil Muthuswamy <sunilmut@microsoft.com>
Cc:     Michael Kelley <mikelley@microsoft.com>,
        Boqun Feng <Boqun.Feng@microsoft.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Dexuan Cui <decui@microsoft.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?Q?=22Krzysztof_Wilczy=C5=84ski=22?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] PCI: hv: Make the code arch neutral
Message-ID: <YUKiUuwPfuGEFqr+@boqun-archlinux>
References: <MW4PR21MB2002AE9B673A54D748BD1F2DC0D99@MW4PR21MB2002.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW4PR21MB2002AE9B673A54D748BD1F2DC0D99@MW4PR21MB2002.namprd21.prod.outlook.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Mon, Sep 13, 2021 at 05:36:46PM +0000, Sunil Muthuswamy wrote:
> This patch makes the Hyper-V vPCI code architectural neutral by
> moving the architectural dependent pieces into arch specific
> code. This allows for the implementation of Hyper-V vPCI for
> other architecture such as ARM64.
> 
> There are no functional changes expected from this patch.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>

This overall looks good to me, I think you may want to base on 5.15-rc1
which has Michael's and my patches on which this patchset depends.

A small nit below:

[...]
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 62dbe98d1fe1..b7213b57b4ec 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -44,8 +44,8 @@
>  #include <linux/delay.h>
>  #include <linux/semaphore.h>
>  #include <linux/irqdomain.h>
> -#include <asm/irqdomain.h>
> -#include <asm/apic.h>
> +//#include <asm/irqdomain.h>
> +//#include <asm/apic.h>

remove the commented out #include too.

Regards,
Boqun

>  #include <linux/irq.h>
>  #include <linux/msi.h>
>  #include <linux/hyperv.h>
[...]
