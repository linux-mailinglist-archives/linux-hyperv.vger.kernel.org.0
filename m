Return-Path: <linux-hyperv+bounces-575-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D0987D3F0E
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Oct 2023 20:21:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACC1E1C20A1D
	for <lists+linux-hyperv@lfdr.de>; Mon, 23 Oct 2023 18:21:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F24D921379;
	Mon, 23 Oct 2023 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="PbZDGy48"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29B261DA32
	for <linux-hyperv@vger.kernel.org>; Mon, 23 Oct 2023 18:21:53 +0000 (UTC)
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0ED103
	for <linux-hyperv@vger.kernel.org>; Mon, 23 Oct 2023 11:21:51 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id 5614622812f47-3b4145e887bso605430b6e.3
        for <linux-hyperv@vger.kernel.org>; Mon, 23 Oct 2023 11:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1698085310; x=1698690110; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ELhPHgmF7pPJ0f5VbSNCKVTdPqoWjN7MfIE8blhP1v8=;
        b=PbZDGy48iqssau03QIP9wvYb2V5M/5cCvDd4R64DNFEgRiKFLbyU047d0oZiYj5ZZd
         KNyNdKEJLnDWRSFx8l3mIPZTSXVsW9vXg21GQKyca7VgSbc6nr4BrLPeyA89N3QpqKDD
         iFfVpeMWULqCn8aMbbcA/n4FeUGFi9NuRmYyynsWX9fTAjyD+0OSgQAC02mtyPb2g11K
         J+vpPbS1e3b7vWxDlRZa0zf6N71NS/Mn5dR3fcRopN9nnFNdYyOKV+it30ljw5F3Uh8w
         jX4A6SHv//xnErt9az90/raLduCT5KJDcN3v4LaxWPFPQH7jiUPe8AgMbdZVcdfdKoWS
         yV9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698085310; x=1698690110;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ELhPHgmF7pPJ0f5VbSNCKVTdPqoWjN7MfIE8blhP1v8=;
        b=SawM66sTUjd/NR/BPg3+YakhumQuD24OKEALb1+kvd4dcy4swk5AuiiFJFJyoOY029
         jaPS14XyuvYowJt+NysevS6pfTRDuxsRAEbNCa6cOLCUHPybvVrfGS3sVhsEVtrD0/h0
         3R5qt68WYbhn8u2IWp8DT48XcOIGi40s+6upF8/tM4y1mmohkp5MlrshU2IHnGkqSKMW
         FIwqnRa2BX2O2wA61TnsUNKbUIMoZwpXEux14uN3X7sXfHp5HfeBwO1aWfwOkcJr7tqm
         qP/t/ytv0vo2EiuElthx9VLlYEvI5BjA5QbVJ0Pcc57C8D4Hui9el2QdmQUIjMa+gCGx
         pFcg==
X-Gm-Message-State: AOJu0Yyy3MSgD0tMSij5w0G/XYHXlVAQ4ZwT8sMH/TZcsdz6izCAkWeX
	bwOLunLoamw1Bloc2Ij8ZuawjQ==
X-Google-Smtp-Source: AGHT+IENr5mCUHAQy2/Dcv2K9Fd98rrNYfVmPpwtNc8CFJKK9E6ArTW0+TnAeTK7TBCwNez8Vc6hMQ==
X-Received: by 2002:a05:6808:46:b0:3ad:f866:39bd with SMTP id v6-20020a056808004600b003adf86639bdmr9848014oic.27.1698085310628;
        Mon, 23 Oct 2023 11:21:50 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id z18-20020a056808029200b003b2f369a932sm1579278oic.49.2023.10.23.11.21.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 11:21:50 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1quzYj-003jR4-AF;
	Mon, 23 Oct 2023 15:21:49 -0300
Date: Mon, 23 Oct 2023 15:21:49 -0300
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
Subject: Re: [Patch v7 3/5] RDMA/mana_ib: Create adapter and Add error eq
Message-ID: <20231023182149.GK691768@ziepe.ca>
References: <1697494322-26814-1-git-send-email-sharmaajay@linuxonhyperv.com>
 <1697494322-26814-4-git-send-email-sharmaajay@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1697494322-26814-4-git-send-email-sharmaajay@linuxonhyperv.com>

On Mon, Oct 16, 2023 at 03:12:00PM -0700, sharmaajay@linuxonhyperv.com wrote:
> From: Ajay Sharma <sharmaajay@microsoft.com>
> 
> Create adapter object as nice container for VF resources.
> Add error eq needed for adapter creation and later used
> for notification from Management SW. The management
> software uses this channel to send messages or error
> notifications back to the Client.
> 
> Signed-off-by: Ajay Sharma <sharmaajay@microsoft.com>
> ---
>  drivers/infiniband/hw/mana/device.c           |  22 ++-
>  drivers/infiniband/hw/mana/main.c             |  97 ++++++++++++
>  drivers/infiniband/hw/mana/mana_ib.h          |  33 ++++
>  .../net/ethernet/microsoft/mana/gdma_main.c   | 147 ++++++++++--------
>  drivers/net/ethernet/microsoft/mana/mana_en.c |   3 +
>  include/net/mana/gdma.h                       |  13 +-
>  6 files changed, 245 insertions(+), 70 deletions(-)

Split up your patches properly please this says it creates the
adapter, code to create an EQ and process events should not be in this
patch.

Jason

