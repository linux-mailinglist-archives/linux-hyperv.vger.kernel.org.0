Return-Path: <linux-hyperv+bounces-1350-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7311816B91
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Dec 2023 11:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8490128107D
	for <lists+linux-hyperv@lfdr.de>; Mon, 18 Dec 2023 10:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2447A199A5;
	Mon, 18 Dec 2023 10:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/bqz4w3"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F332C199A0;
	Mon, 18 Dec 2023 10:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9506C433C7;
	Mon, 18 Dec 2023 10:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702896631;
	bh=THORXsmMa6FFpWqOaSlLmLtFa2iBR+EvaN2a3Bv/bvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F/bqz4w3xrPcbxShtoRWGnwPA2HHAV9Ia2rVB5jnhQs+uvIWcrIesqUFVlENSonuI
	 e+b/SxrhRPS3XPcUJFpyJLiO90SonsrKtPtSAYnP6waBUa5bvFHta1GpEa8IyZq9XY
	 RC1+KUjyLnR7s7BvwfQxMaavZOV0rwXaz7dBcT/0Af05NBLSx9dCkDIRL0vZyGLL0y
	 rOCqnOVG4w3k5QS9CrSORoVYC9W2Pflis8k5mIsE3fBKQ+4vugEiyyc/ky3fVDivcP
	 r16cemzoOLtoF0GLC1v0MQDsSpXEgaLHH5C8sfSt38HFCofryhhKNvY6UgA8/C18rp
	 K77+BXXHCvdGw==
Date: Mon, 18 Dec 2023 10:50:26 +0000
From: Simon Horman <horms@kernel.org>
To: Yury Norov <yury.norov@gmail.com>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: mana: select PAGE_POOL
Message-ID: <20231218105026.GB6288@kernel.org>
References: <20231215203353.635379-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231215203353.635379-1-yury.norov@gmail.com>

On Fri, Dec 15, 2023 at 12:33:53PM -0800, Yury Norov wrote:
> Mana uses PAGE_POOL API. x86_64 defconfig doesn't select it:
> 
> ld: vmlinux.o: in function `mana_create_page_pool.isra.0':
> mana_en.c:(.text+0x9ae36f): undefined reference to `page_pool_create'
> ld: vmlinux.o: in function `mana_get_rxfrag':
> mana_en.c:(.text+0x9afed1): undefined reference to `page_pool_alloc_pages'
> make[3]: *** [/home/yury/work/linux/scripts/Makefile.vmlinux:37: vmlinux] Error 1
> make[2]: *** [/home/yury/work/linux/Makefile:1154: vmlinux] Error 2
> make[1]: *** [/home/yury/work/linux/Makefile:234: __sub-make] Error 2
> make[1]: Leaving directory '/home/yury/work/build-linux-x86_64'
> make: *** [Makefile:234: __sub-make] Error 2
> 
> So we need to select it explicitly.
> 
> Signed-off-by: Yury Norov <yury.norov@gmail.com>

Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Simon Horman <horms@kernel.org> # build-tested

