Return-Path: <linux-hyperv+bounces-1937-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED9A889BDC0
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Apr 2024 13:07:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE8D1F226D3
	for <lists+linux-hyperv@lfdr.de>; Mon,  8 Apr 2024 11:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAADA6518F;
	Mon,  8 Apr 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nByh4qB0"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6355FB8F;
	Mon,  8 Apr 2024 11:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712574454; cv=none; b=Vlt6gDLKffoyJKU9P1bzesROtLbsECTZ7m2Btur6VOM7HWWXQrGi+Hnh8kwpwSm7wflsyGe4Cfbkzw8vzMa7+qdo6VoblREGCTfV+rPpAr8bqhRvtKKp7u3OcAy2KFnV3eXtzK8cnzq2EA5nEvNWIFaanjFnl5Oae7abcqZSnhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712574454; c=relaxed/simple;
	bh=R2LuuhSb8d6q3LtxSsHfHd/kQABTJ1jxxQJ/ujhQYfg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WyLIMGHVj42/HKhQyZURVyaCFPiWnI/yiySUmVN0W0hya83f8MyMae2HEoVHce9EocmMwyX1+Wj1bq4jPQX4PaEtqhItBOP6vYngHc2xZXGAdqTUSsiNOP3pmNRpFsQeT+11Q5Us0exeTyTSd4ISV2oB7nMY769GexIUg961cbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nByh4qB0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F33AC433F1;
	Mon,  8 Apr 2024 11:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712574454;
	bh=R2LuuhSb8d6q3LtxSsHfHd/kQABTJ1jxxQJ/ujhQYfg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nByh4qB0rdSeeOibjSvCimXfcV/qAR7lbkNljjj77K8nA+Oj7E/oM3toKo88czV+8
	 9rxlZFwLtCElIPO4Z8Sqd8Txi3ZQABfDJxi+ROUR3NXvwN1+qpl9xfRhhZX3VRpMGV
	 7olUd5uOgTdIXHrdPLNuHkF79Hfcc8Ox/K2OTfe7g4gwCI9t68JcexnDji9plBCvdD
	 RnOazez5g2lcqCZGMDMXNkx9+sOMsHIsdQC3bVFCG362slU0ZVxBo4DkktEK5fbCHq
	 sEGEC+JlIMcl+zuAep24ICZzrrb/+j+HGFFI1wM4dCHDfQ1GHcYjhxnK1c+8QK2A0v
	 zAS2hdWoWm87g==
Date: Mon, 8 Apr 2024 14:07:30 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Erick Archer <erick.archer@outlook.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: Long Li <longli@microsoft.com>, Ajay Sharma <sharmaajay@microsoft.com>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Shradha Gupta <shradhagupta@linux.microsoft.com>,
	Konstantin Taranov <kotaranov@microsoft.com>,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v3 0/3] RDMA/mana_ib: Add flex array to struct
 mana_cfg_rx_steer_req_v2
Message-ID: <20240408110730.GE8764@unreal>
References: <AS8PR02MB72374BD1B23728F2E3C3B1A18B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AS8PR02MB72374BD1B23728F2E3C3B1A18B022@AS8PR02MB7237.eurprd02.prod.outlook.com>

On Sat, Apr 06, 2024 at 04:23:34PM +0200, Erick Archer wrote:
> The "struct mana_cfg_rx_steer_req_v2" uses a dynamically sized set of
> trailing elements. Specifically, it uses a "mana_handle_t" array. So,
> use the preferred way in the kernel declaring a flexible array [1].
> 
> At the same time, prepare for the coming implementation by GCC and Clang
> of the __counted_by attribute. Flexible array members annotated with
> __counted_by can have their accesses bounds-checked at run-time via
> CONFIG_UBSAN_BOUNDS (for array indexing) and CONFIG_FORTIFY_SOURCE (for
> strcpy/memcpy-family functions).
> 
> Also, avoid the open-coded arithmetic in the memory allocator functions
> [2] using the "struct_size" macro.
> 
> Moreover, use the "offsetof" helper to get the indirect table offset
> instead of the "sizeof" operator and avoid the open-coded arithmetic in
> pointers using the new flex member. This new structure member also allow
> us to remove the "req_indir_tab" variable since it is no longer needed.
> 
> Now, it is also possible to use the "flex_array_size" helper to compute
> the size of these trailing elements in the "memcpy" function.
> 
> Specifically, the first commit adds the flex member and the patches 2 and
> 3 refactor the consumers of the "struct mana_cfg_rx_steer_req_v2".
> 
> This code was detected with the help of Coccinelle, and audited and
> modified manually. The Coccinelle script used to detect this code pattern
> is the following:
> 
> virtual report
> 
> @rule1@
> type t1;
> type t2;
> identifier i0;
> identifier i1;
> identifier i2;
> identifier ALLOC =~ "kmalloc|kzalloc|kmalloc_node|kzalloc_node|vmalloc|vzalloc|kvmalloc|kvzalloc";
> position p1;
> @@
> 
> i0 = sizeof(t1) + sizeof(t2) * i1;
> ...
> i2 = ALLOC@p1(..., i0, ...);
> 
> @script:python depends on report@
> p1 << rule1.p1;
> @@
> 
> msg = "WARNING: verify allocation on line %s" % (p1[0].line)
> coccilib.report.print_report(p1[0],msg)
> 
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#zero-length-and-one-element-arrays [1]
> Link: https://www.kernel.org/doc/html/next/process/deprecated.html#open-coded-arithmetic-in-allocator-arguments [2]
> Signed-off-by: Erick Archer <erick.archer@outlook.com>
> ---
> Changes in v3:
> - Split the changes in various commits to simplify the acceptance process
>   (Leon Romanovsky).
> 
> Changes in v2:
> - Remove the "req_indir_tab" variable (Gustavo A. R. Silva).
> - Update the commit message.
> - Add the "__counted_by" attribute.
> 
> Previous versions:
> v1 -> https://lore.kernel.org/linux-hardening/AS8PR02MB7237974EF1B9BAFA618166C38B382@AS8PR02MB7237.eurprd02.prod.outlook.com/
> v2 -> https://lore.kernel.org/linux-hardening/AS8PR02MB723729C5A63F24C312FC9CD18B3F2@AS8PR02MB7237.eurprd02.prod.outlook.com/
> ---
> Erick Archer (3):
>   net: mana: Add flex array to struct mana_cfg_rx_steer_req_v2
>   RDMA/mana_ib: Prefer struct_size over open coded arithmetic
>   net: mana: Avoid open coded arithmetic

Unfortunately, I still can't take RDMA patch alone without the netdev
patches.

Jakub, do you want shared branch for this series or should I take
everything through RDMA tree as netdev part is small enough?

Thanks

