Return-Path: <linux-hyperv+bounces-1945-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47EE389D53D
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Apr 2024 11:16:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5DC4EB21B71
	for <lists+linux-hyperv@lfdr.de>; Tue,  9 Apr 2024 09:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A063F7F487;
	Tue,  9 Apr 2024 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkxWqbQb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68EA67F478;
	Tue,  9 Apr 2024 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712654197; cv=none; b=dwIhxsaSaXgZF5lus1qcSnE4SxTvENU/8ZBK57rsp8R42V8FAyIHDKXZ41+eMezesplgrTel1I+lKBO4xilZ8ztQ3NYWc97HfSajIPXWG9WKZNGmdIZfWYafDAbPL296URrrirn5vSMCSjvcuVEvn9K0xYIurJSQNWRIMoA7xxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712654197; c=relaxed/simple;
	bh=eD1sSl1LC2w+iXUBFJovazhs1iLnydCk/NsupckT0aA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ArGXpPthGlY6NZ8fVqFCm/u9dPEeoRnrsO0Ni1PLGg8H94uqQ7CGuN/oNkXXx4zCCMMscTNLFOubg6wWRjJrqX3UHalbive4d2Qe9F1bL+Qf3vJAbLlYo0Gsd4ur2+X/V3yGRqrRXgpEbvMtJ6uHgNoLg8wdqVF+2LrbbAs8yzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkxWqbQb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96CFBC433F1;
	Tue,  9 Apr 2024 09:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712654197;
	bh=eD1sSl1LC2w+iXUBFJovazhs1iLnydCk/NsupckT0aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fkxWqbQb9tHTw4XeMFVjdPuQJghz65DBJErAO9tKG2/fT6EdGB4LPn4HWSqdyRxFk
	 KDEK3Ex1GHmRB4oYsGlkqOyn+xtZQI1GVQo7mqMedb7ggHTr4/nGLZriJXyEHgq1wn
	 yuKRuKU4p+YNyQHSv+30LX9wuzmCcvLENKNoN8Lb+0MhSPd4gKva7KVkCqEj7dofPa
	 wLSA0nE97w5t+XmQoR1bDHHbqOrTRfjPaBBWIwoQnpwdirUEcSbYfQv19z3Naf/qm/
	 UQ4oWp/E7wzChrn8GXazfFEyxsiOc24YWfnc9bHn1sM48W9YQi/A0Lv9xp36obg6dz
	 oBLidi4Zcq1wA==
Date: Tue, 9 Apr 2024 12:16:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Erick Archer <erick.archer@outlook.com>, Long Li <longli@microsoft.com>,
	Ajay Sharma <sharmaajay@microsoft.com>,
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
Message-ID: <20240409091632.GF4195@unreal>
References: <AS8PR02MB72374BD1B23728F2E3C3B1A18B022@AS8PR02MB7237.eurprd02.prod.outlook.com>
 <20240408110730.GE8764@unreal>
 <20240408183657.7fb6cc35@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240408183657.7fb6cc35@kernel.org>

On Mon, Apr 08, 2024 at 06:36:57PM -0700, Jakub Kicinski wrote:
> On Mon, 8 Apr 2024 14:07:30 +0300 Leon Romanovsky wrote:
> > Jakub, do you want shared branch for this series or should I take
> > everything through RDMA tree as netdev part is small enough?
> 
> Shared branch would be good. Ed has some outstanding patches 
> to refactor the ethtool RSS API.

Great, I'll wait for a day or two to give people time to review and
then I'll create a shared branch.

Thanks

