Return-Path: <linux-hyperv+bounces-297-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 97CFA7B1BE0
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Sep 2023 14:15:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id D66A0282464
	for <lists+linux-hyperv@lfdr.de>; Thu, 28 Sep 2023 12:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 226A35386;
	Thu, 28 Sep 2023 12:15:53 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D13438BC3
	for <linux-hyperv@vger.kernel.org>; Thu, 28 Sep 2023 12:15:51 +0000 (UTC)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C09A18F
	for <linux-hyperv@vger.kernel.org>; Thu, 28 Sep 2023 05:15:48 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77575233636so187689285a.2
        for <linux-hyperv@vger.kernel.org>; Thu, 28 Sep 2023 05:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1695903347; x=1696508147; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1KoGFF3gG67f7HtS8wXtabehMpcb0H20FLcT60YySvc=;
        b=HMqOo1Gc8Xtb3EMUKCTRx8xi7WmT1jcdK0Uc2hXomlsQzOhsWcpmgy4FR3FVMajjv/
         nOTO5Ve/J99rUy50CG43s3WBmNVOPZXhbkgGMCWgV7Z7CpTGoOECvLNoIaT+Fbfh/J21
         k8ZsDfY+Id2gSmRQm5FzbKjdhtT1T0b4ULvWpEWh9MDeZZDQMlN94yRem/dKTSKYP9c0
         Foop5S8N7zJFmS3TLeDcHcltYOqX11kBtRnPDcQjPVO6uynjxtlpFV5UAfNiGPzLwVhS
         /AJ0u0Mm+onLAMq1NjHeiqECa60DNcfkpPpkFo3+jdhHV35W3tZAA1WadvV867Rm2ps7
         7Oag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695903347; x=1696508147;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1KoGFF3gG67f7HtS8wXtabehMpcb0H20FLcT60YySvc=;
        b=h5/axrXWX1w2pNSfvTrbyOulPoe9OZB8xn3eKupfaBypA9+s6mfr0P5uG7P987a95H
         NFZW/mlWBXmj+ABKylmw4AGpCI3YBWIT3oFXDaQ25PVa2Aqx8rCodvFkjno+ECQDJ+QS
         oqZMp0EkbrWXohgxAdtU2SumGsFsaZjDTKdbn/mL+0lUS9Ep9Ggn0AlsTf8LX2qWEpsP
         ooqV1qHRmVzb87vG+uAiJCybB06aPO9lGUh0yb52DB1lxNWnxvSDVlGOGpotRTEyxh1a
         PnGS0h3zSVwH4FCZSZevm3RSpoNrzz7gwTsPzkAFvtXb+E3Nf4cVCDAvmol1rP+ISJ76
         pD7w==
X-Gm-Message-State: AOJu0YwYoFzgksIMmeYHhWoa5E9Tpo1jB0Pylwh8bR5ihkA92ryKBsOk
	fFXR70VQ0+afFXtcZct6rojlqny4TF1/n7tyZic=
X-Google-Smtp-Source: AGHT+IFO/ToWCbCZ46SVTe0ZeYuahYfaS+aix1nnBVV8zB6sSjGr7UUq6XnTTgGkxgad33ZGaOimBA==
X-Received: by 2002:a0c:ab06:0:b0:65b:fa3:4a01 with SMTP id h6-20020a0cab06000000b0065b0fa34a01mr819278qvb.62.1695903347119;
        Thu, 28 Sep 2023 05:15:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id h19-20020a0cab13000000b0065b121d6251sm3213778qvb.146.2023.09.28.05.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Sep 2023 05:15:46 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1qlpvl-001fTg-Uy;
	Thu, 28 Sep 2023 09:15:45 -0300
Date: Thu, 28 Sep 2023 09:15:45 -0300
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
Subject: Re: [Patch v6 0/5] RDMA/mana_ib
Message-ID: <20230928121545.GP13795@ziepe.ca>
References: <1694802270-17452-1-git-send-email-sharmaajay@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1694802270-17452-1-git-send-email-sharmaajay@linuxonhyperv.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 11:24:25AM -0700, sharmaajay@linuxonhyperv.com wrote:
> From: Ajay Sharma <sharmaajay@microsoft.com>
> 
> Change from v5:
> Use xarray for qp lookup.

this series is malformed somehow, it does not appear in patchworks

Jason

