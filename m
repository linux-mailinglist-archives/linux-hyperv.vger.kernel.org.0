Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D903F394968
	for <lists+linux-hyperv@lfdr.de>; Sat, 29 May 2021 02:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229541AbhE2ADb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Fri, 28 May 2021 20:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbhE2ADa (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Fri, 28 May 2021 20:03:30 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68574C061574;
        Fri, 28 May 2021 17:01:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=wClK8t5OqOKAJXZRdJ7lK3nU0nLrVWRCjDxwfQ1YPMI=; b=oQEOU/XvSEfv8fMGMn0Ibiyl1G
        LKUmNpGddt8Mx4Rzc2n1OXVQygVaS1Hp3LuerB4w21NGojS/f0EQXiAzFBr1Wx0TXBk0i5ANHtKRJ
        tORl/HV+bZzjqJv3n8eqlqX5CJLFkASF/ji4lMdaKwVqP53Tjac61kBHeZKEj+N4Pu23FcC5xOn+V
        VKRsUwZNciWxbginuPe10cDX1Zs6DbxYi+3erBw1ms7nDb0Venf7+yUudFgO3hPOUQaaubHAgAW5O
        dVL+8ZZzNYUOxpoxQryTugtaikRc03ghdTOD+GqHfFjpcWM5edHLX/2Noj7eqktgzaSJcYUghauEZ
        mvXFD1JQ==;
Received: from [2601:1c0:6280:3f0::ce7d]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lmmQF-001zoQ-B8; Sat, 29 May 2021 00:01:47 +0000
Subject: Re: [PATCH 03/19] drivers/hv: minimal mshv module (/dev/mshv/)
To:     Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, mikelley@microsoft.com,
        viremana@linux.microsoft.com, sunilmut@microsoft.com,
        wei.liu@kernel.org, vkuznets@redhat.com, ligrassi@microsoft.com,
        kys@microsoft.com
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1622241819-21155-4-git-send-email-nunodasneves@linux.microsoft.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <e161e8cc-4d08-8bfd-ab1e-363ed5a39503@infradead.org>
Date:   Fri, 28 May 2021 17:01:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <1622241819-21155-4-git-send-email-nunodasneves@linux.microsoft.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On 5/28/21 3:43 PM, Nuno Das Neves wrote:
> Introduce a barebones module file for the mshv API.
> Introduce CONFIG_HYPERV_ROOT_API for controlling compilation of mshv.
> 
> Co-developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Nuno Das Neves <nunodasneves@linux.microsoft.com>
> ---

Hi,

> diff --git a/drivers/hv/Kconfig b/drivers/hv/Kconfig
> index 66c794d92391..d618b1fab2bb 100644
> --- a/drivers/hv/Kconfig
> +++ b/drivers/hv/Kconfig
> @@ -27,4 +27,22 @@ config HYPERV_BALLOON
>  	help
>  	  Select this option to enable Hyper-V Balloon driver.
>  
> +config HYPERV_ROOT_API
> +	tristate "Microsoft Hypervisor root partition interfaces: /dev/mshv"
> +	depends on HYPERV
> +	help
> +	  Provides access to interfaces for managing guest virtual machines
> +	  running under the Microsoft Hypervisor.
> +
> +	  These interfaces will only work when Linux is running as root
> +	  partition on the Microsoft Hypervisor.
> +
> +	  The interfaces are provided via a device named /dev/mshv.
> +
> +	  To compile this as a module, choose M here.
> +          The module is named mshv.

^^^^^^^^^^^^^

Please follow coding-style for Kconfig files:

(from Documentation/process/coding-style.rst, section 10):

For all of the Kconfig* configuration files throughout the source tree,
the indentation is somewhat different.  Lines under a ``config`` definition
are indented with one tab, while help text is indented an additional two
spaces.

> +
> +	  If unsure, say N.
> +
> +
>  endmenu

thanks.
-- 
~Randy

