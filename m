Return-Path: <linux-hyperv+bounces-460-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5DD67B7504
	for <lists+linux-hyperv@lfdr.de>; Wed,  4 Oct 2023 01:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by am.mirrors.kernel.org (Postfix) with ESMTP id 3483F1F218D3
	for <lists+linux-hyperv@lfdr.de>; Tue,  3 Oct 2023 23:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381D2405CE;
	Tue,  3 Oct 2023 23:35:29 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA373FB3E
	for <linux-hyperv@vger.kernel.org>; Tue,  3 Oct 2023 23:35:27 +0000 (UTC)
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095D8AC;
	Tue,  3 Oct 2023 16:35:24 -0700 (PDT)
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-690bc3f82a7so1271758b3a.0;
        Tue, 03 Oct 2023 16:35:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696376123; x=1696980923;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJD24QbXAixuWuUpvUYY/DJkjTh/y9ZMHAxjDwAuOCg=;
        b=dulbo8hKkcuH/Wn0336uMqp1zEwOiEteaOzWQVjiK82Yt2Wuub50C7gdYVIj605FBD
         VZi2iwRAepDaGiI4g/xTWU+HwZyOdDR0zgSKtQd+pdIwUSjSW3qrsKB3ij/ZULa1gyRU
         GPf/5zExPiCxbgcS7sRak22PR6GI2Pxje5DGMEjLzjvu5c8UzBCrL3eX1TOJc3V9dlT+
         ILjeN2oTIUyRYnLPn8P2p/9pnYyTiAzJ82iD381xF5Fpp5nmmP/JZ14hNO/XOVHL9aKV
         7O5bZXA6PHavdbmI3QnPa6Ka04xSD5uE2B6sty6vrdZ6w8yeuNJfNwk1PosyS9DMMXVT
         zjvw==
X-Gm-Message-State: AOJu0YyZIqVDnAiNf9+zI+5CkTX76HZD9shfLYxy7dd+Q7GSDENSKejV
	vYBgZdNgVyDoCcEpN/3MQEc=
X-Google-Smtp-Source: AGHT+IFygOHV2/FvdD4qmBhjkUVrn/Kq2uyKGkQqrsQf3OvfZZd939O7TMH4i4YP0wgmh5TMOwkkxg==
X-Received: by 2002:a05:6a00:852:b0:68f:efc2:ba3d with SMTP id q18-20020a056a00085200b0068fefc2ba3dmr1215971pfk.33.1696376123288;
        Tue, 03 Oct 2023 16:35:23 -0700 (PDT)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id w16-20020a639350000000b0057d0a8e634dsm1948102pgm.48.2023.10.03.16.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 16:35:22 -0700 (PDT)
Date: Tue, 3 Oct 2023 23:35:21 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Wei Liu <wei.liu@kernel.org>,
	Nuno Das Neves <nunodasneves@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-arch@vger.kernel.org, patches@lists.linux.dev,
	mikelley@microsoft.com, kys@microsoft.com, haiyangz@microsoft.com,
	decui@microsoft.com, apais@linux.microsoft.com,
	Tianyu.Lan@microsoft.com, ssengar@linux.microsoft.com,
	mukeshrathor@microsoft.com, stanislav.kinsburskiy@gmail.com,
	jinankjain@linux.microsoft.com, vkuznets@redhat.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, hpa@zytor.com, will@kernel.org,
	catalin.marinas@arm.com
Subject: Re: [PATCH v4 15/15] Drivers: hv: Add modules to expose /dev/mshv to
 VMMs running on Hyper-V
Message-ID: <ZRylORx/KAgJyLgQ@liuwe-devbox-debian-v2>
References: <1696010501-24584-1-git-send-email-nunodasneves@linux.microsoft.com>
 <1696010501-24584-16-git-send-email-nunodasneves@linux.microsoft.com>
 <2023093004-evoke-snowbird-363b@gregkh>
 <ZRhkxxBbxkeM4whg@liuwe-devbox-debian-v2>
 <2023093002-bonfire-petty-c3ca@gregkh>
 <ZRiPY5GzrGvlnPmY@liuwe-devbox-debian-v2>
 <2023100130-profusely-landside-0f97@gregkh>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023100130-profusely-landside-0f97@gregkh>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Sun, Oct 01, 2023 at 08:20:37AM +0200, Greg KH wrote:
> On Sat, Sep 30, 2023 at 09:13:07PM +0000, Wei Liu wrote:
> > On Sat, Sep 30, 2023 at 08:31:13PM +0200, Greg KH wrote:
> > > On Sat, Sep 30, 2023 at 06:11:19PM +0000, Wei Liu wrote:
> > > > On Sat, Sep 30, 2023 at 08:11:37AM +0200, Greg KH wrote:
> > > > > On Fri, Sep 29, 2023 at 11:01:41AM -0700, Nuno Das Neves wrote:
> > > > > > --- /dev/null
> > > > > > +++ b/include/uapi/linux/mshv.h
> > > > > > @@ -0,0 +1,306 @@
> > > > > > +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> > > > > 
> > > > > Much better.
> > > > > 
> > > > > > +#ifndef _UAPI_LINUX_MSHV_H
> > > > > > +#define _UAPI_LINUX_MSHV_H
> > > > > > +
> > > > > > +/*
> > > > > > + * Userspace interface for /dev/mshv
> > > > > > + * Microsoft Hypervisor root partition APIs
> > > > > > + * NOTE: This API is not yet stable!
> > > > > 
> > > > > Sorry, that will not work for obvious reasons.
> > > > 
> > > > This can be removed. For practical purposes, the API has been stable for
> > > > the past three years.
> > > 
> > > Then who wrote this text?
> > 
> > I don't think this matter, does it? This patch series had been rewritten
> > so many times internally to conform to upstream standard it is very
> > difficult to track down who wrote this and when.
> 
> The point is someone wrote this for a good reason so figuring out why
> that was done would be good for you all to do as maybe it is true!
> 
> > If you have concrete concerns about removing the text, please let me
> > know.
> 
> You need to verify that the comment is not true before removing it,
> otherwise you all will have a very hard time in the future when things
> change...

I understand your point. Thanks, I will make sure to do that. :-)

Thanks,
Wei.

> 
> thanks,
> 
> greg k-h

