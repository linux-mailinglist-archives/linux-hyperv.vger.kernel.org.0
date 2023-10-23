Return-Path: <linux-hyperv+bounces-573-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C42987D3EC7
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Oct 2023 20:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 588832816D1
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Oct 2023 18:15:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3628021372;
	Mon, 23 Oct 2023 18:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="pLl4V02x"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A9821105
	for <linux-hyperv@vger.kernel.org>; Mon, 23 Oct 2023 18:15:02 +0000 (UTC)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2842CC0
	for <linux-hyperv@vger.kernel.org>; Mon, 23 Oct 2023 11:15:00 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6ce344fa7e4so2539592a34.0
        for <linux-hyperv@vger.kernel.org>; Mon, 23 Oct 2023 11:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698084899; x=1698689699; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EEHshj4ZGLSNUd1/3J7uLikUiQYUKL38M7lUB087fzk=;
        b=pLl4V02x1g+KaWGkeoEaRAtGZ4uvxAvbsXh3RWA4MZd7Z3mKpeTNMUpsoRIW6SQgjD
         vjHHrsnCuycG0Jtxh8hmDTAQsZAGUOzvvVwOnlw164sgcOLjJ1m987eZfDtTpxbf+nH2
         KA5p7fjDTEBiLjpqY3jiu3aD8HMxm9sizINmLH2UxnoYXOYmPJ55iLgr8AIDVt9+507a
         KCQRYRlpk0g7+T6RWrtU16Bt8h1Xy+1kIV8RUoBFBJeG6CbQN/1EKQHO9up4HEBBUa8I
         FHQybkh7ecT33SFnaaMYpF4PBcqb3NK00CSwIof4FV2yUskciQNw2f3sTrXrxaSiub63
         RQRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698084899; x=1698689699;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EEHshj4ZGLSNUd1/3J7uLikUiQYUKL38M7lUB087fzk=;
        b=NftD3d6wYFd1zyx+xjOmb7xQszQO0aRqR1BRjAkUVDNKYGYHZ6xmu9zJ/lUP5KBi2q
         mK0hTo+glDMj33GhXflw/V8W6E4UWXzOtnS8Xd4nxzMV7R2t1m7Ycphjmh442FG4mvTx
         1SVUjZ90gt9oXhSYXDKRGVcyolRjADdS65DgmgYzI7fZU+rfoZM9Hku29laDWqXJp6HD
         lTTWMRE9Na7gjrrX32BsXtvH3Fhi3Fe/SQx5DYmAwDpw/rRWEz96qiXpLuLWUZvO/GVk
         9dk3+XxD74zo73QiUI2mwmT7w7gN2Z34BlnuYX++qDq1Ymu2S+tqbKn2nYrdh9gZaPUJ
         OEsA==
X-Gm-Message-State: AOJu0YwocW5qDiFYjiQ9n0OtvxIHt30usCuPJHLNVPhBo4c+q0aoQqMz
	GPBGzL8lQgmlHzFgdjQbPvmhqQ==
X-Google-Smtp-Source: AGHT+IETjW4KVURL38sAuytMhqq9oI5+G8qJObbDoigH6JMmCgE8pXkkrgDDG3XrQXmZN4EUlkVEng==
X-Received: by 2002:a05:6830:2702:b0:6be:e447:da3 with SMTP id j2-20020a056830270200b006bee4470da3mr9821558otu.28.1698084899393;
        Mon, 23 Oct 2023 11:14:59 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id k14-20020a056830168e00b006ce2e464a45sm1530719otr.29.2023.10.23.11.14.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:14:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1quzS5-003jNB-IG;
	Mon, 23 Oct 2023 15:14:57 -0300
Date: Mon, 23 Oct 2023 15:14:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: sharmaajay@linuxonhyperv.com
Cc: Long Li <longli@microsoft.com>, Leon Romanovsky <leon@kernel.org>,
	Dexuan Cui <decui@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-rdma@vger.kernel.org, linux-hyperv@vger.kernel.org,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Ajay Sharma <sharmaajay@microsoft.com>
Subject: Re: [Patch v7 1/5] RDMA/mana_ib: Rename all mana_ib_dev type
 variables to mib_dev
Message-ID: <20231023181457.GI691768@ziepe.ca>
References: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1697494322-26814-2-git-send-email-sharmaajay@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697494322-26814-2-git-send-email-sharmaajay@linuxonhyperv.com>

On Mon, Oct 16, 2023 at 03:11:58PM -0700, sharmaajay@linuxonhyperv.com wrote:
> From: Ajay Sharma <sharmaajay@microsoft.com>
> 
> This patch does not introduce any functional changes. It
> creates naming convention to distinguish especially when
> used in the same function.Renaming all mana_ib_dev type
> variables to mib_dev to have clean separation between
> eth dev and ibdev variables.

> Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/cq.c      | 12 ++--
>  drivers/infiniband/hw/mana/device.c  | 34 +++++------
>  drivers/infiniband/hw/mana/main.c    | 87 ++++++++++++++--------------
>  drivers/infiniband/hw/mana/mana_ib.h |  9 +--
>  drivers/infiniband/hw/mana/mr.c      | 29 +++++-----
>  drivers/infiniband/hw/mana/qp.c      | 84 +++++++++++++--------------
>  drivers/infiniband/hw/mana/wq.c      | 21 +++----
>  7 files changed, 141 insertions(+), 135 deletions(-)

Please no, don't create pointless giant churn like this. It only hurts
backporters

Maybe just target the functions with more than one type

Jason

