Return-Path: <linux-hyperv+bounces-142-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D7E7A9877
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Sep 2023 19:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 111B128277E
	for <lists+linux-hyperv@lfdr.de>; Thu, 21 Sep 2023 17:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2AB4168DA;
	Thu, 21 Sep 2023 17:22:30 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2323716416
	for <linux-hyperv@vger.kernel.org>; Thu, 21 Sep 2023 17:22:22 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id BA76B40068;
	Thu, 21 Sep 2023 10:14:56 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 3CEC8212C497; Thu, 21 Sep 2023 10:14:08 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3CEC8212C497
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1695316448;
	bh=+CYT1qzL77ITSUiOiG5QEUM8nPiTvooU7tBhQsqM/d0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Bxk57YQd0srLJzlZokrzXcny5XIx+dF2kGt7HYXVpIUe0SakExM0oIxva5SYAUg/4
	 xUYtOtU39CtQBe1UJl3ntPkxhwJIZ0WhMG11AndfPt7z5qykB0IBS7t9BgNVy4Otc1
	 fDIuapaILU/4/D3d6l/6+Ljha+rQIYQlcNFbkkZo=
Date: Thu, 21 Sep 2023 10:14:08 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Mathias Krause <minipli@grsecurity.net>
Cc: kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
	decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org, mikelley@microsoft.com,
	ssengar@microsoft.com
Subject: Re: [PATCH] x86/hyperv: Remove hv_vtl_early_init initcall
Message-ID: <20230921171408.GA26395@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1695185552-19910-1-git-send-email-ssengar@linux.microsoft.com>
 <0e86d1cb-a042-7d80-b410-0cc4b31744aa@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0e86d1cb-a042-7d80-b410-0cc4b31744aa@grsecurity.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,SPF_HELO_PASS,SPF_PASS,
	USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Sep 21, 2023 at 09:17:24AM +0200, Mathias Krause wrote:
> On 20.09.23 06:52, Saurabh Sengar wrote:
> > There has been cases reported where HYPERV_VTL_MODE is enabled by mistake,
> > on a non Hyper-V platforms. This causes the hv_vtl_early_init function to
> > be called in an non Hyper-V/VTL platforms which results the memory
> > corruption.
> > 
> > Remove the early_initcall for vhv_vtl_early_init and call it at the end of

vhv_vtl_early_init need to be replaced with hv_vtl_early_init here.

Wei,

Do you need a V2 for it ?

- Saurabh


