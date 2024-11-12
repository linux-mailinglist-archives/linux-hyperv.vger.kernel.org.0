Return-Path: <linux-hyperv+bounces-3323-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F219C51B5
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Nov 2024 10:17:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68FF61F21EC9
	for <lists+linux-hyperv@lfdr.de>; Tue, 12 Nov 2024 09:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6325620D51A;
	Tue, 12 Nov 2024 09:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AvO3SzMZ"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3523A20D504;
	Tue, 12 Nov 2024 09:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731402981; cv=none; b=Yf0l3CIUa7VYK5dJNWPR471aN1fE1Hn92++E5YLaFVNf5S1xsXN9f9uFq1Du5dcEpnlTjjEA+s+CBLyR1jX+mLYL/UZV/FxOzCPgPkYpy6S7qrLsDdQ8SPRI+DkSzTHqpLRk9Szsn5Dtg72nGmBfAJH74i/B/VhtyRkiU+npAjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731402981; c=relaxed/simple;
	bh=rOO3Fcs7OqIJVX10L2UG6uZC2oV6lsTWehBJvcEoESQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sg3j31Fp7SsSqC32vjQx20lp7zxQIUUvTJ2snra4IOLaY0ai5EMbtJxcx57kn7co2xl2RgiOmisyVtvCd54uVIbN3HW7RgNASSyb7SdB5sR1h0CFrHopCtr91vTR/XruXaxIcBFB3sMhG30GFwwJ25SFunhoEAIT72dj52/0H5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AvO3SzMZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E7AC4CECD;
	Tue, 12 Nov 2024 09:16:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731402980;
	bh=rOO3Fcs7OqIJVX10L2UG6uZC2oV6lsTWehBJvcEoESQ=;
	h=Date:From:To:cc:Subject:In-Reply-To:References:From;
	b=AvO3SzMZ1GsVNC/bgf3Ty621g8jszH17qKGayzdvV1scl7jcAsWx6Z4+3ivyOqj/N
	 H5rb4n8tDCNmV7EgiIxMfxRimgKbsxFhm1mWfk6CcXf5jUbHRDu5/V/TfUZzo0QoSL
	 w3URroRMtLb8fAFwc9Zs2sExFdLZKvTJYcbMvgksvzwGELja3hx/0ju2GGBrW/vHU5
	 wKtUKNUQeq1HLzgiJdCqgE0d3xHUE1vy8NLEjKXK/xqQiMbSHCWy9NCmG69G5jLSO4
	 L17feYdENKnL9Syb1WPL18QQ1dbq7FDjRv1y/mQlUp2EEv5Luz6VEHtKHNCr0oaPK9
	 171kuZNyhT8gg==
Date: Tue, 12 Nov 2024 10:16:18 +0100 (CET)
From: Jiri Kosina <jikos@kernel.org>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
cc: Saurabh Singh Sengar <ssengar@linux.microsoft.com>, 
    Michael Kelley <mhklinux@outlook.com>, 
    "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
    "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, 
    "K. Y. Srinivasan" <kys@microsoft.com>, 
    Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
    Dexuan Cui <decui@microsoft.com>, Benjamin Tissoires <bentiss@kernel.org>, 
    Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
    "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] HID: hyperv: streamline driver probe to avoid devres
 issues
In-Reply-To: <877c98x2am.fsf@redhat.com>
Message-ID: <nycvar.YFH.7.76.2411121016020.20286@cbobk.fhfr.pm>
References: <20241111131240.35158-1-vkuznets@redhat.com> <SN6PR02MB41577C6B7BF387BEB9114A05D4582@SN6PR02MB4157.namprd02.prod.outlook.com> <20241112060449.GA18117@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <877c98x2am.fsf@redhat.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Tue, 12 Nov 2024, Vitaly Kuznetsov wrote:

> >> Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> >
> > Tested V2 as well, please feel free to  add,
> > Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> 
> Thank you!

Applied to hid.git, thanks!

-- 
Jiri Kosina
SUSE Labs


