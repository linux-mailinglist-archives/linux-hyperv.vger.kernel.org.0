Return-Path: <linux-hyperv+bounces-2747-lists+linux-hyperv=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-hyperv@lfdr.de
Delivered-To: lists+linux-hyperv@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCABB94AE90
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 19:01:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA23286051
	for <lists+linux-hyperv@lfdr.de>; Wed,  7 Aug 2024 17:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAC313A87A;
	Wed,  7 Aug 2024 17:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jJxh2eT9"
X-Original-To: linux-hyperv@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6047829C;
	Wed,  7 Aug 2024 17:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723050019; cv=none; b=B6x3hzGiDdaJ7ImdfenTU4U/FMJ8l/DBkXry3KSSmx22WpoetDTnxZzvKmNA+N2PwRRFQkGz0L2Aju+bZZO4QbiJoOlo4jMDhR6xCkXwtII3tPn8FuyEqdoIAmMZOlbo48416ptKxAgRAUMbJjMOKLo+XicIAQ629S0IgqW+VqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723050019; c=relaxed/simple;
	bh=0ZzIZ3Ein6AVG3K74QzGFETXpKkjUXKztkvYhZlNk4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hYoTXWan3SDSSjkVh+XOafSWpEelTXziFeH9ysth/R+t9czlYRm9jIkNHRM4D5CcXFjiqUyjZbSiRr9UkicqtR+PoZtEDOLwkJ196hqWU5mBpWvKbOVyBAhf8Pl059cfISdV7GZpqmNToaoEmb38pkVohBTMxf4qwEGB8SdE9K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jJxh2eT9; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723050018; x=1754586018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0ZzIZ3Ein6AVG3K74QzGFETXpKkjUXKztkvYhZlNk4g=;
  b=jJxh2eT9lbwRZ8EF11nfyqcbN5fHEMICVr6KRPhDzPX3j1YZI6vWvdYv
   T1hpcTdgLm9ISUsO5SeqQC1MJm6n9sldxRbz9MZdbUjZ8B5aiFIHSS/IU
   DnXoZxOmhPUodafheYEOEXvXvICtRy3/eLD+xWp/X7Ec7CeDDZ2QoJ3ww
   SqIKjkSTWtmWQlfbIs2nvdtF5htgQ0t1dpRVats2mmXYDuKGPHSSIVZRH
   jaMkGY6qHzL2hdADLa7oEX9ezZU8V2IdWPtiNa2RlLBv0QXNoPkHKFKAI
   G0UEqneWP9j4MlljKxIKErS1wlRmogYNkGqToq7aijAAIUjXbtE323QU0
   w==;
X-CSE-ConnectionGUID: PEDp9FNsQuegr3Lo8c/Qqg==
X-CSE-MsgGUID: 2rslIHkNS8G6UODXXhSbCQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11157"; a="25010745"
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="25010745"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 10:00:17 -0700
X-CSE-ConnectionGUID: MMNhW7tgTMSk/jXHgJU0EA==
X-CSE-MsgGUID: pMcRMVPgRDe7MKO0BxsgYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,270,1716274800"; 
   d="scan'208";a="57614514"
Received: from xuexue-mobl1.ccr.corp.intel.com (HELO localhost) ([10.124.166.194])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2024 10:00:16 -0700
Date: Wed, 7 Aug 2024 10:00:14 -0700
From: Yunhong Jiang <yunhong.jiang@linux.intel.com>
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: linux-acpi@vger.kernel.org, linux-hyperv@vger.kernel.org,
	haiyangz@microsoft.com, krzk+dt@kernel.org, x86@kernel.org,
	wei.liu@kernel.org, dave.hansen@linux.intel.com,
	devicetree@vger.kernel.org, hpa@zytor.com,
	linux-kernel@vger.kernel.org, bp@alien8.de, tglx@linutronix.de,
	mingo@redhat.com, rafael@kernel.org, kys@microsoft.com,
	kirill.shutemov@linux.intel.com, conor+dt@kernel.org,
	lenb@kernel.org, decui@microsoft.com
Subject: Re: [PATCH 2/7] dt-bindings: x86: Add ACPI wakeup mailbox
Message-ID: <20240807170014.GB17382@yjiang5-mobl.amr.corp.intel.com>
References: <20240806221237.1634126-1-yunhong.jiang@linux.intel.com>
 <20240806221237.1634126-3-yunhong.jiang@linux.intel.com>
 <172298750308.229414.6420535043181861002.robh@kernel.org>
Precedence: bulk
X-Mailing-List: linux-hyperv@vger.kernel.org
List-Id: <linux-hyperv.vger.kernel.org>
List-Subscribe: <mailto:linux-hyperv+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-hyperv+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <172298750308.229414.6420535043181861002.robh@kernel.org>

On Tue, Aug 06, 2024 at 05:38:25PM -0600, Rob Herring (Arm) wrote:
> 
> On Tue, 06 Aug 2024 15:12:32 -0700, Yunhong Jiang wrote:
> > Add the binding to use the ACPI wakeup mailbox mechanism to bringup APs.
> > 
> > Signed-off-by: Yunhong Jiang <yunhong.jiang@linux.intel.com>
> > ---
> >  .../devicetree/bindings/x86/wakeup.yaml       | 41 +++++++++++++++++++
> >  1 file changed, 41 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/x86/wakeup.yaml
> > 
> 
> My bot found errors running 'make dt_binding_check' on your patch:
> 
> yamllint warnings/errors:
> ./Documentation/devicetree/bindings/x86/wakeup.yaml:4:1: [error] syntax error: expected '<document start>', but found '<block mapping start>' (syntax)
> ./Documentation/devicetree/bindings/x86/wakeup.yaml:41:111: [warning] line too long (153 > 110 characters) (line-length)
> 
> dtschema/dtc warnings/errors:
> make[2]: *** Deleting file 'Documentation/devicetree/bindings/x86/wakeup.example.dts'
> Documentation/devicetree/bindings/x86/wakeup.yaml:4:1: did not find expected <document start>
> make[2]: *** [Documentation/devicetree/bindings/Makefile:26: Documentation/devicetree/bindings/x86/wakeup.example.dts] Error 1
> make[2]: *** Waiting for unfinished jobs....
> ./Documentation/devicetree/bindings/x86/wakeup.yaml:4:1: did not find expected <document start>
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/x86/wakeup.yaml: ignoring, error parsing file
> make[1]: *** [/builds/robherring/dt-review-ci/linux/Makefile:1430: dt_binding_check] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
> 
> doc reference errors (make refcheckdocs):
> 
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240806221237.1634126-3-yunhong.jiang@linux.intel.com
> 
> The base for the series is generally the latest rc1. A different dependency
> should be noted in *this* patch.
> 
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
> 
> pip3 install dtschema --upgrade
> 
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your schema.
> 
I remember I ran 'make dt_binding_check' in the early development stage, but
possibly missed the error information. Will fix this.

Thank you
--jyh

