Return-Path: <linux-hyperv+bounces-4911-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5932A89258
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 04:56:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78D343A4735
	for <lists+linux-hyperv@lfdr.de>; Tue, 15 Apr 2025 02:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 832686FC5;
	Tue, 15 Apr 2025 02:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="RJAwrj0V"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 212D72DFA41;
	Tue, 15 Apr 2025 02:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744685765; cv=none; b=CBvHYZZHDLBokJpOtMH24DC6OkIXKAy0+/b4s5M5zv0YMpz42bqrDjgbHOHVRBbV3yZzktaI+Zh8ggX84TA0VFDbla1t58K4YCojkpR99vTXNqg7Yce6fain1I9ktOydA0Bho8K2FCWlq8hF2caVNuakCAp7Mi1vQtchtLjYge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744685765; c=relaxed/simple;
	bh=3h7xkMohyHDFKTkqIfb+HNnnozRIVE2YQSTxT4y6Ibc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mw1nWY9+BO2XDWPFj22FSzH6TgBJrs3o30YuchiQjjj4p3sBHITkcTGRcgvHRgks4ne54BCq2VbqYxOyBH7AelB0ADdXRAdXXHzpJqOLQVDRw6zytqiJqoG5Ulg5tV+eRgi5X6Rn/8n7plyZXoU+VoBNmA/77iwCkiqJuyYw5z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=RJAwrj0V; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 9B1EF210C426; Mon, 14 Apr 2025 19:56:03 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 9B1EF210C426
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1744685763;
	bh=hyav3wk9oLUGcjWQ+GqZV5VGB7nXpdgblZ8UCyni3Nk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RJAwrj0VTZWXngCxF2zVt7ULmC3sliHZOFFHaCWNXKKnSQbyBfZ4+Ur/mXA6i0HMz
	 OFbYBCYCfE5Z0/zFWlUngNaXhOGhJx+nhg0AqSURdkJwszarBmL3ZNAzI6/1BO9xnR
	 cI14yfLAAO1kGGybFrsEuNRYWewkOG+U/eGfCMrI=
Date: Mon, 14 Apr 2025 19:56:03 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v3] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Message-ID: <20250415025603.GA4053@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1743929288-7181-1-git-send-email-shradhagupta@linux.microsoft.com>
 <BL4PR21MB46271A66420D9B03C2947360BFB32@BL4PR21MB4627.namprd21.prod.outlook.com>
 <BL4PR21MB46274267168AB06EF05CC0D4BFB32@BL4PR21MB4627.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL4PR21MB46274267168AB06EF05CC0D4BFB32@BL4PR21MB4627.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Apr 14, 2025 at 09:01:26PM +0000, Dexuan Cui wrote:
> > From: Dexuan Cui
> > Sent: Monday, April 14, 2025 1:57 PM
> > > @@ -1681,12 +1728,13 @@ int main(int argc, char *argv[])
> > >  	static struct option long_options[] = {
> > > [...]
> > > +		{"debug-enabled",	no_argument,	   0,  'd' },
> 
> If we use --debug, we won't have to touch the 2 lines of
> "help" and "no-daemon" in the struct option long_options[].

Thanks Dexuan, no problem, I'll make that change.

regards,
Shradha

