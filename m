Return-Path: <linux-hyperv+bounces-4686-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D866EA704CF
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 16:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFC88167F82
	for <lists+linux-hyperv@lfdr.de>; Tue, 25 Mar 2025 15:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D270B25BAC7;
	Tue, 25 Mar 2025 15:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="skXZmrRw"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE9825B691;
	Tue, 25 Mar 2025 15:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742915698; cv=none; b=Sk4VPVmoy6hMp6471aNNi0bwVoHy0J1Z99gbuWShKg3NIBgP1VVCMdYb/oNddUR/UTFUhSiTjDhXk+4CTYCD89Lw4kW44sqgqQZfZ6DN7ynSBKtGlNEpoVeeLekFAytZXCBh4LXspjLBkzSCkuRjEXyzkp9yvphVJal9jRPTtQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742915698; c=relaxed/simple;
	bh=Qr9ZIbMRaSK3R5fL4BGohjOJJqswOHWbh7MuIsprLic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l7euzjUIxbZAUXjlQNGXHP3gbAI+ukbObcowP+exZdxNdkTO4S60ti2TyjZmPcxanuKFyT31yXqZgXaf7QhWi4dS8/3taGwIfyOXheMRB46cP2s5A9ziD1O9haJ9MQH8qgP76AsksK1y1MCytOCeUUdfiJxH1j4TDld1B4/fsSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=skXZmrRw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995D2C4CEE4;
	Tue, 25 Mar 2025 15:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742915697;
	bh=Qr9ZIbMRaSK3R5fL4BGohjOJJqswOHWbh7MuIsprLic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=skXZmrRw6YdQYiTVif5jU23ZFWHadER00kNOs+wjmKF5qII1of/+wa9o9QlMDr91S
	 ASa850MLMtSEEY/KvuBHlQ1+SnF/JOQdS61wxkPl20Pawex3HRtvH2sk3zm1l4XpkR
	 6ec5BlPrsjkASsA0uFijf1OX+v0CbUi49hcBdp76p7reXPoeZOfi9rWG0/1rlvWWiv
	 DsEpUUBK8KqiOv+3PF2BeziepniCjYM7JB8nyvHVuRj8v9gc9zPvK6OUCAyBpWaJl7
	 MCyoIu8ai91OqxVAuyPrR72pPuctJ1NOgRTDRNgRAdZX98tIleBTUdg6sMWONZ76rZ
	 S0PzAt7iA45eg==
Date: Tue, 25 Mar 2025 15:14:56 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Shradha Gupta <shradhagupta@linux.microsoft.com>
Cc: Wei Liu <wei.liu@kernel.org>, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shradha Gupta <shradhagupta@microsoft.com>
Subject: Re: [PATCH] hv/hv_kvp_daemon: Enable debug logs for hv_kvp_daemon
Message-ID: <Z-LIcNEpsLWSVT3e@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <1742800492-25911-1-git-send-email-shradhagupta@linux.microsoft.com>
 <Z-GO-VGHMFDIAZ7r@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
 <20250325062408.GA22632@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250325062408.GA22632@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>

On Mon, Mar 24, 2025 at 11:24:08PM -0700, Shradha Gupta wrote:
[...]
> > > @@ -1662,6 +1755,7 @@ void print_usage(char *argv[])
> > >  	fprintf(stderr, "Usage: %s [options]\n"
> > >  		"Options are:\n"
> > >  		"  -n, --no-daemon        stay in foreground, don't daemonize\n"
> > > +		"  -d, --debug-enabled    Enable debug logs\n"
> > 
> > You should specify where the log is written to. The only place that
> > tells where it is written to is in syslog.
> >
> I can add the log location here as well, thanks.
>  
> > Does systemd has a way to collect logs from a specific daemon? If so,
> > we can consider using that facility
> 
> yeah, using services that can be done. For hv_kvp_daemon, the services
> are defined and configured by distro vendors(ex:
> rhel:-hypervkvpd.service, ubuntu:-hv-kvp-daemon.service). Using
> StandardOutput, StandardError directives(for these services), these logs
> can be configured to be visible in journalctl logs as well.

Yes, I would rather use systemd's logging facility. That simplifies this
patch. You won't need to handle a log file yourself.

Thanks,
Wei.

