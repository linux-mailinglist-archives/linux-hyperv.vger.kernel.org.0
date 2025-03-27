Return-Path: <linux-hyperv+bounces-4713-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37660A729C5
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Mar 2025 06:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6281894C34
	for <lists+linux-hyperv@lfdr.de>; Thu, 27 Mar 2025 05:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 141061B4151;
	Thu, 27 Mar 2025 05:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="ay5uFe/Q"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FB2F3FC3;
	Thu, 27 Mar 2025 05:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743051937; cv=none; b=i5aOfPSaqc6QcTMkILxotYqB8nsOHAf6b1AMadsaNeZl54ZF4ZljZcOR4qKWQN/Ty9IenwUtGsdr9cmtTbi1sSRH26rmtcIyNi59+b74SW37g1GcAmjEo6ksKvZtZdY94m4OWhzdOVbXPG1qKLYftHyGHZV+wjJm3Dnl0DrJgLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743051937; c=relaxed/simple;
	bh=ziw/QGKZkQsUu5UZvBqDkL77NBthm+ZHfIifh234wFw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QygC4uojLV8cM83EZvMb2GPtGTwaD/vasM7+Wv2a8nn/r7pSHRVc9zdreKj9jGI/sXpsf332jcU7Wm2r7k18jYX3m0993qiKRXtudXMj2KbouZu/rsCJEAYOxIZ/sfJbIHFV+2c58pKri/fBMRmD8L+nRwuM/JFoildfkWMq78s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=ay5uFe/Q; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1134)
	id 475E4210235E; Wed, 26 Mar 2025 22:05:35 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 475E4210235E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1743051935;
	bh=eY2eKCGkvnw/1wqgt72GCxGv6WXewnBTgsd4F/m4SxE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ay5uFe/Q1yiKpIv/p4MhaowqS2joX9jMUHaVkbLPRqXXyKeT4TYLH+vZbFD0a0lag
	 ivA72eFjlo1V95EiF/kgimzq6uh+//qpNJ+gEiXPzLmJqadD80sXfODfoWAtsoqoV0
	 ifNi5/ZrdRIM3d2nHjUn2+fmbQIoUqYlwnwqD6Vo=
Date: Wed, 26 Mar 2025 22:05:35 -0700
From: Shradha Gupta <shradhagupta@linux.microsoft.com>
To: Wei Liu <wei.liu@kernel.org>
Cc: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Message-ID: <20250327050535.GB13258@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1742800492-25911-1-git-send-email-shradhagupta@linux.microsoft.com>
 <Z-GO-VGHMFDIAZ7r@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
 <20250325062408.GA22632@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <Z-LIcNEpsLWSVT3e@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z-LIcNEpsLWSVT3e@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Mar 25, 2025 at 03:14:56PM +0000, Wei Liu wrote:
> On Mon, Mar 24, 2025 at 11:24:08PM -0700, Shradha Gupta wrote:
> [...]
> > > > @@ -1662,6 +1755,7 @@ void print_usage(char *argv[])
> > > >  	fprintf(stderr, "Usage: %s [options]\n"
> > > >  		"Options are:\n"
> > > >  		"  -n, --no-daemon        stay in foreground, don't daemonize\n"
> > > > +		"  -d, --debug-enabled    Enable debug logs\n"
> > > 
> > > You should specify where the log is written to. The only place that
> > > tells where it is written to is in syslog.
> > >
> > I can add the log location here as well, thanks.
> >  
> > > Does systemd has a way to collect logs from a specific daemon? If so,
> > > we can consider using that facility
> > 
> > yeah, using services that can be done. For hv_kvp_daemon, the services
> > are defined and configured by distro vendors(ex:
> > rhel:-hypervkvpd.service, ubuntu:-hv-kvp-daemon.service). Using
> > StandardOutput, StandardError directives(for these services), these logs
> > can be configured to be visible in journalctl logs as well.
> 
> Yes, I would rather use systemd's logging facility. That simplifies this
> patch. You won't need to handle a log file yourself.
> 
> Thanks,
> Wei.
Thanks Wei. Summarizing the changes in next version, I will skip the log
file and add debug log in syslog as LOG_DEBUG. This would be enabled
with -d(debug-enabled) flag in the the daemon. The Distro vendors can
modify their service file configuration to redirect/view these logs
accordingly.

