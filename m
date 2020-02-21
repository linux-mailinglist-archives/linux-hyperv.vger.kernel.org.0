Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4F06F166CEA
	for <lists+linux-hyperv@lfdr.de>; Fri, 21 Feb 2020 03:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729290AbgBUCdu (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 20 Feb 2020 21:33:50 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38474 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729268AbgBUCdu (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 20 Feb 2020 21:33:50 -0500
Received: by mail-qt1-f195.google.com with SMTP id i23so283195qtr.5;
        Thu, 20 Feb 2020 18:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CJP5LjskY0xuyHpqzi/Sp0OFSxwmRBAuuNSOyFdMDrw=;
        b=vLzlGE8Rc4j0z0misWUTgTTV4OEkdRDWO+AGyOAJoSj3Aekh80TjcLWegGnsawrj9I
         WnBwGlSjWApxCrR0HhHd+fbPigpt3KUTJkL0slgPyy2kxwzGMpr/NXUa1/EmCEO4mmFe
         Z0DWzqpmfGZrVLdRB61ZzDTMXwUQMVTHJIANmqMln0U99pk6Q37pEuDXdT32cMzPt00s
         k33BiEfASBiEXNYwx/u99yksKE5OBc5amDD74M6yNAFr4SPm9VAIqCKB308h09WLq9G7
         GEXYcDSTY8CwZd11se0J8SNV0CEDZbOFQ6TUkAMp1ri7lqVpObNTaw/CX9KrQ34aG1Ol
         tFsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CJP5LjskY0xuyHpqzi/Sp0OFSxwmRBAuuNSOyFdMDrw=;
        b=nNrLox/tN54UM6KhbYeJiBQBCfFNCFMponIQbOCf/xi/vU0tCW03lwdeTd4Zg+/H6P
         Tg/U9pLK0M8guamqrDhvdWOf2RNuusFeNQ4IkjkgYjESTbeGuJY74YSND8idlaZPrFxh
         3+52ehM2lVhYTzrcapvhpCNRISLG5FHAyF25+uRaGRC+6Ro219LY7F7H6x0850dHicIG
         OV/IZH82D4nhN0wzom3D1AO9Mb91GI3HQ83WrlnSbqottVj9ffHbOZGZH75rDbOJHe2D
         OKDDELAn1UeeoeGvX8AQaFHLr69NMrr24uXnbz1DdgdLH8V8ZpuAk3G/Ff4ONM+v5cc7
         H7yw==
X-Gm-Message-State: APjAAAUT664yx/bFARZ4mTrGmSQlHYTA2+eXUiLKGIqmsFQI6xGyLEdK
        +Pfp9oPafGBhgpiBTxCOPhY=
X-Google-Smtp-Source: APXvYqxIHEQ+62I6c+ag0k9JoRxOaDsRZzdEfqlnCP5h4FV+YOdpMGvAhHMNcxyWGGM8xrfVruWfrA==
X-Received: by 2002:aed:2a87:: with SMTP id t7mr29337838qtd.384.1582252429515;
        Thu, 20 Feb 2020 18:33:49 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id d185sm856433qkf.46.2020.02.20.18.33.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Feb 2020 18:33:48 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 5BE4021D25;
        Thu, 20 Feb 2020 21:33:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 20 Feb 2020 21:33:48 -0500
X-ME-Sender: <xms:ikFPXtagK57hemUqoQlkFvR8aR50EYdz22yZX_7m5XF_FxEN7-7z3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrkeefgdeglecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuohhrthgvugftvggtihhpvdculdegtddmnecujfgurhepfffhvffukfhfgggtuggjseht
    tdertddttddvnecuhfhrohhmpeeuohhquhhnucfhvghnghcuoegsohhquhhnrdhfvghngh
    esghhmrghilhdrtghomheqnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphep
    hedvrdduheehrdduuddurdejudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhi
    thihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrdhfvghngheppehgmh
    grihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:ikFPXnEUx8DUlerkl2WWSsKabLCwb-_JYU5cTdVquUfecPfxQEWLUw>
    <xmx:ikFPXtdnhSmUpQdDUDatVLhkB8tIiRVmMlF-Noq2i38RWHsyNXDBIQ>
    <xmx:ikFPXiDTcEmm7s_E1MjjprD8QgQF5ipsX5CHHgrK3sWQC_RFgtA8Fg>
    <xmx:jEFPXgRwIIGl24hMjO5CE6WSMOeRJMzP8iCe0tf51uw8uwqwTPv2YzWi_xs>
Received: from localhost (unknown [52.155.111.71])
        by mail.messagingengine.com (Postfix) with ESMTPA id 58B213060F09;
        Thu, 20 Feb 2020 21:33:46 -0500 (EST)
Date:   Fri, 21 Feb 2020 10:33:44 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     linux-pci@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Michael Kelley <mikelley@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v3 0/3] PCI: hv: Generify pci-hyperv.c
Message-ID: <20200221023344.GJ69864@debian-boqun.qqnc3lrjykvubdpftowmye0fmh.lx.internal.cloudapp.net>
References: <20200210033953.99692-1-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200210033953.99692-1-boqun.feng@gmail.com>
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Ping ;-)

Any suggestion or plan on this patchset?

Thanks and Regards,
Boqun

On Mon, Feb 10, 2020 at 11:39:50AM +0800, Boqun Feng wrote:
> Hi,
> 
> This is the first part for virtual PCI support of Hyper-V guest on
> ARM64. The whole patchset doesn't have any functional change, but only
> refactors the pci-hyperv.c code to make it more arch-independent.
> 
> Previous version:
> v1: https://lore.kernel.org/lkml/20200121015713.69691-1-boqun.feng@gmail.com/
> v2: https://lore.kernel.org/linux-arm-kernel/20200203050313.69247-1-boqun.feng@gmail.com/
> 
> Changes since v2:
> 
> *	Rebased on 5.6-rc1
> 
> *	Reword commit logs as per Andrew's suggestion.
> 
> *	It makes more sense to have a generic interface to set the whole
> 	msi_entry rather than only the "address" field. So change
> 	hv_set_msi_address_from_desc() to hv_set_msi_entry_from_desc().
> 	Additionally, make it an inline function as per the suggestion
> 	of Andrew and Thomas.
> 
> *	Add the missing comment saying the partition_id of
> 	hv_retarget_device_interrupt must be self.
> 
> *	Add the explanation for why "__packed" is needed for TLFS
> 	structures.
> 
> I've done compile and boot test of this patchset, also done some tests
> with a pass-through NVMe device.
> 
> Suggestions and comments are welcome!
> 
> Regards,
> Boqun
> 
> Boqun Feng (3):
>   PCI: hv: Move hypercall related definitions into tlfs header
>   PCI: hv: Move retarget related structures into tlfs header
>   PCI: hv: Introduce hv_msi_entry
> 
>  arch/x86/include/asm/hyperv-tlfs.h  | 41 +++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h     |  8 ++++++
>  drivers/pci/controller/pci-hyperv.c | 43 ++---------------------------
>  3 files changed, 52 insertions(+), 40 deletions(-)
> 
> -- 
> 2.24.1
> 
