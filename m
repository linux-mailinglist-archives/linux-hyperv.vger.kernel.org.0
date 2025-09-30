Return-Path: <linux-hyperv+bounces-7032-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E657BAEBD0
	for <lists+linux-hyperv@lfdr.de>; Wed, 01 Oct 2025 01:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A87381941BA9
	for <lists+linux-hyperv@lfdr.de>; Tue, 30 Sep 2025 23:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FED32BDC34;
	Tue, 30 Sep 2025 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jue5ZoOT"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2B1BDCF;
	Tue, 30 Sep 2025 23:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759274089; cv=none; b=HDsE+kPuJRDhwuDWqIvDF4kbMZHocAanKXI+Ax1iy7cOMecqEMGjRTdB9aquhEmKr5EKW9r5BchQhtNLLcVWAFN1ayUCv33p868luRmWx/xALLj5fzeUqiC2Ugdi/btZsuJm0mo9Tq+H/bazqNYVGPdY+/jUPgxTn7CB2F58atM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759274089; c=relaxed/simple;
	bh=x/5Suh6ta4XqztcOCKv8Meis7VdCs7lMsTyyNIl940E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X6UtHltNMUMHN+YTxEhrTeY4s/Chs7ePjUhlK+VhV0YO6FCPhXU6CBg2nZXYL+yXQBE5j+FrJJn0c/PGOGbzs7lpa6UsXDuTEg/EOO/BLcXZu8h93aepQ9waDNrwKmDFdU/cRNr4f2idfxaScwEPI/rQJEdjMHv3c9O55zh7M9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jue5ZoOT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C83AC4CEF0;
	Tue, 30 Sep 2025 23:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759274088;
	bh=x/5Suh6ta4XqztcOCKv8Meis7VdCs7lMsTyyNIl940E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Jue5ZoOTk9fFauOFMTDhisM87Tz+wpahGA1iuAgwFkpKfKwg4ETac49FmdTp/zV18
	 WoFpDXpTh+AhzXGLPenhaM/KvUY0rQfgbbAwI29m7QKBsVxcsCxUMEVSCIiWaxq0aw
	 x+kS59Ha4B4tPodOLMayGU76pEOmlYa1t+xGUg0ufLEx8Op7IUkrPIpeFrTQeijHmm
	 f4a7eDuLiGe5AzzBSyeMh0pUDsC23qNsHgWmFlrMl+p7Xy4ORF9ps1/yWk8BkdLLSf
	 J+OyYpA++4DviXt7TKOlJF6wDOcV9EFlvwbB6yUK44Zp8h2seDBGO2FSRtbRwGfgDF
	 qib+JyUc+Yk1Q==
Date: Tue, 30 Sep 2025 23:14:46 +0000
From: Wei Liu <wei.liu@kernel.org>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Cc: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>,
	linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org,
	prapal@linux.microsoft.com, easwar.hariharan@linux.microsoft.com,
	tiala@microsoft.com, anirudh@anirudhrb.com,
	paekkaladevi@linux.microsoft.com, kys@microsoft.com,
	haiyangz@microsoft.com, wei.liu@kernel.org, decui@microsoft.com
Subject: Re: [PATCH v4 0/5] mshv: Fixes for stats and vp state page mappings
Message-ID: <aNxkZtyxuYQ0Gjw7@liuwe-devbox-ubuntu-v2.lamzopl0uupeniq2etz1fddiyg.xx.internal.cloudapp.net>
References: <1758903795-18636-1-git-send-email-nunodasneves@linux.microsoft.com>
 <aNcd60fpoI1b6LUT@skinsburskii.localdomain>
 <96009fb8-0ad6-4e5b-8656-af78874a5605@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96009fb8-0ad6-4e5b-8656-af78874a5605@linux.microsoft.com>

On Mon, Sep 29, 2025 at 11:19:51AM -0700, Nuno Das Neves wrote:
> On 9/26/2025 4:12 PM, Stanislav Kinsburskii wrote:
> > On Fri, Sep 26, 2025 at 09:23:10AM -0700, Nuno Das Neves wrote:
> >> There are some differences in how L1VH partitions must map stats and vp
> >> state pages, some of which are due to differences across hypervisor
> >> versions. Detect and handle these cases.
> >>
> > 
> > I'm not sure that support for older and actully broken versions on
> > hypervisor need to be usptreamed, as these versions will go away sooner
> > or later and this support will become dead weight.
> > 
> As far as I know, these changes are relevant for shipped versions of the
> hypervisor - they are not 'broken' except in some very specific cases
> (live migration on L1VH, I think?)
> 

Right, they are not broken, just have more limitations.

> The hypervisor team added a feature bit for these changes so that both old
> and new versions of these APIs can be supported.
> 
> > I think we should upstrem only the changes needed for the new versiong
> > of hypervisors instead and carry legacy support out of tree until it
> > becomes obsoleted.
> > 
> Which version do you suggest to be the cutoff?
> 
> I'd prefer to support as many versions of the hypervisor as we can, as
> long as they are at all relevant. We can remove the support later.
> Removing prematurely just creates friction. Inevitably some users will
> find themselves running on an older hypervisor and then it just fails
> with a cryptic error. This includes myself, since I test L1VH on Azure
> which typically has older hypervisor versions.

This. It takes a long time to saturate the fleet with a new hypervisor.
Realistically I am looking at 2+ years before we can drop the
compatibility code, if ever.

Another reason to upstream the compatibility code is because partners
will want to pick up our code, so hiding this code from them makes both
our and their life harder.

Wei

> 
> Nuno

