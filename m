Return-Path: <linux-hyperv+bounces-26-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E1B79DF61
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Sep 2023 07:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9B361C20EA8
	for <lists+linux-hyperv@lfdr.de>; Wed, 13 Sep 2023 05:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78241549A;
	Wed, 13 Sep 2023 05:27:15 +0000 (UTC)
X-Original-To: linux-hyperv@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB92014F92
	for <linux-hyperv@vger.kernel.org>; Wed, 13 Sep 2023 05:27:15 +0000 (UTC)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by lindbergh.monkeyblade.net (Postfix) with ESMTP id F412B172A;
	Tue, 12 Sep 2023 22:27:14 -0700 (PDT)
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 2B049212BE43; Tue, 12 Sep 2023 22:27:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2B049212BE43
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1694582834;
	bh=Wf3IR5Rw+P9N8xEXtP0JOGbFUququkZ2xKLTTFywNE4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n0OS1U2wu+nD2bfTE7KyChF5Q+6yfMPXgNwDBGYxTY365OYF7iEtIeiaBkjs74DSe
	 kfrFScGaycfGQnUMkCWONgLPuxVZkoXgzgb+wnanBzaiTZn0aItzbzPIiMyyGTkC6T
	 8SOvc/BkgtSwaBdQWNJlxCY87ZddNQf7cgWjGlK0=
Date: Tue, 12 Sep 2023 22:27:14 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Mathias Krause <minipli@grsecurity.net>
Cc: linux-hyperv@vger.kernel.org, "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	linux-kernel@vger.kernel.org, stable@kernel.org
Subject: Re: [PATCH] x86/hyperv/vtl: Replace real_mode_header only under
 Hyper-V
Message-ID: <20230913052714.GA29112@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20230908102610.1039767-1-minipli@grsecurity.net>
 <20230908150224.GA3196@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <ca1a5950-9092-6caf-471c-ebda623173e5@grsecurity.net>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca1a5950-9092-6caf-471c-ebda623173e5@grsecurity.net>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Sep 11, 2023 at 10:00:59AM +0200, Mathias Krause wrote:
> On 08.09.23 17:02, Saurabh Singh Sengar wrote:
> > On Fri, Sep 08, 2023 at 12:26:10PM +0200, Mathias Krause wrote:
> >> Booting a CONFIG_HYPERV_VTL_MODE=y enabled kernel on bare metal or a
> >> non-Hyper-V hypervisor leads to serve memory corruption as
> > 
> > FWIW, CONFIG_HYPERV_VTL_MODE is not expected to be enabled for non VTL
> > platforms.
> 
> Fair enough, but there's really no excuse to randomly crashing the
> kernel if one forgot to RTFM like I did. The code should (and easily
> can) handle such situations, especially if it's just a matter of a two
> line change.

Thanks, I understand your concern. We don't want people to enable this
flag by mistake and see unexpected behaviours.

To add extra safety for this flag, we can make this flag dependent on
EXPERT config.

- Saurabh

