Return-Path: <linux-hyperv+bounces-96-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDD37A1D7C
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 13:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 949781C20DF5
	for <lists+linux-hyperv@lfdr.de>; Fri, 15 Sep 2023 11:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00046101E8;
	Fri, 15 Sep 2023 11:33:01 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C30DDB7
	for <linux-hyperv@vger.kernel.org>; Fri, 15 Sep 2023 11:33:00 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5F81D1AB;
	Fri, 15 Sep 2023 04:32:59 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id B273B212BE71; Fri, 15 Sep 2023 04:32:58 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B273B212BE71
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1694777578;
	bh=Dtj/ryT9PtzyNAYJFW0neqg88SKiucgUubfUdZkU8WU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Tl/KAqnpHbzC445uggyxkJDlewAN0SZy8jILuUKI9Tfcb+iGNUUMqGrZyVwD3w56K
	 Q7XCtUBZmJ/KZaY0vpk7ZaTlHBRi0jMqf/0mRUWM9WeAxCmsYu/SgllWs1O7ZNOkMd
	 SHipndaxshC+g22TcXN4EYCPMwSesCsUvtZBDoBQ=
Date: Fri, 15 Sep 2023 04:32:58 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Mathias Krause <minipli@grsecurity.net>
Cc: linux-hyperv@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] x86/hyperv/vtl: Replace real_mode_header only under
 Hyper-V
Message-ID: <20230915113258.GA24381@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230908102610.1039767-1-minipli@grsecurity.net>
 <20230908150224.GA3196@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ca1a5950-9092-6caf-471c-ebda623173e5@grsecurity.net>
 <20230913052714.GA29112@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <92c52af3-085e-8467-88bf-da4fbc56eeaa@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <92c52af3-085e-8467-88bf-da4fbc56eeaa@grsecurity.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 09:06:15AM +0200, Mathias Krause wrote:
> On 13.09.23 07:27, Saurabh Singh Sengar wrote:
> > On Mon, Sep 11, 2023 at 10:00:59AM +0200, Mathias Krause wrote:
> >> On 08.09.23 17:02, Saurabh Singh Sengar wrote:
> >>> On Fri, Sep 08, 2023 at 12:26:10PM +0200, Mathias Krause wrote:
> >>>> Booting a CONFIG_HYPERV_VTL_MODE=y enabled kernel on bare metal or a
> >>>> non-Hyper-V hypervisor leads to serve memory corruption as
> >>>
> >>> FWIW, CONFIG_HYPERV_VTL_MODE is not expected to be enabled for non VTL
> >>> platforms.

<snip>

> 
> Well, if you want to prevent people from using it, make it depend on
> BROKEN, because that's what it is. All the other hypervisor support in
> the kernel (Xen, VMware, KVM, ACRN, Jailhouse, even plain Hyper-V) can
> perfectly cope with getting booted on a different hypervisor or bare
> metal. Why is Hyper-V's VTL mode such a special snow flake that it has
> to cause random memory corruption and, in turn, crash the kernel with
> spectacular (and undebugable) fireworks if it's not booted under Hyper-V?

'BROKEN' is certainly not the right choice here. If it is used on the
correct platform as it is designed to be nothing is broken.

The default option for CONFIG_HYPERV_VTL_MODE is set to 'N', there is
sufficient documentation for it as well. I agree there can be cases where
people can still end up enabling it, for that EXPERT is a reasonable
solution.

- Saurabh



> 
> Thanks,
> Mathias

