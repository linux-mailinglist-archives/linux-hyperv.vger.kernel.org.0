Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288BE436747
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Oct 2021 18:08:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbhJUQK6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 21 Oct 2021 12:10:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:37062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230103AbhJUQK5 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 21 Oct 2021 12:10:57 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1AEFD611CB;
        Thu, 21 Oct 2021 16:08:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634832521;
        bh=3wcwNbtDNknQedZoy24cZfK1CiOqshIYIk3e2c4B9Rw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XWhJ08GGIqTZw+TvT/nMCDAy7quf2FJv33jj0Ily06vxkI8rUxTQELDkeHb0u+NFl
         MD0Lx9+x7lhMM3GIAZfA1T2u0eNmQAG1bqpXTvz67evSI6p28cRymuvwfzx0MmCdPZ
         Eu9kyx0IRx+BQHrjfg6pUkXIBKHVfUT3rJ6PyHjkKsGXSiMQ2s0MWrlq5f/6WPUXfA
         12KC4ZTUvETH0cKn32kcKsPv7RGUIftWATLF8XYn+cHxWi3nvl7PC2jb98L+8EJMFN
         xtCzC0AmpDoL2r37xWXDC3EUt/EyyEmL8iLEASXb2kkCdjx5XS/xqqOzJAGW3sGtIs
         FzUF2rqmMe78Q==
Received: by pali.im (Postfix)
        id D8DB085E; Thu, 21 Oct 2021 18:08:38 +0200 (CEST)
Date:   Thu, 21 Oct 2021 18:08:38 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Naveen Naidu <naveennaidu479@gmail.com>
Cc:     bhelgaas@google.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, Rob Herring <robh@kernel.org>,
        skhan@linuxfoundation.org, Robert Richter <rric@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        "maintainer:BROADCOM IPROC ARM ARCHITECTURE" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Jianjun Wang <jianjun.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Shawn Guo <shawn.guo@linaro.org>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Joyce Ooi <joyce.ooi@intel.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jonathan Derrick <jonathan.derrick@linux.dev>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Amey Narkhede <ameynarkhede03@gmail.com>,
        Russell Currey <ruscur@russell.cc>,
        Oliver O'Halloran <oohall@gmail.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Marc Zyngier <maz@kernel.org>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Toan Le <toan@os.amperecomputing.com>
Subject: Re: [PATCH v3 01/25] PCI: Add PCI_ERROR_RESPONSE and it's related
 definitions
Message-ID: <20211021160838.r7t7fmmeseaecfac@pali>
References: <cover.1634825082.git.naveennaidu479@gmail.com>
 <f7960a4dee0e417eedd7d2e031d04ac9016c6686.1634825082.git.naveennaidu479@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f7960a4dee0e417eedd7d2e031d04ac9016c6686.1634825082.git.naveennaidu479@gmail.com>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thursday 21 October 2021 20:37:26 Naveen Naidu wrote:
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

Reviewed-by: Pali Rohár <pali@kernel.org>

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
> +
>  /*
>   * pci_power_t values must match the bits in the Capabilities PME_Support
>   * and Control/Status PowerState fields in the Power Management capability.
> -- 
> 2.25.1
> 
