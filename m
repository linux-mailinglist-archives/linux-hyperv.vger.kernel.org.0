Return-Path: <linux-hyperv+bounces-4772-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E365A7879E
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Apr 2025 07:40:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EE0E21892D0B
	for <lists+linux-hyperv@lfdr.de>; Wed,  2 Apr 2025 05:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266F020C46D;
	Wed,  2 Apr 2025 05:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="bEqpqXet"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAE9A13AA27;
	Wed,  2 Apr 2025 05:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743572453; cv=none; b=tVNSfUoL/USyT/3bKuYnX/d1IhAw6quNqJ5U8JMHgEgeaPJl8BCb7I4vwklGhueGsPnDddWLewRgqAKuR8ex8kF8hjNpR7iQp7LTvlRBJb1lkHhcYthItUXXi/T759W6Dorfpamk2SO9v4gW9ISCw2AdTvyvvMaIfL2xUyhLrE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743572453; c=relaxed/simple;
	bh=wZNAuYXkU51dfAFPidgsL7ZUk4uvCwu3iAmPgfx/jes=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cqZOwjcOxwZuVdkI0M+tNcRhKMsYmpJBqlp3vzhzCFlM/OosKERVOpjguNPZSZZcGBPBfaMUxWYc8hx11ToR9GK9soI9KbphiA9TO4jHdNURtqRSYFethTFbBhNW47qq8aBlMAcve7GGa2oNfn4T7z0TN2QuGAk/ffH1FhEfANU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=bEqpqXet; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 3A3112041307; Tue,  1 Apr 2025 22:40:51 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 3A3112041307
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743572451;
	bh=ZiB90PMMKAEaJMud/Ou60Rtt4u2bRPDLCYMXvuis7bU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bEqpqXet8h/38+KXimF2PsdMwKXgrUPJin8d4Ze+PWII0DMFUixbmRr7oVdtiDNht
	 2AGCqlO+x/Q2+3HKhwaxk7M5DAiCGDWigFWgdR0vfn3WKn6QnRSNC4zm/kpMGYlcT4
	 HMKvdkpbmfnJLG4vznDZnfC1Xnil+qczsJw8Gis0=
Date: Tue, 1 Apr 2025 22:40:51 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Dexuan Cui <decui@microsoft.com>
Cc: KY Srinivasan <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH v2] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Message-ID: <20250402054051.GA22424@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1743401688-1573-1-git-send-email-shradhagupta@linux.microsoft.com>
 <BL4PR21MB462765E191592754911DB67BBFAD2@BL4PR21MB4627.namprd21.prod.outlook.com>
 <20250401040609.GA11465@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <BL4PR21MB4627E73164911623CFB98BADBFAC2@BL4PR21MB4627.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL4PR21MB4627E73164911623CFB98BADBFAC2@BL4PR21MB4627.namprd21.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Apr 01, 2025 at 07:18:04PM +0000, Dexuan Cui wrote:
> > From: Shradha Gupta <shradhagupta@linux.microsoft.com>
> > Sent: Monday, March 31, 2025 9:06 PM
> > > > +static void convert_tm_to_string(char *tm_str, size_t tm_str_size)
> > > > +{
> > > > +	struct tm tm;
> > > > +	time_t t;
> > > > +
> > > > +	time(&t);
> > > > +	gmtime_r(&t, &tm);
> > > > +	strftime(tm_str, tm_str_size, "%Y-%m-%dT%H:%M:%S", &tm);
> > > > +}
> > >
> > > Now the function is unnecessary since v2 uses syslog(), which already
> > > prefixes every message with a timestamp.
> > 
> > Hi Dexuan,
> > I have deliberately kept this timestamp in the raw message so that
> > if/whenever they are redirected to other file, irrespective of the
> > configuration of the syslog we have valid timestamp for debugging
> 
> A message produced by syslog() is always prefixed with a timestamp,
> and IMO can't be redirected.  By "redirected to other file",  I guess
> you mean systemd's options StandardOutput= and StandardError=
> for a service, but those are stdout/err, not syslog().

rsyslog can be configured to forward syslog logs from a service to a file.
If the timestamp template in rsyslog.conf is not configured, the timestamps
would be missed in forwarded file.
But I think that would be an issue to be handled by the script/service
forwarding these logs. It can be easily fixed by adding the timestamp
template.

I will remove the timestamp from the raw log message then. Thanks

> 
> > > > +static void kvp_dump_initial_pools(int pool)
> > > > + [...]
> > > > +	for (i = 0; i < kvp_file_info[pool].num_records; i++)
> > > > +		syslog(LOG_DEBUG, "[%s]: pool: %d, %d/%d key=%s
> > > > val=%s\n",
> > > > +		       tm_str, pool, i, kvp_file_info[pool].num_records,
> > >
> > > Can you change the 'i' to 'i+1'? This makes the messages a little more
> > > natural to users who are not programmers :-)
> > sure, but I am just worried that might cause confusion when someone
> > tried to co-relate it with the actual kv_pool_{i} contents that start
> > with 0.
> IMO these messages are mostly for admins, who would feel more
> natural when seeing N/N as the last element, compared  with N-1/N.
Got it, will modify this too
> 
> Thanks,
> Dexuan

