Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC0345515A
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Nov 2021 00:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241749AbhKRABW (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 17 Nov 2021 19:01:22 -0500
Received: from mail.kernel.org ([198.145.29.99]:59276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241730AbhKRABN (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 17 Nov 2021 19:01:13 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id C8D5A61AD2;
        Wed, 17 Nov 2021 23:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637193494;
        bh=jt1bptChpIJAfJm7hhcvnL0z6T39eDJjHsyLzG8zD1Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=lyKjNjZh0qOCqIMVIpeRoNDwhdUJ/tL20BWpiwNwGttOe0RfGC7KJ4PhUovOify8k
         CPIwK9uSUQMg7VMxx+ystTmi5eBYFIkTtVD4sE8ulLOvbgkfTXGOpyI5/5ntrQgvl0
         CfZ1WfNlECodqxIGcyQGBzURqYPwL89BjB4irtfrZDGz99G0bGiOvyoqAHp04d3fBv
         aBxC568xp2R7kzM9biPqbt5SZcYkGOgkMTsagR6oWZfjlJq8OfZ4tIYBwT1Dm+Bjb+
         xfWKIqeKqVbpwaZ3tBQdETriNpArC0Ads/tlo1ukjZbgXjypi2+h68mtdIpt5Dhoxd
         4UKc+KstDfPQQ==
Date:   Wed, 17 Nov 2021 17:58:12 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
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
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v3 01/25] PCI: Add PCI_ERROR_RESPONSE and it's related
 definitions
Message-ID: <20211117235812.GA1786428@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7960a4dee0e417eedd7d2e031d04ac9016c6686.1634825082.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Oct 21, 2021 at 08:37:26PM +0530, Naveen Naidu wrote:
> An MMIO read from a PCI device that doesn't exist or doesn't respond
> causes a PCI error.  There's no real data to return to satisfy the
> CPU read, so most hardware fabricates ~0 data.
> 
> Add a PCI_ERROR_RESPONSE definition for that and use it where
> appropriate to make these checks consistent and easier to find.
> 
> Also add helper definitions SET_PCI_ERROR_RESPONSE and
> RESPONSE_IS_PCI_ERROR to make the code more readable.
> 
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Naveen Naidu <naveennaidu479@gmail.com>
> ---
>  include/linux/pci.h | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index cd8aa6fce204..689c8277c584 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -154,6 +154,15 @@ enum pci_interrupt_pin {
>  /* The number of legacy PCI INTx interrupts */
>  #define PCI_NUM_INTX	4
>  
> +/*
> + * Reading from a device that doesn't respond typically returns ~0.  A
> + * successful read from a device may also return ~0, so you need additional
> + * information to reliably identify errors.
> + */
> +#define PCI_ERROR_RESPONSE     (~0ULL)
> +#define SET_PCI_ERROR_RESPONSE(val)    (*(val) = ((typeof(*(val))) PCI_ERROR_RESPONSE))
> +#define RESPONSE_IS_PCI_ERROR(val) ((val) == ((typeof(val)) PCI_ERROR_RESPONSE))

Beautiful!  I really like this.

I would prefer the macros to start with "PCI_", e.g.,
PCI_SET_ERROR_RESPONSE().

I think "RESPONSE_IS_PCI_ERROR()" is too strong because (as the
comment says), ~0 *may* indicate an error.  Or it may be a successful
read of a register that happens to contain ~0.

Possibilities to convey the idea that this isn't definitive:

  PCI_POSSIBLE_ERROR_RESPONSE(val)  # a little long
  PCI_LIKELY_ERROR(val)             # we really have no idea whether
  PCI_PROBABLE_ERROR(val)           #   likely or probable
  PCI_POSSIBLE_ERROR(val)           # promising?

Can you rebase to my "main" branch (v5.16-rc1), tweak the above, and
collect up the acks/reviews?

We should also browse drivers outside drivers/pci for places we could
use these.  Not necessarily as part of this series, although if
authors there object, it would be good to learn that earlier than
later.

Drivers that implement pci_error_handlers might be a fruitful place to
start.  But you've done a great job finding users of ~0 and 0xffff...
in drivers/pci/, too.

> +
>  /*
>   * pci_power_t values must match the bits in the Capabilities PME_Support
>   * and Control/Status PowerState fields in the Power Management capability.
> -- 
> 2.25.1
> 
> _______________________________________________
> Linux-kernel-mentees mailing list
> Linux-kernel-mentees@lists.linuxfoundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/linux-kernel-mentees
