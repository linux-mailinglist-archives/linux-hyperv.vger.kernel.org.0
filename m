Return-Path: <linux-hyperv+bounces-597-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D071C7D8629
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 17:47:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36DAE28201D
	for <lists+linux-hyperv@lfdr.de>; Thu, 26 Oct 2023 15:47:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B0D374DC;
	Thu, 26 Oct 2023 15:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="YTLOXLcJ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE8C1A5B9
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Oct 2023 15:47:21 +0000 (UTC)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0D4198
	for <linux-hyperv@vger.kernel.org>; Thu, 26 Oct 2023 08:47:19 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-27d0e3d823fso844399a91.1
        for <linux-hyperv@vger.kernel.org>; Thu, 26 Oct 2023 08:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1698335239; x=1698940039; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=xlBcWVOwKivgAn0UMjWC0U1b/ad+4cMpTB3lolYhGNU=;
        b=YTLOXLcJyFyr5vU+nhB/v0MyiIeUegIRMB0yjXlK3hclQb8HGnkdsvHGZd7MHCqBL3
         bC1RAG+f9mf2o4HcHKv7jeaISlqhUlayDQx5EgSSxT6s6FFAjUukRAjDEMDCn37HvzOe
         zxm7MbFTo3wuRvkK4B/VhjNUxAWl+dO/EU+KA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698335239; x=1698940039;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlBcWVOwKivgAn0UMjWC0U1b/ad+4cMpTB3lolYhGNU=;
        b=OUCM0z/rhBsMLCjZoQrzYJmBCT+MM7oUjqSk2efx2Flf0nd3finVfdzTrImHHHdBt/
         K1Ib1ClvheOGwOA+8OpRiqYo6Kme+43zJge/BCLA+/Vh4ckjbqd2we4JgOXNn3uz17BM
         /IfmDbmX0BF4z3LSehsegD4w1zvU5gHi00FH7dSsJMuup3KAZAsy38xaBh0Jvstetna4
         cWXTdTUqFRCEYRH63qW9Kx6lbA1yI2aonHq3emoqENYEnlVuhmXrjMWzmaz7Ih+sRvTp
         GA8JCEL2fpkuM1pihE9u/HDjmlqCvC8dj979uKwYynvyFj/Cz0xrHN7FzMxHFPf2WE5H
         0wcw==
X-Gm-Message-State: AOJu0YzYrSl3sfrnZA/S6N9JZ0i64DvzSQ595BpaRkMHGvNjIKX5WQRY
	5aD3xj7W0JreZJczmfChqRvjcA==
X-Google-Smtp-Source: AGHT+IE+QPVJnhPXypHjhY8uvISBKpa7dbbm+rvilNnSdebvclKGppTYd6ACyZS9wBGFhF/d0zryLA==
X-Received: by 2002:a17:90a:e38a:b0:27d:36df:8472 with SMTP id b10-20020a17090ae38a00b0027d36df8472mr15374711pjz.27.1698335239138;
        Thu, 26 Oct 2023 08:47:19 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a195e00b0027cfd582b51sm2008331pjh.3.2023.10.26.08.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 08:47:18 -0700 (PDT)
Date: Thu, 26 Oct 2023 08:47:17 -0700
From: Kees Cook <keescook@chromium.org>
To: Justin Stitt <justinstitt@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Dimitris Michailidis <dmichail@fungible.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Louis Peens <louis.peens@corigine.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Ronak Doshi <doshir@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	intel-wired-lan@lists.osuosl.org, oss-drivers@corigine.com,
	linux-hyperv@vger.kernel.org
Subject: Re: [PATCH 0/3] ethtool: Add ethtool_puts()
Message-ID: <202310260845.B2AEF3166@keescook>
References: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231025-ethtool_puts_impl-v1-0-6a53a93d3b72@google.com>

On Wed, Oct 25, 2023 at 11:40:31PM +0000, Justin Stitt wrote:
> @replace_2_args@
> identifier BUF;
> expression VAR;
> @@
> 
> -       ethtool_sprintf
> +       ethtool_puts
>         (&BUF, VAR)

I think cocci will do a better job at line folding if we adjust this
rule like I had to adjust the next rule: completely remove and re-add
the arguments:

-       ethtool_sprintf(&BUF, VAR)
+       ethtool_puts(&BUF, VAR)

Then I think the handful of weird line wraps in the treewide patch will
go away.

-- 
Kees Cook

