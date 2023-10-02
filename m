Return-Path: <linux-hyperv+bounces-402-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA27A7B59FC
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 20:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 05CA8281A01
	for <lists+linux-hyperv@lfdr.de>; Mon,  2 Oct 2023 18:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933D71EA95;
	Mon,  2 Oct 2023 18:26:38 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6774B1EA91;
	Mon,  2 Oct 2023 18:26:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D269C433C9;
	Mon,  2 Oct 2023 18:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696271198;
	bh=eur7A7Y3SzDW6ljEQkfCfCenQyoxYCoEfd1Tln8zfqc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=iJUIwUx4t7QNZst/Cx4lJwT62Xfz3o6VvavukhzSh5nzFA5PEry5FIMcU2nA5JHGH
	 Nb2r2SQQVFOgadlBtnmsH168qXAkq+tjPtXwJtss3Jl6UnuhW8mm2r5J3RMQDjvzkm
	 sCnKmGhA+n9Ur3yJp/MbievOAuPxiMRbhTG/3/Mt3q48+6gldE4VofhC8K27ng12hF
	 kP7O62WOxp5G2s39ieBfQJ74BIA5eXjPW39F2I1G4opvSOlAuI9pC2ZpIl7nJQqgYn
	 6Gmm7Q/Aonk710NI7tpIg4Ht2PCwSbaAOODvwmKGJSmGQfEUWwiSiCXnh9bPw42aYB
	 2d5iDQxGKIWiA==
Date: Mon, 2 Oct 2023 11:26:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kees Cook <keescook@chromium.org>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, "David S. Miller"
 <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Martin KaFai Lau
 <martin.lau@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Yisen Zhuang
 <yisen.zhuang@huawei.com>, Salil Mehta <salil.mehta@huawei.com>, Claudiu
 Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
 "K. Y. Srinivasan" <kys@microsoft.com>, Haiyang Zhang
 <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, Dexuan Cui
 <decui@microsoft.com>, Long Li <longli@microsoft.com>, Ajay Sharma
 <sharmaajay@microsoft.com>, Alex Elder <elder@kernel.org>, Pravin B Shelar
 <pshelar@ovn.org>, Shaokun Zhang <zhangshaokun@hisilicon.com>, Cong Wang
 <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Nathan
 Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>,
 Tom Rix <trix@redhat.com>, Simon Horman <horms@kernel.org>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 linux-hyperv@vger.kernel.org, linux-rdma@vger.kernel.org,
 dev@openvswitch.org, linux-parisc@vger.kernel.org, llvm@lists.linux.dev,
 linux-hardening@vger.kernel.org
Subject: Re: [PATCH 00/14] Batch 1: Annotate structs with __counted_by
Message-ID: <20231002112635.7daf13ef@kernel.org>
In-Reply-To: <202309270854.67756EAC2@keescook>
References: <20230922172449.work.906-kees@kernel.org>
	<202309270854.67756EAC2@keescook>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 Sep 2023 08:57:36 -0700 Kees Cook wrote:
> > Since the element count member must be set before accessing the annotated
> > flexible array member, some patches also move the member's initialization
> > earlier. (These are noted in the individual patches.)  
> 
> Hi, just checking on this batch of changes. Is it possible to take the
> 1-13 subset:

On it, sorry for the delay.

