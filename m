Return-Path: <linux-hyperv+bounces-2986-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F5D596FFE5
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Sep 2024 05:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33EAC1F2305E
	for <lists+linux-hyperv@lfdr.de>; Sat,  7 Sep 2024 03:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3F22D045;
	Sat,  7 Sep 2024 03:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LJ1iH+nb"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 695C0139E;
	Sat,  7 Sep 2024 03:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725681470; cv=none; b=Pf3rMieC4lgVRCU6U2aHmLWBJpMvpRV95b4TWJ3ryke5++oi8IZBiJkkDrYUR7Y0EpbKVaUaTdmdmCAugrJ6Mo/NkNOkzLpX3hV2MpGTPSTJgVkqmHfTcdoD4N52ShlMyVkwE6HEHSzjIuUKhdELxdItBBs4VnvHzuYTrIt13tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725681470; c=relaxed/simple;
	bh=83dhicwxRUDtcvZO2V6nF5Kwj8AdvS3W3ynwQn7Whfo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MbRQOQlkz10g6mAmSNVAAeb1+BdHR3uxvM+kbN7dB7aTZI0j/tNHLpl0iupw9C1BlOHINfbBtuUJ7DN21dkPS9n9HoKU2QTSuHmqzO5hOekOpet8WJas7a8i/0FWf3McffXJE693U5j274nxNM4yJyRjsa6huu19k0m214XvWTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LJ1iH+nb; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id AB40520B743B; Fri,  6 Sep 2024 20:57:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com AB40520B743B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725681468;
	bh=sNC93gMOZsdU8Zwo9klCFwLTJSIlWKc9TKjNHtPcdxA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LJ1iH+nb0aPOFMMfxOC1DER2DuixXjIck+OCAEtWgTv3WR1jLFPXU+panbon5PI9n
	 /VGBEu7ni3jbV7+D0A3HQWjswFhlJ8Hznw0WcMtrWKaT4PiGRaZ1x82N89RPSsYskq
	 4HYCu3qtLDrIxLNJI73PXmocQX0/5KYeUjoDSf4Q=
Date: Fri, 6 Sep 2024 20:57:48 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>,
	KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	"wei.liu@kernel.org" <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] tools/hv: Add memory allocation check in
 hv_fcopy_start
Message-ID: <20240907035748.GA5769@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240829024446.3041-1-zhujun2@cmss.chinamobile.com>
 <SA1PR21MB13179B929747B9B88948DCA5BF902@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240905052033.GA378@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <SJ0PR21MB13245A34AC4AC3638F2108DCBF9F2@SJ0PR21MB1324.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ0PR21MB13245A34AC4AC3638F2108DCBF9F2@SJ0PR21MB1324.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sat, Sep 07, 2024 at 12:49:59AM +0000, Dexuan Cui wrote:
> > From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
> > Sent: Wednesday, September 4, 2024 10:21 PM
> >  [...]
> > hv_fcopy_send_data is the parent function which calls hv_fcopy_start.
> > Possibly a good solution is to check the return value from
> > hv_fcopy_send_data
> 
> The return value of hv_fcopy_send_data() is saved into icmsghdr->status, which
> is sent to the host, so the PowerShell command on the host will report an error
> immediately.
> 
> > in fcopy_pkt_process function. Otherwise I prefer exit over returning error.
> > 
> > And as you rightly pointed out if we use exit, there is no sense of using free.
> > 
> > - Saurabh
> 
> exit() here is not ideal in that the host doesn't know what's going on inside
> the VM, and I guess the host PowerShell command will time out after quite
> a while. Without exit(), the daemon can continue to run to accept the next
> requests from the host; with exit(), we rely on systemd's Restart=on-failure.
> I prefer not to call exit() here.
> 
> Thanks,
> Dexuan
> 

make sense, thanks.

- Saurabh

