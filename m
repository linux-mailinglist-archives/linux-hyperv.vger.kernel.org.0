Return-Path: <linux-hyperv+bounces-5368-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C8EB7AABAB5
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 09:27:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8CA64A03E8
	for <lists+linux-hyperv@lfdr.de>; Tue,  6 May 2025 07:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F30328BAB9;
	Tue,  6 May 2025 05:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UNExQlPi"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8EF23A9BD;
	Tue,  6 May 2025 05:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746508679; cv=none; b=l2QJQ5ESfr84rE3gFZ6H/v52g0Pf7mIiLTjMsFVZMCtpu89+E4y2e9NK+J81fRm2A0peqG9YZxLQk6tnnkwSvkP64ErnKrCAtzDrnbq9aW3bk7ZFXPKmmfL7vONMA4fgG1WDC/q4cvaCC+ABRxkeRdGtnZbCyiAX9hCJysV2pNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746508679; c=relaxed/simple;
	bh=YupN7OpiadTlvUUHNYqjvAOJEtB1+VQb1H44FbQZ4cY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfO6/iysCCuVRrwL5PQ5A2bhe5kZkc0cc5SK7+EKtx6810JBwfk4Ye0ekRq9IgfqERtDiFXk4d7KSWXb4FR/hUjryuJX9jlB1t5sk+1i2wVht6gApZUBPM2NFbKerlEtZjd5s6pu0LCtuGdYvbXfDne8zkLNBrcwLzaKTjHgPX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UNExQlPi; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746508678; x=1778044678;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=YupN7OpiadTlvUUHNYqjvAOJEtB1+VQb1H44FbQZ4cY=;
  b=UNExQlPiBZiKBgL4ATJd0VU1yuZb13+MEjwygUTxtGGHJ/tfLphnFiQE
   2gAIq/guZ6jat7cFtQWmltXyjUHvXiWtCMG4vcoPPq/v7JR74fJ9Mm8kW
   BJKDVftMxbZWt2jnZD4/ANz6Tn7OqGinXMudHgAl2uoYKCn7NER6daOiE
   Xdvcb01k7C80eg2rrGuyVlhMvzsVXvE+vsR7lrpQuJQM/WjINHgxo3hzn
   QEG/W1tNYVoJZOvxpVC4zXaWMI/hbNykdtN4w4CRrA16sOO9Fk9/DNg2Q
   ayoA9prIn0MvWZMEieZ113EuapQkGK1W5TAxCMbS2aA1xU+4Am7e9i2Ba
   Q==;
X-CSE-ConnectionGUID: l/pzZrPDTjuTNE730KtPFA==
X-CSE-MsgGUID: hFLim6LGS32dk5BNX0IwOA==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="51801224"
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="51801224"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 22:17:57 -0700
X-CSE-ConnectionGUID: mocT4V6qQBm6tcQbt70gsg==
X-CSE-MsgGUID: JImtxp0ZSCOBUGVUt4J8Ng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,265,1739865600"; 
   d="scan'208";a="172700057"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 22:17:57 -0700
Date: Mon, 5 May 2025 22:23:00 -0700
From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: x86@kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Michael Kelley <mhklinux@outlook.com>, devicetree@vger.kernel.org,
	Saurabh Sengar <ssengar@linux.microsoft.com>,
	Chris Oo <cho@microsoft.com>, linux-hyperv@vger.kernel.org,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Ravi V. Shankar" <ravi.v.shankar@intel.com>,
	Ricardo Neri <ricardo.neri@intel.com>
Subject: Re: [PATCH v3 02/13] x86/acpi: Add a helper function to get a
 pointer to the wakeup mailbox
Message-ID: <20250506052300.GE25533@ranerica-svr.sc.intel.com>
References: <20250503191515.24041-1-ricardo.neri-calderon@linux.intel.com>
 <20250503191515.24041-3-ricardo.neri-calderon@linux.intel.com>
 <CAJZ5v0g563qdyEdd6v1voyyZM5tpZab72LXTZcO9C0jE6mnRzw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0g563qdyEdd6v1voyyZM5tpZab72LXTZcO9C0jE6mnRzw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)

On Mon, May 05, 2025 at 11:55:03AM +0200, Rafael J. Wysocki wrote:
> On Sat, May 3, 2025 at 9:10 PM Ricardo Neri
> <ricardo.neri-calderon@linux.intel.com> wrote:
> >
> > In preparation to move the functionality to wake secondary CPUs up out
> > of the ACPI code, add a helper function to get a pointer to the mailbox.
> >
> > Use this helper function only in the portions of the code for which the
> > variable acpi_mp_wake_mailbox will be out of scope once it is relocated
> > out of the ACPI directory.
> >
> > The wakeup mailbox is only supported for CONFIG_X86_64 and needed only
> > with CONFIG_SMP.
> >
> > Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
> > ---
> > Changes since v2:
> >  - Introduced this patch.
> 
> Have you considered merging it with the previous patch?  They both do
> analogous things.

Indeed, I can merge these two patches.

Thanks and BR,
Ricardo

