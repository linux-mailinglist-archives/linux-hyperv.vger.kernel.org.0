Return-Path: <linux-hyperv-owner@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55C2A30FBC2
	for <lists+linux-hyperv@lfdr.de>; Thu,  4 Feb 2021 19:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbhBDSlb (ORCPT <rfc822;lists+linux-hyperv@lfdr.de>);
        Thu, 4 Feb 2021 13:41:31 -0500
Received: from mail-wm1-f44.google.com ([209.85.128.44]:34789 "EHLO
        mail-wm1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238782AbhBDSj1 (ORCPT
        <rfc822;linux-hyperv@vger.kernel.org>);
        Thu, 4 Feb 2021 13:39:27 -0500
Received: by mail-wm1-f44.google.com with SMTP id o10so6472597wmc.1;
        Thu, 04 Feb 2021 10:39:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3Bu3tpqlL0TzsMYLFu8iWOAryYWVnd5+YG1LX0UHDPQ=;
        b=o6xFZTJwJehJ7EoTGclD4//KBHh/D2eB8UJDefIL7sMRdCfXujn93aNK4h22pggznq
         NZAWNsOtukpPKM+pxMF3T6sazZzCGc+DfyKvPKfDU5GYm35vAguJQZ6bEVFUYoE1dB+s
         bHKWLfcpIBWKNDmcO3RNyUpAIRcLgxWs0YxxsM4w216kAspp7jujVrCQmUFxJgdUcjq4
         8XsWwKn4nklhhYFdxo0AS4HyeWjTO/cqBuaIbUpnbvVv7To9SQtvbdbJjR1sx7HTghfv
         0BNP+CptC8NNZzg0qPrw9TuQLCdpoom2/kJhbpgsvLhVFozd/rtoF3Ie6pEcCT4HLcpb
         LCxA==
X-Gm-Message-State: AOAM530sRWtLkCIYvB1cpyyKkWsHAqEnYKOTvuULdOSOTqOPiiuG2+iq
        ZyBPxdeEBuBbrqhzkEHNsxJ+0SUtPU4=
X-Google-Smtp-Source: ABdhPJzLgBnSvTmHL4w+FbG10WXayLpJVzF0JC2gGeVnqKAPgXTqM+wkqU8kNPlQZasMRVax1MCDFA==
X-Received: by 2002:a1c:a546:: with SMTP id o67mr433285wme.151.1612463923713;
        Thu, 04 Feb 2021 10:38:43 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([51.145.34.42])
        by smtp.gmail.com with ESMTPSA id z1sm9325938wru.70.2021.02.04.10.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 10:38:43 -0800 (PST)
Date:   Thu, 4 Feb 2021 18:38:41 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Cc:     virtualization@lists.linux-foundation.org,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Michael Kelley <mikelley@microsoft.com>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Sunil Muthuswamy <sunilmut@microsoft.com>,
        Nuno Das Neves <nunodasneves@linux.microsoft.com>,
        pasha.tatashin@soleen.com, Wei Liu <wei.liu@kernel.org>,
        Robert Moore <robert.moore@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Len Brown <lenb@kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" 
        <linux-acpi@vger.kernel.org>,
        "open list:ACPI COMPONENT ARCHITECTURE (ACPICA)" <devel@acpica.org>
Subject: Re: [PATCH v6 08/16] ACPI / NUMA: add a stub function for
 node_to_pxm()
Message-ID: <20210204183841.y4fgwjuggtbrnere@liuwe-devbox-debian-v2>
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-9-wei.liu@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210203150435.27941-9-wei.liu@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-hyperv.vger.kernel.org>
X-Mailing-List: linux-hyperv@vger.kernel.org

On Wed, Feb 03, 2021 at 03:04:27PM +0000, Wei Liu wrote:
> There is already a stub function for pxm_to_node but conversion to the
> other direction is missing.
> 
> It will be used by Microsoft Hypervisor code later.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>

Hi ACPI maintainers, if you're happy with this patch I can take it via
the hyperv-next tree, given the issue is discovered when pxm_to_node is
called in our code.

> ---
> v6: new
> ---
>  include/acpi/acpi_numa.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> index a4c6ef809e27..40a91ce87e04 100644
> --- a/include/acpi/acpi_numa.h
> +++ b/include/acpi/acpi_numa.h
> @@ -30,6 +30,10 @@ static inline int pxm_to_node(int pxm)
>  {
>  	return 0;
>  }
> +static inline int node_to_pxm(int node)
> +{
> +	return 0;
> +}
>  #endif				/* CONFIG_ACPI_NUMA */
>  
>  #ifdef CONFIG_ACPI_HMAT
> -- 
> 2.20.1
> 
