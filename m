Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5204298B2
	for <lists+linux-hyperv@lfdr.de>; Mon, 11 Oct 2021 23:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235193AbhJKVP6 (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Mon, 11 Oct 2021 17:15:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:41330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231994AbhJKVP6 (ORCPT <rfc822;linux-hyperv@vger.kernel.org>);
        Mon, 11 Oct 2021 17:15:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A875360E78;
        Mon, 11 Oct 2021 21:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633986838;
        bh=blg+VYtvSu5Pr5+yOmFCnDpo/ep2Cm5P4E/L6neXHzw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=W9odjvXGmU08ITxGsuD5h6w+0VRUMh5sMkxWkHsHH6VAfJHBYoxDy23okIGvbg7/S
         rreUvfFTkgrGH4HbrjdHeQu20tjE1iGNsuFAN48MvN3g0NlKhBkGCmPmlU8+6HXIZc
         kfeqymosmvouNEwyejfU6pktJEysFR8OnFERr0EaQpnJED0JSAphXPwS0DLx4UK6xY
         EfK5NJbA8W4qg+ToFHJIE8J0tGG4HXH3OSbCO/nLFkpkPxmZPA/TIEhaf1saly3gfw
         9FaASI5Ij6O3QuqR8ls+9Xr8E7XPPTcg5+Rz3DAPR5uTPrOL5EF9gJ3im/VZ3rBQrn
         fwuVR3C1OS4Zg==
Date:   Mon, 11 Oct 2021 16:13:56 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Long Li <longli@microsoft.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] PCI: iov: Update format string type to match
 variable type
Message-ID: <20211011211356.GA1692323@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211008222732.2868493-2-kw@linux.com>
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Fri, Oct 08, 2021 at 10:27:31PM +0000, Krzysztof Wilczyński wrote:
> Functions pci_iov_sysfs_link() and pci_iov_remove_virtfn() take
> a Virtual Function (VF) ID as an integer value and then use it to
> assemble the desired name for the corresponding sysfs attribute (a
> symbolic link in this case).

It's not really clear to me that "int" is the correct type for the VF
ID.  pci_iov_add_virtfn() is declared to take an int, but
sriov_add_vfs() passes as unsigned int, which I think probably makes
more sense unless there's some interface that may return either a VF
ID or an error.

NumVFs in the SR-IOV Capability is only 16 bits wide, so I guess
either mostly works...

> Internally, both functions use sprintf() to create the desired attribute
> name, and leverage the "%u" modifier as part of the format string used
> to do so.  However, the VF ID is passed to both functions as a signed
> integer type variable, which makes the variable type and format string
> modifier somewhat incompatible.
> 
> Thus, change the modifier used in the format string to "%d" to better
> match the variable type.
> 
> No change to functionality intended.
> 
> Signed-off-by: Krzysztof Wilczyński <kw@linux.com>
> ---
>  drivers/pci/iov.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/iov.c b/drivers/pci/iov.c
> index dafdc652fcd0..056bba3b4236 100644
> --- a/drivers/pci/iov.c
> +++ b/drivers/pci/iov.c
> @@ -140,7 +140,7 @@ int pci_iov_sysfs_link(struct pci_dev *dev,
>  	char buf[VIRTFN_ID_LEN];
>  	int rc;
>  
> -	sprintf(buf, "virtfn%u", id);
> +	sprintf(buf, "virtfn%d", id);
>  	rc = sysfs_create_link(&dev->dev.kobj, &virtfn->dev.kobj, buf);
>  	if (rc)
>  		goto failed;
> @@ -322,7 +322,7 @@ void pci_iov_remove_virtfn(struct pci_dev *dev, int id)
>  	if (!virtfn)
>  		return;
>  
> -	sprintf(buf, "virtfn%u", id);
> +	sprintf(buf, "virtfn%d", id);
>  	sysfs_remove_link(&dev->dev.kobj, buf);
>  	/*
>  	 * pci_stop_dev() could have been called for this virtfn already,
> -- 
> 2.33.0
> 
