Return-Path: <linux-hyperv+bounces-1195-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BCAA803E2B
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 20:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1AEA8B209DC
	for <lists+linux-hyperv@lfdr.de>; Mon,  4 Dec 2023 19:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8342030F9D;
	Mon,  4 Dec 2023 19:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cgoZfdq9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD0B2F864;
	Mon,  4 Dec 2023 19:14:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8608FC433C9;
	Mon,  4 Dec 2023 19:14:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701717269;
	bh=kfWReJzoKyST0mYqrsmPO5P8wLRuTmZubW3mAnPQP1g=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cgoZfdq9gW9Pr9xKC3b01h9h3v8ELo9+WYL+fDpUCEbba0Kz1rfxZrAVrfOiZ5ruo
	 YYDDg+vGo/pozOJAZgQK+y7PQcUAxfjLp6o0Ooy6UQWcHYTSXGnDvlAmy/gGlqd5KB
	 b240NbfpFBWcCsgduQYsKm1O4Dtc0KWopgQSlnpsbNvjKfcpCNbqOnvKX17fn73iuM
	 GyuyUC9MRhbkFtHIt5uMPCk+mnhGG8PoLRI0F+Z2WcSpw3wtlgyziIknClpvQkUn21
	 KheiX6gnBS2zjZ/rNqJwvtF8Mfp/WUhOkqSZIAqDOi1apTQrjxAyT85f3u8xQOv3Zu
	 yD8PBrrw69Wqg==
Date: Mon, 4 Dec 2023 13:14:27 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: linux-kernel@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-hyperv@vger.kernel.org, linux-pci@vger.kernel.org,
	Jan Kara <jack@suse.cz>,
	Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
	Matthew Wilcox <willy@infradead.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
	Alexey Klimov <klimov.linux@gmail.com>,
	Bart Van Assche <bvanassche@acm.org>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v2 14/35] PCI: hv: switch hv_get_dom_num() to use atomic
 find_bit()
Message-ID: <20231204191427.GA623236@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231203193307.542794-13-yury.norov@gmail.com>

On Sun, Dec 03, 2023 at 11:32:46AM -0800, Yury Norov wrote:
> The function traverses bitmap with for_each_clear_bit() just to allocate
> a bit atomically. We can do it better with a dedicated find_and_set_bit().

No objection from me, but please tweak the subject line to match
previous hv history, i.e., capitalize the first word after the prefix:

  PCI: hv: Use atomic find_and_set_bit()

I think there's value in using similar phrasing across the whole
series.  Some subjects say "optimize xyz()", some say "rework xyz()",
some "rework xyz()", etc.  I think it's more informative to include
the "atomic" and "find_bit()" ideas in the subject than the specific
functions that *use* it.

I also like how some of the other commit logs clearly say what the
patch does, e.g., "Simplify by using dedicated find_and_set_bit()", as
opposed to just "We can do it better ..." which technically doesn't
say what the patch does.

Very nice simplification in all these users, thanks for doing it!

I assume you'll merge these all together since they depend on [01/35],
so:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> ---
>  drivers/pci/controller/pci-hyperv.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-hyperv.c b/drivers/pci/controller/pci-hyperv.c
> index 30c7dfeccb16..033b1fb7f4eb 100644
> --- a/drivers/pci/controller/pci-hyperv.c
> +++ b/drivers/pci/controller/pci-hyperv.c
> @@ -3605,12 +3605,9 @@ static u16 hv_get_dom_num(u16 dom)
>  	if (test_and_set_bit(dom, hvpci_dom_map) == 0)
>  		return dom;
>  
> -	for_each_clear_bit(i, hvpci_dom_map, HVPCI_DOM_MAP_SIZE) {
> -		if (test_and_set_bit(i, hvpci_dom_map) == 0)
> -			return i;
> -	}
> +	i = find_and_set_bit(hvpci_dom_map, HVPCI_DOM_MAP_SIZE);
>  
> -	return HVPCI_DOM_INVALID;
> +	return i < HVPCI_DOM_MAP_SIZE ? i : HVPCI_DOM_INVALID;
>  }
>  
>  /**
> -- 
> 2.40.1
> 

