Return-Path: <linux-hyperv+bounces-3438-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BFCC19E9D18
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 18:31:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF3028165D
	for <lists+linux-hyperv@lfdr.de>; Mon,  9 Dec 2024 17:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF75D524B4;
	Mon,  9 Dec 2024 17:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="cIRjVzz1"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30C52233137;
	Mon,  9 Dec 2024 17:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733765458; cv=none; b=TWQCg2q8t/eT0+Q/l+jEJ52A7rzfVQSH9PAcJuMEt3ED6VEN08lnr8ZUAtFp3B9zY1UAs42TcRg04kGluYnPT+8nmRnidiMmyd4Q+VURGw5eMSISCH4pexD7PgoOrc6JUprPKUb0KCtHBH3/UIOMgvIF8ITaAjR7/8MeZL565ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733765458; c=relaxed/simple;
	bh=MaRBRA8BofakgPUD4dP5c+wZsPmz67UHvD9rdarO1hM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OfhlNlo89blP5S2nF6QkL7KdEfaOJ3ARC9NYo1Wvcxs/QujDicg4U4UfEthZCH+tu3WavhNs2hLHSJDgPmrzl7cRSBBLBKbtKul/ckEpNx9qm8/AY2kC9/yDgrh8itru48wu5orfqOCTp4Q0h0zkj4Umfwc+sRGgh1+ma/gpQmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=cIRjVzz1; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 93F7120C8BA2; Mon,  9 Dec 2024 09:30:56 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 93F7120C8BA2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1733765456;
	bh=bqXOdnQKoVPPZ/PjMw7ad7afClJiAGSulQNBgrrXhEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cIRjVzz1q2gCsD+C8+qkEhV3jDosgVaBDvKxVTzF7PygGX9KXHEEFSBBwCUqZMVHq
	 Kpu0BHZW674WkTgs63hmnyzw9Zo/Z2qJsLgY3MguLVW35uy7PDjsL8udC8ngwkgszs
	 rOF2GCGF9hIC1osMAxkKHxns4Rgw7bsuo0b6AWJ0=
Date: Mon, 9 Dec 2024 09:30:56 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Michael Kelley <mhklinux@outlook.com>
Cc: "kys@microsoft.com" <kys@microsoft.com>,
	"haiyangz@microsoft.com" <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"decui@microsoft.com" <decui@microsoft.com>,
	"gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
	"vkuznets@redhat.com" <vkuznets@redhat.com>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] Drivers: hv: util: Don't force error code to
 ENODEV in util_probe()
Message-ID: <20241209173056.GA1194@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20241106154247.2271-1-mhklinux@outlook.com>
 <20241106154247.2271-2-mhklinux@outlook.com>
 <20241208173049.GA14100@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SN6PR02MB4157ED3DA55558829D6152D5D4332@SN6PR02MB4157.namprd02.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SN6PR02MB4157ED3DA55558829D6152D5D4332@SN6PR02MB4157.namprd02.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sun, Dec 08, 2024 at 11:12:15PM +0000, Michael Kelley wrote:
> From: Saurabh Singh Sengar <ssengar@linux.microsoft.com> Sent: Sunday, December 8, 2024 9:31 AM
> > 
> > On Wed, Nov 06, 2024 at 07:42:46AM -0800, mhkelley58@gmail.com wrote:
> > > From: Michael Kelley <mhklinux@outlook.com>
> > >
> > > If the util_init function call in util_probe() returns an error code,
> > > util_probe() always return ENODEV, and the error code from the util_init
> > > function is lost. The error message output in the caller, vmbus_probe(),
> > > doesn't show the real error code.
> > >
> > > Fix this by just returning the error code from the util_init function.
> > > There doesn't seem to be a reason to force ENODEV, as other errors
> > > such as ENOMEM can already be returned from util_probe(). And the
> > > code in call_driver_probe() implies that ENODEV should mean that a
> > > matching driver wasn't found, which is not the case here.
> > >
> > > Suggested-by: Dexuan Cui <decui@microsoft.com>
> > > Signed-off-by: Michael Kelley <mhklinux@outlook.com>
> > > ---
> > > Changes in v2: None. This is the first version of Patch 1 of this series.
> > > The "v2" is due to changes to Patch 2 of the series.
> > >
> > >  drivers/hv/hv_util.c | 4 +---
> > >  1 file changed, 1 insertion(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/hv/hv_util.c b/drivers/hv/hv_util.c
> > > index c4f525325790..370722220134 100644
> > > --- a/drivers/hv/hv_util.c
> > > +++ b/drivers/hv/hv_util.c
> > > @@ -590,10 +590,8 @@ static int util_probe(struct hv_device *dev,
> > >  	srv->channel = dev->channel;
> > >  	if (srv->util_init) {
> > >  		ret = srv->util_init(srv);
> > > -		if (ret) {
> > > -			ret = -ENODEV;
> > > +		if (ret)
> > >  			goto error1;
> > > -		}
> > 
> > After reviewing V2 of this series, I couldn’t find any scenario where
> > 'util_init' in any driver returns a value other than 0. 
> 
> Yeah, I noticed the same thing when doing this patch set.
> 
> > In such cases,
> > could we consider making all these functions 'void' ?
> > 
> > After this ee can remove the check for util_int return type.
> 
> I decided against making these changes. It seemed like code churn
> for not much benefit. And there's the possibility of some future
> change reintroducing an error code in one of the util_init functions,
> in which case we would need to put things back like they are now.
> Certainly this is a judgment call, but my take was to leave things
> as they are.
> 
> The changes you suggest would probably go as a third patch in
> the series. Wei Liu has already picked up the two patches as they
> are, so it would be fine to create an independent patch with the
> changes you suggest, if we want to go that route. My preference
> isn't that strong either way.

I realized later that the patch is already merged. I believe it's fine
to leave it as is unless someone feels motivated enough to push this change.

- Saurabh

