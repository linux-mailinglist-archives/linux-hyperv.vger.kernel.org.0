Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A352456468
	for <lists+linux-hyperv@lfdr.de>; Thu, 18 Nov 2021 21:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbhKRUrX (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 18 Nov 2021 15:47:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:34004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232565AbhKRUrX (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 18 Nov 2021 15:47:23 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 475F96128C;
        Thu, 18 Nov 2021 20:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637268262;
        bh=sVeugOXOThpr87Zi3LpkKeS4dLNuxTnnYlOPOREQuJ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Jb8casGJHw1GPw52ROWvElXI1Y3Ol4NorSB8tY4VFUWAsxhMhJw1eGg8yeeDOl3HL
         1gEwn+J/Nwj3oOgX2oyUA2qOkyE/QgPMADTRcCzD9yMiYgcjYUYDgq+dL2TdYrZkrO
         DdUxiQel6roOXC65gdhkzxUJk9jgL+XYK9S7+j+2lkQ1K/Kzq9TxQ0cGLh3BqCmPU8
         SJQVIITH1U7ML7B0BhEONKb9SbGnIRmDeuojCtWd98bXE7wmEYbfbkzXsfTzGIULyP
         C+fXuO7dL5eKt7rtZyOn/GSS+MoJ67VMC4nYz5UwIajXf0XXzbE3KqP5TeTFwOTboQ
         1i0TF1Z0kO7nA==
Date:   Thu, 18 Nov 2021 14:44:21 -0600
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
        Kishon Vijay Abraham I <kishon@ti.com>,
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
Subject: Re: [PATCH v4 00/25] Unify PCI error response checking
Message-ID: <20211118204421.GA1881943@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1637243717.git.naveennaidu479@gmail.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Thu, Nov 18, 2021 at 07:33:10PM +0530, Naveen Naidu wrote:
> An MMIO read from a PCI device that doesn't exist or doesn't respond
> causes a PCI error.  There's no real data to return to satisfy the 
> CPU read, so most hardware fabricates ~0 data.
> 
> This patch series adds PCI_ERROR_RESPONSE definition and other helper
> definition PCI_SET_ERROR_RESPONSE and PCI_POSSIBLE_ERROR and uses it
> where appropriate to make these checks consistent and easier to find.
> 
> This helps unify PCI error response checking and make error check
> consistent and easier to find.
> 
> This series also ensures that the error response fabrication now happens
> in the PCI_OP_READ and PCI_USER_READ_CONFIG. This removes the
> responsibility from controller drivers to do the error response setting. 

Applied to pci/error for v5.17.  Thanks, this is really nice work.
Somehow small changes like these add up to something much greater than
one would expect.

This touches many native controller drivers but in trivial ways, so I
plan to merge this branch after the usual native controller stuff from
Lorenzo.

I tweaked the commit logs to clarify that this series is all about
*config* reads, not MMIO reads.  MMIO reads have similar issues, and
we can use PCI_ERROR_RESPONSE, etc., there, too, but that's not what
this series does.

Bjorn
