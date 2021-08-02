Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ED0D3DD1C0
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Aug 2021 10:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232578AbhHBIN3 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 2 Aug 2021 04:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhHBIN2 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 2 Aug 2021 04:13:28 -0400
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D728EC06175F;
        Mon,  2 Aug 2021 01:13:18 -0700 (PDT)
Received: by mail-il1-x12a.google.com with SMTP id y4so15782070ilp.0;
        Mon, 02 Aug 2021 01:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AtBZnjnsEhq8+1whNEvZTyzi9w6AuOfFdYFVpER8LBI=;
        b=gHc8g0reJgpE3/Xsd7ph0xPd3khmGTUlO2h+PpKMuvk/Cmmt8Zn/W5CPTK9YyY2UpJ
         WjVygMZ2LaBCi+b23knmTCeyk0gEVNrgHQVRiAXgWFowM+2D/TMZWUI/JFmc56g9PuM1
         w7/J5hNpIr/ugyJdiOmLEiqsZL5xjUfWPe/41cRR3GxwpHSScb91HvBjneDSnyTkQhG+
         XU0LnT35kvQrQzetyfCHIyNCX+RotVtZ0NGal1GuJvpEYVFKZkqhcYOx7lDy3l7u/+mP
         B1JFuOTdGKV57AxpfQdvm+9InaY89uNvWp15jmXKLXWGua6aXzgn3g/hSN1a3ka+ysMg
         d2FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AtBZnjnsEhq8+1whNEvZTyzi9w6AuOfFdYFVpER8LBI=;
        b=qfKTvsG6A8slvuArRuoXrZBWumNx8U2+8pcIRoz+hAzWSj6xX+1iGbb8AlC5bVCQFO
         QMFOQ5+/qCYJIO4ruK1i9CU0cV/YGqI2J+sVj7Qfp6WGlWLR/Ad0n3LeHDH2p1UUPICV
         soGTAkc1UCmQdobngZcG60VpnQL2Ybexij5JzfaDb1UbI4wymHixnp5uQpvzjJ7o370a
         ocBHDh3mi0vAwrQk5VS+JepnN54H/+txk8Tpx/+CybAYqUNTAzaxSmq8RYpfXoTk0jZL
         VDCMLLctl0pAuxksH9673l46WpZgTfC7IqRgTuCKSIeegcm6Cy0fV5Ned6RFv2toN3Tl
         R0Gw==
X-Gm-Message-State: AOAM532nVdZjgMgX7AyFowpGhUZI9LgEE+brQWDZlGfpbAUW3MAppO3W
        X7JyBzYx0awFdO4vh2dRy0A=
X-Google-Smtp-Source: ABdhPJzKz+NGJseX8rP+io5l1kJdxX0oHx52/WXCPV19pvKpLv64WeF2YrblDplB4m7a47/5iK78bA==
X-Received: by 2002:a05:6e02:1d8a:: with SMTP id h10mr327663ila.20.1627891997677;
        Mon, 02 Aug 2021 01:13:17 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id w14sm6624150ioa.47.2021.08.02.01.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Aug 2021 01:13:16 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id CD36C27C0054;
        Mon,  2 Aug 2021 04:13:15 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 02 Aug 2021 04:13:15 -0400
X-ME-Sender: <xms:GqkHYScu-M7hy0ZulHd9wPobpER6nvew7X8WKagI3I2GH2LyI8qVBw>
    <xme:GqkHYcPMDL-jXV0KwHQmSt7snZXNFLt0BJC7reiLlS1CG0Ezq8MIQzfanltX9OzFi
    jjEvIsavP7l4_Lhtw>
X-ME-Received: <xmr:GqkHYTi5jq0LcMwPZz1YdLl8CCyVodlEzjKv5R2gN79EGdUxgu2WW9XVYt2vRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddriedugddutdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhepveeijedthfeijeefudehhedvveegudegteehgffgtddvuedtveegtedvvdef
    gedtnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhp
    vghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsohhquhhnrd
    hfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:GqkHYf-YsLTa_l-ST0IWIveswnuVuQDIf81H5micEHJ-_k3HKGwYJg>
    <xmx:GqkHYesC_gGgr1SWf2vDFUVj98qcUGfjfmX6W04Fh6nvD-6wwcXTcQ>
    <xmx:GqkHYWH8UAvqUnU-N9oyDvRVSR4LC_BFRIM-WKtJPe3nACZPHU8jJg>
    <xmx:G6kHYeQlwcYIbbBR-5rx5VNSmb0fjritlFZO7fMemNnIyYMl63_HOQK5-Hg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Aug 2021 04:13:14 -0400 (EDT)
Date:   Mon, 2 Aug 2021 16:13:11 +0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
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
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH v6 0/8] PCI: hv: Support host bridge probing on ARM64
Message-ID: <YQepFyKjDr4e5w8Y@boqun-archlinux>
References: <20210726180657.142727-1-boqun.feng@gmail.com>
 <20210727161259.GA718226@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210727161259.GA718226@bjorn-Precision-5520>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Tue, Jul 27, 2021 at 11:12:59AM -0500, Bjorn Helgaas wrote:
> On Tue, Jul 27, 2021 at 02:06:49AM +0800, Boqun Feng wrote:
> > Hi,
> > 
> > This is the v6 for the preparation of virtual PCI support on Hyper-V
> > ARM64, Previous versions:
> > 
> > v1:	https://lore.kernel.org/lkml/20210319161956.2838291-1-boqun.feng@gmail.com/
> > v2:	https://lore.kernel.org/lkml/20210503144635.2297386-1-boqun.feng@gmail.com/
> > v3:	https://lore.kernel.org/lkml/20210609163211.3467449-1-boqun.feng@gmail.com/
> > v4:	https://lore.kernel.org/lkml/20210714102737.198432-1-boqun.feng@gmail.com/
> > v5:	https://lore.kernel.org/lkml/20210720134429.511541-1-boqun.feng@gmail.com/
> 
> Thanks for these; they're very handy for archaeology later.
> 
> > Changes since last version:
> > 
> > *	Rebase to 5.14-rc3
> 
> Just FYI, it's not a problem that you rebased, but it's not necessary.
> These will be applied to a topic branch from v5.14-rc1 anyway.

Got it ;-)

Regards,
Boqun
