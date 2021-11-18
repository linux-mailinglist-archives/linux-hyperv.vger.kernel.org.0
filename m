Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41778455CAE
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Nov 2021 14:30:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231214AbhKRNd5 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Nov 2021 08:33:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbhKRNd5 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Nov 2021 08:33:57 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7ADC061570;
        Thu, 18 Nov 2021 05:30:57 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id x7so5178191pjn.0;
        Thu, 18 Nov 2021 05:30:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Rri8CgMU3iUgw+czpevbWjMbr1UWm75xhAwXD02I6xU=;
        b=FDEnvL+UtpoLRk6Q1zJ5TWKgN3pkejoc+c1lfiUwMmvGmldi6KxwZO1grB8bUwgggl
         NxymJ9lCNeYeShRKPCEoAFb/qyeXIlHXW6H9LhjrDZVVUGNirPbyJuI24LirczSzl/Na
         OK380QfTTMyJLsiytjnQRYSmo9aAci9N0vFC8VP0JB29tQt8eoW/ggKIxCPmK5+dxsXW
         XwurEenZVOh5wEwUMaPPAASeHd9USOigFhhHFenuvMmC1EPdDlgUL2LZwm9an0CE8meS
         Rv6YcVKeQnHd4N1kacEKQoyflUzVHPAi/1nTgQ8d8eBhHJHyNrVBYPckBm/kGT11HH/L
         8L/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Rri8CgMU3iUgw+czpevbWjMbr1UWm75xhAwXD02I6xU=;
        b=a5WFdMRvp59jhSVUzUa3eYMxNzpW8Q7md3s6YaaeYv6B7nGagPp3xNDSe4S4qzCcDB
         gBgod+Jv66g2t1uVbtTBcWfu56FEb2SvMdkW9UbcqDaaWZWmFtFOZ5Q7wCw0uL+Zw6Hm
         IghIgj2G1L4KmyLCtUwbdzVkjgNZGZpSU3WDkUJLGykHb4eXCPONhs62AT+Uu1McOUip
         f+kNo3TvJFpDzMAhz0fmhzqn+du/F08d8iXWR/w3Xju+3GIxnkfqBOn6W0OyoaVr/yg3
         tKrjAsDs+UFzd9UndqdMEaPldoGAqp09Lm0u/P77JE0LHcd4FS8z1ORSjNkMMiNvNVzI
         u3Rg==
X-Gm-Message-State: AOAM532rTZkZbHnxzyYK6ahZXygsGr1UCOQsit2BEcvyF7POV9Q2O9CW
        pOFUIE4dfDh9KMbfoOEtVqvNVkNSa113nkgB
X-Google-Smtp-Source: ABdhPJw603nbU+O/fPHP8RoT4nn8P5boytORpwShOu3KLVJrVk3lFo3z0RQCNEqj18u5XFcu5Q1lpg==
X-Received: by 2002:a17:90a:df14:: with SMTP id gp20mr10690696pjb.186.1637242256451;
        Thu, 18 Nov 2021 05:30:56 -0800 (PST)
Received: from theprophet ([2406:7400:63:2c47:5ffe:fc34:61f0:f1ea])
        by smtp.gmail.com with ESMTPSA id z19sm3624615pfe.181.2021.11.18.05.30.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 05:30:56 -0800 (PST)
Date:   Thu, 18 Nov 2021 19:00:20 +0530
From:   Naveen Naidu <naveennaidu479@gmail.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     bhelgaas@google.com,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        linux-hyperv@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>,
        linux-pci@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Russell Currey <ruscur@russell.cc>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Toan Le <toan@os.amperecomputing.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Rob Herring <robh@kernel.org>, Wei Liu <wei.liu@kernel.org>,
        linux-samsung-soc@vger.kernel.org, Marc Zyngier <maz@kernel.org>,
        Joyce Ooi <joyce.ooi@intel.com>,
        Dexuan Cui <decui@microsoft.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        linux-rockchip@lists.infradead.org,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Robert Richter <rric@kernel.org>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Ray Jui <rjui@broadcom.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        linux-arm-kernel@lists.infradead.org,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Scott Branden <sbranden@broadcom.com>,
        linuxppc-dev@lists.ozlabs.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lukas Wunner <lukas@wunner.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
