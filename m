Return-Path: <linux-hyperv+bounces-2974-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC3396CE65
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 07:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E8F52889B7
	for <lists+linux-hyperv@lfdr.de>; Thu,  5 Sep 2024 05:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF65142E7C;
	Thu,  5 Sep 2024 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="XhvqD2uq"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9781A15625A;
	Thu,  5 Sep 2024 05:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725513635; cv=none; b=TMtsJ83+Age0708v+w/9Gdyme5a9SnTDDdghywD7fhxrF+6vwoIv94R6utDRxaIjK1sRZ9luCKxXWjvcypMtEPvQo7XHyZTI4lbMXjfCz48lcvxgjP8o2SzEeyZt/yMvPu1nT+0YlOapWYA7Ilkww0I2mxTbZVnnkYXMZVnOvJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725513635; c=relaxed/simple;
	bh=YHnPI33glpPJz52HXm9gNvwTD0jruvYXgh8PiOXPnMk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OnZ3xKeZqMi6llWQqnmbPzH8pIipEHNlTXWFobZaul/nVPOrFWSGBlJwHU7tjaJ54g8+JUhz7WwdNYVu5BjaWRM86TRMCKn/a6vpzPaN3Ry7vqEiEvRGQFzysY/mLOUmjH8hNOP+cVW+a8/T+KwZzzUOI3Ipwy7ypcAXS20P11g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=XhvqD2uq; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 5706720B740C; Wed,  4 Sep 2024 22:20:33 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5706720B740C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1725513633;
	bh=v/9/moBEygaC2UoABGbqLX7Iy1PX+Y5nD0iWYLGxslw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XhvqD2uqAWyl6sqIA5Zuuxi7u/yjPUdHonQfJRQUWf5ClGVE7PlyyJ5m1XJi46qWx
	 OsAfCkh5ThUYS0GIWDaF8dxhEoBAHpkT0d4QfP49XSHNdi5jAqBcWbIhzY3BH6ZGDw
	 qbUO3LjGH/qLHO4dfG+tPXihmOwRykKCYlQ3x0Fk=
Date: Wed, 4 Sep 2024 22:20:33 -0700
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
Message-ID: <20240905052033.GA378@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240829024446.3041-1-zhujun2@cmss.chinamobile.com>
 <SA1PR21MB13179B929747B9B88948DCA5BF902@SA1PR21MB1317.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA1PR21MB13179B929747B9B88948DCA5BF902@SA1PR21MB1317.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Sat, Aug 31, 2024 at 12:34:43AM +0000, Dexuan Cui wrote:
> > From: Zhu Jun <zhujun2@cmss.chinamobile.com>
> > Sent: Wednesday, August 28, 2024 7:45 PM
> > @@ -296,6 +296,18 @@ static int hv_fcopy_start(struct hv_start_fcopy
> > *smsg_in)
> >         file_name = (char *)malloc(file_size * sizeof(char));
> >         path_name = (char *)malloc(path_size * sizeof(char));
> > 
> > +    if (!file_name) {
> > +        free(file_name);
> > +        syslog(LOG_ERR, "Can't allocate file_name memory!");
> > +        exit(EXIT_FAILURE);
> > +    }
> > +
> > +    if (!path_name) {
> > +        free(path_name);
> > +        syslog(LOG_ERR, "Can't allocate path_name memory!");
> > +        exit(EXIT_FAILURE);
> > +    }
> 
> If we're calling exit() just 2 lines later, it doesn't make a lot of sense
> to call free().
> 
> How about this:
> 
> @@ -296,6 +296,12 @@ static int hv_fcopy_start(struct hv_start_fcopy *smsg_in)
>         file_name = (char *)malloc(file_size * sizeof(char));
>         path_name = (char *)malloc(path_size * sizeof(char));
> 
> +       if (!file_name || !path_name) {
> +               free(file_name);
> +               free(path_name);
> + 	   syslog(LOG_ERR, "Can't allocate memory for file name and/or path name");
> +               return HV_E_FAIL;
> +       }
> 
> Note: free(NULL) is valid (refer to "man 3 free").


hv_fcopy_send_data is the parent function which calls hv_fcopy_start.
Possibly a good solution is to check the return value from hv_fcopy_send_data
in fcopy_pkt_process function. Otherwise I prefer exit over returning error.

And as you rightly pointed out if we use exit, there is no sense of using free.

- Saurabh


