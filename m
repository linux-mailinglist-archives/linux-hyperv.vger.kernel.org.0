Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CA20A0D89
	for <lists+linux-hyperv@lfdr.de>; Thu, 29 Aug 2019 00:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726907AbfH1W0V (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Wed, 28 Aug 2019 18:26:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:57892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726828AbfH1W0V (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Wed, 28 Aug 2019 18:26:21 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6580A217F5;
        Wed, 28 Aug 2019 22:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567031180;
        bh=nh/Cp1V3gNlbWJY+TFHAxN8PnPYse/LGeF2iYlhuYr0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y19PaU3SJXWC5Jbbcdbffp+tIBXD/MaU3idWNPVC1i9/TYyH5mH3cGqpAhUPTgQB6
         z/VKY/ron/skTmRO6tRYfYvUNLQMpKkEGmit8DxkT7py4vHms/0/79RjxNGBRJImT8
         BHfPqMmItT6H6/p8Vo6LWWdZk6cj0ZJX9dzDxhBc=
Date:   Wed, 28 Aug 2019 17:26:18 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof Wilczynski <kw@linux.com>
Cc:     "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Sasha Levin <sashal@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hyperv@vger.kernel.org
Subject: Re: [PATCH] PCI: hv: Make functions only used locally static in
 pci-hyperv.c
Message-ID: <20190828222618.GE7013@google.com>
References: <20190826154159.9005-1-kw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190826154159.9005-1-kw@linux.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-hyperv-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

Maybe just:

  PCI: hv: Make functions static

since we already know it's in pci-hyperv.c, and it's obvious that you
can only do this for functions that are only used locally.

On Mon, Aug 26, 2019 at 05:41:59PM +0200, Krzysztof Wilczynski wrote:
> Functions hv_read_config_block(), hv_write_config_block()
> and hv_register_block_invalidate() are not used anywhere
> else and are local to drivers/pci/controller/pci-hyperv.c,
> and do not need to be in global scope, so make these static.
> 
> Resolve compiler warning that can be seen when building with
> warnings enabled (W=1).

Rewrap commit log to fill 75 columns.

Does this fix all the similar warnings in drivers/pci/?  If there are
more, maybe we could fix them all in a single patch or at least a
single series?

> Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index f1f300218fab..c9642e429c2d 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -930,7 +930,7 @@ static void hv_pci_read_config_compl(void *context, struct pci_response *resp,
>   *
>   * Return: 0 on success, -errno on failure
>   */
> -int hv_read_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
> +static int hv_read_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
>  			 unsigned int block_id, unsigned int *bytes_returned)
>  {
>  	struct hv_pcibus_device *hbus =
> @@ -1010,7 +1010,7 @@ static void hv_pci_write_config_compl(void *context, struct pci_response *resp,
>   *
>   * Return: 0 on success, -errno on failure
>   */
> -int hv_write_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
> +static int hv_write_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
>  			  unsigned int block_id)
>  {
>  	struct hv_pcibus_device *hbus =
> @@ -1079,7 +1079,7 @@ int hv_write_config_block(struct pci_dev *pdev, void *buf, unsigned int len,
>   *
>   * Return: 0 on success, -errno on failure
>   */
> -int hv_register_block_invalidate(struct pci_dev *pdev, void *context,
> +static int hv_register_block_invalidate(struct pci_dev *pdev, void *context,
>  				 void (*block_invalidate)(void *context,
>  							  u64 block_mask))
>  {
> -- 
> 2.22.1
> 