Subject: Re: [PATCH v3 01/25] PCI: Add PCI_ERROR_RESPONSE and it's related
 definitions
Message-ID: <20211118133020.nkr3xzbzonxtrqbw@theprophet>
References: <f7960a4dee0e417eedd7d2e031d04ac9016c6686.1634825082.git.naveennaidu479@gmail.com>
 <20211117235812.GA1786428@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211117235812.GA1786428@bhelgaas>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 17/11, Bjorn Helgaas wrote:
> On Thu, Oct 21, 2021 at 08:37:26PM +0530, Naveen Naidu wrote:
> > An MMIO read from a PCI device that doesn't exist or doesn't respond
> > causes a PCI error.  There's no real data to return to satisfy the
> > CPU read, so most hardware fabricates ~0 data.
> > 
> > Add a PCI_ERROR_RESPONSE definition for that and use it where
> > appropriate to make these checks consistent and easier to find.
> > 
> > Also add helper definitions SET_PCI_ERROR_RESPONSE and
> > RESPONSE_IS_PCI_ERROR to make the code more readable.
> > 
> > Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> > Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> > ---
> >  include/linux/pci.h | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index cd8aa6fce204..689c8277c584 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -154,6 +154,15 @@ enum pci_interrupt_pin {
> >  /* The number of legacy PCI INTx interrupts */
> >  #define PCI_NUM_INTX	4
> >  
> > +/*
> > + * Reading from a device that doesn't respond typically returns ~0.  A
> > + * successful read from a device may also return ~0, so you need additional
> > + * information to reliably identify errors.
> > + */
> > +#define PCI_ERROR_RESPONSE     (~0ULL)
> > +#define SET_PCI_ERROR_RESPONSE(val)    (*(val) = ((typeof(*(val))) PCI_ERROR_RESPONSE))
> > +#define RESPONSE_IS_PCI_ERROR(val) ((val) == ((typeof(val)) PCI_ERROR_RESPONSE))
> 
> Beautiful!  I really like this.
>

Thank you very much for the review ^^

> I would prefer the macros to start with "PCI_", e.g.,
> PCI_SET_ERROR_RESPONSE().
> 

ACK

> I think "RESPONSE_IS_PCI_ERROR()" is too strong because (as the
> comment says), ~0 *may* indicate an error.  Or it may be a successful
> read of a register that happens to contain ~0.
> 
> Possibilities to convey the idea that this isn't definitive:
> 
>   PCI_POSSIBLE_ERROR_RESPONSE(val)  # a little long
>   PCI_LIKELY_ERROR(val)             # we really have no idea whether
>   PCI_PROBABLE_ERROR(val)           #   likely or probable
>   PCI_POSSIBLE_ERROR(val)           # promising?
>

ACK. Will use PCI_POSSIBLE_ERROR()

> Can you rebase to my "main" branch (v5.16-rc1), tweak the above, and
> collect up the acks/reviews?
> 

ACK

> We should also browse drivers outside drivers/pci for places we could
> use these.  Not necessarily as part of this series, although if
> authors there object, it would be good to learn that earlier than
> later.
> 
> Drivers that implement pci_error_handlers might be a fruitful place to
> start.  But you've done a great job finding users of ~0 and 0xffff...
> in drivers/pci/, too.
> 

A quick grep showed that there are around 80 drivers which have
pci_error_handlers. I was thinking that it would be better if we handle
these drivers in another patch series since the current patch series is
itself 25 patches long. And in my short tenure reading LKML, I gathered
that folks generally are not so kind to a long list of patches in a
single patch series ^^' (I might be wrong though, Apologies)

The consensus on the patch series does seem slightly positive so
ideally, I was hoping that we would not have the case where a author
does not like the way we are handling this patch. Then again, I'm
pretty sure that I might be wrong ^^'

I hope it would be okay that I send in a new patch series with the
suggested changes and handle the other changes in another patch series
^^

Thanks,
Naveen
> > +
> >  /*
> >   * pci_power_t values must match the bits in the Capabilities PME_Support
> >   * and Control/Status PowerState fields in the Power Management capability.
> > -- 
> > 2.25.1
> > 
> > _______________________________________________
> > Linux-kernel-mentees mailing list
> > Linux-kernel-mentees@lists.linuxfoundation.org
> > https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
